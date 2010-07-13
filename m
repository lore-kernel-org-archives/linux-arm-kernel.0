From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 13 Jul 2010 09:38:53 +0200
Subject: [PATCH 5/5] pxa: Modularize remnants of code in Palms
In-Reply-To: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
References: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1279006733-17731-5-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palmld.c   |   63 +++++++++++++++----
 arch/arm/mach-pxa/palmt5.c   |   22 ++++++-
 arch/arm/mach-pxa/palmtreo.c |  141 ++++++++++++++++++++----------------------
 arch/arm/mach-pxa/palmtx.c   |   49 ++++++++++++---
 arch/arm/mach-pxa/palmz72.c  |   22 ++++++-
 5 files changed, 196 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 166d735..1f592b5 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -128,6 +128,7 @@ static unsigned long palmld_pin_config[] __initdata = {
 /******************************************************************************
  * NOR Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition palmld_partitions[] = {
 	{
 		.name		= "Flash",
@@ -161,9 +162,18 @@ static struct platform_device palmld_flash = {
 	},
 };
 
+static void __init palmld_nor_init(void)
+{
+	platform_device_register(&palmld_flash);
+}
+#else
+static inline void palmld_nor_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmld_matrix_keys[] = {
 	KEY(0, 1, KEY_F2),
 	KEY(0, 2, KEY_UP),
@@ -190,9 +200,18 @@ static struct pxa27x_keypad_platform_data palmld_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmld_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmld_keypad_platform_data);
+}
+#else
+static inline void palmld_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmld_pxa_buttons[] = {
 	{KEY_F8, GPIO10_PALMLD_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 	{KEY_F9, GPIO15_PALMLD_LOCK_SWITCH, 0, "Lock Switch" },
@@ -212,9 +231,18 @@ static struct platform_device palmld_pxa_keys = {
 	},
 };
 
+static void __init palmld_keys_init(void)
+{
+	platform_device_register(&palmld_pxa_keys);
+}
+#else
+static inline void palmld_keys_init(void) {}
+#endif
+
 /******************************************************************************
  * LEDs
  ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 struct gpio_led gpio_leds[] = {
 {
 	.name			= "palmld:green:led",
@@ -240,26 +268,34 @@ static struct platform_device palmld_leds = {
 	}
 };
 
+static void __init palmld_leds_init(void)
+{
+	platform_device_register(&palmld_leds);
+}
+#else
+static inline void palmld_leds_init(void) {}
+#endif
+
 /******************************************************************************
  * HDD
  ******************************************************************************/
-static struct platform_device palmld_hdd = {
+#if defined(CONFIG_PATA_PALMLD) || defined(CONFIG_PATA_PALMLD_MODULE)
+static struct platform_device palmld_ide_device = {
 	.name	= "pata_palmld",
 	.id	= -1,
 };
 
+static void __init palmld_ide_init(void)
+{
+	platform_device_register(&palmld_ide_device);
+}
+#else
+static inline void palmld_ide_init(void) {}
+#endif
+
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-	&palmld_pxa_keys,
-#endif
-	&palmld_leds,
-	&palmld_hdd,
-	&palmld_flash,
-};
-
 static struct map_desc palmld_io_desc[] __initdata = {
 {
 	.virtual	= PALMLD_IDE_VIRT,
@@ -300,8 +336,11 @@ static void __init palmld_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
 	palm27x_common_init(&palmld);
-	pxa_set_keypad_info(&palmld_keypad_platform_data);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palmld_kpc_init();
+	palmld_keys_init();
+	palmld_nor_init();
+	palmld_leds_init();
+	palmld_ide_init();
 }
 
 MACHINE_START(PALMLD, "Palm LifeDrive")
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 26925fc..db2f8ab 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -106,6 +106,7 @@ static unsigned long palmt5_pin_config[] __initdata = {
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmt5_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -131,9 +132,18 @@ static struct pxa27x_keypad_platform_data palmt5_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmt5_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmt5_keypad_platform_data);
+}
+#else
+static inline void palmt5_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmt5_pxa_buttons[] = {
 	{KEY_F8, GPIO10_PALMT5_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
@@ -151,6 +161,14 @@ static struct platform_device palmt5_pxa_keys = {
 	},
 };
 
+static void __init palmt5_keys_init(void)
+{
+	platform_device_register(&palmt5_pxa_keys);
+}
+#else
+static inline void palmt5_keys_init(void) {}
+#endif
+
 /******************************************************************************
  * Machine init
  ******************************************************************************/
@@ -175,8 +193,8 @@ static void __init palmt5_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
 	palm27x_common_init(&palmt5);
-	pxa_set_keypad_info(&palmt5_keypad_platform_data);
-	platform_device_register(&palmt5_pxa_keys);
+	palmt5_kpc_init();
+	palmt5_keys_init();
 }
 
 MACHINE_START(PALMT5, "Palm Tungsten|T5")
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index dcb5f93..93c83d4 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -161,7 +161,7 @@ static unsigned long centro685_pin_config[] __initdata = {
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int treo680_matrix_keys[] = {
 	KEY(0, 0, KEY_F8),		/* Red/Off/Power */
 	KEY(0, 1, KEY_LEFT),
@@ -221,19 +221,6 @@ static unsigned int treo680_matrix_keys[] = {
 	KEY(7, 5, KEY_I),
 };
 
-static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
-	.matrix_key_rows	= 8,
-	.matrix_key_cols	= 7,
-	.matrix_key_map		= treo680_matrix_keys,
-	.matrix_key_map_size	= ARRAY_SIZE(treo680_matrix_keys),
-	.direct_key_map		= { KEY_CONNECT },
-	.direct_key_num		= 1,
-
-	.debounce_interval	= 30,
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
 static unsigned int centro_matrix_keys[] = {
 	KEY(0, 0, KEY_F9),		/* Home */
 	KEY(0, 1, KEY_LEFT),
@@ -293,28 +280,50 @@ static unsigned int centro_matrix_keys[] = {
 	KEY(7, 5, KEY_I),
 };
 
-static struct pxa27x_keypad_platform_data centro_keypad_platform_data = {
+static struct pxa27x_keypad_platform_data treo680_keypad_pdata = {
 	.matrix_key_rows	= 8,
 	.matrix_key_cols	= 7,
-	.matrix_key_map		= centro_matrix_keys,
-	.matrix_key_map_size	= ARRAY_SIZE(centro_matrix_keys),
+	.matrix_key_map		= treo680_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(treo680_matrix_keys),
 	.direct_key_map		= { KEY_CONNECT },
 	.direct_key_num		= 1,
 
 	.debounce_interval	= 30,
 };
-#endif /* CONFIG_MACH_CENTRO */
+
+static void __init palmtreo_kpc_init(void)
+{
+	static struct pxa27x_keypad_platform_data *data = &treo680_keypad_pdata;
+
+	if (machine_is_centro()) {
+		data->matrix_key_map = centro_matrix_keys;
+		data->matrix_key_map_size = ARRAY_SIZE(centro_matrix_keys);
+	}
+
+	pxa_set_keypad_info(&treo680_keypad_pdata);
+}
+#else
+static inline void palmtreo_kpc_init(void) {}
+#endif
 
 /******************************************************************************
  * USB host
  ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 static struct pxaohci_platform_data treo680_ohci_info = {
 	.port_mode    = PMM_PERPORT_MODE,
 	.flags        = ENABLE_PORT1 | ENABLE_PORT3,
 	.power_budget = 0,
 };
-#endif /* CONFIG_MACH_TREO680 */
+
+static void __init palmtreo_uhc_init(void)
+{
+	if (machine_is_treo680())
+		pxa_set_ohci_info(&treo680_ohci_info);
+}
+#else
+static inline void palmtreo_uhc_init(void) {}
+#endif
 
 /******************************************************************************
  * Vibra and LEDs
@@ -343,16 +352,6 @@ static struct gpio_led_platform_data treo680_gpio_led_info = {
 	.num_leds	= ARRAY_SIZE(treo680_gpio_leds),
 };
 
-static struct platform_device treo680_leds = {
-	.name   = "leds-gpio",
-	.id     = -1,
-	.dev    = {
-		.platform_data  = &treo680_gpio_led_info,
-	}
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
 static struct gpio_led centro_gpio_leds[] = {
 	{
 		.name			= "centro:vibra:vibra",
@@ -377,31 +376,28 @@ static struct gpio_led_platform_data centro_gpio_led_info = {
 	.num_leds	= ARRAY_SIZE(centro_gpio_leds),
 };
 
-static struct platform_device centro_leds = {
+static struct platform_device palmtreo_leds = {
 	.name   = "leds-gpio",
 	.id     = -1,
 	.dev    = {
-		.platform_data  = &centro_gpio_led_info,
+		.platform_data  = &treo680_gpio_led_info,
 	}
 };
-#endif /* CONFIG_MACH_CENTRO */
+
+static void __init palmtreo_leds_init(void)
+{
+	if (machine_is_centro())
+		palmtreo_leds.dev.platform_data = &centro_gpio_led_info;
+
+	platform_device_register(&palmtreo_leds);
+}
+#else
+static inline void palmtreo_leds_init(void) {}
+#endif
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-#ifdef CONFIG_MACH_TREO680
-static struct platform_device *treo680_devices[] __initdata = {
-	&treo680_leds,
-};
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
-static struct platform_device *centro_devices[] __initdata = {
-	&centro_leds,
-};
-#endif /* CONFIG_MACH_CENTRO */
-
-#ifdef CONFIG_MACH_TREO680
 struct palm27x_handheld palmtreo680 = {
 	.mmc_detect	= GPIO_NR_TREO_SD_DETECT_N,
 	.mmc_ro		= GPIO_NR_TREO680_SD_READONLY,
@@ -417,28 +413,6 @@ struct palm27x_handheld palmtreo680 = {
 	.lcd_power	= GPIO_NR_TREO_BL_POWER,
 };
 
-static void __init treo680_init(void)
-{
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
-	palm27x_common_init(&palmtreo680);
-	pxa_set_keypad_info(&treo680_keypad_platform_data);
-	pxa_set_ohci_info(&treo680_ohci_info);
-	platform_add_devices(ARRAY_AND_SIZE(treo680_devices));
-}
-
-MACHINE_START(TREO680, "Palm Treo 680")
-	.phys_io        = TREO_PHYS_IO_START,
-	.io_pg_offst    = io_p2v(0x40000000),
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = treo680_init,
-MACHINE_END
-#endif /* CONFIG_MACH_TREO680 */
-
-#ifdef CONFIG_MACH_CENTRO
 struct palm27x_handheld palmcentro = {
 	.mmc_detect	= GPIO_NR_TREO_SD_DETECT_N,
 	.mmc_ro		= -1,
@@ -454,15 +428,33 @@ struct palm27x_handheld palmcentro = {
 	.lcd_power	= GPIO_NR_TREO_BL_POWER,
 };
 
-static void __init centro_init(void)
+static void __init palmtreo_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
-	palm27x_common_init(&palmcentro);
-	pxa_set_keypad_info(&centro_keypad_platform_data);
-	platform_add_devices(ARRAY_AND_SIZE(centro_devices));
+
+	if (machine_is_centro()) {
+		pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
+		palm27x_common_init(&palmcentro);
+	} else {
+		pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
+		palm27x_common_init(&palmtreo680);
+	}
+
+	palmtreo_kpc_init();
+	palmtreo_uhc_init();
+	palmtreo_leds_init();
 }
 
+MACHINE_START(TREO680, "Palm Treo 680")
+	.phys_io        = TREO_PHYS_IO_START,
+	.io_pg_offst    = io_p2v(0x40000000),
+	.boot_params    = 0xa0000100,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa27x_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = palmtreo_init,
+MACHINE_END
+
 MACHINE_START(CENTRO, "Palm Centro 685")
 	.phys_io        = TREO_PHYS_IO_START,
 	.io_pg_offst    = io_p2v(0x40000000),
@@ -470,6 +462,5 @@ MACHINE_START(CENTRO, "Palm Centro 685")
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
-       .init_machine   = centro_init,
+       .init_machine	= palmtreo_init,
 MACHINE_END
-#endif /* CONFIG_MACH_CENTRO */
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index fe7ef08..03cab2f 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -130,6 +130,7 @@ static unsigned long palmtx_pin_config[] __initdata = {
 /******************************************************************************
  * NOR Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition palmtx_partitions[] = {
 	{
 		.name		= "Flash",
@@ -163,9 +164,18 @@ static struct platform_device palmtx_flash = {
 	},
 };
 
+static void __init palmtx_nor_init(void)
+{
+	platform_device_register(&palmtx_flash);
+}
+#else
+static inline void palmtx_nor_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmtx_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -191,9 +201,18 @@ static struct pxa27x_keypad_platform_data palmtx_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmtx_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmtx_keypad_platform_data);
+}
+#else
+static inline void palmtx_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * GPIO keys
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button palmtx_pxa_buttons[] = {
 	{KEY_F8, GPIO10_PALMTX_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
 };
@@ -211,9 +230,18 @@ static struct platform_device palmtx_pxa_keys = {
 	},
 };
 
+static void __init palmtx_keys_init(void)
+{
+	platform_device_register(&palmtx_pxa_keys);
+}
+#else
+static inline void palmtx_keys_init(void) {}
+#endif
+
 /******************************************************************************
  * NAND Flash
  ******************************************************************************/
+#if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
 static void palmtx_nand_cmd_ctl(struct mtd_info *mtd, int cmd,
 				 unsigned int ctrl)
 {
@@ -273,18 +301,17 @@ static struct platform_device palmtx_nand = {
 	}
 };
 
+static void __init palmtx_nand_init(void)
+{
+	platform_device_register(&palmtx_nand);
+}
+#else
+static inline void palmtx_nand_init(void) {}
+#endif
 
 /******************************************************************************
  * Machine init
  ******************************************************************************/
-static struct platform_device *devices[] __initdata = {
-#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-	&palmtx_pxa_keys,
-#endif
-	&palmtx_flash,
-	&palmtx_nand,
-};
-
 static struct map_desc palmtx_io_desc[] __initdata = {
 {
 	.virtual	= PALMTX_PCMCIA_VIRT,
@@ -331,8 +358,10 @@ static void __init palmtx_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtx_pin_config));
 	palm27x_common_init(&palmtx);
-	pxa_set_keypad_info(&palmtx_keypad_platform_data);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	palmtx_kpc_init();
+	palmtx_keys_init();
+	palmtx_nor_init();
+	palmtx_nand_init();
 }
 
 MACHINE_START(PALMTX, "Palm T|X")
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index e66e911..b20b983 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -112,6 +112,7 @@ static unsigned long palmz72_pin_config[] __initdata = {
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int palmz72_matrix_keys[] = {
 	KEY(0, 0, KEY_POWER),
 	KEY(0, 1, KEY_F1),
@@ -137,9 +138,18 @@ static struct pxa27x_keypad_platform_data palmz72_keypad_platform_data = {
 	.debounce_interval	= 30,
 };
 
+static void __init palmz72_kpc_init(void)
+{
+	pxa_set_keypad_info(&palmz72_keypad_platform_data);
+}
+#else
+static inline void palmz72_kpc_init(void) {}
+#endif
+
 /******************************************************************************
  * LEDs
  ******************************************************************************/
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "palmz72:green:led",
@@ -161,6 +171,14 @@ static struct platform_device palmz72_leds = {
 	}
 };
 
+static void __init palmz72_leds_init(void)
+{
+	platform_device_register(&palmz72_leds);
+}
+#else
+static inline void palmz72_leds_init(void) {}
+#endif
+
 #ifdef CONFIG_PM
 
 /* We have some black magic here
@@ -254,8 +272,8 @@ static void __init palmz72_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmz72_pin_config));
 	palm27x_common_init(&palmz72);
-	pxa_set_keypad_info(&palmz72_keypad_platform_data);
-	platform_device_register(&palmz72_leds);
+	palmz72_kpc_init();
+	palmz72_leds_init();
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-- 
1.7.1
