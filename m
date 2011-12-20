From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Dec 2011 12:49:52 -0600
Subject: [PATCH 1/1] dt: reform for_each_property to
 for_each_property_of_node_of_node
In-Reply-To: <1324403518-3462-1-git-send-email-b29396@freescale.com>
References: <1324403518-3462-1-git-send-email-b29396@freescale.com>
Message-ID: <4EF0D8D0.1020505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/20/2011 11:51 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Make this micro more easy to use(do not need to pass properties, a node is

Make this macro easier to use...

> enough), also change to a more sensible name as for_each_child_of_node.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/of/base.c  |    2 +-
>  include/linux/of.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9b6588e..f6f6fe8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1159,7 +1159,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
>  	if (!of_aliases)
>  		return;
>  
> -	for_each_property(pp, of_aliases->properties) {
> +	for_each_property_of_node(of_aliases, pp) {
>  		const char *start = pp->name;
>  		const char *end = start + strlen(start);
>  		struct device_node *np;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4948552..f1a490c 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -219,8 +219,8 @@ extern int of_device_is_available(const struct device_node *device);
>  extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
>  				int *lenp);
> -#define for_each_property(pp, properties) \
> -	for (pp = properties; pp != NULL; pp = pp->next)
> +#define for_each_property_of_node(dn, pp) \
> +	for (pp = dn->properties; pp != NULL; pp = pp->next)

Probably should prepend it with "of_" while you're at it.

Rob
