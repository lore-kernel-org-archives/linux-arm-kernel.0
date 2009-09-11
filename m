From: sleep_walker@suse.cz (=?UTF-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Fri, 11 Sep 2009 13:57:02 +0200
Subject: [PATCH 2/2] PalmTreo: add Palm Centro 685 support
In-Reply-To: <1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
	<1252670222-25233-2-git-send-email-sleep_walker@suse.cz>
Message-ID: <1252670222-25233-3-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>


Signed-off-by: Tom?? ?ech <sleep_walker@suse.cz>
---
 arch/arm/mach-pxa/Kconfig                 |   13 ++-
 arch/arm/mach-pxa/include/mach/palmtreo.h |    7 ++
 arch/arm/mach-pxa/palmtreo.c              |  161 +++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                         |    2 +-
 4 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index ce6519c..57eceb8 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -425,6 +425,17 @@ config PALM_TREO
 	bool
 	depends on ARCH_PXA_PALM
 
+config MACH_CENTRO
+	bool "Palm Centro 685 (GSM)"
+	default y
+	depends on ARCH_PXA_PALM
+	select PXA27x
+	select IWMMXT
+	select PALM_TREO
+	help
+	  Say Y here if you intend to run this kernel on Palm Centro 685 (GSM)
+	  smartphone.
+
 config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
@@ -433,7 +444,7 @@ config MACH_TREO680
 	select IWMMXT
 	select PALM_TREO
 	help
-	  Say Y here if you intend to run this kernel on Palm Treo 680
+	  Say Y here if you intend to run this kernel on Palm Treo 680 (GSM)
 	  smartphone.
 
 config MACH_PALMLD
diff --git a/arch/arm/mach-pxa/include/mach/palmtreo.h b/arch/arm/mach-pxa/include/mach/palmtreo.h
index 8cb0bca..2d3f14e 100644
--- a/arch/arm/mach-pxa/include/mach/palmtreo.h
+++ b/arch/arm/mach-pxa/include/mach/palmtreo.h
@@ -3,6 +3,7 @@
  *
  * currently supported:
  *     Palm Treo 680 (GSM)
+ *     Palm Centro 685 (GSM)
  *
  * Author:     Tomas Cech <sleep_walker@suse.cz>
  *
@@ -45,6 +46,12 @@
 #define GPIO_NR_TREO680_BT_EN		43
 #endif /* CONFIG_MACH_TREO680 */
 
+/* Centro685 specific GPIOs */
+#define GPIO_NR_CENTRO_SD_POWER		21
+#define GPIO_NR_CENTRO_VIBRATE_EN	22
+#define GPIO_NR_CENTRO_KEYB_BL		33
+#define GPIO_NR_CENTRO_BT_EN		80
+
 /* Various addresses  */
 #define TREO_PHYS_RAM_START	0xa0000000
 #define TREO_PHYS_IO_START	0x40000000
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 5e66028..c071b60 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -3,6 +3,7 @@
  *
  * currently supported:
  *     Palm Treo 680 (GSM)
+ *     Palm Centro 685 (GSM)
  *
  * Author:     Tomas Cech <sleep_walker@suse.cz>
  *
@@ -160,6 +161,21 @@ static unsigned long treo680_pin_config[] __initdata = {
 };
 #endif /* CONFIG_MACH_TREO680 */
 
+#ifdef CONFIG_MACH_CENTRO
+static unsigned long centro685_pin_config[] __initdata = {
+	/* Bluetooth attached to BT UART*/
+	MFP_CFG_OUT(GPIO80, AF0, DRIVE_LOW),    /* power: LOW = off */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+	GPIO45_BTUART_RTS,
+
+	/* MATRIX KEYPAD - different wake up source */
+	GPIO100_KP_MKIN_0,
+	GPIO99_KP_MKIN_5 | WAKEUP_ON_LEVEL_HIGH,
+};
+#endif /* CONFIG_MACH_CENTRO */
+
 /******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
@@ -172,6 +188,16 @@ static struct pxamci_platform_data treo680_mci_platform_data = {
 };
 #endif /* CONFIG_MACH_TREO680 */
 
+#ifdef CONFIG_MACH_CENTRO
+static struct pxamci_platform_data centro_mci_platform_data = {
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect	= GPIO_NR_TREO_SD_DETECT_N,
+	.gpio_card_ro		= -1,
+	.gpio_power		= GPIO_NR_CENTRO_SD_POWER,
+	.gpio_power_invert	= 1,
+};
+#endif /* CONFIG_MACH_CENTRO */
+
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
@@ -247,6 +273,78 @@ static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
 };
 #endif /* CONFIG_MACH_TREO680 */
 
+#ifdef CONFIG_MACH_CENTRO
+static unsigned int centro_matrix_keys[] = {
+	KEY(0, 0, KEY_F9),		/* Home */
+	KEY(0, 1, KEY_LEFT),
+	KEY(0, 2, KEY_LEFTCTRL),	/* Alternate */
+	KEY(0, 3, KEY_L),
+	KEY(0, 4, KEY_A),
+	KEY(0, 5, KEY_Q),
+	KEY(0, 6, KEY_P),
+
+	KEY(1, 0, KEY_RIGHTCTRL),	/* Menu */
+	KEY(1, 1, KEY_RIGHT),
+	KEY(1, 2, KEY_LEFTSHIFT),	/* Left shift */
+	KEY(1, 3, KEY_Z),
+	KEY(1, 4, KEY_S),
+	KEY(1, 5, KEY_W),
+
+	KEY(2, 0, KEY_F1),		/* Phone */
+	KEY(2, 1, KEY_UP),
+	KEY(2, 2, KEY_0),
+	KEY(2, 3, KEY_X),
+	KEY(2, 4, KEY_D),
+	KEY(2, 5, KEY_E),
+
+	KEY(3, 0, KEY_F10),		/* Calendar */
+	KEY(3, 1, KEY_DOWN),
+	KEY(3, 2, KEY_SPACE),
+	KEY(3, 3, KEY_C),
+	KEY(3, 4, KEY_F),
+	KEY(3, 5, KEY_R),
+
+	KEY(4, 0, KEY_F12),		/* Mail */
+	KEY(4, 1, KEY_KPENTER),
+	KEY(4, 2, KEY_RIGHTALT),	/* Alt */
+	KEY(4, 3, KEY_V),
+	KEY(4, 4, KEY_G),
+	KEY(4, 5, KEY_T),
+
+	KEY(5, 0, KEY_F8),		/* Red/Off/Power */
+	KEY(5, 1, KEY_PAGEUP),		/* Side up */
+	KEY(5, 2, KEY_DOT),
+	KEY(5, 3, KEY_B),
+	KEY(5, 4, KEY_H),
+	KEY(5, 5, KEY_Y),
+
+	KEY(6, 0, KEY_TAB),		/* Side Activate */
+	KEY(6, 1, KEY_PAGEDOWN),	/* Side down */
+	KEY(6, 2, KEY_ENTER),
+	KEY(6, 3, KEY_N),
+	KEY(6, 4, KEY_J),
+	KEY(6, 5, KEY_U),
+
+	KEY(7, 0, KEY_F6),		/* Green/Call */
+	KEY(7, 1, KEY_O),
+	KEY(7, 2, KEY_BACKSPACE),
+	KEY(7, 3, KEY_M),
+	KEY(7, 4, KEY_K),
+	KEY(7, 5, KEY_I),
+};
+
+static struct pxa27x_keypad_platform_data centro_keypad_platform_data = {
+	.matrix_key_rows	= 8,
+	.matrix_key_cols	= 7,
+	.matrix_key_map		= centro_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(centro_matrix_keys),
+	.direct_key_map		= { KEY_CONNECT },
+	.direct_key_num		= 1,
+
+	.debounce_interval	= 30,
+};
+#endif /* CONFIG_MACH_CENTRO */
+
 /******************************************************************************
  * aSoC audio
  ******************************************************************************/
@@ -423,6 +521,40 @@ static struct platform_device treo680_leds = {
 };
 #endif /* CONFIG_MACH_TREO680 */
 
+#ifdef CONFIG_MACH_CENTRO
+static struct gpio_led centro_gpio_leds[] = {
+	{
+		.name			= "centro:vibra:vibra",
+		.default_trigger	= "none",
+		.gpio			= GPIO_NR_CENTRO_VIBRATE_EN,
+	},
+	{
+		.name			= "centro:green:led",
+		.default_trigger	= "mmc0",
+		.gpio			= GPIO_NR_TREO_GREEN_LED,
+	},
+	{
+		.name			= "centro:white:keybbl",
+		.default_trigger	= "none",
+		.active_low		= 1,
+		.gpio			= GPIO_NR_CENTRO_KEYB_BL,
+	},
+};
+
+static struct gpio_led_platform_data centro_gpio_led_info = {
+	.leds		= centro_gpio_leds,
+	.num_leds	= ARRAY_SIZE(centro_gpio_leds),
+};
+
+static struct platform_device centro_leds = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &centro_gpio_led_info,
+	}
+};
+#endif /* CONFIG_MACH_CENTRO */
+
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
@@ -484,6 +616,12 @@ static struct platform_device *treo680_devices[] __initdata = {
 };
 #endif /* CONFIG_MACH_TREO680 */
 
+#ifdef CONFIG_MACH_CENTRO
+static struct platform_device *centro_devices[] __initdata = {
+	&centro_leds,
+};
+#endif /* CONFIG_MACH_CENTRO */
+
 /* setup udc GPIOs initial state */
 static void __init treo_udc_init(void)
 {
@@ -549,3 +687,26 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.init_machine   = treo680_init,
 MACHINE_END
 #endif /* CONFIG_MACH_TREO680 */
+
+#ifdef CONFIG_MACH_CENTRO
+static void __init centro_init(void)
+{
+	treo_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
+	pxa_set_mci_info(&centro_mci_platform_data);
+
+	pxa_set_keypad_info(&centro_keypad_platform_data);
+
+	platform_add_devices(ARRAY_AND_SIZE(centro_devices));
+}
+
+MACHINE_START(CENTRO, "Palm Centro 685")
+	.phys_io        = TREO_PHYS_IO_START,
+	.io_pg_offst    = io_p2v(0x40000000),
+	.boot_params    = 0xa0000100,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa27x_init_irq,
+	.timer          = &pxa_timer,
+       .init_machine   = centro_init,
+MACHINE_END
+#endif /* CONFIG_MACH_CENTRO */
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4426ee6..92b27ab 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -843,7 +843,7 @@ void __init reserve_node_zero(pg_data_t *pgdat)
 				BOOTMEM_EXCLUSIVE);
 	}
 
-	if (machine_is_treo680()) {
+	if (machine_is_treo680() || machine_is_centro()) {
 		reserve_bootmem_node(pgdat, 0xa0000000, 0x1000,
 				BOOTMEM_EXCLUSIVE);
 		reserve_bootmem_node(pgdat, 0xa2000000, 0x1000,
-- 
1.6.4.2
