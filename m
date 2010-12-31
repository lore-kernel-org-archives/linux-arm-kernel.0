From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 31 Dec 2010 17:20:41 +0100
Subject: [PATCH v2 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <AANLkTimSKLMYix3NQVWbddCz+jxBhba-a-2U3eZxw7y6@mail.gmail.com>
References: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
	<1293686881-15046-2-git-send-email-yong.shen@freescale.com>
	<20101230095401.GW14221@pengutronix.de>
	<AANLkTimSKLMYix3NQVWbddCz+jxBhba-a-2U3eZxw7y6@mail.gmail.com>
Message-ID: <20101231162041.GH14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong[1],
On Fri, Dec 31, 2010 at 10:31:30AM +0800, Yong Shen wrote:
> 2010/12/30 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Thu, Dec 30, 2010 at 01:28:00PM +0800, yong.shen at freescale.com wrote:
> >> From: Yong Shen <yong.shen@linaro.org>
> >>
> >> 1. pll_base address should return right value
> >> 2. uart parent clk is from pll3
> >> 3. add cpu_is_mx53 definition
> >>
> >> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> >> ---
> >> ?arch/arm/mach-mx5/clock-mx51-mx53.c ?| ? ?7 ++++---
> >> ?arch/arm/mach-mx5/crm_regs.h ? ? ? ? | ? ?4 ++++
> >> ?arch/arm/plat-mxc/include/mach/mxc.h | ? 15 +++++++++++++--
> >> ?3 files changed, 21 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> index 9fc65bb..6db69db 100644
> >> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> @@ -127,11 +127,11 @@ static inline u32 _get_mux(struct clk *parent, struct clk *m0,
> >> ?static inline void __iomem *_get_pll_base(struct clk *pll)
> >> ?{
> >> ? ? ? if (pll == &pll1_main_clk)
> >> - ? ? ? ? ? ? return MX51_DPLL1_BASE;
> >> + ? ? ? ? ? ? return cpu_is_mx51() ? MX51_DPLL1_BASE : MX53_DPLL1_BASE;
> >> ? ? ? else if (pll == &pll2_sw_clk)
> >> - ? ? ? ? ? ? return MX51_DPLL2_BASE;
> >> + ? ? ? ? ? ? return cpu_is_mx51() ? MX51_DPLL2_BASE : MX53_DPLL2_BASE;
> >> ? ? ? else if (pll == &pll3_sw_clk)
> >> - ? ? ? ? ? ? return MX51_DPLL3_BASE;
> >> + ? ? ? ? ? ? return cpu_is_mx51() ? MX51_DPLL3_BASE : MX53_DPLL3_BASE;
> >> ? ? ? else if (pll == &mx53_pll4_sw_clk)
> >> ? ? ? ? ? ? ? return MX53_DPLL4_BASE;
> >> ? ? ? else
> > hmmm, not nice. ?I assume Sascha won't take that.
> Since the file name is clock-mx51-mx53.c, so this file is supposed to
> contain clock information either for mx51 or mx53. And you can find
> cpu_is_mx5x() is widely used across the file for this purpose, which
> is way I also adapt it in this function. So IMHO, I guess this is the
> straight way to add it with little code changes. Please correct me.
little code changes are not always the first goal.  Note that this code
results in a runtime choice, it would be nicer to have a dedicated
function for mx51 and mx53 each and set pointers to the respective
function.  OTOH this is not a hot path.
 
> >> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> >> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> >> @@ -126,7 +126,7 @@ extern unsigned int __mxc_cpu_type;
> >> ?# define cpu_is_mx35() ? ? ? ? ? ? ? (0)
> >> ?#endif
> >>
> >> -#ifdef CONFIG_ARCH_MX5
> >> +#ifdef CONFIG_ARCH_MX51
> >> ?# ifdef mxc_cpu_type
> >> ?# ?undef mxc_cpu_type
> >> ?# ?define mxc_cpu_type __mxc_cpu_type
> >> @@ -134,11 +134,22 @@ extern unsigned int __mxc_cpu_type;
> >> ?# ?define mxc_cpu_type MXC_CPU_MX51
> >> ?# endif
> >> ?# define cpu_is_mx51() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX51)
> >> -# define cpu_is_mx53() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX53)
> >> ?#else
> >> ?# define cpu_is_mx51() ? ? ? ? ? ? ? (0)
> >> ?#endif
> >>
> >> +#ifdef CONFIG_ARCH_MX53
> >> +# ifdef mxc_cpu_type
> >> +# ?undef mxc_cpu_type
> >> +# ?define mxc_cpu_type __mxc_cpu_type
> >> +# else
> >> +# ?define mxc_cpu_type MXC_CPU_MX53
> >> +# endif
> >> +# define cpu_is_mx53() ? ? ? ? ? ? ? (mxc_cpu_type == MXC_CPU_MX53)
> >> +#else
> >> +# define cpu_is_mx53() ? ? ? ? ? ? ? (0)
> >> +#endif
> >> +
> >> ?#ifdef CONFIG_ARCH_MXC91231
> >> ?# ifdef mxc_cpu_type
> >> ?# ?undef mxc_cpu_type
> > This hunk is also included in one of Richard's patches for mx50.
> Since Richard's patches are not in the tree so far, so I can not
> develop my patch based on his code, which is why there are some
> duplicated code here. But I guess it should not be an issue, since
> maintainer can easily resolve this conflict when merging this patch.
This was only meant as hint to make you, Richard and Sascha aware of it.

Best regards and happy new year,
Uwe

[1] I hope this is the right part of your name to address you.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
