From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jul 2011 15:40:55 -0600 (MDT)
Subject: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address
	with offset macros
In-Reply-To: <20110707182758.GA32199@google.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
	<1309554558-19819-4-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com>
	<20110707182758.GA32199@google.com>
Message-ID: <alpine.DEB.2.00.1107071537120.2647@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Todd,

On Thu, 7 Jul 2011, Todd Poynor wrote:

> On Thu, Jul 07, 2011 at 02:25:23AM -0600, Paul Walmsley wrote:
> 
> > -int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
> > +int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
> >  {
> >  	int i = 0;
> >  
> > -	if (!clkctrl_reg)
> > +	if (!clkctrl_offs)
> >  		return 0;
> >  
> >  	omap_test_timeout((
> > -		((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) == 0) ||
> > -		 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
> > -		  OMAP4430_IDLEST_SHIFT) == 0x2)),
> > +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0 ||
> > +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x2),
> >  		MAX_MODULE_READY_TIME, i);
> 
> Suggest adding symbols for the constant IDLEST values, next to the 0x3
> value added for "[PATCH v2 04/13] OMAP: hwmod: Wait the idle status to
> be disabled".

Done.

> Would be nice to call _clkctrl_idlest() once.

Agreed.  That's now implemented by creating a new static function, 
_is_module_ready(), that only does one read.

> Similar vague questioning of the API names as for the above-mentioned
> patch: this waits for the module slave to be ready, don't know if
> anything similar is needed for module masters or if it's important to
> keep this distinction.

I think I know the answer to this one, but would rather not speculate 
without some hardware investigation.  Let's review this issue when Beno?t 
returns.


Thanks for the comments, they are much appreciated.


- Paul
