From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Thu, 27 Aug 2009 02:43:31 +0200
Subject: [PATCH 5/5] PalmGSM: add basic Centro support
In-Reply-To: <1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-2-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-3-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-4-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
Message-ID: <1251333811-22360-6-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tom?? ?ech <sleep walker@suse.cz>

---
 arch/arm/mach-pxa/Kconfig                |   11 ++
 arch/arm/mach-pxa/include/mach/palmgsm.h |    7 ++
 arch/arm/mach-pxa/palmgsm.c              |  160 ++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c                        |    2 +-
 4 files changed, 179 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 441f1d6..6f0232a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -405,6 +405,17 @@ config PALMGSM
 	depends on ARCH_PXA_PALM
 	bool
 
+config MACH_CENTRO
+	bool "Palm Centro 685"
+	default y
+	depends on ARCH_PXA_PALM
+	select PXA27x
+	select IWMMXT
+	select PALMGSM
+	help
+	  Say Y here if you intend to run this kernel on Palm Centro 685
+	  smartphone.
+
 config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
diff --git a/arch/arm/mach-pxa/include/mach/palmgsm.h b/arch/arm/mach-pxa/include/mach/palmgsm.h
index 8d1a3bc..6e52946 100644
--- a/arch/arm/mach-pxa/include/mach/palmgsm.h
+++ b/arch/arm/mach-pxa/include/mach/palmgsm.h
@@ -3,6 +3,7 @@
  *
  * currently supported:
  *     Palm Treo 680 (GSM)
+ *     Palm Centro 685 (GSM)
  *
  * Author:     Tomas Cech <sleep_walker@suse.cz>
  *
@@ -45,6 +46,12 @@
 #define GPIO_NR_TREO680_KEYB_BL		24
 #define GPIO_NR_TREO680_BT_EN		43
 
+/* Centro685 specific GPIOs */
+#define GPIO_NR_CENTRO_SD_POWER		21
+#define GPIO_NR_CENTRO_VIBRATE_EN	22
+#define GPIO_NR_CENTRO_KEYB_BL		33
+#define GPIO_NR_CENTRO_BT_EN		80
+
 /* Various addresses  */
 #define PALMGSM_PHYS_RAM_START	0xa0000000
 #define PALMGSM_PHYS_IO_START	0x40000000
diff --git a/arch/arm/mach-pxa/palmgsm.c b/arch/arm/mach-pxa/palmgsm.c
index 99eb468..90c3a51 100644
--- a/arch/arm/mach-pxa/palmgsm.c
+++ b/arch/arm/mach-pxa/palmgsm.c
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
 #endif
 
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
+#endif
+
 /******************************************************************************
  * SD/MMC card controller
  ******************************************************************************/
@@ -172,6 +188,15 @@ static struct pxamci_platform_data treo680_mci_platform_data = {
 };
 #endif
 
+#ifdef CONFIG_MACH_CENTRO
+static struct pxamci_platform_data centro_mci_platform_data = {
+	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect	= GPIO_NR_PALMGSM_SD_DETECT_N,
+	.gpio_power		= GPIO_NR_TREO680_SD_POWER,
+	.gpio_power_invert	= 1,
+};
+#endif
+
 /******************************************************************************
  * GPIO keyboard
  ******************************************************************************/
@@ -247,6 +272,78 @@ static struct pxa27x_keypad_platform_data treo680_keypad_platform_data = {
 };
 #endif
 
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
+#endif
+
 /******************************************************************************
  * aSoC audio
  ******************************************************************************/
@@ -458,6 +555,40 @@ static struct platform_device treo680_leds = {
 };
 #endif
 
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
+		.gpio			= GPIO_NR_PALMGSM_GREEN_LED,
+	},
+	{
+		.name			= "centro:keybbl:keybbl",
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
+#endif
+
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
@@ -514,6 +645,12 @@ static struct platform_device *treo680_devices[] __initdata = {
 };
 #endif
 
+#ifdef CONFIG_MACH_CENTRO
+static struct platform_device *centro_devices[] __initdata = {
+	&centro_leds,
+};
+#endif
+
 /* setup udc GPIOs initial state */
 static void __init palmgsm_udc_init(void)
 {
@@ -557,3 +694,26 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.init_machine	= treo680_init,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_MACH_CENTRO
+static void __init centro_init(void)
+{
+	palmgsm_init();
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
+	pxa_set_mci_info(&centro_mci_platform_data);
+
+	pxa_set_keypad_info(&centro_keypad_platform_data);
+
+	platform_add_devices(ARRAY_AND_SIZE(centro_devices));
+ }
+
+MACHINE_START(CENTRO, "Palm Centro 685")
+	.phys_io        = PALMGSM_PHYS_IO_START,
+	.io_pg_offst    = io_p2v(0x40000000),
+	.boot_params    = 0xa0000100,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa27x_init_irq,
+	.timer          = &pxa_timer,
+       .init_machine   = centro_init,
+MACHINE_END
+#endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4722582..4f51395 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -836,7 +836,7 @@ void __init reserve_node_zero(pg_data_t *pgdat)
 				BOOTMEM_EXCLUSIVE);
 	}
 
-	if (machine_is_treo680()) {
+	if (machine_is_treo680() || machine_is_centro()) {
 		reserve_bootmem_node(pgdat, 0xa0000000, 0x1000,
 				BOOTMEM_EXCLUSIVE);
 		reserve_bootmem_node(pgdat, 0xa2000000, 0x1000,
-- 
1.6.3.3
