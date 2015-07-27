From: klimov.linux@gmail.com (Alexey Klimov)
Date: Tue, 28 Jul 2015 00:28:27 +0300
Subject: [RFC PATCH 0/3] clocksource: exynos_mct: allow mct to use 64-bit
 counter from coprocessor
Message-ID: <1438032507.17734.46.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

year(s) ago it was discovered that MCT timer and ARM architectured
timer
are the same hardware with different interface. Here [1].

I followed mail-list discussions about removing MCT and using arch
timer for Exynos5-based SoCs but things aren't moving at least latest
upstream kernel on odroid-xu3 will use MCT as default timers.
Maybe the reason are some power-management related things that very
specific to Samsung. I don't know.


Idea of this draft patchset comes from Doug patches when he tried to
optimize read of 64-bit counter located in mmio. [2]
Why not using cp15 counter instead if possible?

Previous numbers for 1000000 gettimeofday() calls from userspace
are about 1 ms. With this patches we have 0.5 ms or even better.
So twice as fast.

Just as matter of interest i tried to perform 2000000 sched_yield()
calls from userspace. I see around 20% speedup with patches applied.

I tried to use hackbench but it's hard to feel the difference, maybe
speedup is 0.5% but with bad fluctuation.

Everything is tested on odroid-xu3.
Looks like Cortex-A9 based Samsung SoCs (odroid-u2, odroid-x) don't
have arch timer.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014
-May/256943.html
[2] https://lkml.org/lkml/2014/6/20/431



Current code created with such assumptions: 
-- don't want to insert huge refactoring in MCT code;
-- target platform only ARMv7 Exynos5-based SoC that works in 32-bit
mode so i don't want to build described functionality on ARM64.
Currently i'm trying to patch odroid-xu3 DT only.
-- firmware on odroid-xu3 is broken and secondary cores start
in SVC mode instead of HYP mode. Maybe i can remove check for hyp mode;
-- in addition instead of DT property I may parse PFR regs and find
Generic Timer Extension there.

I hope you are not getting bored reading to me. Current code is a
little bit draft so comments and ideas are welcome.

Best regards,
Alexey Klimov
