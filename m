From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 17 Aug 2014 16:28:54 +0100
Subject: [PATCH 1/3] of: Add of_match_machine helper
In-Reply-To: <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140817152854.5406BC40ADD@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014 02:01:53 +0300, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Add of_match_machine function to test the device tree root for an
> of_match array. This can be useful when testing SoC versions at runtime,
> for example.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
>  drivers/of/base.c  | 21 +++++++++++++++++++++
>  include/linux/of.h |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d8574ad..37798ea 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -977,6 +977,27 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
>  EXPORT_SYMBOL(of_find_matching_node_and_match);
>  
>  /**
> + * of_match_machine - Tell if root of device tree has a matching of_match struct
> + *	@matches:	array of of device match structures to search in
> + *
> + *	Returns the result of of_match_node for the root node.
> + */
> +const struct of_device_id *of_match_machine(const struct of_device_id *matches)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return NULL;
> +
> +	match = of_match_node(matches, root);
> +	of_node_put(root);
> +	return match;
> +}
> +EXPORT_SYMBOL(of_match_machine);

Too wordy...

	return of_match_node(matches, of_allnodes);

:-)

It could be a static inline, but I don't think it's even worth having a
helper. The callers could just open code the above.

g.
