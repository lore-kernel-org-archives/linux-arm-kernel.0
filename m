From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 23:15:56 +0000
Subject: [PATCH 3/5] ARM: restart: exynos4: use new restart hook XXX
 WIP XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX
In-Reply-To: <04f101cc9dd6$4b228f20$e167ad60$%kim@samsung.com>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6wy-0001aV-VK@rmk-PC.arm.linux.org.uk>
 <20111107103048.GM12913@n2100.arm.linux.org.uk>
 <CAH9JG2WO9LHLbLy-8Ly1UrN--L=VNuzV0yZ+5WeDxwHLbJkyOw@mail.gmail.com>
 <20111107115223.GO12913@n2100.arm.linux.org.uk>
 <04f101cc9dd6$4b228f20$e167ad60$%kim@samsung.com>
Message-ID: <20111110231556.GY12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 02:21:39PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > On Mon, Nov 07, 2011 at 08:17:58PM +0900, Kyungmin Park wrote:
> > > On 11/7/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > > On Sun, Nov 06, 2011 at 05:56:08PM +0000, Russell King - ARM Linux
> wrote:
> > > >> Hook these platforms restart code into the new restart hook rather
> > > >> than using arch_reset().
> > > >>
> > > >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > >> ---
> > > >>  arch/arm/mach-exynos4/cpu.c                 |    6 +-----
> > > >>  arch/arm/mach-exynos4/mach-armlex4210.c     |    1 +
> > > >>  arch/arm/mach-exynos4/mach-nuri.c           |    1 +
> > > >>  arch/arm/mach-exynos4/mach-origen.c         |    1 +
> > > >>  arch/arm/mach-exynos4/mach-smdk4x12.c       |    2 ++
> > > >>  arch/arm/mach-exynos4/mach-smdkv310.c       |    2 ++
> > > >>  arch/arm/mach-exynos4/mach-universal_c210.c |    1 +
> > > >>  7 files changed, 9 insertions(+), 5 deletions(-)
> > > >>
> > > >> diff --git a/arch/arm/mach-exynos4/cpu.c
> b/arch/arm/mach-exynos4/cpu.c
> > > >> index 5b1765b..5b1ee56 100644
> > > >> --- a/arch/arm/mach-exynos4/cpu.c
> > > >> +++ b/arch/arm/mach-exynos4/cpu.c
> > > >> @@ -27,7 +27,6 @@
> > > >>  #include <plat/fb-core.h>
> > > >>  #include <plat/fimc-core.h>
> > > >>  #include <plat/iic-core.h>
> > > >> -#include <plat/reset.h>
> > > >>  #include <plat/tv-core.h>
> > > >>
> > > >>  #include <mach/regs-irq.h>
> > > >> @@ -145,7 +144,7 @@ static void exynos4_idle(void)
> > > >>  	local_irq_enable();
> > > >>  }
> > > >>
> > > >> -static void exynos4_sw_reset(void)
> > > >> +void exynos4_restart(char mode, const char *cmd)
> > > >>  {
> > > >>  	__raw_writel(0x1, S5P_SWRESET);
> > > >>  }
> > > >> @@ -286,8 +285,5 @@ int __init exynos4_init(void)
> > > >>  	/* set idle function */
> > > >>  	pm_idle = exynos4_idle;
> > > >>
> > > >> -	/* set sw_reset function */
> > > >> -	s5p_reset_hook = exynos4_sw_reset;
> > > >> -
> > > >
> > > > I notice in last nights merge of the Samsung stuff, this has become
> > > > less trivial - it's now:
> > > >         /* set sw_reset function */
> > > >         if (soc_is_exynos4210() || soc_is_exynos4212() ||
> > > > soc_is_exynos4412())
> > > >                 s5p_reset_hook = exynos4_sw_reset;
> > > >
> > > > So which of the boards should be converted and which shouldn't ?
> > > > In other words, which exynos4210, 4212 or 4412 platforms?
> > >
> > > except the arch/arm/mach-exynos4/mach-smdk4x12.c, exynos4210 is used.
> > > currently all exynos4 series has same reset function. it's preparation
> > > for exynos5 series maybe.
> > >
> > > you can use the exynos4_sw_reset for all boards.
> > 
> Thanks, Kyungmin.
> 
> > Thanks, that gets me back to where I was with the patch before the
> > exynos4 move.
> > 
> 
> Thanks.

I have to point out that even so, this patch as it stands will break
the exynos build (that's why the subject line contains the XXX WIP XXX
stuff.)

As I said in my pet peaves mail, there should be a header in
arch/arm/mach-exynos for the data and function declarations which are
only used by and only provided by files in this directory.  Such things
as:

struct sys_timer exynos4_timer;
void exynos4_init_irq(void);

etc.  This stuff should not be inappropriately placed:

arch/arm/plat-samsung/include/plat/exynos4.h:extern struct sys_timer exynos4_timer;
arch/arm/plat-samsung/include/plat/exynos4.h:extern void exynos4_init_irq(void);

(e.g.,
$ grep exynos4_init_irq\\\> arch/arm -r
arch/arm/mach-exynos/mach-nuri.c:   .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-origen.c: .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-armlex4210.c:     .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-smdkv310.c:       .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-smdkv310.c:       .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-smdk4x12.c:       .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/mach-smdk4x12.c:       .init_irq       = exynos4_init_irq,
arch/arm/mach-exynos/cpu.c:void __init exynos4_init_irq(void)
arch/arm/mach-exynos/mach-universal_c210.c: .init_irq       = exynos4_init_irq,
arch/arm/plat-samsung/include/plat/exynos4.h:extern void exynos4_init_irq(void);
$ grep exynos4_timer arch/arm -r
arch/arm/mach-exynos/mach-nuri.c:   .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-origen.c: .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-armlex4210.c:     .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-smdkv310.c:       .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-smdkv310.c:       .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-smdk4x12.c:       .timer          = &exynos4_timer,
arch/arm/mach-exynos/mach-smdk4x12.c:       .timer          = &exynos4_timer,
arch/arm/mach-exynos/mct.c:struct sys_timer exynos4_timer = {
arch/arm/mach-exynos/mach-universal_c210.c: .timer          = &exynos4_timer,
arch/arm/plat-samsung/include/plat/exynos4.h:extern struct sys_timer exynos4_timer;
$ grep exynos4_register_clocks arch/arm -r
arch/arm/mach-exynos/clock.c:void __init exynos4_register_clocks(void)
arch/arm/mach-exynos/cpu.c: exynos4_register_clocks();
arch/arm/plat-samsung/include/plat/exynos4.h:extern void exynos4_register_clock(void);
$ grep exynos421._register_clocks arch/arm -r
arch/arm/mach-exynos/clock-exynos4212.c:void __init exynos4212_register_clocks(void)
arch/arm/mach-exynos/cpu.c:         exynos4210_register_clocks();
arch/arm/mach-exynos/cpu.c:         exynos4212_register_clocks();
arch/arm/mach-exynos/clock-exynos4210.c:void __init exynos4210_register_clocks(void)
arch/arm/plat-samsung/include/plat/exynos4.h:extern void exynos4210_register_clocks(void);
arch/arm/plat-samsung/include/plat/exynos4.h:extern void exynos4212_register_clocks(void);
)

I suspect a sizeable proportion of plat/exynos4.h could move into
arch/arm/mach-exynos.
