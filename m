From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 19 Aug 2016 17:29:02 +0100
Subject: [PATCH] ARM: sa1100: clear reset status prior to reboot
Message-ID: <E1bamfG-0002WE-49@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear the current reset status prior to rebooting the platform.  This
adds the bit missing from 04fef228fb00 ("[ARM] pxa: introduce
reset_status and clear_reset_status for driver's usage").

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/setup.c        |  2 +-
 arch/arm/mach-sa1100/assabet.c | 25 +++++++++++++++++++------
 arch/arm/mach-sa1100/generic.c |  3 +++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index aca999e17184..511d86d60119 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1157,7 +1157,7 @@ static int __init topology_init(void)
 
 	return 0;
 }
-subsys_initcall(topology_init);
+postcore_initcall(topology_init);
 
 #ifdef CONFIG_HAVE_PROC_CPU
 static int __init proc_cpu_init(void)
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index d28ecb9ef172..efb8ebecff9b 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -63,6 +63,11 @@ EXPORT_SYMBOL(SCR_value);
 
 static unsigned long BCR_value = ASSABET_BCR_DB1110;
 
+void assabet_debug_bcr(const char *msg)
+{
+	pr_info("Assabet: %s: BCR=%08lx\n", msg, BCR_value);
+}
+
 void ASSABET_BCR_frob(unsigned int mask, unsigned int val)
 {
 	unsigned long flags;
@@ -340,7 +345,7 @@ static void assabet_lcd_set_visual(u32 visual)
 #ifndef ASSABET_PAL_VIDEO
 static void assabet_lcd_backlight_power(int on)
 {
-	if (on)
+	if (on && 0)
 		ASSABET_BCR_set(ASSABET_BCR_LIGHT_ON);
 	else
 		ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
@@ -353,9 +358,10 @@ static void assabet_lcd_backlight_power(int on)
  */
 static void assabet_lcd_power(int on)
 {
-	if (on) {
+	if (on && 0) {
+		msleep(500);
 		ASSABET_BCR_set(ASSABET_BCR_LCD_ON);
-		udelay(500);
+		msleep(500);
 	} else
 		ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
 }
@@ -448,8 +454,8 @@ static void __init assabet_init(void)
 	 * Set up registers for sleep mode.
 	 */
 	PWER = PWER_GPIO0;
-	PGSR = 0;
-	PCFR = 0;
+	PGSR = GPIO_GPIO(17);
+	PCFR = PCFR_OPDE | PCFR_FP;
 	PSDR = 0;
 	PPDR |= PPC_TXD3 | PPC_TXD1;
 	PPSR |= PPC_TXD3 | PPC_TXD1;
@@ -530,6 +536,11 @@ static void __init get_assabet_scr(void)
 	SCR_value = scr;
 }
 
+static char neponset_cmdline[] __initdata = "console=ttySA0,38400n8 "
+"cpufreq=221200 rw root=/dev/mtdblock2 "
+"mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) "
+"load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M profile=2";
+
 static void __init
 fixup_assabet(struct tag *tags, char **cmdline)
 {
@@ -537,8 +548,10 @@ fixup_assabet(struct tag *tags, char **cmdline)
 	map_sa1100_gpio_regs();
 	get_assabet_scr();
 
-	if (machine_has_neponset())
+	if (machine_has_neponset()) {
 		printk("Neponset expansion board detected\n");
+		*cmdline = neponset_cmdline;
+	}
 }
 
 
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 2e2c35b8e0d4..3e09beddb6e8 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -34,6 +34,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/reset.h>
 
 #include "generic.h"
 #include <clocksource/pxa.h>
@@ -95,6 +96,8 @@ static void sa1100_power_off(void)
 
 void sa11x0_restart(enum reboot_mode mode, const char *cmd)
 {
+	clear_reset_status(RESET_STATUS_ALL);
+
 	if (mode == REBOOT_SOFT) {
 		/* Jump into ROM at address 0 */
 		soft_restart(0);
-- 
2.1.0
