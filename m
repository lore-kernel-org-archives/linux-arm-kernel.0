From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Apr 2010 14:47:50 +0300
Subject: [PATCH] arm: mxc: utilise usecount field in clock operations
In-Reply-To: <b9f250fee8e5300e859b2afc234868ba7632f619.1271864861.git.amit.kucheria@canonical.com>
References: <b9f250fee8e5300e859b2afc234868ba7632f619.1271864861.git.amit.kucheria@canonical.com>
Message-ID: <20100422114747.GB14819@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Wed, Apr 21, 2010 at 09:37:31PM +0300, Amit Kucheria wrote:
> clk->usecount can be used by platform code to check if a clock is active or
> not.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  arch/arm/plat-mxc/clock.c |   37 ++++++++++++++++++++++++-------------
>  1 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 323ff8c..c791f38 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c

[snip]

> @@ -160,17 +161,27 @@ EXPORT_SYMBOL(clk_set_rate);
>  int clk_set_parent(struct clk *clk, struct clk *parent)
>  {
>  	int ret = -EINVAL;
> +	struct clk *prev_parent = clk->parent;
>  
>  	if (clk == NULL || IS_ERR(clk) || parent == NULL ||
>  	    IS_ERR(parent) || clk->set_parent == NULL)
>  		return ret;
>  
> +	if (clk->usecount != 0) {
> +		clk_enable(parent);
> +	}

Unnecessary braces here. See chapter 3 of Documentation/CodingStyle.

> +
>  	mutex_lock(&clocks_mutex);
>  	ret = clk->set_parent(clk, parent);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		clk->parent = parent;
> +	}

Ditto

>  	mutex_unlock(&clocks_mutex);
>  
> +	if (clk->usecount != 0) {
> +		clk_disable(prev_parent);
> +	}

Ditto

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(clk_set_parent);
> -- 

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
