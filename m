From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 17 Feb 2012 13:09:19 +0200
Subject: [PATCH] arm: smp-twd: check for uninitialized clock in
 twd_cpufreq_init
In-Reply-To: <CAMQu2gzP1co6QhP-Co9wAwB_pVrjE0X_2GgGni4+t94yjHKi1g@mail.gmail.com>
References: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
 <CAMQu2gzP1co6QhP-Co9wAwB_pVrjE0X_2GgGni4+t94yjHKi1g@mail.gmail.com>
Message-ID: <1329476959.4102.434.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-17 at 16:17 +0530, Shilimkar, Santosh wrote:
> On Fri, Feb 17, 2012 at 4:04 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > Non-smp platforms don't have local timer support, but the twd_cpufreq_init
> > only checks for IS_ERR during init. Check against null also, to avoid
> > crashes during cpufreq transitions on non-smp platforms.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> I sent a patch for the same issue which Kevin reported.

Oh sorry for the noise then. I did a quick search for a similar patch
but didn't find one. This patch can be ignored.

-Tero

> 
> Thread.
> http://www.spinics.net/lists/arm-kernel/msg160275.html
> 
> >  arch/arm/kernel/smp_twd.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> > index 4285daa..dae8902 100644
> > --- a/arch/arm/kernel/smp_twd.c
> > +++ b/arch/arm/kernel/smp_twd.c
> > @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
> >
> >  static int twd_cpufreq_init(void)
> >  {
> > -       if (!IS_ERR(twd_clk))
> > +       if (twd_clk && !IS_ERR(twd_clk))
> 
> Checking the clock node is not enoough because you can
> not have clock node and rely on calibration..
> Testing twd_evt is safe to avoid the issue.
> 
> Regards
> santosh
