From: horms@verge.net.au (Simon Horman)
Date: Sat, 12 Jul 2014 23:01:56 +0200
Subject: shmobile build breakage
In-Reply-To: <20140712101153.GG21766@n2100.arm.linux.org.uk>
References: <20140712101153.GG21766@n2100.arm.linux.org.uk>
Message-ID: <20140712210155.GB12422@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 11:11:53AM +0100, Russell King - ARM Linux wrote:
> Regular nightly randconfig build testing found:
> 
> arch/arm/mach-shmobile/platsmp-apmu.c:245:6: error: redefinition of 'shmobile_smp_apmu_suspend_init'
> In file included from arch/arm/mach-shmobile/platsmp-apmu.c:23:0:
> arch/arm/mach-shmobile/common.h:41:91: note: previous definition of 'shmobile_smp_apmu_suspend_init' was here
> arch/arm/mach-shmobile/platsmp-apmu.c:46:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
> arch/arm/mach-shmobile/platsmp-apmu.c:53:12: warning: 'apmu_power_off_poll' defined but not used [-Wunused-function]
> make[2]: *** [arch/arm/mach-shmobile/platsmp-apmu.o] Error 1
> 
> arch/arm/mach-shmobile/platsmp-apmu.c does this:
> 
> #include "common.h"
> ...
> #if defined(CONFIG_SUSPEND)
> void shmobile_smp_apmu_suspend_init(void)
> {
>         shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
> }
> #else
> void shmobile_smp_apmu_suspend_init(void) {}
> #endif
> 
> whereas common.h does this:
> 
> #ifdef CONFIG_SUSPEND
> int shmobile_suspend_init(void);
> void shmobile_smp_apmu_suspend_init(void);
> #else
> static inline int shmobile_suspend_init(void) { return 0; }
> static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
> #endif
> 
> So when CONFIG_SUSPEND is disabled, we get an inline function and a
> stub function, and the compiler complains.
> 
> The two warnings mentioned above could do with fixing as well.

Hi Russell,

sorry for letting this one slip through.

I believe it is resolved by "ARM: shmobile: fix
shmobile_smp_apmu_suspend_init build failure for !SUSPEND" from Arnd.
I have asked the arm SoC folks to pull a branch including that fix.

That pull request is
"Third Round of Renesas ARM Based SoC Updates for v3.17"
