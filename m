From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 May 2015 07:55:39 -0700
Subject: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer
 clock
In-Reply-To: <20150506053539.GA10871@codeaurora.org>
References: <1430848941-27106-1-git-send-email-tony@atomide.com>
 <20150506053539.GA10871@codeaurora.org>
Message-ID: <20150506145539.GI21061@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [150505 22:36]:
> On 05/05, Tony Lindgren wrote:
> > With recent changes to use determine_rate, the comparison of two
> > clocks won't work without doing __clk_get_hw on the clocks
> > first.
> > 
> > Cc: Michael Turquette <mturquette@linaro.org>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Found one more of these, the coccinelle scripts do not seem
> > to match this?
> 
> I don't think the coccinelle script was ever merged...

Oh OK, but the wrong comparisons in the kernel code got
fixed, right? 

> > @@ -298,7 +299,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
> >  	if (IS_ERR(src))
> >  		return PTR_ERR(src);
> >  
> > -	if (clk_get_parent(timer->fclk) != src) {
> > +	if (__clk_get_hw(clk_get_parent(timer->fclk)) != __clk_get_hw(src)) {
> 
> Please use clk_is_match() instead so we can find these instances
> with an easy grep.

Thanks here's an updated version with that.

Regards,

Tony

8< -----------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 May 2015 09:03:34 -0700
Subject: [PATCH] ARM: OMAP2+: Fix bogus struct clk comparison for timer clock

With recent changes to use determine_rate, the comparison of two
clocks won't work without clk_is_match that does __clk_get_hw
on the clocks first.

Cc: Michael Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -298,7 +298,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
-	if (clk_get_parent(timer->fclk) != src) {
+	if (!clk_is_match(clk_get_parent(timer->fclk), src)) {
 		r = clk_set_parent(timer->fclk, src);
 		if (r < 0) {
 			pr_warn("%s: %s cannot set source\n", __func__,
