From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Dec 2014 10:03:28 +0100
Subject: [PATCH RFT 2/2] arm: dts: disable CCI on exynos420 based
 arndale-octa
In-Reply-To: <CAM4voa=aN53CWjTzw-A736xZo3xWr2N4kBpM0vJX5KqfV-ikjQ@mail.gmail.com>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
 <1417187977.19247.4.camel@AMDC1943>
 <CAM4voa=aN53CWjTzw-A736xZo3xWr2N4kBpM0vJX5KqfV-ikjQ@mail.gmail.com>
Message-ID: <1417424608.4055.24.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-11-28 at 21:09 +0530, Abhilash Kesavan wrote:
> Hello Krzysztof,
> 
> On Fri, Nov 28, 2014 at 8:49 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > On pi?, 2014-11-28 at 20:20 +0530, Abhilash Kesavan wrote:
> >> The arndale-octa board was giving "imprecise external aborts" during
> >> boot-up with MCPM enabled. CCI enablement of the boot cluster was found
> >> to be the cause of these aborts (possibly because the secure f/w was not
> >> allowing it). Hence, disable CCI for the arndale-octa board.
> >>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> ---
> >>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    4 ++++
> >>  arch/arm/boot/dts/exynos5420.dtsi             |    2 +-
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > I tested these 2 patches on Arndale Octa but there are no improvements.
> > I still got imprecise aborts (some not fatal and sometimes killing init
> > with full backtrace).
> 
> Thanks for testing. Are you testing this with exynos_defconfig with no
> other changes ? Can you please confirm from the bootlog that MCPM and
> CCI are not being initialized.
> 
That was exynos_defconfig with disabled DRM and enabled some debug,
next-20141128.

When I tried only exynos_defconfig (with disabled DRM) it worked fine...
So the imprecise aborts were caused by one of following debug options:

DEBUG_SECTION_MISMATCH
DYNAMIC_DEBUG
DEBUG_ATOMIC_SLEEP
DEBUG_PREEMPT
PROVE_LOCKING
LOCKUP_DETECTOR
DEBUG_LOCK_ALLOC
PROVE_RCU
DEBUG_RT_MUTEXES
DEBUG_MUTEXES
DEBUG_SPINLOCK
DEBUG_LIST
DEBUG_PAGEALLOC
SPARSE_RCU_POINTER
DEBUG_FS
PM_DEBUG
PM_ADVANCED_DEBUG
GPIO_SYSFS                                                                                                               

> Can you remove these 2 patches and on linux-next check if you are
> getting aborts even with 5420_MCPM disabled.

I tried this already and imprecise aborts shown, however with my
debugging options above.

Overall the patches seems to work properly (although the debugging issue
needs to be resolved still), so:

On Arndale Octa (Exynos 5420):
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
