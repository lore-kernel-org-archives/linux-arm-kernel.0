From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Aug 2014 11:41:25 +0200
Subject: [PATCH 1/3] of: Add of_match_machine helper
In-Reply-To: <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140808094123.GC5387@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 02:01:53AM +0300, Tuomas Tynkkynen wrote:
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

I was going to say that this kerneldoc is weirdly formatted, but when I
looked at the other kerneldoc comments in this file it seems that they
use similarly weird formatting...

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

I wonder if of_find_node_by_path("/") is somewhat overkill here. Perhaps
simply of_node_get(of_allnodes) would be more appropriate here since the
function is implemented in the core?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/67e6af16/attachment.sig>
