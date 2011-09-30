From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 15:04:23 +0100
Subject: [RFC] Need help deciphering reboot modes!
In-Reply-To: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
References: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
Message-ID: <20110930140422.GI3895@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 01:57:25PM +0100, Will Deacon wrote:
> 'g'	-> A supported option by spitz and tosa (both mach-pxa). I can't
> 	   begin to imagine what it might stand for.

Aha! Some digging revealed this is a reset via GPIO and is specific to
mach-pxa. Maybe we can eliminate it with something like below:

Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..e85d31e 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -107,6 +107,9 @@ extern void __show_regs(struct pt_regs *);
 extern int cpu_architecture(void);
 extern void cpu_init(void);
 
+#define ARM_REBOOT_MODE_HARD   'h'
+#define ARM_REBOOT_MODE_SOFT   's'
+
 void arm_machine_restart(char mode, const char *cmd);
 extern void (*arm_pm_restart)(char str, const char *cmd);
diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index 01e9d64..18556da 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -9,6 +9,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <asm/proc-fns.h>
+#include <asm/system.h>
 
 #include <mach/regs-ost.h>
 #include <mach/reset.h>
@@ -54,8 +55,6 @@ out:
  */
 static void do_gpio_reset(void)
 {
-	BUG_ON(reset_gpio == -1);
-
 	/* drive it low */
 	gpio_direction_output(reset_gpio, 0);
 	mdelay(2);
@@ -69,8 +68,6 @@ static void do_gpio_reset(void)
 	mdelay(10);
 
 	WARN_ON(1);
-	/* fallback */
-	do_hw_reset();
 }
 
 static void do_hw_reset(void)
@@ -86,15 +83,14 @@ void arch_reset(char mode, const char *cmd)
 	clear_reset_status(RESET_STATUS_ALL);
 
 	switch (mode) {
-	case 's':
+	case ARM_REBOOT_MODE_SOFT:
 		/* Jump into ROM at address 0 */
 		cpu_reset(0);
 		break;
-	case 'g':
-		do_gpio_reset();
-		break;
-	case 'h':
+	case ARM_REBOOT_MODE_HARD:
 	default:
+		if (reset_gpio != -1)
+			do_gpio_reset();
 		do_hw_reset();
 		break;
 	}
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 438c7b5..34be135 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -925,7 +925,7 @@ static inline void spitz_i2c_init(void) {}
  ******************************************************************************/
 static void spitz_poweroff(void)
 {
-	arm_machine_restart('g', NULL);
+	arm_machine_restart(ARM_REBOOT_MODE_HARD, NULL);
 }
 
 static void spitz_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 9f69a26..e118933 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -905,7 +905,7 @@ static struct platform_device *devices[] __initdata = {
 
 static void tosa_poweroff(void)
 {
-	arm_machine_restart('g', NULL);
+	arm_machine_restart(ARM_REBOOT_MODE_HARD, NULL);
 }
 
 static void tosa_restart(char mode, const char *cmd)
