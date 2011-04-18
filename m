From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Apr 2011 19:34:21 +0100
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <4DAC7AE9.9030106@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
	<20110418131527.GF31131@pengutronix.de>
	<20110418133353.GL14770@pengutronix.de>
	<4DAC7AE9.9030106@codeaurora.org>
Message-ID: <20110418183421.GD25671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 10:54:49AM -0700, Stephen Boyd wrote:
> On 04/18/2011 06:33 AM, Sascha Hauer wrote:
> >>>  
> >>> +/**
> >>> + * clock multiplexer
> >>> + *
> >>> + * @clk		clock source
> >>> + * @reg		the register this multiplexer can be configured with
> >>> + * @shift	the shift to the start bit of this multiplexer
> >>> + * @width	the width in bits of this multiplexer
> >>> + * @num_clks	number of parent clocks
> >>> + * @lock	register lock
> >>> + * @clks	array of possible parents for this multiplexer. Can contain
> >>> + *		holes with NULL in it for invalid register settings
> >> NULL is a valid clk, isn't it?
> > You're right. I think for invalid mux settings we should ERR_PTR(-EINVAL)
> > or similar to the array.
> 
> Note that if you're using clkdev you can't actually return a NULL clock
> to the caller of clk_get() due to:
> 
> struct clk *clk_get_sys(const char *dev_id, const char *con_id)
> {
>         struct clk *clk;
> 
>         mutex_lock(&clocks_mutex);
>         clk = clk_find(dev_id, con_id);
>         if (clk && !__clk_get(clk))
>                 clk = NULL;
>         mutex_unlock(&clocks_mutex);
> 
>         return clk ? clk : ERR_PTR(-ENOENT);
> }
> 
> 
> So all this talk about NULL being a valid clock returned to drivers is
> kinda pointless unless the mach has a custom clk_get() implementation.

Oops, clk_get_sys() and clk_find() really should be fixed for this.  I'll
sort a patch for it.
