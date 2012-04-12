From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 14:49:23 +0800
Subject: [PATCH 13/13] clk: basic: improve parent_names & return errors
In-Reply-To: <1334192572-12499-14-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-14-git-send-email-mturquette@linaro.org>
Message-ID: <20120412064920.GH2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 06:02:51PM -0700, Mike Turquette wrote:
...
> @@ -175,23 +188,32 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>  	div->flags = clk_divider_flags;
>  	div->lock = lock;
>  
> +	/* allocate the temporary parent_names */
>  	if (parent_name) {
> -		div->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> -		if (!div->parent[0])
> -			goto out;
> +		parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
> +		if (!parent_names[0]) {
> +			pr_err("%s: could not allocate parent_names\n",
> +					__func__);
> +			goto fail_parent_names;
> +		}
>  	}

Why do we need to copy the parent_names here at all?  clk_register()
has done that for each basic clk.

Regards,
Shawn

>  
> +	/* register the clock */
>  	clk = clk_register(dev, name,
>  			&clk_divider_ops, &div->hw,
> -			div->parent,
> +			(parent_name ? parent_names: NULL),
>  			(parent_name ? 1 : 0),
>  			flags);
> -	if (clk)
> -		return clk;
>  
> -out:
> -	kfree(div->parent[0]);
> -	kfree(div);
> +	/* free the temporary parent_names */
> +	if (parent_name)
> +		kfree(parent_names[0]);
> +
> +	if (!IS_ERR(clk))
> +		goto out;
>  
> -	return NULL;
> +fail_parent_names:
> +	kfree(div);
> +out:
> +	return clk;
>  }
