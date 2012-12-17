From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 17 Dec 2012 13:40:45 +0100 (CET)
Subject: [PATCH v2 6/7] ARM: mackerel: support booting with or without DT
In-Reply-To: <1355503531-7276-7-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-7-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <Pine.LNX.4.64.1212171332520.24007@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dynamic switching to booting either with or without DT.
So far only a part of the board initialisation can be done via DT. Devices,
that still need platform data are kept that way. Devices, that can be
initialised from DT will not be supplied from the platform data, if a DT
image is detected.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Simon

As suggested by you we drop patch #3/7 "ARM: sh7372: support mixed DT and 
board code interrupt controller init" and as suggested by Grant we drop 
patch #4/7 "ARM: sh7372: add clock lookup entries for DT-based devices" 
(you can drop it from your soc5 branch too now.) As a result we update 
this patch as follows:

v2:

1. use a lookup table to still be able to use non-DT clock names (thanks 
to Grant for pointing out)

2. use sh7372_init_irq in the non-DT case (thanks to Simon)

Patches 1, 2, 5 and 7 don't change.

Thanks
Guennadi

 arch/arm/mach-shmobile/board-mackerel.c |  100 +++++++++++++++++++++++++-----
 1 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 39b8f2e..6d13b3a 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1326,7 +1326,6 @@ static struct platform_device mackerel_camera = {
 
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
-	&smc911x_device,
 	&lcdc_device,
 	&usbhs0_device,
 	&usbhs1_device,
@@ -1335,17 +1334,21 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_ak4643_device,
 	&fsi_hdmi_device,
 	&nand_flash_device,
+	&ceu_device,
+	&mackerel_camera,
+	&hdmi_device,
+	&hdmi_lcdc_device,
+	&meram_device,
+};
+
+static struct platform_device *mackerel_devices_dt[] __initdata = {
+	&smc911x_device,
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
 #endif
 	&sdhi2_device,
 	&sh_mmcif_device,
-	&ceu_device,
-	&mackerel_camera,
-	&hdmi_device,
-	&hdmi_lcdc_device,
-	&meram_device,
 };
 
 /* Keypad Initialization */
@@ -1404,6 +1407,41 @@ static struct i2c_board_info i2c1_devices[] = {
 	},
 };
 
+static int mackerel_i2c_bus_notify(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	/* We're only interested in 1 event: when the adapter is added */
+	if (action != BUS_NOTIFY_ADD_DEVICE ||
+	    strcmp(dev_name(dev->parent), "i2c-sh_mobile.0"))
+		return NOTIFY_DONE;
+
+	i2c_new_device(to_i2c_adapter(dev), &i2c0_devices[1]);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mackerel_i2c_notifier = {
+	.notifier_call = mackerel_i2c_bus_notify,
+};
+
+/*
+ * Auxdata required until real OF clocks are provided
+ */
+struct of_dev_auxdata mackerel_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xfff20000, "i2c-sh_mobile.0", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6c20000, "i2c-sh_mobile.1", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xfff30000, "i2c-sh_mobile.2", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6d20000, "i2c-sh_mobile.3", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6d30000, "i2c-sh_mobile.4", NULL),
+	OF_DEV_AUXDATA("renesas,shmobile-sdhi", 0xe6850000, "sh_mobile_sdhi.0", NULL),
+	OF_DEV_AUXDATA("renesas,shmobile-sdhi", 0xe6860000, "sh_mobile_sdhi.1", NULL),
+	OF_DEV_AUXDATA("renesas,shmobile-sdhi", 0xe6870000, "sh_mobile_sdhi.2", NULL),
+	OF_DEV_AUXDATA("renesas,sh-mmcif", 0xe6bd0000, "sh_mmcif.0", NULL),
+	{},
+};
+
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
 #define GPIO_PORT10CR	IOMEM(0xE605100A)
 #define GPIO_PORT167CR	IOMEM(0xE60520A7)
@@ -1420,22 +1458,26 @@ static void __init mackerel_init(void)
 		{ "A3SP", &usbhs0_device, },
 		{ "A3SP", &usbhs1_device, },
 		{ "A3SP", &nand_flash_device, },
+		{ "A4R", &ceu_device, },
+	};
+	struct pm_domain_device domain_devices_dt[] = {
 		{ "A3SP", &sh_mmcif_device, },
 		{ "A3SP", &sdhi0_device, },
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 		{ "A3SP", &sdhi1_device, },
 #endif
 		{ "A3SP", &sdhi2_device, },
-		{ "A4R", &ceu_device, },
 	};
 	u32 srcr4;
 	struct clk *clk;
 
-	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
-				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
-	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
-				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
-	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	if (!of_have_populated_dt()) {
+		regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
+					     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
+		regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+					     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+		regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	}
 
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
@@ -1633,22 +1675,36 @@ static void __init mackerel_init(void)
 	udelay(50);
 	__raw_writel(srcr4 & ~(1 << 13), SRCR4);
 
-	i2c_register_board_info(0, i2c0_devices,
-				ARRAY_SIZE(i2c0_devices));
-	i2c_register_board_info(1, i2c1_devices,
-				ARRAY_SIZE(i2c1_devices));
+	if (!of_have_populated_dt()) {
+		i2c_register_board_info(0, i2c0_devices,
+					ARRAY_SIZE(i2c0_devices));
+		i2c_register_board_info(1, i2c1_devices,
+					ARRAY_SIZE(i2c1_devices));
+	} else {
+		bus_register_notifier(&i2c_bus_type,
+				      &mackerel_i2c_notifier);
+	}
 
 	sh7372_add_standard_devices();
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
+	if (!of_have_populated_dt())
+		platform_add_devices(mackerel_devices_dt,
+				     ARRAY_SIZE(mackerel_devices_dt));
 
 	rmobile_add_devices_to_domains(domain_devices,
 				       ARRAY_SIZE(domain_devices));
+	if (!of_have_populated_dt())
+		rmobile_add_devices_to_domains(domain_devices_dt,
+					       ARRAY_SIZE(domain_devices_dt));
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
 	pm_clk_add(&fsi_device.dev, "spu2");
 	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     mackerel_auxdata_lookup, NULL);
 }
 
 static const char *mackerel_boards_compat_dt[] __initdata = {
@@ -1659,10 +1715,20 @@ static const char *mackerel_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(MACKEREL_DT, "mackerel")
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
+	.init_irq	= sh7372_init_irq_of,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= mackerel_init,
+	.init_late	= sh7372_pm_init_late,
+	.timer		= &shmobile_timer,
+	.dt_compat	= mackerel_boards_compat_dt,
+MACHINE_END
+
+MACHINE_START(MACKEREL, "mackerel")
+	.map_io		= sh7372_map_io,
+	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
 	.init_late	= sh7372_pm_init_late,
 	.timer		= &shmobile_timer,
-	.dt_compat  = mackerel_boards_compat_dt,
 MACHINE_END
-- 
1.7.2.5
