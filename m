From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:08:29 +0400
Subject: [PATCH 08/20] SA1100: h3100/h3600: add htc-egpio driver
In-Reply-To: <1256414910-22665-1-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-7-git-send-email-mad_soft@inbox.ru>
	<1256414910-22665-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414910-22665-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be used for future conversion of assign_h3600_egpio calls to
gpiolib.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c                   |   45 ++++++++++++++++++++++++
 arch/arm/mach-sa1100/include/mach/h3600_gpio.h |   24 +++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 1297c11..429fdb0 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -25,10 +25,12 @@
 #include <linux/tty.h>
 #include <linux/pm.h>
 #include <linux/device.h>
+#include <linux/mfd/htc-egpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/serial_core.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -184,11 +186,54 @@ static struct sa1100_port_fns h3xxx_port_fns __initdata = {
 	.set_wake	= h3xxx_uart_set_wake,
 };
 
+/*
+ * EGPIO
+ */
+
+static struct resource egpio_resources[] = {
+	[0] = {
+		.start	= H3600_EGPIO_PHYS,
+		.end	= H3600_EGPIO_PHYS + 0x4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct htc_egpio_chip egpio_chips[] = {
+	[0] = {
+		.reg_start	= 0,
+		.gpio_base	= H3XXX_EGPIO_BASE,
+		.num_gpios	= 16,
+		.direction	= HTC_EGPIO_OUTPUT,
+		.initial_values	= 0x0080, /* H3XXX_EGPIO_RS232_ON */
+	},
+};
+
+static struct htc_egpio_platform_data egpio_info = {
+	.reg_width	= 16,
+	.bus_width	= 16,
+	.chip		= egpio_chips,
+	.num_chips	= ARRAY_SIZE(egpio_chips),
+};
+
+static struct platform_device h3xxx_egpio = {
+	.name		= "htc-egpio",
+	.id		= -1,
+	.resource	= egpio_resources,
+	.num_resources	= ARRAY_SIZE(egpio_resources),
+	.dev		= {
+		.platform_data = &egpio_info,
+	},
+};
+
+static struct platform_device *h3xxx_devices[] = {
+	&h3xxx_egpio,
+};
 
 static void __init h3xxx_mach_init(void)
 {
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
+	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
 }
 
 static struct map_desc h3600_io_desc[] __initdata = {
diff --git a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
index 18de674..ce80f1a 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
@@ -97,4 +97,28 @@
 #define EGPIO_H3600_LVDD_ON		(1 << 15)  /* enable 9V and -6.5V to LCD. */
 
 
+/* gpiolib versions of EGPIOs */
+
+/* H3100 / 3600 EGPIO pins */
+#define H3XXX_EGPIO_BASE		(GPIO_MAX + 1)
+
+#define H3XXX_EGPIO_VPP_ON		(H3XXX_EGPIO_BASE + 0)
+#define H3XXX_EGPIO_CARD_RESET		(H3XXX_EGPIO_BASE + 1) /* reset the attached pcmcia/compactflash card.  active high. */
+#define H3XXX_EGPIO_OPT_RESET		(H3XXX_EGPIO_BASE + 2) /* reset the attached option pack.  active high. */
+#define H3XXX_EGPIO_CODEC_NRESET	(H3XXX_EGPIO_BASE + 3) /* reset the onboard UDA1341.  active low. */
+#define H3XXX_EGPIO_OPT_NVRAM_ON	(H3XXX_EGPIO_BASE + 4) /* apply power to optionpack nvram, active high. */
+#define H3XXX_EGPIO_OPT_ON		(H3XXX_EGPIO_BASE + 5) /* full power to option pack.  active high. */
+#define H3XXX_EGPIO_LCD_ON		(H3XXX_EGPIO_BASE + 6) /* enable 3.3V to LCD.  active high. */
+#define H3XXX_EGPIO_RS232_ON		(H3XXX_EGPIO_BASE + 7) /* UART3 transceiver force on.  Active high. */
+
+/* H3600 only EGPIO pins */
+#define H3600_EGPIO_LCD_PCI		(H3XXX_EGPIO_BASE + 8) /* LCD control IC enable.  active high. */
+#define H3600_EGPIO_IR_ON		(H3XXX_EGPIO_BASE + 9) /* apply power to IR module.  active high. */
+#define H3600_EGPIO_AUD_AMP_ON		(H3XXX_EGPIO_BASE + 10) /* apply power to audio power amp.  active high. */
+#define H3600_EGPIO_AUD_PWR_ON		(H3XXX_EGPIO_BASE + 11) /* apply power to reset of audio circuit.  active high. */
+#define H3600_EGPIO_QMUTE		(H3XXX_EGPIO_BASE + 12) /* mute control for onboard UDA1341.  active high. */
+#define H3600_EGPIO_IR_FSEL		(H3XXX_EGPIO_BASE + 13) /* IR speed select: 1->fast, 0->slow */
+#define H3600_EGPIO_LCD_5V_ON		(H3XXX_EGPIO_BASE + 14) /* enable 5V to LCD. active high. */
+#define H3600_EGPIO_LVDD_ON		(H3XXX_EGPIO_BASE + 15) /* enable 9V and -6.5V to LCD. */
+
 #endif /* _INCLUDE_H3600_GPIO_H_ */
-- 
1.6.5.1.63.ga9d7.dirty
