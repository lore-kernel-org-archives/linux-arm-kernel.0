From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Feb 2012 09:38:56 -0600
Subject: [PATCHv5 02/14] arm: omap: voltage: renamed vp_vddmin and
 vp_vddmax fields
In-Reply-To: <1329838370.4102.479.camel@sokoban>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
 <1329833098-19900-3-git-send-email-t-kristo@ti.com>
 <CAOMWX4cviUjAJ2eCB5LjUBmOpEWU5HP9-miPtZY1TwBGYyOPdA@mail.gmail.com>
 <20120221145322.GD22675@n2100.arm.linux.org.uk>
 <1329838370.4102.479.camel@sokoban>
Message-ID: <20120221153854.GA2411@kobold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:32-20120221, Tero Kristo wrote:
> On Tue, 2012-02-21 at 14:53 +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 21, 2012 at 08:40:22AM -0600, Menon, Nishanth wrote:
> > > On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
> > > > These are now called vddmin and vddmax, as these fields will be used
> > > > globally for selecting voltage ranges for a pmic channel, and not
> > > > only for voltage processor.
> > > 
> > > NAK. I think we need to setup voltage for SoC limits as well. the
> > > programmed voltage to the VP register should be:
> > > VP->vlimito->min = MAX(soc->vdd_min, pmic->vdd_min)
> > > VP->vlimito->max = MIN(soc->vdd_max, pmic->vdd_max)
> > > 
> 
> This kind of code is actually introduced in patch #7 of this set. VP
> part of the code calculates the voltage processor vlimitto values in
> omap_vp_init. VC limits are handled in omap_vc_init_channel /
> omap_vc_calc_vsel.

Apologies , you are right #7 does indeed take this into consideration
probably belongs to #7, but, we also need to ensure that vp forceupdate
and vc_bypass actually keep to the requirement as well.

> 
> > > else you could be running the SoC beyond design voltage potentially
> > > damaging the device.
> > 
> > And if you're doing that kind of thing, you must also check that
> > the resulting min and max are sane.  In other words, the minimum is
> > less than the maximum.
> > 
> > Sure, it's something that should never happen (because it would be a
> > design error) but if it did happen...
> 
> This could be added yes, current code assumes the limits themselves are
> at least somewhat sane, doesn't hurt to add a kern dump for this case I
> think as it sounds rather fatal.
I agree - it is indeed the case.

-- 
Regards,
Nishanth Menon
