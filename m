From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Feb 2012 14:19:47 -0800
Subject: [PATCH v2 5/7] ARM: OMAP2+: Split omap2_hsmmc_init() to
 properly support I2C GPIO pins
In-Reply-To: <4F470DDA.7050603@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-6-git-send-email-rnayak@ti.com>
 <4F464CFF.3080006@compulab.co.il>
 <20120223184751.GX18185@atomide.com> <4F470DDA.7050603@ti.com>
Message-ID: <20120224221947.GA18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120223 19:39]:
> On Friday 24 February 2012 12:17 AM, Tony Lindgren wrote:
> >* Igor Grinberg<grinberg@compulab.co.il>  [120223 05:56]:
> >>>--- a/arch/arm/mach-omap2/board-cm-t35.c
> >>>+++ b/arch/arm/mach-omap2/board-cm-t35.c
> >>>@@ -411,9 +411,9 @@ static struct omap2_hsmmc_info mmc[] = {
> >>>  	{
> >>>  		.mmc		= 1,
> >>>  		.caps		= MMC_CAP_4_BIT_DATA,
> >>>-		.gpio_cd	= -EINVAL,
> >>>+		.gpio_cd	= OMAP_MAX_GPIO_LINES + 0,
> >>>  		.gpio_wp	= -EINVAL,
> >
> >I don't have these changes, in my second revision of the patch.
> >
> >It's best not to hardcode the values here.
> 
> Ok, I just though doing it the other way is more round about
> hardcoding where in the board passes a hardcoded value to
> twl4030 gpio driver and the driver passes the *same* hardcoded
> value back to the board callback, which is then populated in
> mmc pdata. The board could as well directly hardcode it in the
> mmc pdata. That makes it much more readable than this round about
> hardcoding.
> But I'll go back to the old way if you think thats how we should
> handle this.

Yes let's not change it, or if we need to change it, let's do
it in a separate patch.
 
> >
> >>>-
> >>>+		.deferred	= true,
> >>>  	},
> >>>  	{
> >>>  		.mmc		= 2,
> >>>@@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
> >>>  		.gpio_cd	= -EINVAL,
> >>>  		.gpio_wp	= -EINVAL,
> >>>  		.ocr_mask	= 0x00100000,	/* 3.3V */
> >>>+		.deferred	= true,
> >>
> >>Why do you defer this one?
> >>It does not use external GPIO chip, in fact it does not use CD/WP at all.
> >
> >Why do you have the following then to set gpio_cd?
> 
> There is only one instance of gpio_cd being populated for the
> first element in the array mmc[], which is already deferred.
> 
> >>> -	mmc[0].gpio_cd = gpio + 0;
> 
> Igor was asking about the second element in the array which never
> has gpio_cd populated. Its just initialized to -EINVAL and stays
> that way.

Ah OK, sorry I forgot about that..
 
> Sorry for the mess up. I will make sure I have taken all changes/fixes
> from your reposts.

No problem, thanks.

Tony
