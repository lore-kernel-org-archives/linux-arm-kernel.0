From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jul 2015 17:15:55 -0400 (EDT)
Subject: [PATCH v2] ARM: appropriate __init annotation for const data
Message-ID: <alpine.LFD.2.20.1507271659350.1806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Init data marked const should be annotated with __initconst for
correctness and not __initdata.  In some cases the array gathering
references to that data has to be marked const as well. This fixes
LTO builds that otherwise fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

Changes since v1: Many more "const" added throughout. More coverage in 
my LTO build.

diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
index f90fdf4ce7..2e60243347 100644
--- a/arch/arm/kernel/psci.c
+++ b/arch/arm/kernel/psci.c
@@ -278,7 +278,7 @@ out_put_node:
 	return err;
 }
 
-static const struct of_device_id psci_of_match[] __initconst = {
+static const struct of_device_id const psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci", .data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2", .data = psci_0_2_init},
 	{},
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index eaf58f88ef..82eec33c6a 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -38,7 +38,7 @@ static void __init at91rm9200_dt_device_init(void)
 	at91rm9200_pm_init();
 }
 
-static const char *at91rm9200_dt_board_compat[] __initconst = {
+static const char *const at91rm9200_dt_board_compat[] __initconst = {
 	"atmel,at91rm9200",
 	NULL
 };
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index e47a2093a0..7eb64f7630 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -72,7 +72,7 @@ static void __init at91sam9_dt_device_init(void)
 	at91sam9260_pm_init();
 }
 
-static const char *at91_dt_board_compat[] __initconst = {
+static const char *const at91_dt_board_compat[] __initconst = {
 	"atmel,at91sam9",
 	NULL
 };
@@ -89,7 +89,7 @@ static void __init at91sam9g45_dt_device_init(void)
 	at91sam9g45_pm_init();
 }
 
-static const char *at91sam9g45_board_compat[] __initconst = {
+static const char *const at91sam9g45_board_compat[] __initconst = {
 	"atmel,at91sam9g45",
 	NULL
 };
@@ -106,7 +106,7 @@ static void __init at91sam9x5_dt_device_init(void)
 	at91sam9x5_pm_init();
 }
 
-static const char *at91sam9x5_board_compat[] __initconst = {
+static const char *const at91sam9x5_board_compat[] __initconst = {
 	"atmel,at91sam9x5",
 	"atmel,at91sam9n12",
 	NULL
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e24df77abd..265ffeb203 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -311,7 +311,7 @@ static void at91sam9_sdram_standby(void)
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
-static const struct of_device_id ramc_ids[] __initconst = {
+static const struct of_device_id const ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 41d829d8e7..8fc47630bb 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -52,7 +52,7 @@ static void __init sama5_dt_device_init(void)
 	at91sam9x5_pm_init();
 }
 
-static const char *sama5_dt_board_compat[] __initconst = {
+static const char *const sama5_dt_board_compat[] __initconst = {
 	"atmel,sama5",
 	NULL
 };
@@ -63,7 +63,7 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
 
-static const char *sama5_alt_dt_board_compat[] __initconst = {
+static const char *const sama5_alt_dt_board_compat[] __initconst = {
 	"atmel,sama5d4",
 	NULL
 };
diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index 7aef92720e..5478fe6bcc 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -44,7 +44,7 @@ static void __init bcm5301x_init_early(void)
 			"imprecise external abort");
 }
 
-static const char __initconst *bcm5301x_dt_compat[] = {
+static const char *const bcm5301x_dt_compat[] __initconst = {
 	"brcm,bcm4708",
 	NULL,
 };
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index a55a7ecf14..cf3f8658f0 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -33,7 +33,7 @@ struct bcm_kona_smc_data {
 	unsigned result;
 };
 
-static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
+static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
 	{.compatible = "brcm,kona-smc"},
 	{.compatible = "bcm,kona-smc"}, /* deprecated name */
 	{},
diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 45abf6bd5f..c3d9642217 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -160,7 +160,7 @@ static struct platform_device autcpu12_mmgpio_pdev __initdata = {
 	},
 };
 
-static const struct gpio autcpu12_gpios[] __initconst = {
+static const struct gpio const autcpu12_gpios[] __initconst = {
 	{ AUTCPU12_DPOT_CS,	GPIOF_OUT_INIT_HIGH,	"DPOT CS" },
 	{ AUTCPU12_DPOT_CLK,	GPIOF_OUT_INIT_LOW,	"DPOT CLK" },
 	{ AUTCPU12_DPOT_UD,	GPIOF_OUT_INIT_LOW,	"DPOT UD" },
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 4e9837ded9..db5eb69a42 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -339,7 +339,7 @@ static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
 	.power_off	= csn3xxx_usb_power_off,
 };
 
-static struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
+static const struct of_dev_auxdata const cns3xxx_auxdata[] __initconst = {
 	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
 	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
 	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },
@@ -392,7 +392,7 @@ static void __init cns3xxx_init(void)
                         cns3xxx_auxdata, NULL);
 }
 
-static const char *cns3xxx_dt_compat[] __initdata = {
+static const char *const cns3xxx_dt_compat[] __initconst = {
 	"cavium,cns3410",
 	"cavium,cns3420",
 	NULL,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 3b8740c083..676997895e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -715,7 +715,7 @@ const short da850_lcdcntl_pins[] __initconst = {
 	-1
 };
 
-const short da850_vpif_capture_pins[] __initdata = {
+const short da850_vpif_capture_pins[] __initconst = {
 	DA850_VPIF_DIN0, DA850_VPIF_DIN1, DA850_VPIF_DIN2, DA850_VPIF_DIN3,
 	DA850_VPIF_DIN4, DA850_VPIF_DIN5, DA850_VPIF_DIN6, DA850_VPIF_DIN7,
 	DA850_VPIF_DIN8, DA850_VPIF_DIN9, DA850_VPIF_DIN10, DA850_VPIF_DIN11,
@@ -725,7 +725,7 @@ const short da850_vpif_capture_pins[] __initdata = {
 	-1
 };
 
-const short da850_vpif_display_pins[] __initdata = {
+const short da850_vpif_display_pins[] __initconst = {
 	DA850_VPIF_DOUT0, DA850_VPIF_DOUT1, DA850_VPIF_DOUT2, DA850_VPIF_DOUT3,
 	DA850_VPIF_DOUT4, DA850_VPIF_DOUT5, DA850_VPIF_DOUT6, DA850_VPIF_DOUT7,
 	DA850_VPIF_DOUT8, DA850_VPIF_DOUT9, DA850_VPIF_DOUT10,
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 438f68547f..06b6451225 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,7 +20,7 @@
 
 #define DA8XX_NUM_UARTS	3
 
-static const struct of_device_id da8xx_irq_match[] __initconst = {
+static const struct of_device_id const da8xx_irq_match[] __initconst = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
 };
@@ -59,7 +59,7 @@ static void __init da850_init_machine(void)
 
 }
 
-static const char *da850_boards_compat[] __initdata = {
+static const char *const da850_boards_compat[] __initconst = {
 	"enbw,cmc",
 	"ti,da850-evm",
 	"ti,da850",
diff --git a/arch/arm/mach-digicolor/digicolor.c b/arch/arm/mach-digicolor/digicolor.c
index cfc88d1caa..4d62f1bde4 100644
--- a/arch/arm/mach-digicolor/digicolor.c
+++ b/arch/arm/mach-digicolor/digicolor.c
@@ -8,7 +8,7 @@
 
 #include <asm/mach/arch.h>
 
-static const char *digicolor_dt_compat[] __initconst = {
+static const char *const digicolor_dt_compat[] __initconst = {
 	"cnxt,cx92755",
 	NULL,
 };
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 4d4a19099a..62f3437257 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -31,7 +31,7 @@ static void __init imx7d_init_irq(void)
 	irqchip_init();
 }
 
-static const char *imx7d_dt_compat[] __initconst = {
+static const char *const imx7d_dt_compat[] __initconst = {
 	"fsl,imx7d",
 	NULL,
 };
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 7858d5b6f6..a271a0b8c1 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -212,7 +212,7 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
 	.dma_filter = pl08x_filter_id,
 };
 
-static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
+static const struct of_dev_auxdata const lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
 	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
 	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
@@ -248,7 +248,7 @@ static void __init lpc3250_machine_init(void)
 			     lpc32xx_auxdata_lookup, NULL);
 }
 
-static char const *lpc32xx_dt_compat[] __initdata = {
+static const char *lpc32xx_dt_compat[] __initconst = {
 	"nxp,lpc3220",
 	"nxp,lpc3230",
 	"nxp,lpc3240",
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index b2296c9309..6e155f03b8 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -20,12 +20,12 @@
 
 extern void __init mmp_dt_init_timer(void);
 
-static const char *pxa168_dt_board_compat[] __initdata = {
+static const char *const pxa168_dt_board_compat[] __initconst = {
 	"mrvl,pxa168-aspenite",
 	NULL,
 };
 
-static const char *pxa910_dt_board_compat[] __initdata = {
+static const char *const pxa910_dt_board_compat[] __initconst = {
 	"mrvl,pxa910-dkb",
 	NULL,
 };
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 998c0f533a..0341359b24 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -30,7 +30,7 @@ static void __init mmp_init_time(void)
 	of_clk_init(NULL);
 }
 
-static const char *mmp2_dt_board_compat[] __initdata = {
+static const char *const mmp2_dt_board_compat[] __initconst = {
 	"mrvl,mmp2-brownstone",
 	NULL,
 };
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 2e7cec86e5..1063af930d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -282,7 +282,7 @@ static void __init apx4devkit_init(void)
 #define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
 #define TX28_FEC_nINT		MXS_GPIO_NR(4, 5)
 
-static const struct gpio tx28_gpios[] __initconst = {
+static const struct gpio const tx28_gpios[] __initconst = {
 	{ ENET0_MDC__GPIO_4_0, GPIOF_OUT_INIT_LOW, "GPIO_4_0" },
 	{ ENET0_MDIO__GPIO_4_1, GPIOF_OUT_INIT_LOW, "GPIO_4_1" },
 	{ ENET0_RX_EN__GPIO_4_2, GPIOF_OUT_INIT_LOW, "GPIO_4_2" },
@@ -528,7 +528,7 @@ static void mxs_restart(enum reboot_mode mode, const char *cmd)
 	soft_restart(0);
 }
 
-static const char *mxs_dt_compat[] __initdata = {
+static const char *mxs_dt_compat[] __initconst = {
 	"fsl,imx28",
 	"fsl,imx23",
 	NULL,
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 7add7994db..f62f8326aa 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -705,7 +705,7 @@ static struct omap_prcm_init_data scrm_data __initdata = {
 };
 #endif
 
-static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
+static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
 #ifdef CONFIG_SOC_AM33XX
 	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
 #endif
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 076fd20d7e..c9ae7bed68 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -563,7 +563,7 @@ struct i2c_init_data {
 	u8 hsscll_12;
 };
 
-static const __initdata struct i2c_init_data omap4_i2c_timing_data[] = {
+static const struct i2c_init_data omap4_i2c_timing_data[] __initconst = {
 	{
 		.load = 50,
 		.loadbits = 0x3,
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 261bb7cb4e..307676d8c5 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -95,7 +95,7 @@ static struct voltagedomain *voltagedomains_am35xx[] __initdata = {
 };
 
 
-static const char *sys_clk_name __initdata = "sys_ck";
+static const char *const sys_clk_name __initconst = "sys_ck";
 
 void __init omap3xxx_voltagedomains_init(void)
 {
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 48b22a0a0c..9b1f245b57 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -92,7 +92,7 @@ static struct voltagedomain *voltagedomains_omap4[] __initdata = {
 	NULL,
 };
 
-static const char *sys_clk_name __initdata = "sys_clkin_ck";
+static const char *const sys_clk_name __initconst = "sys_clkin_ck";
 
 void __init omap44xx_voltagedomains_init(void)
 {
diff --git a/arch/arm/mach-omap2/voltagedomains54xx_data.c b/arch/arm/mach-omap2/voltagedomains54xx_data.c
index 33d22b8725..af5ff64964 100644
--- a/arch/arm/mach-omap2/voltagedomains54xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains54xx_data.c
@@ -78,7 +78,7 @@ static struct voltagedomain *voltagedomains_omap5[] __initdata = {
 	NULL,
 };
 
-static const char *sys_clk_name __initdata = "sys_clkin";
+static const char *const sys_clk_name __initconst = "sys_clkin";
 
 void __init omap54xx_voltagedomains_init(void)
 {
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 7e0e5bd0c9..167d127b60 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -19,7 +19,7 @@
 #include "generic.h"
 
 #ifdef CONFIG_PXA3xx
-static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
+static const struct of_dev_auxdata const pxa3xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40100000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40200000, "pxa2xx-uart.1", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40700000, "pxa2xx-uart.2", NULL),
@@ -39,7 +39,7 @@ static void __init pxa3xx_dt_init(void)
 			     pxa3xx_auxdata_lookup, NULL);
 }
 
-static const char *pxa3xx_dt_board_compat[] __initdata = {
+static const char *pxa3xx_dt_board_compat[] __initconst = {
 	"marvell,pxa300",
 	"marvell,pxa310",
 	"marvell,pxa320",
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
index cc28b89dd4..382cc1b905 100644
--- a/arch/arm/mach-realview/realview-dt.c
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -13,7 +13,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 
-static const char *realview_dt_platform_compat[] __initconst = {
+static const char *const realview_dt_platform_compat[] __initconst = {
 	"arm,realview-eb",
 	"arm,realview-pb1176",
 	"arm,realview-pb11mp",
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index f886478b88..5f028ff84c 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -39,7 +39,7 @@ static void __init s3c2416_dt_machine_init(void)
 	s3c_pm_init();
 }
 
-static char const *s3c2416_dt_compat[] __initdata = {
+static const char *const s3c2416_dt_compat[] __initconst = {
 	"samsung,s3c2416",
 	"samsung,s3c2450",
 	NULL
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 2fddf38192..94e5bcfec9 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -61,7 +61,7 @@ static void s3c64xx_dt_restart(enum reboot_mode mode, const char *cmd)
 	soft_restart(0);
 }
 
-static char const *s3c64xx_dt_compat[] __initdata = {
+static const char *const s3c64xx_dt_compat[] __initconst = {
 	"samsung,s3c6400",
 	"samsung,s3c6410",
 	NULL
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index bf37e3c532..1e7c933c4d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1348,7 +1348,7 @@ static void eva_restart(enum reboot_mode mode, const char *cmd)
 	writel((1 << 31), RESCNT2);
 }
 
-static const char *eva_boards_compat_dt[] __initdata = {
+static const char *const eva_boards_compat_dt[] __initconst = {
 	"renesas,armadillo800eva",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 9a74efda3d..4f78296f7d 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -72,7 +72,7 @@ static void __init bockw_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char *bockw_boards_compat_dt[] __initdata = {
+static const char *const bockw_boards_compat_dt[] __initconst = {
 	"renesas,bockw-reference",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 25558d1f41..25a0e7233f 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -723,7 +723,7 @@ static void __init bockw_init_late(void)
 	ADD_USB_FUNC_DEVICE_IF_POSSIBLE();
 }
 
-static const char *bockw_boards_compat_dt[] __initdata = {
+static const char *const bockw_boards_compat_dt[] __initconst = {
 	"renesas,bockw",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 260d8319fd..aa591e8393 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -898,7 +898,7 @@ static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
 	writel((1 << 31), RESCNT2);
 }
 
-static const char *kzm9g_boards_compat_dt[] __initdata = {
+static const char *const kzm9g_boards_compat_dt[] __initconst = {
 	"renesas,kzm9g",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index b15eb92326..59ff4fbb64 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -38,7 +38,7 @@ static void __init marzen_init(void)
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
 }
 
-static const char *marzen_boards_compat_dt[] __initdata = {
+static const char *const marzen_boards_compat_dt[] __initconst = {
 	"renesas,marzen",
 	"renesas,marzen-reference",
 	NULL,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 51db288f19..2fff1aa5ab 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -330,7 +330,7 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
-static const char *marzen_boards_compat_dt[] __initdata = {
+static const char *const marzen_boards_compat_dt[] __initconst = {
         "renesas,marzen",
         NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 171174777b..d46639fc68 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -20,7 +20,7 @@
 
 #include "common.h"
 
-static const char *r7s72100_boards_compat_dt[] __initdata = {
+static const char *const r7s72100_boards_compat_dt[] __initconst = {
 	"renesas,r7s72100",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 446cee6119..20173c4f41 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -20,7 +20,7 @@
 
 #include "common.h"
 
-static const char *r8a73a4_boards_compat_dt[] __initdata = {
+static const char *const r8a73a4_boards_compat_dt[] __initconst = {
 	"renesas,r8a73a4",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 00291cc177..a15b2f16dd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -787,7 +787,7 @@ static void __init r8a7740_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char *r8a7740_boards_compat_dt[] __initdata = {
+static const char *const r8a7740_boards_compat_dt[] __initconst = {
 	"renesas,r8a7740",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index c49aa094fe..b9116c81e5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -615,7 +615,7 @@ void __init r8a7778_init_irq_dt(void)
 	iounmap(base);
 }
 
-static const char *r8a7778_compat_dt[] __initdata = {
+static const char *const r8a7778_compat_dt[] __initconst = {
 	"renesas,r8a7778",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index c03e562be1..7a457eacd5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -756,7 +756,7 @@ u32 __init r8a7779_read_mode_pins(void)
 	return mode;
 }
 
-static const char *r8a7779_compat_dt[] __initdata = {
+static const char *const r8a7779_compat_dt[] __initconst = {
 	"renesas,r8a7779",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ef8eb3af58..3b8dbaf077 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -23,7 +23,7 @@
 #include "r8a7791.h"
 #include "rcar-gen2.h"
 
-static const char *r8a7791_boards_compat_dt[] __initdata = {
+static const char *const r8a7791_boards_compat_dt[] __initconst = {
 	"renesas,r8a7791",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fb2ab7590a..d09b787007 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -794,7 +794,7 @@ static void __init sh73a0_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char *sh73a0_boards_compat_dt[] __initdata = {
+static const char *const sh73a0_boards_compat_dt[] __initconst = {
 	"renesas,sh73a0",
 	NULL,
 };
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 26fda4ed4d..a92b1aab74 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -193,7 +193,7 @@ static void __init spear_clockevent_init(int irq)
 	setup_irq(irq, &spear_timer_irq);
 }
 
-const static struct of_device_id timer_of_match[] __initconst = {
+static const struct of_device_id timer_of_match[] __initconst = {
 	{ .compatible = "st,spear-timer", },
 	{ },
 };
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index b373acade3..ae10fb280a 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -14,7 +14,7 @@
 
 #include "smp.h"
 
-static const char *stih41x_dt_match[] __initdata = {
+static const char *const stih41x_dt_match[] __initconst = {
 	"st,stih415",
 	"st,stih416",
 	"st,stih407",
diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
index 60bb1a8e1b..a041e13ab0 100644
--- a/arch/arm/mach-zx/zx296702.c
+++ b/arch/arm/mach-zx/zx296702.c
@@ -13,7 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
-static const char *zx296702_dt_compat[] __initconst = {
+static const char *const zx296702_dt_compat[] __initconst = {
 	"zte,zx296702",
 	NULL,
 };
