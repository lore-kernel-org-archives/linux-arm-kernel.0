From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 May 2012 13:34:14 -0700
Subject: [PATCH 17/18][V3] ARM: OMAP3/4: consolidate cpuidle Makefile
In-Reply-To: <1335276339-11135-18-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:38 +0200")
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <1335276339-11135-18-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87wr4tj96h.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Define a CPU_IDLE section in the makefile, declare the functions in
> the header files conforming to the kernel coding rules and remove the
> 'define's in the C files.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>

This patch breaks compilation for the !CONFIG_PM case:

   arch/arm/mach-omap2/built-in.o: In function `__omap3_enter_idle':
   /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle34xx.c:121: undefined reference to `omap_sram_idle'

Since you moved this stuff out of a CONFIG_PM conditional part of the
Makefile, it broke because pm34xx.c is still compiled conditionally on
CONFIG_PM.

When changing Makefile/Kconfig dependencies like this, please
be sure to at least compile test with the various options
enabled/disabled.

For now, I've dropped this patch from the series.  Feel free to
update/retest/resend since the idea is fine.

Kevin
