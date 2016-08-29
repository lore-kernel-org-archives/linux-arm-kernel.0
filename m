From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:41 +0100
Subject: [PATCH 07/33] ARM: sa1100/assabet: add BCR/BSR GPIO driver
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJk9-0000mO-9q@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a GPIO driver for the board control register/board status register
for the sa1100/assabet platform.  This allows us to transition a range
of drivers to use the gpiod APIs rather than the platform private
ASSABET_BCR_* interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig   |  1 +
 arch/arm/mach-sa1100/assabet.c | 71 ++++++++++++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 36e3c79f4973..07df3a59b13f 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -5,6 +5,7 @@ menu "SA11x0 Implementations"
 config SA1100_ASSABET
 	bool "Assabet"
 	select ARM_SA1110_CPUFREQ
+	select GPIO_REG
 	help
 	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
 	  Microprocessor Development Board (also known as the Assabet).
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d28ecb9ef172..8f24c84042e0 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/gpio-reg.h>
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/serial_core.h>
@@ -61,20 +62,45 @@
 unsigned long SCR_value = ASSABET_SCR_INIT;
 EXPORT_SYMBOL(SCR_value);
 
-static unsigned long BCR_value = ASSABET_BCR_DB1110;
+static struct gpio_chip *assabet_bcr_gc;
+
+static const char *assabet_names[] = {
+	"cf_pwr", "cf_gfx_rst", "codec_rst", "irda_fsel",
+	"irda_md0", "irda_md1", "stereo_lb", "cf_bus_off",
+	"audio", "backlight", "lcd_12rgb", "lcd_on",
+	"rs232", "d9_led", "d8_led", "vib_on",
+	"com_dtr", "com_rts", "rad_wu", "smb_en",
+	"tv_ir_dec", "qmute", "rad_on", "spk_off",
+	"rs232_valid", "com_dcd", "com_cts", "com_dsr",
+	"rad_cts", "rad_dsr", "rad_dcd", "rad_ri",
+};
 
+/* The old deprecated interface */
 void ASSABET_BCR_frob(unsigned int mask, unsigned int val)
 {
-	unsigned long flags;
+	unsigned long m = mask, v = val;
 
-	local_irq_save(flags);
-	BCR_value = (BCR_value & ~mask) | val;
-	ASSABET_BCR = BCR_value;
-	local_irq_restore(flags);
+	assabet_bcr_gc->set_multiple(assabet_bcr_gc, &m, &v);
 }
-
 EXPORT_SYMBOL(ASSABET_BCR_frob);
 
+static int __init assabet_init_gpio(void __iomem *reg, u32 def_val)
+{
+	struct gpio_chip *gc;
+
+	writel_relaxed(def_val, reg);
+
+	gc = gpio_reg_init(NULL, reg, -1, 32, "assabet", 0xff000000, def_val,
+			   assabet_names);
+
+	if (IS_ERR(gc))
+		return PTR_ERR(gc);
+
+	assabet_bcr_gc = gc;
+
+	return gc->base;
+}
+
 /*
  * The codec reset goes to three devices, so we need to release
  * the rest when any one of these requests it.  However, that
@@ -146,7 +172,7 @@ static void adv7171_write(unsigned reg, unsigned val)
 	unsigned gpdr = GPDR;
 	unsigned gplr = GPLR;
 
-	ASSABET_BCR = BCR_value | ASSABET_BCR_AUDIO_ON;
+	ASSABET_BCR_frob(ASSABET_BCR_AUDIO_ON, ASSABET_BCR_AUDIO_ON);
 	udelay(100);
 
 	GPCR = SDA | SCK | MOD; /* clear L3 mode to ensure UDA1341 doesn't respond */
@@ -457,14 +483,6 @@ static void __init assabet_init(void)
 	sa11x0_ppc_configure_mcp();
 
 	if (machine_has_neponset()) {
-		/*
-		 * Angel sets this, but other bootloaders may not.
-		 *
-		 * This must precede any driver calls to BCR_set()
-		 * or BCR_clear().
-		 */
-		ASSABET_BCR = BCR_value = ASSABET_BCR_DB1111;
-
 #ifndef CONFIG_ASSABET_NEPONSET
 		printk( "Warning: Neponset detected but full support "
 			"hasn't been configured in the kernel\n" );
@@ -748,12 +766,31 @@ static int __init assabet_leds_init(void)
 fs_initcall(assabet_leds_init);
 #endif
 
+void __init assabet_init_irq(void)
+{
+	u32 def_val;
+
+	sa1100_init_irq();
+
+	if (machine_has_neponset())
+		def_val = ASSABET_BCR_DB1111;
+	else
+		def_val = ASSABET_BCR_DB1110;
+
+	/*
+	 * Angel sets this, but other bootloaders may not.
+	 *
+	 * This must precede any driver calls to BCR_set() or BCR_clear().
+	 */
+	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
+}
+
 MACHINE_START(ASSABET, "Intel-Assabet")
 	.atag_offset	= 0x100,
 	.fixup		= fixup_assabet,
 	.map_io		= assabet_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
-	.init_irq	= sa1100_init_irq,
+	.init_irq	= assabet_init_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= assabet_init,
 	.init_late	= sa11x0_init_late,
-- 
2.1.0
