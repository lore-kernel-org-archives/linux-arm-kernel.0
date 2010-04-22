From: tim.gardner@canonical.com (Tim Gardner)
Date: Thu, 22 Apr 2010 17:00:00 -0600
Subject: [PATCH 1/1] arm: mxc: utilise usecount field in clock operations
In-Reply-To: <d501dcf8dbe98ed7f5aa9e7b34e68f0e1076ac84.1271968118.git.amit.kucheria@verdurent.com>
References: <d501dcf8dbe98ed7f5aa9e7b34e68f0e1076ac84.1271968118.git.amit.kucheria@verdurent.com>
Message-ID: <4BD0D4F0.9090605@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2010 02:30 PM, Amit Kucheria wrote:
> From: Amit Kucheria<amit.kucheria@canonical.com>
>
> This patch fixes the clock refcounting when reparenting is used.
>
> Sascha just pointed out a good explanation of refcounting here:
> http://www.spinics.net/lists/arm-kernel/msg85879.html
>
> Signed-off-by: Amit Kucheria<amit.kucheria@canonical.com>
> ---
>   arch/arm/plat-mxc/clock.c |   34 ++++++++++++++++++++++------------
>   1 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 323ff8c..14781cc 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c
> @@ -50,15 +50,16 @@ static DEFINE_MUTEX(clocks_mutex);
>
>   static void __clk_disable(struct clk *clk)
>   {
> -	if (clk == NULL || IS_ERR(clk))
> +	WARN_ON(!clk->usecount);
> +	if (clk == NULL || IS_ERR(clk) || !clk->usecount)
>   		return;
>

The clk==NULL check seem superfluous if WARN_ON(!clk->usecount) has 
already dereferenced clk (and possibly crashed). You might need two 
statements if its likely that clk could be NULL.

> -	__clk_disable(clk->parent);
> -	__clk_disable(clk->secondary);
> -
> -	WARN_ON(!clk->usecount);
> -	if (!(--clk->usecount)&&  clk->disable)
> -		clk->disable(clk);
> +	if (!(--clk->usecount)) {
> +		if (clk->disable)
> +			clk->disable(clk);
> +		__clk_disable(clk->parent);
> +		__clk_disable(clk->secondary);
> +	}
>   }
>
>   static int __clk_enable(struct clk *clk)
> @@ -66,12 +67,13 @@ static int __clk_enable(struct clk *clk)
>   	if (clk == NULL || IS_ERR(clk))
>   		return -EINVAL;
>
> -	__clk_enable(clk->parent);
> -	__clk_enable(clk->secondary);
> -
> -	if (clk->usecount++ == 0&&  clk->enable)
> -		clk->enable(clk);
> +	if (clk->usecount++ == 0) {
> +		__clk_enable(clk->parent);
> +		__clk_enable(clk->secondary);
>
> +		if (clk->enable)
> +			clk->enable(clk);
> +	}
>   	return 0;
>   }
>
> @@ -160,17 +162,25 @@ EXPORT_SYMBOL(clk_set_rate);
>   int clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	int ret = -EINVAL;
> +	struct clk *prev_parent = clk->parent;
>
>   	if (clk == NULL || IS_ERR(clk) || parent == NULL ||
>   	    IS_ERR(parent) || clk->set_parent == NULL)
>   		return ret;
>
> +	if (clk->usecount != 0)
> +		clk_enable(parent);
> +
>   	mutex_lock(&clocks_mutex);
>   	ret = clk->set_parent(clk, parent);
>   	if (ret == 0)
>   		clk->parent = parent;
> +
>   	mutex_unlock(&clocks_mutex);
>
> +	if (clk->usecount != 0)
> +		clk_disable(prev_parent);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL(clk_set_parent);


-- 
Tim Gardner tim.gardner at canonical.com
