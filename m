From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 27 Feb 2015 17:16:04 +0000
Subject: [PATCH v2] drivers: cpuidle: cpuidle-arm64: include
 asm/proc-fns.h explicitly
In-Reply-To: <54F09EFA.4090906@linaro.org>
References: <20150226182307.GD17949@e104818-lin.cambridge.arm.com>
 <54F09EFA.4090906@linaro.org>
Message-ID: <20150227171604.GA12998@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 04:44:42PM +0000, Daniel Lezcano wrote:
> On 02/26/2015 07:23 PM, Catalin Marinas wrote:
> > On Wed, Feb 25, 2015 at 01:11:40PM +0000, Will Deacon wrote:
> >> On Wed, Feb 25, 2015 at 12:59:42PM +0000, Lorenzo Pieralisi wrote:
> >>> ARM64 CPUidle driver requires the cpu_do_idle function so that it can
> >>> be used to enter the shallowest idle state, and it is declared in
> >>> asm/proc-fns.h.
> >>>
> >>> The current ARM64 CPUidle driver does not include asm/proc-fns.h
> >>> explicitly and it has so far relied on implicit inclusion from other
> >>> header files.
> >>>
> >>> Owing to some header dependencies reshuffling this currently triggers
> >>> build failures when CONFIG_ARM64_64K_PAGES=y:
> >>>
> >>> drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
> >>> drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of
> >>> function "cpu_do_idle" [-Werror=implicit-function-declaration]
> >>>     cpu_do_idle();
> >>>     ^
> >>>
> >>> This patch adds the explicit inclusion of the asm/proc-fns.h header file
> >>> to fix the build breakage and stop relying on implicit asm/proc-fns.h
> >>> inclusion.
> >>>
> >>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >>> [lp: rewrote commit log]
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> Tested-by: Mark Rutland <mark.rutland@arm.com>
> >>> ---
> >>> v2 changes:
> >>
> >> Acked-by: Will Deacon <will.deacon@arm.com>
> >>
> >> Catalin will pick this up for -rc2, I suspect.
> >
> > I can merge this as long as Daniel or Rafael are fine with it.
> 
> I am wondering if asm/proc-fns.h shouldn't be directly included in 
> asm/cpuidle.h, otherwise each time cpuidle.h is included somewhere we 
> have to include proc-fns.h also.
> 
> It is not a problem for ARM64 because there is not a big number of 
> cpuidle drivers but for ARM32 it is not the case. I have a patchset 
> which put proc-fns.h inclusion directly in asm/cpuidle.h and cleanup the 
> drivers. For the sake of consistency between ARM/ARM64 may be it would 
> make sense to include in the cpuidle.h directly, no ?

This patch is a build fix, and I'd rather get it in asap. We can move
the inclusion and merge the resulting clean-up patch in your series later.
I will put together the patch now, if Catalin has the pull request ready
to be sent I do not see the point in delaying it though.

Lorenzo

> >>> - Picked up
> >>>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325523.html
> >>> - Rebased against 4.0-rc1 and rewrote commit log
> >>>
> >>>   drivers/cpuidle/cpuidle-arm64.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> >>> index 39a2c62..c8bb6c5 100644
> >>> --- a/drivers/cpuidle/cpuidle-arm64.c
> >>> +++ b/drivers/cpuidle/cpuidle-arm64.c
> >>> @@ -19,6 +19,7 @@
> >>>   #include <linux/of.h>
> >>>
> >>>   #include <asm/cpuidle.h>
> >>> +#include <asm/proc-fns.h>
> >>>
> >>>   #include "dt_idle_states.h"
> >>>
> 
> 
> -- 
>   <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 
