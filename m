From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 16:44:24 -0600
Subject: [RFC 4/5] clk: per-user clock accounting for debug
In-Reply-To: <1403855872-14749-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <53ADF3C8.2060702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> When a clock has multiple users, the WARNING on imbalance of
> enable/disable may not show the guilty party since although they may
> have commited the error earlier, the warning is emitted later when some
> other user, presumably innocent, disables the clock.
> 
> Provide per-user clock enable/disable accounting and disabler tracking
> in order to help debug these problems.
> 
> NOTE: with this patch, clk_get_parent() behaves like clk_get(), i.e. it
> needs to be matched with a clk_put().  Otherwise, memory will leak.

> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> index 91659b2..9657fc8 100644
> --- a/include/linux/clk-private.h
> +++ b/include/linux/clk-private.h
> @@ -56,7 +56,11 @@ struct clk_core {
>  };
>  
>  struct clk {
> -	struct clk_core clk;
> +	struct clk_core	*core;
> +	unsigned int	enable_count;
> +	const char	*dev_id;
> +	const char	*con_id;

Why not just store the "struct device *" there instead of pulling the
name out of it, so ...

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c

>  void clk_disable(struct clk *clk_user)
>  {
> -	__clk_disable_internal(clk_to_clk_core(clk_user));
> +	struct clk_core *clk = clk_to_clk_core(clk_user);
> +	unsigned long flags;
> +
> +	flags = clk_enable_lock();
> +	if (!WARN(clk_user->enable_count == 0,
> +		  "incorrect disable clk dev %s con %s last disabler %pF\n",
> +		  clk_user->dev_id, clk_user->con_id, clk_user->last_disable)) {

Here, you could do something like:

    if (!clk_user->enable_count) {
        dev_err(clk_user->dev, "", ...);
        goto out;
    }
    ...
    out:
    clk_enable_unlock(flags);
}

I suppose that has the disadvantage of not using WARN() so not
generating a full back-trace. Still, you could keep the use of WARN()
and pass as a parameter to the printf parameters dev_name(clk_user->dev)
rather than manually saving the fields separately.
