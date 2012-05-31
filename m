From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 May 2012 12:46:17 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531094301.GT8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
 <20120531085432.GK5377@arwen.pp.htv.fi>
 <20120531090518.GR8026@tbergstrom-lnx.Nvidia.com>
 <20120531092603.GM5377@arwen.pp.htv.fi>
 <20120531094301.GT8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120531094616.GP5377@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 12:43:01PM +0300, Peter De Schrijver wrote:
> > > > on Tegra:
> > > > 
> > > > device_reset(dev)
> > > > 	-> dev_pm_domain->reset()
> > > > 		-> tegra_periph_reset()
> > > > 
> > > 
> > > These methods are also needed internally by the powergating code.
> > 
> > so ? Just call them when you need...
> > 
> 
> the powergating code calls assert and deassert indepedently
> ie:
> 
> tegra_periph_reset_assert()
> 
> do stuff
> 
> tegra_periph_reset_assert()

I don't see the issue here. expose tegra_periph_reset() for the device
API only, internally you can do whatever you like. Call them
independently if you need.

> > > > on OMAP:
> > > > 
> > > > device_reset(dev)
> > > > 	-> dev_pm_domain->reset()
> > > > 		-> omap_hwmod_reset()
> > > > 
> > > > 
> > > > btw:
> > > > 
> > > > tegra_periph_reset(....)
> > > > {
> > > > 	tegra_periph_reset_assert(...);
> > > > 	udelay(2);
> > > > 	tegra_periph_reset_deassert(...);
> > > > }
> > > 
> > > which uses the clockframework currently.
> > 
> > no problems there. The point is that you already know which clock feed
> > into which device, so if you have a device-based API for device
> > soft-reset, you can figure out which exact clock to toggle, right ?
> 
> you have the struct clk, you could dive into that and grab clk_hw and call
> some function directly. But sounds quite horrible to me.

Well, that's just because struct device doesn't know about its own clock
providers, right ? Should that be patched too ?

Russell, as the orignal author of the clk API, what do you think ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/f2e30a7e/attachment.sig>
