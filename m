From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 05 Sep 2014 16:29:36 -0700
Subject: [PATCH] RFC: add function for localbus address
In-Reply-To: <1409672700-21697-1-git-send-email-svarbanov@mm-sol.com>
References: <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <1409672700-21697-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <540A4760.8060105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/14 08:45, Stanimir Varbanov wrote:
> Hi Grant,
>
> I came down to this. Could you review? Is that
> implementation closer to the suggestion made by you.

I like this patch (but I'm biased because I want it to exist). Feel free
to add my Tested-by.


> ---
>  drivers/of/address.c       |   49 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c      |   20 ++++++++++++++---
>  include/linux/of_address.h |   19 +++++++++++++++++
>  3 files changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..86c2166 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -601,6 +601,32 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
>  }
>  EXPORT_SYMBOL(of_get_address);
>  
> +const __be32 *of_get_localbus_address(struct device_node *np, int index,
> +				      u64 *size)
> +{
> +	struct device_node *root, *parent;
> +	const __be32 *ranges, *prop = NULL;
> +
> +	parent = of_get_parent(np);
> +	if (!parent)
> +		return NULL;
> +
> +	root = of_find_node_by_path("/");
> +
> +	if (parent == root) {
> +		of_node_put(parent);
> +		return NULL;
> +	}

I don't get this part though. Perhaps it needs a comment to say why we
don't allow the node to live in the root.

> +
> +	ranges = of_get_property(parent, "ranges", NULL);
> +	of_node_put(parent);
> +
> +	if (!ranges)
> +		prop = of_get_address(np, index, size, NULL);
> +
> +	return prop;
> +}
> +
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
