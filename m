From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 May 2012 12:05:18 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531085432.GK5377@arwen.pp.htv.fi>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
Message-ID: <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> What if a module needs two clocks and you drive the reset on both of the
> clocks ? What would happen ?
> 

Only 'leave clocks' have this reset method and a module can only have 1 of
them.

> > but then we would have the keep a list of IDs (1 per module) which the drivers
> > can use to call some tegra reset function which would in the end use registers
> > in the same memory area to cause a reset. (the registers controlling
> > modulereset are interleaved with those controlling the enable/disable of the
> > main moduleclock and bitpositions are identical)
> 
> Well, under a generic device-level API, you could just call an internal
> clk_reset() function because you know which clocks feed into which
> devices anyway. It could look something like:
> 
> on Tegra:
> 
> device_reset(dev)
> 	-> dev_pm_domain->reset()
> 		-> tegra_periph_reset()
> 

These methods are also needed internally by the powergating code.

> on OMAP:
> 
> device_reset(dev)
> 	-> dev_pm_domain->reset()
> 		-> omap_hwmod_reset()
> 
> 
> btw:
> 
> tegra_periph_reset(....)
> {
> 	tegra_periph_reset_assert(...);
> 	udelay(2);
> 	tegra_periph_reset_deassert(...);
> }

which uses the clockframework currently.

Cheers,

Peter.
