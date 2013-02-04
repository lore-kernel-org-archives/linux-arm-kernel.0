From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 17:46:12 +0000
Subject: [PATCH V2 3/7] ARM: OMAP2+: Remove hard-coded test on timer ID
In-Reply-To: <1359999786-8740-4-git-send-email-jon-hunter@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
 <1359999786-8740-4-git-send-email-jon-hunter@ti.com>
Message-ID: <20130204174612.GF2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 11:43:02AM -0600, Jon Hunter wrote:
> @@ -280,22 +281,22 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(timer->fclk))
>  		return -ENODEV;
>  
> -	/* FIXME: Need to remove hard-coded test on timer ID */
> -	if (gptimer_id != 12) {
> -		struct clk *src;
> -
> -		src = clk_get(NULL, fck_source);
> -		if (IS_ERR(src)) {
> -			r = -EINVAL;
> -		} else {
> -			r = clk_set_parent(timer->fclk, src);
> -			if (IS_ERR_VALUE(r))
> -				pr_warn("%s: %s cannot set source\n",
> -					__func__, oh->name);
> +	src = clk_get(NULL, fck_source);
> +	if (IS_ERR(src))
> +		return -EINVAL;

This should be:
		return PTR_ERR(src);

and should've been there previously...
