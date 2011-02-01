From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 1 Feb 2011 10:54:58 +0530
Subject: [PATCH 4/6] omap4: dpll: Enable all DPLL autoidle at boot
In-Reply-To: <alpine.DEB.2.00.1101311614570.16671@utopia.booyaka.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-5-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101311614570.16671@utopia.booyaka.com>
Message-ID: <f8e27368d1e145b19c1d5c6e607a0043@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, February 01, 2011 4:47 AM
> To: rnayak at ti.com; Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; b-cousson at ti.com;
linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 4/6] omap4: dpll: Enable all DPLL autoidle at boot
>
> Hi guys
>
> On Fri, 28 Jan 2011, Santosh Shilimkar wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Enable all DPLL autoidle at boot on OMAP4.
>
> Is there some reason why we can't do this in the OMAP4 PM code?  At some
> point, I think it would be good to essentially disable all PM at boot,
and
> then let the PM code specifically enable autoidle later in the boot
> process, etc.  The idea being that !CONFIG_PM would result in a chip
> programmed for lowest latency, etc.

I guess it makes sense to do this late in boot and only if CONFIG_PM
is enabled. Will make the necessary changes and repost.

Regards,
Rajendra

>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock44xx_data.c
b/arch/arm/mach-omap2/clock44xx_data.c
> > index e8cb32f..e5c59a0 100644
> > --- a/arch/arm/mach-omap2/clock44xx_data.c
> > +++ b/arch/arm/mach-omap2/clock44xx_data.c
> > @@ -3300,6 +3300,8 @@ int __init omap4xxx_clk_init(void)
> >  			clkdev_add(&c->lk);
> >  			clk_register(c->lk.clk);
> >  			omap2_init_clk_clkdm(c->lk.clk);
> > +			if (c->lk.clk->dpll_data)
> > +				omap3_dpll_allow_idle(c->lk.clk);
> >  		}
> >
> >  	recalculate_root_clocks();
> > --
> > 1.6.0.4
> >
>
>
> - Paul
