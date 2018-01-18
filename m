From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 18 Jan 2018 15:12:21 -0800
Subject: [PATCH net-next v2] net: stmmac: Fix reception of Broadcom switches
 tags
Message-ID: <20180118231222.19394-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom tags inserted by Broadcom switches put a 4 byte header after
the MAC SA and before the EtherType, which may look like some sort of 0
length LLC/SNAP packet (tcpdump and wireshark do think that way). With
ACS enabled in stmmac the packets were truncated to 8 bytes on
reception, whereas clearing this bit allowed normal reception to occur.

In order to make that possible, we need to pass a net_device argument to
the different core_init() functions and we are dependent on the Broadcom
tagger padding packets correctly (which it now does). To be as little
invasive as possible, this is only done for gmac1000 when the network
device is DSA-enabled (netdev_uses_dsa() returns true).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- fixed build failure in dwmac4_core.c
- updated dwmac100_core.c to also clear the ASTP bit

 drivers/net/ethernet/stmicro/stmmac/common.h         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c    |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  | 15 +++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  2 +-
 6 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index ce2ea2d491ac..2ffe76c0ff74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -474,7 +474,7 @@ struct mac_device_info;
 /* Helpers to program the MAC core */
 struct stmmac_ops {
 	/* MAC core initialization */
-	void (*core_init)(struct mac_device_info *hw, int mtu);
+	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 9eb7f65d8000..a3fa65b1ca8e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -483,7 +483,8 @@ static int sun8i_dwmac_init(struct platform_device *pdev, void *priv)
 	return 0;
 }
 
-static void sun8i_dwmac_core_init(struct mac_device_info *hw, int mtu)
+static void sun8i_dwmac_core_init(struct mac_device_info *hw,
+				  struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 v;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 8a86340ff2d3..540d21786a43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -25,18 +25,28 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
+#include <net/dsa.h>
 #include <asm/io.h>
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
 
-static void dwmac1000_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac1000_core_init(struct mac_device_info *hw,
+				struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONTROL);
+	int mtu = dev->mtu;
 
 	/* Configure GMAC core */
 	value |= GMAC_CORE_INIT;
 
+	/* Clear ACS bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~GMAC_CONTROL_ACS;
+
 	if (mtu > 1500)
 		value |= GMAC_CONTROL_2K;
 	if (mtu > 2000)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 8ef517356313..91b23f9db31a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -25,15 +25,26 @@
 *******************************************************************************/
 
 #include <linux/crc32.h>
+#include <net/dsa.h>
 #include <asm/io.h>
 #include "dwmac100.h"
 
-static void dwmac100_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac100_core_init(struct mac_device_info *hw,
+			       struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + MAC_CONTROL);
 
-	writel((value | MAC_CORE_INIT), ioaddr + MAC_CONTROL);
+	value |= MAC_CORE_INIT;
+
+	/* Clear ASTP bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~MAC_CONTROL_ASTP;
+
+	writel(value, ioaddr + MAC_CONTROL);
 
 #ifdef STMMAC_VLAN_TAG_USED
 	writel(ETH_P_8021Q, ioaddr + MAC_VLAN1);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index f3ed8f7853eb..ed222b20fcf1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -17,16 +17,26 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <net/dsa.h>
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
 
-static void dwmac4_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac4_core_init(struct mac_device_info *hw,
+			     struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	int mtu = dev->mtu;
 
 	value |= GMAC_CORE_INIT;
 
+	/* Clear ACS bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~GMAC_CONFIG_ACS;
+
 	if (mtu > 1500)
 		value |= GMAC_CONFIG_2K;
 	if (mtu > 2000)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f99f14c35063..7ad841434ec8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2527,7 +2527,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 	}
 
 	/* Initialize the MAC Core */
-	priv->hw->mac->core_init(priv->hw, dev->mtu);
+	priv->hw->mac->core_init(priv->hw, dev);
 
 	/* Initialize MTL*/
 	if (priv->synopsys_id >= DWMAC_CORE_4_00)
-- 
2.14.1
