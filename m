From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 21 Nov 2011 14:44:52 +0200
Subject: [PATCH 03/10] arm/tegra: prepare clock code for multiple tegra
 variants
In-Reply-To: <20111118190649.GB31678@quad.lixom.net>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-4-git-send-email-pdeschrijver@nvidia.com>
 <20111118190649.GB31678@quad.lixom.net>
Message-ID: <20111121124452.GM19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 08:06:49PM +0100, Olof Johansson wrote:
> Hi,
> 
> A nit and two comments below.
> 
> On Thu, Nov 17, 2011 at 06:19:17PM +0200, Peter De Schrijver wrote:
> > Rework the tegra20 clock code to support multiple tegra variants :
> > 
> >  * remove tegra2_periph_reset_assert/tegra2_periph_reset_deassert. This
> >    functionality should be in clock.c.
> >  * compile tegra_sdmmc_tap_delay only on tegra20 as this feature will not
> >    be available in future variants.
> >  * don't export clk_measure_input_freq as its functionality is also available
> >    using clk_get_rate().
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/clock.c         |   14 +++++++++-----
> >  arch/arm/mach-tegra/clock.h         |    3 ---
> >  arch/arm/mach-tegra/tegra2_clocks.c |   14 +-------------
> >  arch/arm/mach-tegra/timer.c         |   12 ++++++++----
> >  4 files changed, 18 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
> > index f8d41ff..47f6366 100644
> > --- a/arch/arm/mach-tegra/clock.c
> > +++ b/arch/arm/mach-tegra/clock.c
> > @@ -387,13 +387,15 @@ EXPORT_SYMBOL(tegra_clk_init_from_table);
> >  
> >  void tegra_periph_reset_deassert(struct clk *c)
> >  {
> > -	tegra2_periph_reset_deassert(c);
> > +	BUG_ON(!c->ops->reset);
> > +	c->ops->reset(c, false);
> >  }
> >  EXPORT_SYMBOL(tegra_periph_reset_deassert);
> >  
> >  void tegra_periph_reset_assert(struct clk *c)
> >  {
> > -	tegra2_periph_reset_assert(c);
> > +	BUG_ON(!c->ops->reset);
> > +	c->ops->reset(c, true);
> >  }
> >  EXPORT_SYMBOL(tegra_periph_reset_assert);
> >  
> > @@ -403,10 +405,11 @@ void __init tegra_init_clock(void)
> >  }
> >  
> >  /*
> > - * The SDMMC controllers have extra bits in the clock source register that
> > - * adjust the delay between the clock and data to compenstate for delays
> > - * on the PCB.
> > + * The SDMMC controllers on tegra20 have extra bits in the clock source
> > + * register that adjust the delay between the clock and data to compenstate
> > + * for delays on the PCB.
> >   */
> > +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> >  void tegra_sdmmc_tap_delay(struct clk *c, int delay)
> >  {
> >  	unsigned long flags;
> > @@ -415,6 +418,7 @@ void tegra_sdmmc_tap_delay(struct clk *c, int delay)
> >  	tegra2_sdmmc_tap_delay(c, delay);
> >  	spin_unlock_irqrestore(&c->spinlock, flags);
> >  }
> > +#endif
> 
> Ifdeffing this out doesn't quite make sense. Better to do a #ifdef in the
> include file with an #else case that fills in an empty function. This
> needs to be abstracted differently for the two platforms anyway but
> that can be done separately from this. Does tegra3 have tap delay setup
> as well? (I don't have the TRM handy right now).
> 

I couldn't find it in the tegra30 TRM.

Cheers,

Peter.
