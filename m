From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 16:26:35 +0000
Subject: [PATCH v3 4/7] ARM: sa1100: clean up clock support
In-Reply-To: <1330012851-13693-5-git-send-email-haojian.zhuang@marvell.com>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
 <1330012851-13693-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120223162635.GZ22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 12:00:48AM +0800, Haojian Zhuang wrote:
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&clocks_lock, flags);
>  	if (clk->enabled++ == 0)
> -		clk_gpio27_enable();
> +		clk->ops->enable(clk);
>  	spin_unlock_irqrestore(&clocks_lock, flags);

If we're going to allow clk to be NULL, this needs:

	if (clk) {
		...
	}

around it.

> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(clk_enable);
> @@ -76,13 +72,26 @@ void clk_disable(struct clk *clk)
>  
>  	spin_lock_irqsave(&clocks_lock, flags);
>  	if (--clk->enabled == 0)
> -		clk_gpio27_disable();
> +		clk->ops->disable(clk);
>  	spin_unlock_irqrestore(&clocks_lock, flags);

Same here.

>  }
>  EXPORT_SYMBOL(clk_disable);
>  
> -unsigned long clk_get_rate(struct clk *clk)
> +const struct clkops clk_gpio27_ops = {
> +	.enable		= clk_gpio27_enable,
> +	.disable	= clk_gpio27_disable,
> +};
> +
> +static DEFINE_CLK(gpio27, &clk_gpio27_ops);
> +
> +static struct clk_lookup sa11xx_clkregs[] = {
> +	CLKDEV_INIT("sa1111.0", NULL, &clk_gpio27),
> +	CLKDEV_INIT("sa1100-rtc", NULL, NULL),

And as this introduces NULL clock, the above needs to be part of this
patch.

Apart from that, it's fine.
