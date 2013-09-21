From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Sep 2013 11:12:21 +0100
Subject: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
 yet ready
In-Reply-To: <20130921120006.47b00fe7@armhf>
References: <20130921120006.47b00fe7@armhf>
Message-ID: <20130921101221.GH12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 12:00:06PM +0200, Jean-Francois Moine wrote:
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 442a313..f8b28d9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  
>  	if (dev) {
>  		clk = of_clk_get_by_name(dev->of_node, con_id);
> -		if (!IS_ERR(clk) && __clk_get(clk))
> -			return clk;
> +		if (!IS_ERR(clk)) {
> +			if (__clk_get(clk))
> +				return clk;
> +		} else {
> +			if (PTR_ERR(clk) == -EPROBE_DEFER)
> +				return clk;
> +		}

Thanks for patching this file and bringing this code to my attention.
The original is fscked.  Calling __clk_get() outside of any lock is
a serious bug and leads to races.

Also, a failing __clk_get() probably should not drop through to
clk_get_sys(), but should instead do this:

		if (!IS_ERR(clk)) {
			if (!__clk_get(clk))
				clk = ERR_PTR(-ENOENT);
			return clk;
		}

since a _found_ clock but one which can't be used (due to the module
going away) is not a reason to drop through to clk_get_sys().

Which means your change should look like this:

		if (!IS_ERR(clk)) {
			if (!__clk_get(clk))
				clk = ERR_PTR(-ENOENT);
			return clk;
		}
		if (PTR_ERR(clk) == -EPROBE_DEFER)
			return clk;
