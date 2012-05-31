From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 May 2012 11:18:42 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120531075125.GL8026@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120531081841.GG5377@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 10:51:25AM +0300, Peter De Schrijver wrote:
> On Wed, May 30, 2012 at 10:52:31AM +0200, Stephen Boyd wrote:
> > On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> > > Add an extension API for clocks. This allows clocktypes to provide extensions
> > > for features which are uncommon and cannot be easily mapped onto normal clock
> > > framework concecpts. eg: resetting blocks, configuring clock phase etc.
> > 
> > This seems rather generic. Why not add more specific APIs/concepts like
> > clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
> > make them map.
> > 
> 
> Some of those might be very SoC specific. Eg OMAP doesn't need software
> controlled modulereset. I don't think we should add a new function to the

it depends on what you call modulereset. We have soft-reset logic hidden
under the hood, it's done before device creation, so drivers (most of
them) assume we're probe with the IP in reset state.

What I wonder most is if this should be done at the clock level or at
the device level. In the end you reset the IP block, not the clock,
right ?

> clock framework for clock related features which only exist in a single
> SoC or family. Ideally we could use inheritance to add methods to derived
> clocktypes, but that's not really possible in C unfortunately.

Well, it can be done... in a weird manner, but it can:

struct my_new_clk {
	struct clk	clk;

	int		(*reset)(struct my_new_clk *m);
};

int clk_reset(struct clk *clk)
{
	strut my_new_clk	*m = container_of(clk, struct my_new_clk, clk);

	return m->reset(m);
}

it doesn't look pretty, but it can be done.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/1acbf2af/attachment.sig>
