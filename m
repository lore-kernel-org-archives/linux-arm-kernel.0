From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:09 +0000
Subject: [PATCHv4 12/13] ARM: picoxcell: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-13-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for picoxcell to help building multi platform kernels.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-picoxcell/common.c                   |    9 ++++-----
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   11 ++++-------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 76a379c..43bb172 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -651,6 +651,7 @@ config ARCH_PICOXCELL
 	select GENERIC_GPIO
 	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
+	select MULTI_IRQ_HANDLER
 	select NO_IOPORT
 	select USE_OF
 	help
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 34d0834..ad871bd 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -11,6 +11,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
@@ -33,22 +34,20 @@ static const char *picoxcell_dt_match[] = {
 };
 
 static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl192-vic" },
+	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
 	{ /* Sentinel */ }
 };
 
 static void __init picoxcell_init_irq(void)
 {
-	vic_init(IO_ADDRESS(PICOXCELL_VIC0_BASE), 0, ~0, 0);
-	vic_init(IO_ADDRESS(PICOXCELL_VIC1_BASE), 32, ~0, 0);
-	irq_domain_generate_simple(vic_of_match, PICOXCELL_VIC0_BASE, 0);
-	irq_domain_generate_simple(vic_of_match, PICOXCELL_VIC1_BASE, 32);
+	of_irq_init(vic_of_match);
 }
 
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= ARCH_NR_IRQS,
 	.init_irq	= picoxcell_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &picoxcell_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
diff --git a/arch/arm/mach-picoxcell/include/mach/entry-macro.S b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
index a6b09f7..9b505ac 100644
--- a/arch/arm/mach-picoxcell/include/mach/entry-macro.S
+++ b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
@@ -9,11 +9,8 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/map.h>
+	.macro  disable_fiq
+	.endm
 
-#define VA_VIC0		IO_ADDRESS(PICOXCELL_VIC0_BASE)
-#define VA_VIC1		IO_ADDRESS(PICOXCELL_VIC1_BASE)
-
-#include <asm/entry-macro-vic2.S>
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
-- 
1.7.5.4
