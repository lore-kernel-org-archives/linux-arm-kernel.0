From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 01 Dec 2013 12:00:09 -0700
Subject: [RFC][PATCHv6+++ 01/13] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <20131129.134625.431945240074254704.hdoyu@nvidia.com>
References: <20131121.191720.1487772262083864095.hdoyu@nvidia.com><528E577C.2050506@wwwdotorg.org><20131128.145818.1345100874304396564.hdoyu@nvidia.com>
 <20131129.134625.431945240074254704.hdoyu@nvidia.com>
Message-ID: <529B8739.60701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 04:46 AM, Hiroshi Doyu wrote:
...
> Iterating over a property containing a list of phandles with arguments
> is a common operation for device drivers. This patch adds a new
> of_property_for_each_phandle_with_args() macro to make the iteration
> simpler.
> 
> Introduced a new struct "of_phandle_iter" to keep the state when
> iterating over the list.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> v6+++:

Surely that's v9; "+++" is rather unusual.

> diff --git a/drivers/of/base.c b/drivers/of/base.c

> +void of_phandle_iter_next(struct of_phandle_iter *iter,
> +			  struct of_phandle_args *out_args)
> +{
> +	phandle phandle;
> +	struct device_node *dn;
> +	int i, count = iter->cell_count;
> +
> +	iter->err = -EINVAL;
> +	if (!iter->cells_name && !iter->cell_count)
> +		return;

Wasn't that already checked in _start()?

Why not set err = -EINVAL inside the if, rather than setting it to an
error value here by default, then having to over-write it at the end of
the function?

> +static void __of_phandle_iter_set(struct of_phandle_iter *iter,

This is only used in one place; why not simply inline this into
of_phandle_iter_start()? It would make the code simpler.

> +void of_phandle_iter_start(struct of_phandle_iter *iter,

> +	iter->cells_name = cells_name;
> +	iter->cell_count = cell_count;

Why not pass these values into of_phandle_iter_next() instead? There's
no need to pass them just to _start() so they can be read by _next()
instead.

> diff --git a/include/linux/of.h b/include/linux/of.h

> +/*
> + * keep the state at iterating a list of phandles with variable number
> + * of args
> + */
> +struct of_phandle_iter {
> +	int		err;
> +	const __be32	*cur;		/* current phandle */
> +	const __be32	*end;		/* end of the last phandle */

Can't you detect an error case by e.g. (cur == NULL) and thus avoid
requiring an explicit err field?

Together with removing:

> +	const char	*cells_name;
> +	int		cell_count;

... then you'd only be left with cur/end, so I think you could get away
without a struct at all, but simply "cur" as the iterator variable, plus
"end" as the one temp variable.
