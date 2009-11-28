From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 28 Nov 2009 04:05:32 +0100
Subject: [PATCH] ARM: gta02: Add gpio bank B quirk for hardware revision 5 and
	earlier
In-Reply-To: <1259377532-8012-4-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
	<1259377532-8012-3-git-send-email-lars@metafoo.de>
	<1259377532-8012-4-git-send-email-lars@metafoo.de>
Message-ID: <1259377532-8012-5-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On gta02 hardware revision 5 and earlier the basis resistors for transistors of
the leds are missing and reading their gpio pin status will always return 0.
So we have to shadow the led states in software. This is done by "hijacking"
the gpio accessor functions for bank B.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-By: Nelson Castillo <arhuaco@freaks-unidos.net>
---
 arch/arm/mach-s3c2442/mach-gta02.c |   54 ++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 13b14ab..9298db4 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -90,6 +90,7 @@
 #include <plat/pm.h>
 #include <plat/udc.h>
 #include <plat/gpio-cfg.h>
+#include <plat/gpio-core.h>
 #include <plat/iic.h>
 
 static struct pcf50633 *gta02_pcf;
@@ -706,11 +707,64 @@ static void gta02_poweroff(void)
 	pcf50633_reg_set_bit_mask(gta02_pcf, PCF50633_REG_OOCSHDWN, 1, 1);
 }
 
+/* On hardware rev 5 and earlier the leds are missing a resistor and reading
+ * from their gpio pins will always return 0, so we have to shadow the
+ * led states software */
+static unsigned long gpb_shadow;
+extern struct s3c_gpio_chip s3c24xx_gpios[];
+
+static void gta02_gpb_set(struct gpio_chip *chip,
+				unsigned offset, int value)
+{
+	void __iomem *base = S3C24XX_GPIO_BASE(S3C2410_GPB(0));
+	unsigned long flags;
+	unsigned long dat;
+
+	local_irq_save(flags);
+
+	dat = __raw_readl(base + 0x04) | gpb_shadow;
+	dat &= ~(1 << offset);
+	gpb_shadow &= ~(1 << offset);
+	if (value) {
+		dat |= 1 << offset;
+		switch (offset) {
+		case 0 ... 2:
+			gpb_shadow |= 1 << offset;
+			break;
+		default:
+			break;
+		}
+	}
+	__raw_writel(dat, base + 0x04);
+
+	local_irq_restore(flags);
+}
+
+static int gta02_gpb_get(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *base = S3C24XX_GPIO_BASE(S3C2410_GPB(0));
+	unsigned long val;
+
+	val = __raw_readl(base + 0x04) | gpb_shadow;
+	val >>= offset;
+	val &= 1;
+
+	return val;
+}
+
+static void gta02_hijack_gpb(void)
+{
+	s3c24xx_gpios[1].chip.set = gta02_gpb_set;
+	s3c24xx_gpios[1].chip.get = gta02_gpb_get;
+}
+
 static void __init gta02_machine_init(void)
 {
 	/* Set the panic callback to make AUX LED blink at ~5Hz. */
 	panic_blink = gta02_panic_blink;
 
+	gta02_hijack_gpb();
+
 	s3c_pm_init();
 
 #ifdef CONFIG_CHARGER_PCF50633
-- 
1.5.6.5
