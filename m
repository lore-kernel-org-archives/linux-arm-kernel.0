From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:29:30 +0100
Subject: [PATCH 5/6] ARM: integrator: register sched_clock directly
In-Reply-To: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1392373771-17303-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The detour through plat-versatile/sched-clock.c is hard to migrate
to multiplatform set-up and it's very little code being duplicated
so let's just inline the sched_clock registration and cut one more
dependency to plat-versatile.

This also makes this sched_clock implementation compulsory.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_cp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index c97ab88897cf..a938242b0c95 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sys_soc.h>
+#include <linux/sched_clock.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -36,7 +37,6 @@
 #include <asm/mach/time.h>
 
 #include <plat/clcd.h>
-#include <plat/sched_clock.h>
 
 #include "hardware.h"
 #include "cm.h"
@@ -225,11 +225,14 @@ static struct clcd_board clcd_data = {
 
 #define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
 
+static u64 notrace intcp_read_sched_clock(void)
+{
+	return readl(REFCOUNTER);
+}
+
 static void __init intcp_init_early(void)
 {
-#ifdef CONFIG_PLAT_VERSATILE_SCHED_CLOCK
-	versatile_sched_clock_init(REFCOUNTER, 24000000);
-#endif
+	sched_clock_register(intcp_read_sched_clock, 32, 24000000);
 }
 
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
-- 
1.8.5.3
