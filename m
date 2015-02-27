From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 27 Feb 2015 17:54:31 +0000
Subject: [PATCH v2] drivers: cpuidle: cpuidle-arm64: include
 asm/proc-fns.h explicitly
In-Reply-To: <20150227173422.GI17949@e104818-lin.cambridge.arm.com>
References: <20150226182307.GD17949@e104818-lin.cambridge.arm.com>
 <54F09EFA.4090906@linaro.org> <20150227171604.GA12998@red-moon>
 <54F0A703.6090808@linaro.org>
 <20150227173422.GI17949@e104818-lin.cambridge.arm.com>
Message-ID: <20150227175431.GA30173@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 05:34:22PM +0000, Catalin Marinas wrote:
> On Fri, Feb 27, 2015 at 06:18:59PM +0100, Daniel Lezcano wrote:
> > On 02/27/2015 06:16 PM, Lorenzo Pieralisi wrote:
> > >On Fri, Feb 27, 2015 at 04:44:42PM +0000, Daniel Lezcano wrote:
> > >>On 02/26/2015 07:23 PM, Catalin Marinas wrote:
> > >>>On Wed, Feb 25, 2015 at 01:11:40PM +0000, Will Deacon wrote:
> > >>>>On Wed, Feb 25, 2015 at 12:59:42PM +0000, Lorenzo Pieralisi wrote:
> > >>>>>ARM64 CPUidle driver requires the cpu_do_idle function so that it can
> > >>>>>be used to enter the shallowest idle state, and it is declared in
> > >>>>>asm/proc-fns.h.
> > >>>>>
> > >>>>>The current ARM64 CPUidle driver does not include asm/proc-fns.h
> > >>>>>explicitly and it has so far relied on implicit inclusion from other
> > >>>>>header files.
> > >>>>>
> > >>>>>Owing to some header dependencies reshuffling this currently triggers
> > >>>>>build failures when CONFIG_ARM64_64K_PAGES=y:
> > >>>>>
> > >>>>>drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
> > >>>>>drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of
> > >>>>>function "cpu_do_idle" [-Werror=implicit-function-declaration]
> > >>>>>     cpu_do_idle();
> > >>>>>     ^
> > >>>>>
> > >>>>>This patch adds the explicit inclusion of the asm/proc-fns.h header file
> > >>>>>to fix the build breakage and stop relying on implicit asm/proc-fns.h
> > >>>>>inclusion.
> > >>>>>
> > >>>>>Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> > >>>>>[lp: rewrote commit log]
> > >>>>>Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >>>>>Tested-by: Mark Rutland <mark.rutland@arm.com>
> > >>>>>---
> > >>>>>v2 changes:
> > >>>>
> > >>>>Acked-by: Will Deacon <will.deacon@arm.com>
> > >>>>
> > >>>>Catalin will pick this up for -rc2, I suspect.
> > >>>
> > >>>I can merge this as long as Daniel or Rafael are fine with it.
> > >>
> > >>I am wondering if asm/proc-fns.h shouldn't be directly included in
> > >>asm/cpuidle.h, otherwise each time cpuidle.h is included somewhere we
> > >>have to include proc-fns.h also.
> > >>
> > >>It is not a problem for ARM64 because there is not a big number of
> > >>cpuidle drivers but for ARM32 it is not the case. I have a patchset
> > >>which put proc-fns.h inclusion directly in asm/cpuidle.h and cleanup the
> > >>drivers. For the sake of consistency between ARM/ARM64 may be it would
> > >>make sense to include in the cpuidle.h directly, no ?
> > >
> > >This patch is a build fix, and I'd rather get it in asap. We can move
> > >the inclusion and merge the resulting clean-up patch in your series later.
> > >I will put together the patch now, if Catalin has the pull request ready
> > >to be sent I do not see the point in delaying it though.
> > 
> > I was just suggesting to put the proc-fns.h inclusion in cpuidle.h directly.
> > That fixes the build also.
> 
> This would do as well, especially since you plan to clean up arch/arm as
> well (or just move the cpu_do_idle() prototype in asm/cpuidle.h; we
> moved cpu_suspend() there already).

What I wanted to say is that the clean-up will be merged the coming
cycle anyway, not now, so I wanted to avoid delaying the pull request
for something that could have been done later.

Reworked patch below (I kept the tags to avoid even more churn for a
one-liner).

Thanks,
Lorenzo

-- >8 --
Subject: [PATCH] ARM64: cpuidle: add asm/proc-fns.h inclusion

ARM64 CPUidle driver requires the cpu_do_idle function so that it can
be used to enter the shallowest idle state, and it is declared in
asm/proc-fns.h.

The current ARM64 CPUidle driver does not include asm/proc-fns.h
explicitly and it has so far relied on implicit inclusion from other
header files.

Owing to some header dependencies reshuffling this currently triggers
build failures when CONFIG_ARM64_64K_PAGES=y:

drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of
function "cpu_do_idle" [-Werror=implicit-function-declaration]
   cpu_do_idle();
   ^

This patch adds the explicit inclusion of the asm/proc-fns.h header file
in the arm64 asm/cpuidle.h header file, so that the build breakage is fixed
and the required header inclusion is added to the appropriate arch back-end
CPUidle header, already included by the CPUidle arm64 driver, where
CPUidle arch related function declarations belong.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
[lp: rewrote commit log, moved include to arm64 asm/cpuidle.h]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpuidle.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 0710654..c60643f 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_CPUIDLE_H
 #define __ASM_CPUIDLE_H
 
+#include <asm/proc-fns.h>
+
 #ifdef CONFIG_CPU_IDLE
 extern int cpu_init_idle(unsigned int cpu);
 extern int cpu_suspend(unsigned long arg);
-- 
1.9.1
