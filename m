From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Oct 2016 10:54:02 +0200
Subject: [PATCH 3/9] drm/sun4i: Put dotclock range into tcon quirks and
 check against them
In-Reply-To: <20161006160629.11198-4-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-4-wens@csie.org>
Message-ID: <20161007085402.GI4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 12:06:23AM +0800, Chen-Yu Tsai wrote:
> In commit bb43d40d7c83 ("drm/sun4i: rgb: Validate the clock rate") the
> driver was rounding the requested clock rate and then checking the
> result against the original requested rate.
> 
> This does not work well for a number of reasons:
> 
>   - The pixel clock does not have enough resolution to be able to
>     provide all sub-MHz clock rates. This makes it filter out most modes
>     found in simple-panel.
> 
>   - When first introduced, the main limiting factors were the video PLL
>     clock range (27 ~ 381 MHz) and the lowest divider (6). On sun6i and
>     later, the valid PLL clock range is extended to 30 ~ 600 MHz. The
>     PLL's multiplier and divider can make it go much higher out of range,
>     but the clock driver currently has no checks for it.
> 
> Since the limits are well known, we can hard code the range into the
> tcon driver, and check against them. And we really only care about the
> upper limit, which affects the highest resolutions we can support.

We already discussed this, but this is really the wrong way to fix
that issue.

clk_round_rate already gives you the maximum clock rate that can be
handled in a generic and abstracted way, disregarding the current
state of the clock driver.

However, the issue that you're trying to solve is that panels might
have a pixel clock requirement that is not aligned on the resolution
on the pixel clock we can generate.

And this can actually happen at any rate, you could very well have a
display that requires a pixel clock of 63501kHz that you would reject,
while using the 63,5 MHz clock rate would be just fine.

On the other hand, (totally made up example) some panel that requires
a pixel clock of 43MHz, with a +- 1MHz tolerance, that we wouldn't be
able to generate since we would only generate 41 or 45 MHz.

And on yet another hand, the panel might be requesting a pixel clock
well below what we can generate, which is also something that we want
to reject.

I can see two way of fixing this so far, the second being a solution
if the first one fails:
   - Look to a decent amount of panels and bridges datasheet to see
     what their usual tolerance on the pixel clock rate is, then use
     that to make a decision.
   - If there's not really a common tolerance that we can find out,
     extend the panel and bridges API to be able for the panel to
     provide its tolerance on the timings, and make a function that we
     can call to see if a given rate is within boundaries.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/a94a036f/attachment.sig>
