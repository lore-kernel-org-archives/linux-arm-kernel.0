From: rogerq@ti.com (Roger Quadros)
Date: Wed, 20 Mar 2013 17:44:47 +0200
Subject: [PATCH v4 08/21] ARM: OMAP: AM3517evm: Adapt to ehci-omap changes
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Message-ID: <1363794300-31526-9-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use usbhs_init_phys() to register the PHY's RESET regulators
and the NOP PHY device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 9fb8590..191f976 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -274,6 +274,14 @@ static __init void am3517_evm_mcbsp1_init(void)
 	omap_ctrl_writel(devconf0, OMAP2_CONTROL_DEVCONF0);
 }
 
+static struct usbhs_phy_data phy_data[] __initdata = {
+	{
+		.port = 1,
+		.reset_gpio = 57,
+		.vcc_gpio = -EINVAL,
+	},
+};
+
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
@@ -282,12 +290,6 @@ static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 #else
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
 #endif
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = 57,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 #ifdef CONFIG_OMAP_MUX
@@ -349,7 +351,6 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}      /* Terminator */
 };
 
-
 static void __init am3517_evm_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -361,6 +362,8 @@ static void __init am3517_evm_init(void)
 
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
+
+	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
 	usbhs_init(&usbhs_bdata);
 	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
-- 
1.7.4.1
