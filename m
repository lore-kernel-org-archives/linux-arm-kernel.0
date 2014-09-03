From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 03 Sep 2014 16:45:47 -0700
Subject: [PATCH v8 4/7] clk: use struct clk only for external API
In-Reply-To: <1409585675-26894-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585675-26894-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5407A82B.7000602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/14 08:34, Tomeu Vizoso wrote:

>
> NOTE: with this patch, clk_get_parent() behaves like clk_get(), i.e. it
> needs to be matched with a clk_put().  Otherwise, memory will leak.
>
[...]
>  }
> +EXPORT_SYMBOL_GPL(clk_provider_get_parent);
> +
> +/**
> + * clk_get_parent - return the parent of a clk
> + * @clk_user: the clk whose parent gets returned
> + *
> + * Simply returns clk->parent.  Returns NULL if clk is NULL.

We should at least document here that clk_put() is expected to be called
when it's not being used. I wonder why it's this way though. Why can't
every clk_core have a private clk pointer to it's parent that's created
during registration time? Then we just hand that out for
clk_get_parent() and destroy it when the clk_core is freed?

> + */
> +struct clk *clk_get_parent(struct clk *clk_user)
> +{
> +	struct clk_core *clk;
> +	struct clk_core *parent;
> +
> +	if (!clk_user)
> +		return NULL;
> +
> +	clk = clk_to_clk_core(clk_user);
> +	parent = clk_provider_get_parent(clk);
> +
> +	return __clk_create_clk(parent);
> +}
>  EXPORT_SYMBOL_GPL(clk_get_parent);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
