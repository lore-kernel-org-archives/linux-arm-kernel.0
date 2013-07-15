From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 15 Jul 2013 22:59:20 +0400
Subject: [PATCH V2 3/5] of: introduce of_parse_phandle_with_fixed_args
In-Reply-To: <1373913629-32179-3-git-send-email-swarren@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
 <1373913629-32179-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51E44688.3050805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 10:40 PM, Stephen Warren wrote:

> From: Stephen Warren <swarren@nvidia.com>

> This is identical to of_parse_phandle_with_args(), except that the
> number of argument cells is fixed, rather than being parsed out of the
> node referenced by each phandle.

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>   drivers/of/base.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++++--------
>   include/linux/of.h | 10 ++++++++
>   2 files changed, 68 insertions(+), 9 deletions(-)

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 23e7073..ad799d9 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1106,7 +1106,8 @@ EXPORT_SYMBOL(of_parse_phandle);
>
>   static int __of_parse_phandle_with_args(const struct device_node *np,
>   					const char *list_name,
> -					const char *cells_name, int index,
> +					const char *cells_name,
> +					int cells_count, int index,

    The correct grammar would be 'cell_name' and 'cell_count' I think.

>   					struct of_phandle_args *out_args)
>   {
>   	const __be32 *list, *list_end;
> @@ -1142,12 +1143,17 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
>   					 np->full_name);
>   				goto err;
>   			}
> -			if (of_property_read_u32(node, cells_name, &count)) {
> -				pr_err("%s: could not get %s for %s\n",
> -					 np->full_name, cells_name,
> -					 node->full_name);
> -				goto err;
> -			}
> +
> +			if (cells_name) {
> +				if (of_property_read_u32(node, cells_name,
> +							 &count)) {
> +					pr_err("%s: could not get %s for %s\n",
> +						np->full_name, cells_name,
> +						node->full_name);
> +					goto err;
> +				}
> +			} else
> +				count = cells_count;

    According to Documentation/CodingStyle chapter 3, both arms of the 
*if* statment should have {} if oe arm has it.

WBR, Sergei
