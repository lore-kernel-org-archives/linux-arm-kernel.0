From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Fri, 12 Nov 2010 16:38:47 -0600
Subject: [PATCH v8 1/9] davinci: EMAC support for Omapl138-Hawkboard
In-Reply-To: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1289601535-6746-2-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds EMAC support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   43 +++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c472dd8..62d35f0 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -19,6 +19,47 @@
 
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
+#include <mach/mux.h>
+
+#define HAWKBOARD_PHY_ID		"0:07"
+
+static short omapl138_hawk_mii_pins[] __initdata = {
+	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
+	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
+	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
+	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
+static __init void omapl138_hawk_config_emac(void)
+{
+	void __iomem *cfgchip3 = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
+	int ret;
+	u32 val;
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
+
+	val = __raw_readl(cfgchip3);
+	val &= ~BIT(8);
+	ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
+	if (ret) {
+		pr_warning("%s: cpgmac/mii mux setup failed: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	/* configure the CFGCHIP3 register for MII */
+	__raw_writel(val, cfgchip3);
+	pr_info("EMAC: MII PHY configured\n");
+
+	soc_info->emac_pdata->phy_id = HAWKBOARD_PHY_ID;
+
+	ret = da8xx_register_emac();
+	if (ret)
+		pr_warning("%s: emac registration failed: %d\n",
+			__func__, ret);
+}
+
 
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
@@ -30,6 +71,8 @@ static __init void omapl138_hawk_init(void)
 
 	davinci_serial_init(&omapl138_hawk_uart_config);
 
+	omapl138_hawk_config_emac();
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.7.0.4
