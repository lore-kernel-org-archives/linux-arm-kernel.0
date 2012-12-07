From: prasannapadubidri@gmail.com (Prasanna Kumar)
Date: Fri, 7 Dec 2012 18:19:00 +0530
Subject: [PATCH 3/3] ARM: EXYNOS5: save CLK_TOP_SRC3 register before
 powergating
In-Reply-To: <CAJuYYwQ7W-1DKbECW1LASVEwXdcZhs09ksx0ppsaphA=YkWeeQ@mail.gmail.com>
References: <1354018957-17752-1-git-send-email-prasanna.ps@samsung.com>
 <1354018957-17752-4-git-send-email-prasanna.ps@samsung.com>
 <CAJuYYwQ7W-1DKbECW1LASVEwXdcZhs09ksx0ppsaphA=YkWeeQ@mail.gmail.com>
Message-ID: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks for the comments.Please find my reply inline.

On Tue, Dec 4, 2012 at 2:29 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
>
> On 27 November 2012 17:52, Prasanna Kumar <prasanna.ps@samsung.com> wrote:
> > From: Prasanna Kumar <prasanna.ps@samsung.com>
> >
> > This patch adds a software workaround to the hardware
> > problem found in exynos5 while powergating.
> >
> > It is observed that CLK_TOP_SRC3 register gets modified if
> > the G-Scaler/MFC devices are power gated. The clock for G-Scaler gets
> > set to XXTI which results in the device running very slow .
> > A big drop in performance is noticed whilerunning the video.
> > This issue also occurs while powergating MFC.
> >
> > The value of clock source register is restored once the powergating
> > operation is completed.
> >
> > Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> > ---
> >  arch/arm/mach-exynos/pm_domains.c |   27 +++++++++++++++++++++++++++
> >  1 files changed, 27 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/pm_domains.c
> > b/arch/arm/mach-exynos/pm_domains.c
> > index 9f1351d..955cbe3 100644
> > --- a/arch/arm/mach-exynos/pm_domains.c
> > +++ b/arch/arm/mach-exynos/pm_domains.c
> > @@ -48,6 +51,23 @@ static int exynos_pd_power(struct generic_pm_domain
> > *domain, bool power_on)
> >         pwr = power_on ? S5P_INT_LOCAL_PWR_EN : 0;
> >         __raw_writel(pwr, base);
> >
> > +       /*
> > +        *It is found that the CLK SRC register in exynos5
> > +        *gets modified when power domain of gsc/mfc/isp/disp1
> > +        *is powered off.This happens only after the system is
> > +        *suspended and resumed and not before that.
> > +        *The following fix adresses this hardware issue.
> > +        *It saves the value of clock source register and
> > +        *resores it later
> > +        */
> > +
> > +       if (soc_is_exynos5250()) {
> > +               if (!power_on) {
> > +                       /* save clock source register */
> > +                       tmp = __raw_readl(EXYNOS5_CLKSRC_TOP3);
> > +               }
> > +       }
>
> Does the value of EXYNOS5_CLKSRC_TOP3 register change as soon as the
> G-Scaler/MFC devices are power gated?
>
> - If yes, the value of CLKSRC register should be saved before the
> power domain register is programmed.
>
> - If not, as mentioned in the comment, if this issue occurs during a
> suspend-resume cycle, the value of this register can be saved and
> restored in the clock driver code itself.
>
During a normal power gating sequence, this problem is not seen
But Once the suspend-resume cycle is done,  if we try to turn on or
turn off domain,
this issue occurs.

I agree that CLKSRC register should be saved
before the power domain register is programmed.

Saving of CLKSRC_TOP3 register is already being done in clock driver
code.i.e in exynos5_clock_save[]. But the problem remains. So i feel
an exclusive saving of the register in pm_domain driver is required.

Kindly let me know your opinion

> The other thing that needs to be relooked into here is the use of
> EXYNOS5_CLKSRC_TOP3 register address. Currently, the clock registers
> are statically io-remapped. With the upcoming migration to common
> clock for Exynos5, the clock registers will not be statically
> io-remapped but instead remapped during clock initialization. So the
> use of EXYNOS5_CLKSRC_TOP3 will not hold and so we need to relook into
> this.

Yes , we can look into this, once the clock migration happens for Exynos5
Until then, can it be used as statically io-remapped ?


> > @@ -61,6 +81,13 @@ static int exynos_pd_power(struct generic_pm_domain
> > *domain, bool power_on)
> >                 cpu_relax();
> >                 usleep_range(80, 100);
> >         }
> > +
> > +       if (soc_is_exynos5250()) {
>
> We could use the of_machine_is_compatible api here instead of
> soc_is_exynos5250() macro.
>

Yes, of_machine_is_compatible function will be used
instead of soc_is_exynos5250()


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel




--
Thanks
Prasanna Kumar
