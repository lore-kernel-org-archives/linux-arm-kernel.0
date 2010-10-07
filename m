From: simon@sequanux.org (Simon Guinot)
Date: Thu,  7 Oct 2010 16:38:50 +0200
Subject: [PATCH 2/2] [ARM] Kirkwood: add LED support for netxbig_v2 boards
In-Reply-To: <1286462330-16301-1-git-send-email-simon@sequanux.org>
References: <1286462330-16301-1-git-send-email-simon@sequanux.org>
Message-ID: <1286462330-16301-2-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/netxbig_v2-setup.c |  158 ++++++++++++++++++++++++-----
 1 files changed, 133 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index aec528d..d970e1e 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
+#include <mach/leds-netxbig.h>
 #include "common.h"
 #include "mpp.h"
 #include "lacie_v2-common.h"
@@ -104,7 +105,7 @@ static struct platform_device netxbig_v2_gpio_buttons = {
 };
 
 /*****************************************************************************
- * GPIO LEDs
+ * GPIO extension LEDs
  ****************************************************************************/
 
 /*
@@ -114,19 +115,32 @@ static struct platform_device netxbig_v2_gpio_buttons = {
  * - address register : bit [0-2] -> GPIO [47-49]
  * - data register    : bit [0-2] -> GPIO [44-46]
  * - enable register  : GPIO 29
- *
+ */
+
+static int netxbig_v2_gpio_ext_addr[] = { 47, 48, 49 };
+static int netxbig_v2_gpio_ext_data[] = { 44, 45, 46 };
+
+static struct netxbig_gpio_ext netxbig_v2_gpio_ext = {
+	.addr		= netxbig_v2_gpio_ext_addr,
+	.num_addr	= ARRAY_SIZE(netxbig_v2_gpio_ext_addr),
+	.data		= netxbig_v2_gpio_ext_data,
+	.num_data	= ARRAY_SIZE(netxbig_v2_gpio_ext_data),
+	.enable		= 29,
+};
+
+/*
  * Address register selection:
  *
  * addr | register
  * ----------------------------
  *   0  | front LED
  *   1  | front LED brightness
- *   2  | HDD LED brightness
- *   3  | HDD1 LED
- *   4  | HDD2 LED
- *   5  | HDD3 LED
- *   6  | HDD4 LED
- *   7  | HDD5 LED
+ *   2  | SATA LED brightness
+ *   3  | SATA0 LED
+ *   4  | SATA1 LED
+ *   5  | SATA2 LED
+ *   6  | SATA3 LED
+ *   7  | SATA4 LED
  *
  * Data register configuration:
  *
@@ -147,18 +161,109 @@ static struct platform_device netxbig_v2_gpio_buttons = {
  *   6  | blink blue on=1 sec and red on=1 sec
  *   7  | blink blue on=0.5 sec and blue off=2.5 sec
  *
- * data | HDD LED mode
+ * data | SATA LED mode
  * -------------------------------------------------
- *   0  | fix blue on
+ *   0  | fix off
  *   1  | SATA activity blink
  *   2  | fix red on
  *   3  | blink blue on=1 sec and blue off=1 sec
  *   4  | blink red on=1 sec and red off=1 sec
  *   5  | blink blue on=2.5 sec and red on=0.5 sec
  *   6  | blink blue on=1 sec and red on=1 sec
- *   7  | blink blue on=0.5 sec and blue off=2.5 sec
+ *   7  | fix blue on
  */
 
+static int netxbig_v2_red_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 2,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 4,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static int netxbig_v2_blue_pwr_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 1,
+	[NETXBIG_LED_SATA]	= NETXBIG_LED_INVALID_MODE,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= 7,
+};
+
+static int netxbig_v2_blue_sata_mled[NETXBIG_LED_MODE_NUM] = {
+	[NETXBIG_LED_OFF]	= 0,
+	[NETXBIG_LED_ON]	= 7,
+	[NETXBIG_LED_SATA]	= 1,
+	[NETXBIG_LED_TIMER1]	= 3,
+	[NETXBIG_LED_TIMER2]	= NETXBIG_LED_INVALID_MODE,
+};
+
+static struct netxbig_led_timer netxbig_v2_led_timer[] = {
+	[0] = {
+		.delay_on	= 500,
+		.delay_off	= 500,
+		.mode		= NETXBIG_LED_TIMER1,
+	},
+	[1] = {
+		.delay_on	= 500,
+		.delay_off	= 1000,
+		.mode		= NETXBIG_LED_TIMER2,
+	},
+};
+
+#define NETXBIG_LED(_name, maddr, mval, baddr)			\
+	{ .name		= _name,				\
+	  .mode_addr	= maddr,				\
+	  .mode_val	= mval,					\
+	  .bright_addr	= baddr }
+
+static struct netxbig_led net2big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net2big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net2big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net2big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net2big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net2big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net2big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net2big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net2big_v2_leds_ctrl),
+};
+
+static struct netxbig_led net5big_v2_leds_ctrl[] = {
+	NETXBIG_LED("net5big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
+	NETXBIG_LED("net5big-v2:red:power",  0, netxbig_v2_red_mled,       1),
+	NETXBIG_LED("net5big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata2", 5, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata2",  5, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata3", 6, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata3",  6, netxbig_v2_red_mled,       2),
+	NETXBIG_LED("net5big-v2:blue:sata4", 7, netxbig_v2_blue_sata_mled, 2),
+	NETXBIG_LED("net5big-v2:red:sata5",  7, netxbig_v2_red_mled,       2),
+};
+
+static struct netxbig_led_platform_data net5big_v2_leds_data = {
+	.gpio_ext	= &netxbig_v2_gpio_ext,
+	.timer		= netxbig_v2_led_timer,
+	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
+	.leds		= net5big_v2_leds_ctrl,
+	.num_leds	= ARRAY_SIZE(net5big_v2_leds_ctrl),
+};
+
+static struct platform_device netxbig_v2_leds = {
+	.name		= "leds-netxbig",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &net2big_v2_leds_data,
+	},
+};
+
 /*****************************************************************************
  * General Setup
  ****************************************************************************/
@@ -184,18 +289,18 @@ static unsigned int net2big_v2_mpp_config[] __initdata = {
 	MPP24_GPIO,		/* USB mode select */
 	MPP26_GPIO,		/* USB device vbus */
 	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* CPLD extension ALE */
+	MPP29_GPIO,		/* GPIO extension ALE */
 	MPP34_GPIO,		/* Rear Push button */
 	MPP35_GPIO,		/* Inhibit switch power-off */
 	MPP36_GPIO,		/* SATA HDD1 presence */
 	MPP37_GPIO,		/* SATA HDD2 presence */
 	MPP40_GPIO,		/* eSATA presence */
-	MPP44_GPIO,		/* CPLD extension (data 0) */
-	MPP45_GPIO,		/* CPLD extension (data 1) */
-	MPP46_GPIO,		/* CPLD extension (data 2) */
-	MPP47_GPIO,		/* CPLD extension (addr 0) */
-	MPP48_GPIO,		/* CPLD extension (addr 1) */
-	MPP49_GPIO,		/* CPLD extension (addr 2) */
+	MPP44_GPIO,		/* GPIO extension (data 0) */
+	MPP45_GPIO,		/* GPIO extension (data 1) */
+	MPP46_GPIO,		/* GPIO extension (data 2) */
+	MPP47_GPIO,		/* GPIO extension (addr 0) */
+	MPP48_GPIO,		/* GPIO extension (addr 1) */
+	MPP49_GPIO,		/* GPIO extension (addr 2) */
 	0
 };
 
@@ -224,7 +329,7 @@ static unsigned int net5big_v2_mpp_config[] __initdata = {
 	MPP26_GE1_RXD2,
 	MPP27_GE1_RXD3,
 	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* CPLD extension ALE */
+	MPP29_GPIO,		/* GPIO extension ALE */
 	MPP30_GE1_RXCTL,
 	MPP31_GE1_RXCLK,
 	MPP32_GE1_TCLKOUT,
@@ -239,12 +344,12 @@ static unsigned int net5big_v2_mpp_config[] __initdata = {
 	MPP41_GPIO,		/* SATA HDD3 power */
 	MPP42_GPIO,		/* SATA HDD4 power */
 	MPP43_GPIO,		/* SATA HDD5 power */
-	MPP44_GPIO,		/* CPLD extension (data 0) */
-	MPP45_GPIO,		/* CPLD extension (data 1) */
-	MPP46_GPIO,		/* CPLD extension (data 2) */
-	MPP47_GPIO,		/* CPLD extension (addr 0) */
-	MPP48_GPIO,		/* CPLD extension (addr 1) */
-	MPP49_GPIO,		/* CPLD extension (addr 2) */
+	MPP44_GPIO,		/* GPIO extension (data 0) */
+	MPP45_GPIO,		/* GPIO extension (data 1) */
+	MPP46_GPIO,		/* GPIO extension (data 2) */
+	MPP47_GPIO,		/* GPIO extension (addr 0) */
+	MPP48_GPIO,		/* GPIO extension (addr 1) */
+	MPP49_GPIO,		/* GPIO extension (addr 2) */
 	0
 };
 
@@ -280,6 +385,9 @@ static void __init netxbig_v2_init(void)
 	lacie_v2_register_flash();
 	lacie_v2_register_i2c_devices();
 
+	if (machine_is_net5big_v2())
+		netxbig_v2_leds.dev.platform_data = &net5big_v2_leds_data;
+	platform_device_register(&netxbig_v2_leds);
 	platform_device_register(&netxbig_v2_gpio_buttons);
 
 	if (gpio_request(NETXBIG_V2_GPIO_POWER_OFF, "power-off") == 0 &&
-- 
1.6.3.1
