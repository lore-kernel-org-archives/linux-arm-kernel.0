From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Oct 2012 13:43:08 -0500
Subject: [PATCH 6/6] ARM: highbank: Add initial ECX-2000 support
In-Reply-To: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
References: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351276988-28382-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

And initial Calxeda ECX-2000 SOC support. This adds Cortex-A15 peripherals
and machine DT match name.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig    |    2 +-
 arch/arm/mach-highbank/highbank.c |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 0e1d0a4..551c97e 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_HIGHBANK
-	bool "Calxeda ECX-1000 (Highbank)" if ARCH_MULTI_V7
+	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 3da921a..3e60e57 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -26,6 +26,7 @@
 #include <linux/smp.h>
 #include <linux/amba/bus.h>
 
+#include <asm/arch_timer.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
@@ -70,6 +71,7 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 }
 
 const static struct of_device_id irq_match[] = {
+	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{}
 };
@@ -126,6 +128,9 @@ static void __init highbank_timer_init(void)
 	sp804_clockevents_init(timer_base, irq, "timer0");
 
 	twd_local_timer_of_register();
+
+	arch_timer_of_register();
+	arch_timer_sched_clock_init();
 }
 
 static struct sys_timer highbank_timer = {
@@ -200,6 +205,7 @@ static void __init highbank_init(void)
 
 static const char *highbank_match[] __initconst = {
 	"calxeda,highbank",
+	"calxeda,ecx-2000",
 	NULL,
 };
 
-- 
1.7.10.4
