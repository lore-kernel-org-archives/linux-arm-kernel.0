From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 17:45:57 +0200
Subject: [PATCHv2 3/6] sched_clock: Make ARM's sched_clock generic for all
 architectures
In-Reply-To: <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <201306211745.57528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 June 2013, Stephen Boyd wrote:
> Nothing about the sched_clock implementation in the ARM port is
> specific to the architecture. Generalize the code so that other
> architectures can use it by selecting GENERIC_SCHED_CLOCK.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig                                      | 1 +
>  arch/arm/common/timer-sp.c                            | 2 +-
>  arch/arm/kernel/Makefile                              | 2 +-
>  arch/arm/kernel/arch_timer.c                          | 2 +-
>  arch/arm/kernel/time.c                                | 4 +---
>  arch/arm/mach-davinci/time.c                          | 2 +-
>  arch/arm/mach-imx/time.c                              | 2 +-
>  arch/arm/mach-integrator/integrator_ap.c              | 2 +-
>  arch/arm/mach-ixp4xx/common.c                         | 2 +-
>  arch/arm/mach-mmp/time.c                              | 2 +-
>  arch/arm/mach-msm/timer.c                             | 2 +-
>  arch/arm/mach-omap1/time.c                            | 2 +-
>  arch/arm/mach-omap2/timer.c                           | 2 +-
>  arch/arm/mach-pxa/time.c                              | 2 +-
>  arch/arm/mach-sa1100/time.c                           | 2 +-
>  arch/arm/mach-u300/timer.c                            | 2 +-
>  arch/arm/plat-iop/time.c                              | 2 +-
>  arch/arm/plat-omap/counter_32k.c                      | 2 +-
>  arch/arm/plat-orion/time.c                            | 2 +-
>  arch/arm/plat-samsung/samsung-time.c                  | 2 +-
>  arch/arm/plat-versatile/sched-clock.c                 | 2 +-
>  drivers/clocksource/bcm2835_timer.c                   | 2 +-
>  drivers/clocksource/clksrc-dbx500-prcmu.c             | 3 +--
>  drivers/clocksource/dw_apb_timer_of.c                 | 2 +-
>  drivers/clocksource/mxs_timer.c                       | 2 +-
>  drivers/clocksource/nomadik-mtu.c                     | 2 +-
>  drivers/clocksource/samsung_pwm_timer.c               | 2 +-
>  drivers/clocksource/tegra20_timer.c                   | 2 +-
>  drivers/clocksource/time-armada-370-xp.c              | 2 +-
>  drivers/clocksource/timer-marco.c                     | 2 +-
>  drivers/clocksource/timer-prima2.c                    | 2 +-
>  {arch/arm/include/asm => include/linux}/sched_clock.h | 9 +++++++--
>  init/Kconfig                                          | 3 +++
>  init/main.c                                           | 2 ++
>  kernel/time/Makefile                                  | 1 +
>  {arch/arm/kernel => kernel/time}/sched_clock.c        | 3 +--

This causes build failures when doing a simple merge with the arm-soc
tree:

==> build/clps711x_defconfig/faillog <==
/git/arm-soc/arch/arm/mach-clps711x/common.c:37:29: fatal error: asm/sched_clock.h: No such file or directory
 #include <asm/sched_clock.h>
                             ^
==> build/imx_v6_v7_defconfig/faillog <==
/git/arm-soc/drivers/clocksource/vf_pit_timer.c:15:29: fatal error: asm/sched_clock.h: No such file or directory
 #include <asm/sched_clock.h>

How about adding back a temporary arch/arm/include/asm/sched_clock.h
that only contains "#include <linux/sched_clock.h>" so we can change
those two files after the merge and still get a bisectible history?

	Arnd
