From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 11:52:23 +0000
Subject: [PATCH 3/5] ARM: restart: exynos4: use new restart hook XXX
 WIP XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX
In-Reply-To: <CAH9JG2WO9LHLbLy-8Ly1UrN--L=VNuzV0yZ+5WeDxwHLbJkyOw@mail.gmail.com>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6wy-0001aV-VK@rmk-PC.arm.linux.org.uk>
 <20111107103048.GM12913@n2100.arm.linux.org.uk>
 <CAH9JG2WO9LHLbLy-8Ly1UrN--L=VNuzV0yZ+5WeDxwHLbJkyOw@mail.gmail.com>
Message-ID: <20111107115223.GO12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 08:17:58PM +0900, Kyungmin Park wrote:
> On 11/7/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Sun, Nov 06, 2011 at 05:56:08PM +0000, Russell King - ARM Linux wrote:
> >> Hook these platforms restart code into the new restart hook rather
> >> than using arch_reset().
> >>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> ---
> >>  arch/arm/mach-exynos4/cpu.c                 |    6 +-----
> >>  arch/arm/mach-exynos4/mach-armlex4210.c     |    1 +
> >>  arch/arm/mach-exynos4/mach-nuri.c           |    1 +
> >>  arch/arm/mach-exynos4/mach-origen.c         |    1 +
> >>  arch/arm/mach-exynos4/mach-smdk4x12.c       |    2 ++
> >>  arch/arm/mach-exynos4/mach-smdkv310.c       |    2 ++
> >>  arch/arm/mach-exynos4/mach-universal_c210.c |    1 +
> >>  7 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> >> index 5b1765b..5b1ee56 100644
> >> --- a/arch/arm/mach-exynos4/cpu.c
> >> +++ b/arch/arm/mach-exynos4/cpu.c
> >> @@ -27,7 +27,6 @@
> >>  #include <plat/fb-core.h>
> >>  #include <plat/fimc-core.h>
> >>  #include <plat/iic-core.h>
> >> -#include <plat/reset.h>
> >>  #include <plat/tv-core.h>
> >>
> >>  #include <mach/regs-irq.h>
> >> @@ -145,7 +144,7 @@ static void exynos4_idle(void)
> >>  	local_irq_enable();
> >>  }
> >>
> >> -static void exynos4_sw_reset(void)
> >> +void exynos4_restart(char mode, const char *cmd)
> >>  {
> >>  	__raw_writel(0x1, S5P_SWRESET);
> >>  }
> >> @@ -286,8 +285,5 @@ int __init exynos4_init(void)
> >>  	/* set idle function */
> >>  	pm_idle = exynos4_idle;
> >>
> >> -	/* set sw_reset function */
> >> -	s5p_reset_hook = exynos4_sw_reset;
> >> -
> >
> > I notice in last nights merge of the Samsung stuff, this has become
> > less trivial - it's now:
> >         /* set sw_reset function */
> >         if (soc_is_exynos4210() || soc_is_exynos4212() ||
> > soc_is_exynos4412())
> >                 s5p_reset_hook = exynos4_sw_reset;
> >
> > So which of the boards should be converted and which shouldn't ?
> > In other words, which exynos4210, 4212 or 4412 platforms?
> 
> except the arch/arm/mach-exynos4/mach-smdk4x12.c, exynos4210 is used.
> currently all exynos4 series has same reset function. it's preparation
> for exynos5 series maybe.
> 
> you can use the exynos4_sw_reset for all boards.

Thanks, that gets me back to where I was with the patch before the
exynos4 move.
