From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Jul 2014 11:11:53 +0100
Subject: shmobile build breakage
Message-ID: <20140712101153.GG21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regular nightly randconfig build testing found:

arch/arm/mach-shmobile/platsmp-apmu.c:245:6: error: redefinition of 'shmobile_smp_apmu_suspend_init'
In file included from arch/arm/mach-shmobile/platsmp-apmu.c:23:0:
arch/arm/mach-shmobile/common.h:41:91: note: previous definition of 'shmobile_smp_apmu_suspend_init' was here
arch/arm/mach-shmobile/platsmp-apmu.c:46:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
arch/arm/mach-shmobile/platsmp-apmu.c:53:12: warning: 'apmu_power_off_poll' defined but not used [-Wunused-function]
make[2]: *** [arch/arm/mach-shmobile/platsmp-apmu.o] Error 1

arch/arm/mach-shmobile/platsmp-apmu.c does this:

#include "common.h"
...
#if defined(CONFIG_SUSPEND)
void shmobile_smp_apmu_suspend_init(void)
{
        shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
}
#else
void shmobile_smp_apmu_suspend_init(void) {}
#endif

whereas common.h does this:

#ifdef CONFIG_SUSPEND
int shmobile_suspend_init(void);
void shmobile_smp_apmu_suspend_init(void);
#else
static inline int shmobile_suspend_init(void) { return 0; }
static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
#endif

So when CONFIG_SUSPEND is disabled, we get an inline function and a
stub function, and the compiler complains.

The two warnings mentioned above could do with fixing as well.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
