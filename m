From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Jul 2014 18:07:18 +0100
Subject: [PATCH v4 1/2] platform: Remove most references to platform_bus device
Message-ID: <1406135239-17550-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of board files in arch/arm and arch/unicore32
explicitly reference platform_bus device as a parent
for new platform devices.

This is unnecessary, as platform device API guarantees
that devices with NULL parent are going to by adopted
by the mentioned "root" device.

This patch removes or replaces with NULL such references.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-bcm/board_bcm21664.c      |  3 +--
 arch/arm/mach-bcm/board_bcm281xx.c      |  3 +--
 arch/arm/mach-clps711x/board-edb7211.c  |  6 +++---
 arch/arm/mach-clps711x/board-p720t.c    |  6 +++---
 arch/arm/mach-imx/mach-mx27ads.c        |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c  | 14 +++++++-------
 arch/arm/mach-shmobile/board-bockw.c    | 19 ++++++++----------
 arch/arm/mach-shmobile/board-genmai.c   |  5 ++---
 arch/arm/mach-shmobile/board-koelsch.c  | 26 ++++++++++++-------------
 arch/arm/mach-shmobile/board-lager.c    | 34 ++++++++++++++-------------------
 arch/arm/mach-shmobile/board-marzen.c   |  1 -
 arch/arm/mach-shmobile/setup-r7s72100.c |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c  |  8 ++++----
 arch/arm/mach-shmobile/setup-r8a7778.c  | 13 ++++++-------
 arch/arm/mach-shmobile/setup-r8a7779.c  |  6 +++---
 arch/arm/mach-shmobile/setup-r8a7790.c  | 10 +++++-----
 arch/arm/mach-shmobile/setup-r8a7791.c  |  8 ++++----
 arch/unicore32/kernel/puv3-core.c       |  2 +-
 arch/unicore32/kernel/puv3-nb0916.c     |  6 +++---
 19 files changed, 79 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/mach-bcm/board_bcm21664.c
index f0521cc..82ad568 100644
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@ -60,8 +60,7 @@ static void bcm21664_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm21664_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL,
-		&platform_bus);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 1ac59fc..2e367bd 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -58,8 +58,7 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init bcm281xx_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL,
-		&platform_bus);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	kona_l2_cache_init();
 }
 
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index f9828f8..6144fb5 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -158,16 +158,16 @@ static void __init edb7211_init_late(void)
 	gpio_request_array(edb7211_gpios, ARRAY_SIZE(edb7211_gpios));
 
 	platform_device_register(&edb7211_flash_pdev);
-	platform_device_register_data(&platform_bus, "platform-lcd", 0,
+	platform_device_register_data(NULL, "platform-lcd", 0,
 				      &edb7211_lcd_power_pdata,
 				      sizeof(edb7211_lcd_power_pdata));
-	platform_device_register_data(&platform_bus, "generic-bl", 0,
+	platform_device_register_data(NULL, "generic-bl", 0,
 				      &edb7211_lcd_backlight_pdata,
 				      sizeof(edb7211_lcd_backlight_pdata));
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, edb7211_cs8900_resource,
 					ARRAY_SIZE(edb7211_cs8900_resource));
-	platform_device_register_data(&platform_bus, "i2c-gpio", 0,
+	platform_device_register_data(NULL, "i2c-gpio", 0,
 				      &edb7211_i2c_pdata,
 				      sizeof(edb7211_i2c_pdata));
 }
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 0cf0e51..96bcc76 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -348,14 +348,14 @@ static void __init p720t_init_late(void)
 {
 	WARN_ON(gpio_request_array(p720t_gpios, ARRAY_SIZE(p720t_gpios)));
 
-	platform_device_register_data(&platform_bus, "platform-lcd", 0,
+	platform_device_register_data(NULL, "platform-lcd", 0,
 				      &p720t_lcd_power_pdata,
 				      sizeof(p720t_lcd_power_pdata));
-	platform_device_register_data(&platform_bus, "generic-bl", 0,
+	platform_device_register_data(NULL, "generic-bl", 0,
 				      &p720t_lcd_backlight_pdata,
 				      sizeof(p720t_lcd_backlight_pdata));
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
-	platform_device_register_data(&platform_bus, "leds-gpio", 0,
+	platform_device_register_data(NULL, "leds-gpio", 0,
 				      &p720t_gpio_led_pdata,
 				      sizeof(p720t_gpio_led_pdata));
 }
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 2f834ce..eb1c347 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -245,7 +245,7 @@ static void __init mx27ads_regulator_init(void)
 	vchip->set		= vgpio_set;
 	gpiochip_add(vchip);
 
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
+	platform_device_register_data(NULL, "reg-fixed-voltage",
 				      PLATFORM_DEVID_AUTO,
 				      &mx27ads_lcd_regulator_pdata,
 				      sizeof(mx27ads_lcd_regulator_pdata));
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index fe071a9..7ab99a4 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -248,29 +248,29 @@ static void __init ape6evm_add_standard_devices(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
-	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
+	platform_device_register_resndata(NULL, "smsc911x", -1,
 					  lan9220_res, ARRAY_SIZE(lan9220_res),
 					  &lan9220_data, sizeof(lan9220_data));
 
 	regulator_register_always_on(1, "MMC0 Vcc", vcc_mmc0_consumers,
 				     ARRAY_SIZE(vcc_mmc0_consumers), 2800000);
-	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
+	platform_device_register_resndata(NULL, "sh_mmcif", 0,
 					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
 					  &mmcif0_pdata, sizeof(mmcif0_pdata));
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", 2,
+	platform_device_register_data(NULL, "reg-fixed-voltage", 2,
 				      &vcc_sdhi0_info, sizeof(vcc_sdhi0_info));
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 0,
 					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
 					  &sdhi0_pdata, sizeof(sdhi0_pdata));
 	regulator_register_always_on(3, "SDHI1 Vcc", vcc_sdhi1_consumers,
 				     ARRAY_SIZE(vcc_sdhi1_consumers), 3300000);
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 1,
 					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
 					  &sdhi1_pdata, sizeof(sdhi1_pdata));
-	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+	platform_device_register_data(NULL, "gpio-keys", -1,
 				      &ape6evm_keys_pdata,
 				      sizeof(ape6evm_keys_pdata));
-	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+	platform_device_register_data(NULL, "leds-gpio", -1,
 				      &ape6evm_leds_pdata,
 				      sizeof(ape6evm_leds_pdata));
 }
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index f444be2..3ec82a4 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -177,7 +177,7 @@ static struct renesas_usbhs_platform_info usbhs_info __initdata = {
 #define USB1_DEVICE	"renesas_usbhs"
 #define ADD_USB_FUNC_DEVICE_IF_POSSIBLE()			\
 	platform_device_register_resndata(			\
-		&platform_bus, "renesas_usbhs", -1,		\
+		NULL, "renesas_usbhs", -1,			\
 		usbhsf_resources,				\
 		ARRAY_SIZE(usbhsf_resources),			\
 		&usbhs_info, sizeof(struct renesas_usbhs_platform_info))
@@ -236,7 +236,6 @@ static struct sh_eth_plat_data ether_platform_data __initdata = {
 };
 
 static struct platform_device_info ether_info __initdata = {
-	.parent		= &platform_bus,
 	.name		= "r8a777x-ether",
 	.id		= -1,
 	.res		= ether_resources,
@@ -322,7 +321,6 @@ static struct resource vin##idx##_resources[] __initdata = {		\
 };									\
 									\
 static struct platform_device_info vin##idx##_info __initdata = {	\
-	.parent		= &platform_bus,				\
 	.name		= "r8a7778-vin",				\
 	.id		= idx,						\
 	.res		= vin##idx##_resources,				\
@@ -621,10 +619,10 @@ static void __init bockw_init(void)
 	/* VIN1 has a pin conflict with Ether */
 	if (!IS_ENABLED(CONFIG_SH_ETH))
 		platform_device_register_full(&vin1_info);
-	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 0,
+	platform_device_register_data(NULL, "soc-camera-pdrv", 0,
 				      &iclink0_ml86v7667,
 				      sizeof(iclink0_ml86v7667));
-	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 1,
+	platform_device_register_data(NULL, "soc-camera-pdrv", 1,
 				      &iclink1_ml86v7667,
 				      sizeof(iclink1_ml86v7667));
 
@@ -637,12 +635,12 @@ static void __init bockw_init(void)
 	r8a7778_pinmux_init();
 
 	platform_device_register_resndata(
-		&platform_bus, "sh_mmcif", -1,
+		NULL, "sh_mmcif", -1,
 		mmc_resources, ARRAY_SIZE(mmc_resources),
 		&sh_mmcif_plat, sizeof(struct sh_mmcif_plat_data));
 
 	platform_device_register_resndata(
-		&platform_bus, "rcar_usb_phy", -1,
+		NULL, "rcar_usb_phy", -1,
 		usb_phy_resources,
 		ARRAY_SIZE(usb_phy_resources),
 		&usb_phy_platform_data,
@@ -668,7 +666,7 @@ static void __init bockw_init(void)
 		iowrite16(val, fpga + IRQ0MR);
 
 		platform_device_register_resndata(
-			&platform_bus, "smsc911x", -1,
+			NULL, "smsc911x", -1,
 			smsc911x_resources, ARRAY_SIZE(smsc911x_resources),
 			&smsc911x_data, sizeof(smsc911x_data));
 	}
@@ -685,7 +683,7 @@ static void __init bockw_init(void)
 		iounmap(base);
 
 		platform_device_register_resndata(
-			&platform_bus, "sh_mobile_sdhi", 0,
+			NULL, "sh_mobile_sdhi", 0,
 			sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
 			&sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
 	}
@@ -700,7 +698,7 @@ static void __init bockw_init(void)
 		"ak4554-adc-dac", 1, NULL, 0);
 
 	pdev = platform_device_register_resndata(
-		&platform_bus, "rcar_sound", -1,
+		NULL, "rcar_sound", -1,
 		rsnd_resources, ARRAY_SIZE(rsnd_resources),
 		&rsnd_info, sizeof(rsnd_info));
 
@@ -710,7 +708,6 @@ static void __init bockw_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(rsnd_card_info); i++) {
 		struct platform_device_info cardinfo = {
-			.parent         = &platform_bus,
 			.name           = "asoc-simple-card",
 			.id             = i,
 			.data           = &rsnd_card_info[i],
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index c94201e..37184ff 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -46,7 +46,6 @@ static const struct resource ether_resources[] __initconst = {
 };
 
 static const struct platform_device_info ether_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "r7s72100-ether",
 	.id		= -1,
 	.res		= ether_resources,
@@ -76,7 +75,7 @@ static const struct rspi_plat_data rspi_pdata __initconst = {
 };
 
 #define r7s72100_register_rspi(idx)					   \
-	platform_device_register_resndata(&platform_bus, "rspi-rz", idx,   \
+	platform_device_register_resndata(NULL, "rspi-rz", idx,            \
 					rspi##idx##_resources,		   \
 					ARRAY_SIZE(rspi##idx##_resources), \
 					&rspi_pdata, sizeof(rspi_pdata))
@@ -118,7 +117,7 @@ R7S72100_SCIF(6, 0xe800a000, gic_iid(245));
 R7S72100_SCIF(7, 0xe800a800, gic_iid(249));
 
 #define r7s72100_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+	platform_device_register_resndata(NULL, "sh-sci", index,               \
 					  scif##index##_resources,	       \
 					  ARRAY_SIZE(scif##index##_resources), \
 					  &scif##index##_platform_data,	       \
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index c6c6889..d3aa6ae 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -118,7 +118,6 @@ static const struct resource ether_resources[] __initconst = {
 };
 
 static const struct platform_device_info ether_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "r8a7791-ether",
 	.id		= -1,
 	.res		= ether_resources,
@@ -230,7 +229,6 @@ static const struct resource sata0_resources[] __initconst = {
 };
 
 static const struct platform_device_info sata0_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "sata-r8a7791",
 	.id		= 0,
 	.res		= sata0_resources,
@@ -439,13 +437,13 @@ static void __init koelsch_add_standard_devices(void)
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
 	platform_device_register_full(&ether_info);
-	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+	platform_device_register_data(NULL, "leds-gpio", -1,
 				      &koelsch_leds_pdata,
 				      sizeof(koelsch_leds_pdata));
-	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+	platform_device_register_data(NULL, "gpio-keys", -1,
 				      &koelsch_keys_pdata,
 				      sizeof(koelsch_keys_pdata));
-	platform_device_register_resndata(&platform_bus, "qspi", 0,
+	platform_device_register_resndata(NULL, "qspi", 0,
 					  qspi_resources,
 					  ARRAY_SIZE(qspi_resources),
 					  &qspi_pdata, sizeof(qspi_pdata));
@@ -460,28 +458,28 @@ static void __init koelsch_add_standard_devices(void)
 	koelsch_add_i2c(4);
 	koelsch_add_i2c(5);
 
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", 0,
+	platform_device_register_data(NULL, "reg-fixed-voltage", 0,
 				      &vcc_sdhi0_info, sizeof(struct fixed_voltage_config));
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", 1,
+	platform_device_register_data(NULL, "reg-fixed-voltage", 1,
 				      &vcc_sdhi1_info, sizeof(struct fixed_voltage_config));
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", 2,
+	platform_device_register_data(NULL, "reg-fixed-voltage", 2,
 				      &vcc_sdhi2_info, sizeof(struct fixed_voltage_config));
-	platform_device_register_data(&platform_bus, "gpio-regulator", 0,
+	platform_device_register_data(NULL, "gpio-regulator", 0,
 				      &vccq_sdhi0_info, sizeof(struct gpio_regulator_config));
-	platform_device_register_data(&platform_bus, "gpio-regulator", 1,
+	platform_device_register_data(NULL, "gpio-regulator", 1,
 				      &vccq_sdhi1_info, sizeof(struct gpio_regulator_config));
-	platform_device_register_data(&platform_bus, "gpio-regulator", 2,
+	platform_device_register_data(NULL, "gpio-regulator", 2,
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
 
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 0,
 					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
 					  &sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
 
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 1,
 					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
 					  &sdhi1_info, sizeof(struct sh_mobile_sdhi_info));
 
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 2,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 2,
 					  sdhi2_resources, ARRAY_SIZE(sdhi2_resources),
 					  &sdhi2_info, sizeof(struct sh_mobile_sdhi_info));
 
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f8b1e05..d182961 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -277,7 +277,6 @@ static const struct resource ether_resources[] __initconst = {
 };
 
 static const struct platform_device_info ether_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "r8a7790-ether",
 	.id		= -1,
 	.res		= ether_resources,
@@ -354,7 +353,6 @@ static void __init lager_add_vin_device(unsigned idx,
 					struct rcar_vin_platform_data *pdata)
 {
 	struct platform_device_info vin_info = {
-		.parent		= &platform_bus,
 		.name		= "r8a7790-vin",
 		.id		= idx,
 		.res		= &vin_resources[idx * 2],
@@ -391,7 +389,7 @@ LAGER_CAMERA(1, "adv7180", 0x20, NULL, RCAR_VIN_BT656);
 
 static void __init lager_add_camera1_device(void)
 {
-	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 1,
+	platform_device_register_data(NULL, "soc-camera-pdrv", 1,
 				      &cam1_link, sizeof(cam1_link));
 	lager_add_vin_device(1, &vin1_pdata);
 }
@@ -403,7 +401,6 @@ static const struct resource sata1_resources[] __initconst = {
 };
 
 static const struct platform_device_info sata1_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "sata-r8a7790",
 	.id		= 1,
 	.res		= sata1_resources,
@@ -533,7 +530,7 @@ static struct usbhs_private usbhs_priv __initdata = {
 static void __init lager_register_usbhs(void)
 {
 	usb_bind_phy("renesas_usbhs", 0, "usb_phy_rcar_gen2");
-	platform_device_register_resndata(&platform_bus,
+	platform_device_register_resndata(NULL,
 					  "renesas_usbhs", -1,
 					  usbhs_resources,
 					  ARRAY_SIZE(usbhs_resources),
@@ -608,7 +605,6 @@ static struct asoc_simple_card_info rsnd_card_info = {
 static void __init lager_add_rsnd_device(void)
 {
 	struct platform_device_info cardinfo = {
-		.parent         = &platform_bus,
 		.name           = "asoc-simple-card",
 		.id             = -1,
 		.data           = &rsnd_card_info,
@@ -620,7 +616,7 @@ static void __init lager_add_rsnd_device(void)
 				ARRAY_SIZE(i2c2_devices));
 
 	platform_device_register_resndata(
-		&platform_bus, "rcar_sound", -1,
+		NULL, "rcar_sound", -1,
 		rsnd_resources, ARRAY_SIZE(rsnd_resources),
 		&rsnd_info, sizeof(rsnd_info));
 
@@ -663,7 +659,6 @@ static const struct resource pci1_resources[] __initconst = {
 };
 
 static const struct platform_device_info pci1_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "pci-rcar-gen2",
 	.id		= 1,
 	.res		= pci1_resources,
@@ -684,7 +679,6 @@ static const struct resource pci2_resources[] __initconst = {
 };
 
 static const struct platform_device_info pci2_info __initconst = {
-	.parent		= &platform_bus,
 	.name		= "pci-rcar-gen2",
 	.id		= 2,
 	.res		= pci2_resources,
@@ -795,16 +789,16 @@ static void __init lager_add_standard_devices(void)
 	r8a7790_pinmux_init();
 
 	r8a7790_add_standard_devices();
-	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+	platform_device_register_data(NULL, "leds-gpio", -1,
 				      &lager_leds_pdata,
 				      sizeof(lager_leds_pdata));
-	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+	platform_device_register_data(NULL, "gpio-keys", -1,
 				      &lager_keys_pdata,
 				      sizeof(lager_keys_pdata));
 	regulator_register_always_on(fixed_regulator_idx++,
 				     "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
-	platform_device_register_resndata(&platform_bus, "sh_mmcif", 1,
+	platform_device_register_resndata(NULL, "sh_mmcif", 1,
 					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
 					  &mmcif1_pdata, sizeof(mmcif1_pdata));
 
@@ -812,27 +806,27 @@ static void __init lager_add_standard_devices(void)
 
 	lager_add_du_device();
 
-	platform_device_register_resndata(&platform_bus, "qspi", 0,
+	platform_device_register_resndata(NULL, "qspi", 0,
 					  qspi_resources,
 					  ARRAY_SIZE(qspi_resources),
 					  &qspi_pdata, sizeof(qspi_pdata));
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", fixed_regulator_idx++,
+	platform_device_register_data(NULL, "reg-fixed-voltage", fixed_regulator_idx++,
 				      &vcc_sdhi0_info, sizeof(struct fixed_voltage_config));
-	platform_device_register_data(&platform_bus, "reg-fixed-voltage", fixed_regulator_idx++,
+	platform_device_register_data(NULL, "reg-fixed-voltage", fixed_regulator_idx++,
 				      &vcc_sdhi2_info, sizeof(struct fixed_voltage_config));
 
-	platform_device_register_data(&platform_bus, "gpio-regulator", gpio_regulator_idx++,
+	platform_device_register_data(NULL, "gpio-regulator", gpio_regulator_idx++,
 				      &vccq_sdhi0_info, sizeof(struct gpio_regulator_config));
-	platform_device_register_data(&platform_bus, "gpio-regulator", gpio_regulator_idx++,
+	platform_device_register_data(NULL, "gpio-regulator", gpio_regulator_idx++,
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
 
 	lager_add_camera1_device();
 
 	platform_device_register_full(&sata1_info);
 
-	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+	platform_device_register_resndata(NULL, "usb_phy_rcar_gen2",
 					  -1, usbhs_phy_resources,
 					  ARRAY_SIZE(usbhs_phy_resources),
 					  &usbhs_phy_pdata,
@@ -843,10 +837,10 @@ static void __init lager_add_standard_devices(void)
 
 	lager_add_rsnd_device();
 
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 0,
 					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
 					  &sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
-	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 2,
+	platform_device_register_resndata(NULL, "sh_mobile_sdhi", 2,
 					  sdhi2_resources, ARRAY_SIZE(sdhi2_resources),
 					  &sdhi2_info, sizeof(struct sh_mobile_sdhi_info));
 }
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index d832a44..6ed324c 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -272,7 +272,6 @@ static struct resource vin##idx##_resources[] __initdata = {	\
 };								\
 								\
 static struct platform_device_info vin##idx##_info __initdata = { \
-	.parent		= &platform_bus,			\
 	.name		= "r8a7779-vin",			\
 	.id		= idx,					\
 	.res		= vin##idx##_resources,			\
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 412e179..3885a59 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -33,7 +33,7 @@ static struct resource mtu2_resources[] __initdata = {
 };
 
 #define r7s72100_register_mtu2()					\
-	platform_device_register_resndata(&platform_bus, "sh-mtu2",	\
+	platform_device_register_resndata(NULL, "sh-mtu2",		\
 					  -1, mtu2_resources,		\
 					  ARRAY_SIZE(mtu2_resources),	\
 					  NULL, 0)
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 9333770..aaaaf6e 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -68,7 +68,7 @@ R8A73A4_SCIFB(4, 0xe6ce0000, gic_spi(150)); /* SCIFB2 */
 R8A73A4_SCIFB(5, 0xe6cf0000, gic_spi(151)); /* SCIFB3 */
 
 #define r8a73a4_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+	platform_device_register_resndata(NULL, "sh-sci", index,	       \
 					  scif##index##_resources,	       \
 					  ARRAY_SIZE(scif##index##_resources), \
 					  &scif##index##_platform_data,	       \
@@ -149,7 +149,7 @@ static const struct resource irqc1_resources[] = {
 };
 
 #define r8a73a4_register_irqc(idx)					\
-	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+	platform_device_register_resndata(NULL, "renesas_irqc", 	\
 					  idx, irqc##idx##_resources,	\
 					  ARRAY_SIZE(irqc##idx##_resources), \
 					  &irqc##idx##_data,		\
@@ -179,7 +179,7 @@ static struct resource cmt1_resources[] = {
 };
 
 #define r8a7790_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
+	platform_device_register_resndata(NULL, "sh-cmt-48-gen2",	\
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
@@ -280,7 +280,7 @@ static struct resource dma_resources[] = {
 };
 
 #define r8a73a4_register_dmac()							\
-	platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,	\
+	platform_device_register_resndata(NULL, "sh-dma-engine", 0,		\
 				dma_resources, ARRAY_SIZE(dma_resources),	\
 				&dma_pdata, sizeof(dma_pdata))
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d311ef9..5de7b33 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -64,7 +64,7 @@ R8A7778_SCIF(4, 0xffe44000, gic_iid(0x6a));
 R8A7778_SCIF(5, 0xffe45000, gic_iid(0x6b));
 
 #define r8a7778_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+	platform_device_register_resndata(NULL, "sh-sci", index,	       \
 					  scif##index##_resources,	       \
 					  ARRAY_SIZE(scif##index##_resources), \
 					  &scif##index##_platform_data,	       \
@@ -84,7 +84,7 @@ static struct resource sh_tmu0_resources[] = {
 
 #define r8a7778_register_tmu(idx)			\
 	platform_device_register_resndata(		\
-		&platform_bus, "sh-tmu", idx,		\
+		NULL, "sh-tmu", idx,			\
 		sh_tmu##idx##_resources,		\
 		ARRAY_SIZE(sh_tmu##idx##_resources),	\
 		&sh_tmu##idx##_platform_data,		\
@@ -173,7 +173,6 @@ static struct resource ohci_resources[] __initdata = {
 
 #define USB_PLATFORM_INFO(hci)					\
 static struct platform_device_info hci##_info __initdata = {	\
-	.parent		= &platform_bus,			\
 	.name		= #hci "-platform",			\
 	.id		= -1,					\
 	.res		= hci##_resources,			\
@@ -212,7 +211,7 @@ R8A7778_GPIO(4);
 
 #define r8a7778_register_gpio(idx)				\
 	platform_device_register_resndata(			\
-		&platform_bus, "gpio_rcar", idx,		\
+		NULL, "gpio_rcar", idx,				\
 		r8a7778_gpio##idx##_resources,			\
 		ARRAY_SIZE(r8a7778_gpio##idx##_resources),	\
 		&r8a7778_gpio##idx##_platform_data,		\
@@ -496,8 +495,8 @@ static struct resource hpb_dmae_resources[] __initdata = {
 
 static void __init r8a7778_register_hpb_dmae(void)
 {
-	platform_device_register_resndata(&platform_bus, "hpb-dma-engine", -1,
-					  hpb_dmae_resources,
+	platform_device_register_resndata(NULL, "hpb-dma-engine",
+					  -1, hpb_dmae_resources,
 					  ARRAY_SIZE(hpb_dmae_resources),
 					  &dma_platform_data,
 					  sizeof(dma_platform_data));
@@ -565,7 +564,7 @@ void __init r8a7778_init_irq_extpin(int irlm)
 	r8a7778_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
-			&platform_bus, "renesas_intc_irqpin", -1,
+			NULL, "renesas_intc_irqpin", -1,
 			irqpin_resources, ARRAY_SIZE(irqpin_resources),
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index aba4ed6..9c79182 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -123,7 +123,7 @@ void __init r8a7779_init_irq_extpin(int irlm)
 	r8a7779_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
-			&platform_bus, "renesas_intc_irqpin", -1,
+			NULL, "renesas_intc_irqpin", -1,
 			irqpin0_resources, ARRAY_SIZE(irqpin0_resources),
 			&irqpin0_platform_data, sizeof(irqpin0_platform_data));
 }
@@ -632,8 +632,8 @@ static struct resource hpb_dmae_resources[] __initdata = {
 
 static void __init r8a7779_register_hpb_dmae(void)
 {
-	platform_device_register_resndata(&platform_bus, "hpb-dma-engine", -1,
-					  hpb_dmae_resources,
+	platform_device_register_resndata(NULL, "hpb-dma-engine",
+					  -1, hpb_dmae_resources,
 					  ARRAY_SIZE(hpb_dmae_resources),
 					  &dma_platform_data,
 					  sizeof(dma_platform_data));
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 6bd08b1..10e6768 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -113,7 +113,7 @@ static struct resource r8a7790_audio_dmac_resources[] = {
 
 #define r8a7790_register_audio_dmac(id)				\
 	platform_device_register_resndata(			\
-		&platform_bus, "sh-dma-engine", id,		\
+		NULL, "sh-dma-engine", id,			\
 		&r8a7790_audio_dmac_resources[id * 3],	3,	\
 		&r8a7790_audio_dmac_platform_data,		\
 		sizeof(r8a7790_audio_dmac_platform_data))
@@ -149,7 +149,7 @@ R8A7790_GPIO(4);
 R8A7790_GPIO(5);
 
 #define r8a7790_register_gpio(idx)					\
-	platform_device_register_resndata(&platform_bus, "gpio_rcar", idx, \
+	platform_device_register_resndata(NULL, "gpio_rcar", idx,	\
 		r8a7790_gpio##idx##_resources,				\
 		ARRAY_SIZE(r8a7790_gpio##idx##_resources),		\
 		&r8a7790_gpio##idx##_platform_data,			\
@@ -227,7 +227,7 @@ R8A7790_HSCIF(8, 0xe62c0000, gic_spi(154)); /* HSCIF0 */
 R8A7790_HSCIF(9, 0xe62c8000, gic_spi(155)); /* HSCIF1 */
 
 #define r8a7790_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+	platform_device_register_resndata(NULL, "sh-sci", index,  	       \
 					  scif##index##_resources,	       \
 					  ARRAY_SIZE(scif##index##_resources), \
 					  &scif##index##_platform_data,	       \
@@ -246,7 +246,7 @@ static const struct resource irqc0_resources[] __initconst = {
 };
 
 #define r8a7790_register_irqc(idx)					\
-	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+	platform_device_register_resndata(NULL, "renesas_irqc",		\
 					  idx, irqc##idx##_resources,	\
 					  ARRAY_SIZE(irqc##idx##_resources), \
 					  &irqc##idx##_data,		\
@@ -273,7 +273,7 @@ static struct resource cmt0_resources[] = {
 };
 
 #define r8a7790_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
+	platform_device_register_resndata(NULL, "sh-cmt-48-gen2",	\
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 04a96dd..fd54437 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -65,7 +65,7 @@ R8A7791_GPIO(6, 0xe6055400, 32);
 R8A7791_GPIO(7, 0xe6055800, 26);
 
 #define r8a7791_register_gpio(idx)					\
-	platform_device_register_resndata(&platform_bus, "gpio_rcar", idx, \
+	platform_device_register_resndata(NULL, "gpio_rcar", idx,	\
 		r8a7791_gpio##idx##_resources,				\
 		ARRAY_SIZE(r8a7791_gpio##idx##_resources),		\
 		&r8a7791_gpio##idx##_platform_data,			\
@@ -122,7 +122,7 @@ R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
 R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
 
 #define r8a7791_register_scif(index)					       \
-	platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
+	platform_device_register_resndata(NULL, "sh-sci", index,  	       \
 					  scif##index##_resources,	       \
 					  ARRAY_SIZE(scif##index##_resources), \
 					  &scif##index##_platform_data,	       \
@@ -138,7 +138,7 @@ static struct resource cmt0_resources[] = {
 };
 
 #define r8a7791_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
+	platform_device_register_resndata(NULL, "sh-cmt-48-gen2",	\
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
@@ -163,7 +163,7 @@ static struct resource irqc0_resources[] = {
 };
 
 #define r8a7791_register_irqc(idx)					\
-	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+	platform_device_register_resndata(NULL, "renesas_irqc",		\
 					  idx, irqc##idx##_resources,	\
 					  ARRAY_SIZE(irqc##idx##_resources), \
 					  &irqc##idx##_data,		\
diff --git a/arch/unicore32/kernel/puv3-core.c b/arch/unicore32/kernel/puv3-core.c
index 254adee..438dd2e 100644
--- a/arch/unicore32/kernel/puv3-core.c
+++ b/arch/unicore32/kernel/puv3-core.c
@@ -272,7 +272,7 @@ void __init puv3_core_init(void)
 	platform_device_register_simple("PKUnity-v3-UART", 1,
 			puv3_uart1_resources, ARRAY_SIZE(puv3_uart1_resources));
 	platform_device_register_simple("PKUnity-v3-AC97", -1, NULL, 0);
-	platform_device_register_resndata(&platform_bus, "musb_hdrc", -1,
+	platform_device_register_resndata(NULL, "musb_hdrc", -1,
 			puv3_usb_resources, ARRAY_SIZE(puv3_usb_resources),
 			&puv3_usb_plat, sizeof(puv3_usb_plat));
 }
diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 0c6618e..46ebfdc 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -112,13 +112,13 @@ int __init mach_nb0916_init(void)
 	platform_device_register_simple("PKUnity-v3-I2C", -1,
 			puv3_i2c_resources, ARRAY_SIZE(puv3_i2c_resources));
 
-	platform_device_register_data(&platform_bus, "pwm-backlight", -1,
+	platform_device_register_data(NULL, "pwm-backlight", -1,
 			&nb0916_backlight_data, sizeof(nb0916_backlight_data));
 
-	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+	platform_device_register_data(NULL, "gpio-keys", -1,
 			&nb0916_gpio_button_data, sizeof(nb0916_gpio_button_data));
 
-	platform_device_register_resndata(&platform_bus, "physmap-flash", -1,
+	platform_device_register_resndata(NULL, "physmap-flash", -1,
 			&physmap_flash_resource, 1,
 			&physmap_flash_data, sizeof(physmap_flash_data));
 
-- 
1.9.1
