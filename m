From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 02 Jun 2014 14:08:29 +0200
Subject: [PATCH 6/7] ARM: EXYNOS: PM: fix register setup on EXYNOS4x12 for
 AFTR mode code
In-Reply-To: <5375D44F.7000505@linaro.org>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
 <1399287439-31376-7-git-send-email-b.zolnierkie@samsung.com>
 <5375D44F.7000505@linaro.org>
Message-ID: <2762097.QhkViWyNLQ@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Friday, May 16, 2014 11:03:11 AM Daniel Lezcano wrote:
> On 05/05/2014 12:57 PM, Bartlomiej Zolnierkiewicz wrote:
> > Add S5P_CENTRAL_SEQ_OPTION register setup for EXYNOS4x12 to AFTR
> > mode code.  Without this setup AFTR mode doesn't show any benefit
> > over WFI one.  When this setup is applied AFTR mode reduces power
> > consumption by ~12% (as measured on Trats2 board).
> >
> > This change is a preparation for adding secure firmware support to
> > EXYNOS cpuidle driver.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >   arch/arm/mach-exynos/pm.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index 18f6bf8..3922968 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -391,6 +391,10 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
> >   	case CPU_PM_ENTER:
> >   		if (cpu == 0) {
> >   			exynos_pm_central_suspend();
> > +			if (soc_is_exynos4212() || soc_is_exynos4412())
> > +				__raw_writel(S5P_USE_STANDBY_WFI0 |
> > +					     S5P_USE_STANDBY_WFE0,
> > +					     S5P_CENTRAL_SEQ_OPTION);
> 
> Why not put this code in the exynos_enter_aftr() ?

I would prefer to keep this code close to exynos_pm_central_suspend()
because exynos_pm_suspend() (which calls exynos_pm_central_suspend()
too) also contains S5P_USE_STANDBY_WF[I,E]0 setting code (done for all
SoCs).  If possible I would like to make this code common for AFTR &
suspend in the future (once it is tested on Exynos4210 and Exynos5250)
by moving S5P_USE_STANDBY_WF[I,E]0 setting to exynos_pm_central_suspend()
and doing it for all SoCs.  Are you okay with this?

> >   			exynos_cpu_save_register();
> >   		}
> >   		break;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
