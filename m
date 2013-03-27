From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Mar 2013 18:45:48 -0700
Subject: [PATCH] arm:exynos5250: Restore CLK_SRC_TOP3 register via CCF
In-Reply-To: <2280810.4mfMsDOM0e@amdc1227>
References: <1364272935-30607-1-git-send-email-prasanna.ps@samsung.com>
 <2280810.4mfMsDOM0e@amdc1227>
Message-ID: <20130327014548.4014.47225@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-03-26 04:28:13)
> Hi Prasanna,
> 
> On Tuesday 26 of March 2013 10:12:15 Prasanna Kumar wrote:
> > From: Prasanna Kumar <prasanna.ps@samsung.com>
> > 
> > This patch adds support for restoring CLK_SRC_TOP3 register
> > which gets modified while powergating corresponding power domains
> > after a cycle of Suspend-to-Resume.
> > 
> > Please refer below URL to know the background of this issue.
> > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14347.html.
> > 
> > This is based on Common Clock Framework defined for exynos5250 and
> > patch mentioned here
> > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg16739.html
> > 
> > Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> > ---
> >  arch/arm/mach-exynos/pm_domains.c |   43
> > +++++++++++++++++++++++++++++++++++++ 1 files changed, 43 insertions(+), 0
> > deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/pm_domains.c
> > b/arch/arm/mach-exynos/pm_domains.c index 9f1351d..b5ed384 100644
> > --- a/arch/arm/mach-exynos/pm_domains.c
> > +++ b/arch/arm/mach-exynos/pm_domains.c
> 
> First of all, why this is happening in power domain driver? It does not (and 
> should not) know anything about clocks. I'm sure you can find a better place 
> for this.
> 
> > @@ -21,8 +21,11 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/sched.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-private.h>
> 
> This header is _not_ supposed included outside clock core and clock drivers.
> 

Yeah, big NACK on usage of clk-private.h.

Regards,
Mike

> > 
> >  #include <mach/regs-pmu.h>
> > +#include <plat/cpu.h>
> >  #include <plat/devs.h>
> > 
> >  /*
> > @@ -35,6 +38,43 @@ struct exynos_pm_domain {
> >       struct generic_pm_domain pd;
> >  };
> > +static int exynos_pdclk_restore(struct exynos_pm_domain *domain)
> > +{
> > +     int i = 0;
> > +     struct clk *p_clk;
> > +     struct clk_hw *hw_clk;
> > +     const struct clk_ops *p_ops;
> > +
> > +     const char *pdclks[][2] = {
> > +                                     { "gsc-power-domain",
> > +                                             "m_sub_aclk266" },
> > +                                     { "gsc-power-domain",
> > +                                             "m_sub_aclk300" },
> > +                                     { "mfc-power-domain",
> > +                                             "m_sub_aclk333" },
> > +                             };
> > +
> > +     for (i = 0; i < ARRAY_SIZE(pdclks); i++) {
> > +             if (!strcmp(domain->name, pdclks[i][0])) {
> > +                     p_clk = clk_get(NULL, pdclks[i][1]);
> > +                     if (IS_ERR(p_clk)) {
> > +                             pr_err("failed to get base clk\n");
> > +                             return PTR_ERR(p_clk);
> > +                     }
> > +
> > +                     hw_clk = __clk_get_hw(p_clk);
> > +                     if (IS_ERR(hw_clk)) {
> > +                             pr_err("failed to get hw_clk\n");
> > +                             return PTR_ERR(hw_clk);
> > +                     }
> 
> This is completely wrong: hw_clk is an internal structure that should be used 
> only inside the driver of this particular clock and clock core, nowhere else.
> 
> > +                     p_ops = p_clk->ops;
> > +                     if (p_ops != NULL && p_ops->set_parent != NULL)
> > +                             p_clk->ops->set_parent(hw_clk, 1);
> 
> Same goes here: p_clk is an opaque pointer to something that can _not_ be 
> dereferenced outside clock core.
> 
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> 
> NAK.
> 
> This code contains so many Linux kernel development antipatterns, that it's 
> missing only IS_ERR_OR_NULL to be placed on top of hall of fame of such, if 
> one exists.
> 
> >  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
> > {
> >       struct exynos_pm_domain *pd;
> > @@ -61,6 +101,9 @@ static int exynos_pd_power(struct generic_pm_domain
> > *domain, bool power_on) cpu_relax();
> >               usleep_range(80, 100);
> >       }
> > +
> > +     if (!power_on && soc_is_exynos5250())
> > +             exynos_pdclk_restore(pd);
> >       return 0;
> >  }
> 
> Best regards,
> -- 
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Kernel and System Framework
