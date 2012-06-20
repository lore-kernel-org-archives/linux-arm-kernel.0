From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 07:14:38 -0700
Subject: [PATCHv8 06/13] I2C: OMAP: Correct I2C revision for OMAP3
In-Reply-To: <4FE1C9AC.3020104@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-7-git-send-email-shubhrajyoti@ti.com>
 <20120620103235.GD12766@atomide.com> <4FE1C9AC.3020104@ti.com>
Message-ID: <20120620141437.GN12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shubhrajyoti <shubhrajyoti@ti.com> [120620 06:06]:
> On Wednesday 20 June 2012 04:02 PM, Tony Lindgren wrote:
> > * Shubhrajyoti D <shubhrajyoti@ti.com> [120618 07:35]:
> >> From: Jon Hunter <jon-hunter@ti.com>
> >>
> >> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> >> revision is the same for 3430 and 3530. However, the OMAP3630 device has the
> >> same I2C revision as OMAP4. Correct the revision definition to reflect this.
> >>
> >> This patch is based on work done by Jon Hunter <jon-hunter@ti.com>
> >> Changes from his patch
> >> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
> > ...
> >>  /* timeout waiting for the controller to respond */
> >>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> >> @@ -298,7 +298,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
> >>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> >>  					   SYSC_AUTOIDLE_MASK);
> >>  
> >> -		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
> >> +		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
> >>  			dev->syscstate = SYSC_AUTOIDLE_MASK;
> >>  			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
> >>  			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
> > Having to patch all over the place for these revision defines leads
> > into unmaintainable code as new SoCs get added.
> >
> > Please instead just check the revision once during init, then set
> > up some feature bits like I2C_OMAP_NEEDS_XYZ_RESET that the runtime
> > code can check.
> Even now at probe
> 
> dev->rev is set by reading the rev register.
> 
> The (macro)name used to identify is only changed.
> 
> Also all the ips need reset the difference is that 2430 has less bits eg only autoidle and reset.
> So a flag needs reset may not be meaningful.
 
Hmm OK so this is a cosmetic/readability fix..

..but your earlier patch now spreads the checking of revision
to the new non-init function omap_i2c_reset.

Why don't you just do this cosmetic/readability rename fix
before your 03/13 patch? Then set the already existing
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE during init for some
revisions and use that instead of the rev check in
omap_i2c_reset?

Tony
 
