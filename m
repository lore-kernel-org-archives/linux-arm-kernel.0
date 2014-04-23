From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Apr 2014 12:45:41 -0700
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <cover.1398213562.git.nathan_lynch@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
Message-ID: <53581865.2020601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/14 17:48, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).
>
> Clocks supported:
> - CLOCK_REALTIME
> - CLOCK_MONOTONIC
> - CLOCK_REALTIME_COARSE
> - CLOCK_MONOTONIC_COARSE
>
> This also provides clock_getres (as arm64 does).
>
> Note that while the high-precision realtime and monotonic clock
> support depends on the generic timers extension, support for
> clock_getres and coarse clocks is independent of the timer
> implementation and is provided unconditionally.

I think we'll need to rename the clocksource in arch_timer.c if we only
have an mmio architected timer to something like arch_mem_counter. Or we
would need to map the register space for the view into userspace? I'm
guessing that is hard, but if that was done then I assume it would lay
the foundation for any mmio clocksource being used for the vdso.

----8<-----
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b009012429b5..3f3d8ed465f4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -449,10 +449,12 @@ static void __init arch_counter_register(unsigned type)
        u64 start_count;
 
        /* Register the CP15 based counter if we have one */
-       if (type & ARCH_CP15_TIMER)
+       if (type & ARCH_CP15_TIMER) {
                arch_timer_read_counter = arch_counter_get_cntvct_cp15;
-       else
+       } else {
                arch_timer_read_counter = arch_counter_get_cntvct_mem;
+               clocksource_counter.name = "arch_mem_counter";
+       }
 
        start_count = arch_timer_read_counter();
        clocksource_register_hz(&clocksource_counter, arch_timer_rate);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
