From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jan 2012 11:17:34 +0800
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
 <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
Message-ID: <20120119031726.GA2247@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Aisheng into the thread ...

On Thu, Jan 19, 2012 at 12:18:53AM -0200, Fabio Estevam wrote:
> On Wed, Jan 18, 2012 at 5:44 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> 
> > Now you are doing clk_enable()'s business in clk_set_rate().
> > The same result could be achieved by calling clk_enable() prior to
> > clk_set_rate(). clk_set_rate() could simply return an error code, if
> > the clock is not enabled.
> 
> Ok, understood.
> 
> Your suggestion below works fine:
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..c697b4a 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -809,6 +809,8 @@ int __init mx28_clocks_init(void)
>  	clk_prepare_enable(&xbus_clk);
>  	clk_prepare_enable(&emi_clk);
>  	clk_prepare_enable(&uart_clk);
> +	clk_prepare_enable(&saif0_clk);
> +	clk_prepare_enable(&saif1_clk);
> 
>From power saving point of view, I'm not sure you want to keep saif
clock on all the time.  So if the clock is off when you try to call
clk_set_rate(), you may want to turn it back to off after clk_set_rate()
is done.

>  	clk_set_parent(&lcdif_clk, &ref_pix_clk);
>  	clk_set_parent(&saif0_clk, &pll0_clk);
> 
> Or also the patch below instead:
> 
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -814,15 +814,6 @@ int __init mx28_clocks_init(void)
>         clk_set_parent(&saif0_clk, &pll0_clk);
>         clk_set_parent(&saif1_clk, &pll0_clk);
> 
> -       /*
> -        * Set an initial clock rate for the saif internal logic to work
> -        * properly. This is important when working in EXTMASTER mode that
> -        * uses the other saif's BITCLK&LRCLK but it still needs a basic
> -        * clock which should be fast enough for the internal logic.
> -        */
> -       clk_set_rate(&saif0_clk, 24000000);
> -       clk_set_rate(&saif1_clk, 24000000);
> -
>         clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> ---
> 
> Shawn,
> 
> I saw your comments about the need for clk_set_rate, so it looks like
> it is not safe to remove it.
> 
That piece of code was added by Aisheng for saif recording support.

> Can Lothar's suggestion be accepted?
> 
I agree with Lothar's suggestion.  The first thing for me to do may be
picking up Wolfram's patch below, which was posted some time ago, so
that we can have clk_set_rate() returns error when the clock is gated.

[PATCH] arm: mx28: check for gated clocks when setting saif divider
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/064712.html

> In your previous reply you seemed to prefer a solution at mxs-saif.c,
> but if we need to keep the clk_set_rate for saif, then we
> need the clk_prepare_enable for saif clk. I am a bit unsure of what
> your proposal is.
> 
My proposal is we need to clk_prepare_enable before clk_set_rate a clock
if the clock is gated, and then clk_disable_unprepare the clock after
clk_set_rate is done.  This applies whatever codes that want to
clk_set_rate a mxs clock.

-- 
Regards,
Shawn
