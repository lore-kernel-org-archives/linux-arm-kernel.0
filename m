From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 Aug 2012 16:09:25 +0800
Subject: [PATCH] ARM: imx6: spin the cpu until hardware takes it down
Message-ID: <1345277365-30192-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though commit 602bf40 (ARM: imx6: exit coherency when shutting down
a cpu) improves the stability of imx6q cpu hotplug a lot, there are
still hangs seen with a more stressful hotplug testing.

It's expected that once imx_enable_cpu(cpu, false) is called, the cpu
will be taken down by hardware immediately, and the code after that
will not get any chance to execute.  However, this is not always the
case from the testing.  The cpu could possibly be alive for a few
cycles before hardware actually takes it down.  So rather than letting
cpu execute some code that could cause a hang in these cycles, let's
make the cpu spin there and wait for hardware to take it down.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/hotplug.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 20ed2d5..f8f7437 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -42,22 +42,6 @@ static inline void cpu_enter_lowpower(void)
 	  : "cc");
 }
 
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-		"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	  : "=&r" (v)
-	  : "Ir" (CR_C), "Ir" (0x40)
-	  : "cc");
-}
-
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -67,11 +51,10 @@ void platform_cpu_die(unsigned int cpu)
 {
 	cpu_enter_lowpower();
 	imx_enable_cpu(cpu, false);
-	cpu_do_idle();
-	cpu_leave_lowpower();
 
-	/* We should never return from idle */
-	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+	/* spin here until hardware takes it down */
+	while (1)
+		;
 }
 
 int platform_cpu_disable(unsigned int cpu)
-- 
1.7.5.4
