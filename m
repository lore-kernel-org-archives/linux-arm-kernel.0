From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Aug 2011 08:33:02 +0900
Subject: [PATCH 3/5] ARM: EXYNOS4: Add support PM for EXYNOS4212
In-Reply-To: <CAJ0PZbT1YsiXT9k1FJfOCoU8h_XAYqAX6ECJ_=Q0RjR-D_9yyA@mail.gmail.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
	<1314192352-14911-4-git-send-email-kgene.kim@samsung.com>
	<CAJ0PZbT1YsiXT9k1FJfOCoU8h_XAYqAX6ECJ_=Q0RjR-D_9yyA@mail.gmail.com>
Message-ID: <072b01cc637f$558a1190$009e34b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> On Wed, Aug 24, 2011 at 10:25 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > From: Jonghwan Choi <jhbird.choi@samsung.com>
> >
> > This patch moves regarding clock stuff of PM into clock
> > file to support PM on EXYNOS4210 and EXYNOS4212 with one
> > single kernel image. Because some clock registers are
> > different on each SoCs.
> >
> > Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/mach-exynos4/clock-exynos4210.c ? ? ? ?| ? 38 ++++++++++
> > ?arch/arm/mach-exynos4/clock-exynos4212.c ? ? ? ?| ? 34 +++++++++
> > ?arch/arm/mach-exynos4/clock.c ? ? ? ? ? ? ? ? ? | ? 89
> +++++++++++++++++++++++
> > ?arch/arm/mach-exynos4/include/mach/regs-clock.h | ? ?4 +
> > ?arch/arm/mach-exynos4/pm.c ? ? ? ? ? ? ? ? ? ? ?| ? 79
++------------------
> > ?5 files changed, 172 insertions(+), 72 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/clock-exynos4210.c b/arch/arm/mach-
> exynos4/clock-exynos4210.c
> > index fe74b91..a4b00b7 100644
> > --- a/arch/arm/mach-exynos4/clock-exynos4210.c
> > +++ b/arch/arm/mach-exynos4/clock-exynos4210.c
> > +static struct sleep_save exynos4210_clock_save[] = {
> > + ? ? ? SAVE_ITEM(S5P_CLKSRC_IMAGE),
> > + ? ? ? SAVE_ITEM(S5P_CLKSRC_LCD1),
> > + ? ? ? SAVE_ITEM(S5P_CLKDIV_IMAGE),
> > + ? ? ? SAVE_ITEM(S5P_CLKDIV_LCD1),
> > + ? ? ? SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
> > + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4210),
> > + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
> > + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4210),
> > +};
> > +
> > --- a/arch/arm/mach-exynos4/clock-exynos4212.c
> > +++ b/arch/arm/mach-exynos4/clock-exynos4212.c
> > +static struct sleep_save exynos4212_clock_save[] = {
> > + ? ? ? SAVE_ITEM(S5P_CLKSRC_IMAGE),
> > + ? ? ? SAVE_ITEM(S5P_CLKDIV_IMAGE),
> > + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4212),
> > + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4212),
> > +};
> > +
> > --- a/arch/arm/mach-exynos4/clock.c
> > +++ b/arch/arm/mach-exynos4/clock.c
> > +static struct sleep_save exynos4_clock_save[] = {
> 
> Hello,
> 
Hi,

> Is there any reason to have the following two
> SAVE_ITEM(S5P_CLKSRC_IMAGE),
> SAVE_ITEM(S5P_CLKDIV_IMAGE
> defined at both clock-exynos4210.c and clock-exynos4212.c, not defined
> at clock.c once?
> 
Yes, I know. I just wanted to keep in mind there is a different
value(CLKGATE_IP_IMAGE) in regarding IMAGE clocks on each SoCs, and I think
need it now. Anyway thanks for your pointing out.

> Also, consider using CONFIG_PM_SLEEP rather than CONFIG_PM for
> suspend/resume ops.
> 
(Cc'ed Rafael)

Well, even though CONFIG_PM_SLEEP is used in regarding syscore_ops, in this
case, using CONFIG_PM looks better.

If ARCH_SUSPEND_POSSIBLE will be selected, then CONFIG_SUSPEND is selected
and CONFIG_PM_SLEEP is selected in kernel/power/Kconfig and of course,
ARCH_SUSPEND_POSSIBLE is selected in arch/arm/Kconfig. However above
everything depends on CONFIG_PM. So I think to use CONFIG_PM is more
reasonable. In addition, it is more popular in other mainline codes now.

Hi Rafael,
How do you think about this?

Its original code is below.
---
#ifdef CONFIG_PM
static int exynos4210_clock_suspend(void)
{
        s3c_pm_do_save(exynos4210_clock_save,
ARRAY_SIZE(exynos4210_clock_save));

        return 0;
}

static void exynos4210_clock_resume(void)
{
        s3c_pm_do_restore_core(exynos4210_clock_save,
ARRAY_SIZE(exynos4210_clock_save));
}

#else
#define exynos4210_clock_suspend NULL
#define exynos4210_clock_resume NULL
#endif

struct syscore_ops exynos4210_clock_syscore_ops = {
        .suspend        = exynos4210_clock_suspend,
        .resume         = exynos4210_clock_resume,
};
---

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
