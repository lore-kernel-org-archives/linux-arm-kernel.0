From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 17 May 2013 14:05:50 -0700
Subject: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
In-Reply-To: <20130515015212.GB3268@animalcreek.com>
References: <20130515002537.GG5600@atomide.com>
 <20130515015212.GB3268@animalcreek.com>
Message-ID: <20130517210550.GH28484@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 06:52:12PM -0700, Mark A. Greer wrote:
> On Tue, May 14, 2013 at 05:25:37PM -0700, Tony Lindgren wrote:
> > Commit a819c4f1 (ARM: OMAP3: PM: Only access IVA if one exists)
> > changed PM to not access IVA registers on omaps that don't have
> > them. Turns out we still need to idle iva2 as otherwise iva2_pwrdm
> > will stay on and block deeper idle states.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Paul & Kevin, do you have better ideas for fixing this?
> > 
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -546,8 +546,10 @@ static void __init prcm_setup_regs(void)
> >  	/* Clear any pending PRCM interrupts */
> >  	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> >  
> > -	if (omap3_has_iva())
> > -		omap3_iva_idle();
> > +	/*
> > +	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
> > +	 */
> > +	omap3_iva_idle();
> >  
> >  	omap3_d2d_idle();
> >  }

> This is potentially bad for other SoC's that don't have an IVA so I don't
> think its the way to go.  My preference would be to set the OMAP3_HAS_IVA
> flag for the am3703 only since its the one with the bug.  Maybe something
> in id.c:omap3xxx_check_features() but I don't see any existing way to check
> for an am3703 vs. other am37xx SoCs.  Any ideas?

As I think about it more, I may have been overly dramatic here.

Before the check that's being removed existed, omap3_iva_idle() was always
called and nobody complained (including am3517).  So, I'd still like to hear
what Yegor can figure out but I have to believe that this patch is safe.

Mark
--
