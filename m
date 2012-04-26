From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 11:51:35 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org>
 <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
Message-ID: <20120426095135.GG17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 02:36:37AM -0700, Saravana Kannan wrote:
> 
> On Thu, April 26, 2012 1:42 am, Sascha Hauer wrote:
> > On Wed, Apr 25, 2012 at 11:28:32PM -0700, Saravana Kannan wrote:
> >>
> >> >diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> >> >index 6e58f11..8e97491 100644
> >> >--- a/drivers/clk/clk-mux.c
> >> >+++ b/drivers/clk/clk-mux.c
> >> >@@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev,
> >> const char *name,
> >> >  {
> >>
> >> I would really like to remove these functions. At least until we add
> >> device tree support where each clock is listed in device tree.
> >>
> >> At present, these functions seem to be abused more than actually
> >> being used appropriately.
> >
> > I think this goes in my direction. Still exactly this abuse how you call
> > it makes me relatively independent of for example the changes you
> > introduce with your patch. Had I static initializers I would now have
> > to start a rebase orgy.
> 
> In the other email you say you have to change. Here you say, you don't
> have to change. Hopefully, you didn't have to change much

I don't have to change much, still there are changes since I also use
clk_register. I will do the changes if we agree on your patch, but I
really hope this is the last of such changes.

> -- I was aiming for that.

Thank you for this.

> If there was agreement about removing these functions, I was
> planning on helping move the current users after this patch merged.

Please understand that I begin to get frustrated. I was really happy to
see the clock framework merged in the last window. Now it's -rc4 already
and there are still patches flowing that delay the merge of SoC support.

> 
> I think in the long run this will result in less changes for you and more
> readable code. If clk_register() adds another optional param, you can't
> get around that without having to write more wrapper functions or changing
> any existing ones you might have. But with this struct, the common clock
> code can be written in a way so that the a value of 0 for the new param
> defaults to the behavior that was there before the param was added.
> 
> Something to think about: With these wrapper calls, one would do a lot of
> kalloc and copying of small items when one knows at compile time what the
> clocks are going to be.

We do not know during compile what clocks will be since we do not know
at compile time which SoC we are going to run on. Statically allocated
clocks (which are going to be used directly instead of making copies)
may be fine for someone do a build for one SoC only, but I think our
goal is to build a multi SoC and eventually even a multi architecture
kernel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
