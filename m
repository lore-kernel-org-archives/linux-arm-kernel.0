From: b38611@freescale.com (Fugang Duan)
Date: Tue, 20 May 2014 14:11:06 +0800
Subject: [PATCH] ARM: imx6: init enet MAC address
Message-ID: <1400566266-22746-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enet get MAC address order:
>From module parameters or kernel command line -> device tree ->
pfuse -> mac registers set by bootloader -> random mac address.

When there have no "fec.macaddr" parameters set in kernel command
line, enet driver get MAC address from device tree. And then if
the MAC address set in device tree and is valid, enet driver get
MAC address from device tree. Otherwise, enet get MAC address from
pfuse. So, in the condition, update the MAC address (read from pfuse)
to device tree.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/mach-imx/common.h      |    1 +
 arch/arm/mach-imx/mach-imx6q.c  |   90 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-imx/mach-imx6sl.c |    8 +++-
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4facd01..5c69325 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -145,6 +145,7 @@ void imx6sl_set_wait_clk(bool enter);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
+void imx6_enet_mac_init(const char *compatible);
 
 #ifdef CONFIG_SUSPEND
 void v7_cpu_resume(void);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index e60456d..2bec13d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/pci.h>
@@ -164,6 +165,85 @@ static int ar8035_phy_fixup(struct phy_device *dev)
 	return 0;
 }
 
+#define OCOTP_MACn(n)		(0x00000620 + (n) * 0x10)
+#define IMX_MAX_ENET_NUM	2
+void __init imx6_enet_mac_init(const char *compatible)
+{
+	struct device_node *ocotp_np, *enet_np, *from = NULL;
+	void __iomem *base;
+	struct property *newmac;
+	u32 macaddr0_low;
+	u32 macaddr0_high = 0;
+	u32 macaddr1_high = 0;
+	u8 *macaddr;
+	int i;
+
+	for (i = 0; i < IMX_MAX_ENET_NUM; i++) {
+		enet_np = of_find_compatible_node(from, NULL, compatible);
+		if (!enet_np)
+			return;
+
+		from = enet_np;
+
+		if (of_get_mac_address(enet_np))
+			goto put_enet_node;
+
+		ocotp_np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
+		if (!ocotp_np) {
+			pr_warn("failed to find ocotp node\n");
+			goto put_enet_node;
+		}
+
+		base = of_iomap(ocotp_np, 0);
+		if (!base) {
+			pr_warn("failed to map ocotp\n");
+			goto put_ocotp_node;
+		}
+
+		macaddr0_low = readl_relaxed(base + OCOTP_MACn(1));
+		if (i)
+			macaddr1_high = readl_relaxed(base + OCOTP_MACn(2));
+		else
+			macaddr0_high = readl_relaxed(base + OCOTP_MACn(0));
+
+		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
+		if (!newmac)
+			goto put_ocotp_node;
+
+		newmac->value = newmac + 1;
+		newmac->length = 6;
+		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
+		if (!newmac->name) {
+			kfree(newmac);
+			goto put_ocotp_node;
+		}
+
+		macaddr = newmac->value;
+		if (i) {
+			macaddr[0] = (macaddr1_high >> 24) & 0xff;
+			macaddr[1] = (macaddr1_high >> 16) & 0xff;
+			macaddr[2] = (macaddr1_high >> 8) & 0xff;
+			macaddr[3] = macaddr1_high & 0xff;
+			macaddr[4] = (macaddr0_low >> 24) & 0xff;
+			macaddr[5] = (macaddr0_low >> 16) & 0xff;
+		} else {
+			macaddr[0] = (macaddr0_low >> 8) & 0xff;
+			macaddr[1] = macaddr0_low & 0xff;
+			macaddr[2] = (macaddr0_high >> 24) & 0xff;
+			macaddr[3] = (macaddr0_high >> 16) & 0xff;
+			macaddr[4] = (macaddr0_high >> 8) & 0xff;
+			macaddr[5] = macaddr0_high & 0xff;
+		}
+
+		of_update_property(enet_np, newmac);
+
+put_ocotp_node:
+		of_node_put(ocotp_np);
+put_enet_node:
+		of_node_put(enet_np);
+	}
+}
+
 #define PHY_ID_AR8035 0x004dd072
 
 static void __init imx6q_enet_phy_init(void)
@@ -228,6 +308,13 @@ put_node:
 	of_node_put(np);
 }
 
+static inline void imx6q_enet_init(void)
+{
+	imx6_enet_mac_init("fsl,imx6q-fec");
+	imx6q_enet_phy_init();
+	imx6q_1588_init();
+}
+
 static void __init imx6q_axi_init(void)
 {
 	struct regmap *gpr;
@@ -274,13 +361,12 @@ static void __init imx6q_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	imx6q_enet_phy_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
+	imx6q_enet_init();
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
-	imx6q_1588_init();
 	imx6q_axi_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index ad32338..cb001d4 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -19,7 +19,7 @@
 #include "common.h"
 #include "cpuidle.h"
 
-static void __init imx6sl_fec_init(void)
+static void __init imx6sl_fec_clk_init(void)
 {
 	struct regmap *gpr;
 
@@ -35,6 +35,12 @@ static void __init imx6sl_fec_init(void)
 	}
 }
 
+static inline void imx6sl_fec_init(void)
+{
+	imx6sl_fec_clk_init();
+	imx6_enet_mac_init("fsl,imx6sl-fec");
+}
+
 static void __init imx6sl_init_late(void)
 {
 	/* imx6sl reuses imx6q cpufreq driver */
-- 
1.7.8
