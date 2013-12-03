From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 13:14:18 -0700
Subject: [RFC][PATCHv6+++ 01/13] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <20131202.130220.1404999403649937134.hdoyu@nvidia.com>
References: <20131128.145818.1345100874304396564.hdoyu@nvidia.com><20131129.134625.431945240074254704.hdoyu@nvidia.com><529B8739.60701@wwwdotorg.org>
 <20131202.130220.1404999403649937134.hdoyu@nvidia.com>
Message-ID: <529E3B9A.50207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 04:02 AM, Hiroshi Doyu wrote:
...
> Iterating over a property containing a list of phandles with arguments
> is a common operation for device drivers. This patch adds a new
> of_property_for_each_phandle_with_args() macro to make the iteration
> simpler.

> diff --git a/drivers/of/base.c b/drivers/of/base.c

> +const __be32 *of_phandle_iter_init(const struct device_node *np,
> +				   const char *list_name,
> +				   const __be32 **end)
> +{
> +	size_t bytes;
> +	const __be32 *cur;
> +
> +	cur = of_get_property(np, list_name, &bytes);
> +	if (bytes)
> +		*end = cur + bytes / sizeof(*cur);
> +
> +	return cur;
> +}

"bytes" doesn't seem like the correct thing to check in that if
statement. The property might exist but be zero length. Perhaps if (cur)
would be better, or just initializing *end in all cases (the value won't
be used if (!cur), so setting *end to a bogus value in that case won't
matter).

> +const __be32 *of_phandle_iter_next(const char *cells_name, int cell_count,
> +				   const __be32 *cur, const __be32 *end,
> +				   struct of_phandle_args *out_args)
...
> +	if (!cur)
> +		return NULL;
> +
> +	if (end - cur <= 0)
> +		return NULL;

Related, don't you want if (cur >= end) there; just compare the pointers
directly rather than explicitly calculating and testing the difference?
