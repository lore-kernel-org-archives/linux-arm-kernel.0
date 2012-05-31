From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 May 2012 11:54:33 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
 <20120531081841.GG5377@arwen.pp.htv.fi>
 <20120531083131.GQ8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120531085432.GK5377@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 31, 2012 at 11:31:31AM +0300, Peter De Schrijver wrote:
> On Thu, May 31, 2012 at 10:18:42AM +0200, Felipe Balbi wrote:
> > * PGP Signed by an unknown key
> > 
> > On Thu, May 31, 2012 at 10:51:25AM +0300, Peter De Schrijver wrote:
> > > On Wed, May 30, 2012 at 10:52:31AM +0200, Stephen Boyd wrote:
> > > > On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> > > > > Add an extension API for clocks. This allows clocktypes to provide extensions
> > > > > for features which are uncommon and cannot be easily mapped onto normal clock
> > > > > framework concecpts. eg: resetting blocks, configuring clock phase etc.
> > > > 
> > > > This seems rather generic. Why not add more specific APIs/concepts like
> > > > clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
> > > > make them map.
> > > > 
> > > 
> > > Some of those might be very SoC specific. Eg OMAP doesn't need software
> > > controlled modulereset. I don't think we should add a new function to the
> > 
> > it depends on what you call modulereset. We have soft-reset logic hidden
> > under the hood, it's done before device creation, so drivers (most of
> > them) assume we're probe with the IP in reset state.
> > 
> > What I wonder most is if this should be done at the clock level or at
> > the device level. In the end you reset the IP block, not the clock,
> > right ?
> 
> Yes. but, every block has at least 1 clock and thus the mapping is identical
> down to the register level. Ie. we could do this outside the clockframework,

What if a module needs two clocks and you drive the reset on both of the
clocks ? What would happen ?

> but then we would have the keep a list of IDs (1 per module) which the drivers
> can use to call some tegra reset function which would in the end use registers
> in the same memory area to cause a reset. (the registers controlling
> modulereset are interleaved with those controlling the enable/disable of the
> main moduleclock and bitpositions are identical)

Well, under a generic device-level API, you could just call an internal
clk_reset() function because you know which clocks feed into which
devices anyway. It could look something like:

on Tegra:

device_reset(dev)
	-> dev_pm_domain->reset()
		-> tegra_periph_reset()

on OMAP:

device_reset(dev)
	-> dev_pm_domain->reset()
		-> omap_hwmod_reset()


btw:

tegra_periph_reset(....)
{
	tegra_periph_reset_assert(...);
	udelay(2);
	tegra_periph_reset_deassert(...);
}

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/cc589cf2/attachment.sig>
