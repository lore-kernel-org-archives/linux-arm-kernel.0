From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Oct 2013 18:13:17 +0900
Subject: Regression since v3.11 on ARM shmobile ape6evm board
Message-ID: <20131017091317.GA30729@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have noticed what appears to be a regression since v3.11
in Thierry Reding's next-20131017.

The effect, when booting the ape6evm board which is based on the r8a73a4
using its defconfig is that the boot does not proceed past the bootloader.

I see the following:

## Booting kernel from Legacy Image at 41000000 ...
   Image Name:   Linux-3.12.0-rc1-00012-g65cd4f6
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2208640 Bytes = 2.1 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

I have not investigated the problem any further.


commit 65cd4f6c99c1170bd0114dbd71b978012ea44d28
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Thu Jul 18 16:21:18 2013 -0700

    arch_timer: Move to generic sched_clock framework
    
    Register with the generic sched_clock framework now that it
    supports 64 bits. This fixes two problems with the current
    sched_clock support for machines using the architected timers.
    First off, we don't subtract the start value from subsequent
    sched_clock calls so we can potentially start off with
    sched_clock returning gigantic numbers. Second, there is no
    support for suspend/resume handling so problems such as discussed
    in 6a4dae5 (ARM: 7565/1: sched: stop sched_clock() during
    suspend, 2012-10-23) can happen without this patch. Finally, it
    allows us to move the sched_clock setup into drivers clocksource
    out of the arch ports.
    
    Cc: Christopher Covington <cov@codeaurora.org>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
    Signed-off-by: John Stultz <john.stultz@linaro.org>

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 221f07b..1791f12 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/sched_clock.h>
 
 #include <asm/delay.h>
 
@@ -22,13 +21,6 @@ static unsigned long arch_timer_read_counter_long(void)
 	return arch_timer_read_counter();
 }
 
-static u32 sched_clock_mult __read_mostly;
-
-static unsigned long long notrace arch_timer_sched_clock(void)
-{
-	return arch_timer_read_counter() * sched_clock_mult;
-}
-
 static struct delay_timer arch_delay_timer;
 
 static void __init arch_timer_delay_timer_register(void)
@@ -48,11 +40,5 @@ int __init arch_timer_arch_init(void)
 
 	arch_timer_delay_timer_register();
 
-	/* Cache the sched_clock multiplier to save a divide in the hot path. */
-	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
-	sched_clock_func = arch_timer_sched_clock;
-	pr_info("sched_clock: ARM arch timer >56 bits at %ukHz, resolution %uns\n",
-		arch_timer_rate / 1000, sched_clock_mult);
-
 	return 0;
 }
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..35fd0eb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 03dc371..29c39d5 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -61,13 +61,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-static u64 sched_clock_mult __read_mostly;
-
-unsigned long long notrace sched_clock(void)
-{
-	return arch_timer_read_counter() * sched_clock_mult;
-}
-
 void __init time_init(void)
 {
 	u32 arch_timer_rate;
@@ -78,9 +71,6 @@ void __init time_init(void)
 	if (!arch_timer_rate)
 		panic("Unable to initialise architected timer.\n");
 
-	/* Cache the sched_clock multiplier to save a divide in the hot path. */
-	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
-
 	/* Calibrate the delay loop directly */
 	lpj_fine = arch_timer_rate / HZ;
 }
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fbd9ccd..5d52789 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/sched_clock.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -471,6 +472,15 @@ static int __init arch_timer_register(void)
 		goto out;
 	}
 
+	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+	cyclecounter.mult = clocksource_counter.mult;
+	cyclecounter.shift = clocksource_counter.shift;
+	timecounter_init(&timecounter, &cyclecounter,
+			 arch_counter_get_cntvct());
+
+	/* 56 bits minimum, so we assume worst case rollover */
+	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+
 	if (arch_timer_use_virtual) {
 		ppi = arch_timer_ppi[VIRT_PPI];
 		err = request_percpu_irq(ppi, arch_timer_handler_virt,
