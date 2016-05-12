From: plaes@plaes.org (Priit Laes)
Date: Thu, 12 May 2016 06:39:20 +0300
Subject: [linux-sunxi] Re: [PATCH v4 01/11] clk: sunxi: Add display and
 TCON0 clocks driver
In-Reply-To: <20160511221541.GG3492@codeaurora.org>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160506223002.GE3492@codeaurora.org> <20160508200308.GF6167@lukather>
 <20160509223238.GW3492@codeaurora.org>
 <20160509223924.GX3492@codeaurora.org> <1462907459.9981.0.camel@plaes.org>
 <20160511221541.GG3492@codeaurora.org>
Message-ID: <1463024360.16747.4.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-05-11 at 15:15 -0700, Stephen Boyd wrote:
> On 05/10, Priit Laes wrote:
> > 
> > On Mon, 2016-05-09 at 15:39 -0700, Stephen Boyd wrote:
> > > 
> > > On 05/09, Stephen Boyd wrote:
> > > > 
> > > > 
> > > > 
> > > > Ok I applied this one to clk-next.
> > > > 
> > > And I squashed this in to silence the following checker warning.
> > > 
> > > drivers/clk/sunxi/clk-sun4i-display.c:110:33: warning: Variable
> > > length array is used.
> > > 
> > > ---8<---
> > > diff --git a/drivers/clk/sunxi/clk-sun4i-display.c
> > > b/drivers/clk/sunxi/clk-sun4i-display.c
> > > index f02e250e64ed..f8ff6c4a5633 100644
> > > --- a/drivers/clk/sunxi/clk-sun4i-display.c
> > > +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> > > @@ -107,7 +107,7 @@ static int
> > > sun4i_a10_display_reset_xlate(struct
> > > reset_controller_dev *rcdev,
> > > ?static void __init sun4i_a10_display_init(struct device_node
> > > *node,
> > > ?					??const struct
> > > sun4i_a10_display_clk_data *data)
> > > ?{
> > > -	const char *parents[data->parents];
> > > +	const char *parents[4];
> > This change breaks at least de_[bf]e clocks which have 3 clock
> > parents.

> I just used the largest data->parents number, which was 4. How
> does that break anything?

If you look at the?sun4i_a10_display_init, it contains this block:

? ? ret = of_clk_parent_fill(node, parents, ARRAY_SIZE(parents));
????if (ret != ARRAY_SIZE(parents)) {
????????pr_err("%s: Could not retrieve the parents\n", clk_name);
????????goto unmap;
????}

of_clk_parent_fill returns 3 for de_be/de_fe nodes, and
ARRAY_SIZE(parents) is 4.

P?ikest,
Priit :)
