From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Dec 2015 18:06:09 +0100
Subject: [PATCH 1/4] component: remove old add_components method
In-Reply-To: <E1a0tZd-0006ER-PI@rmk-PC.arm.linux.org.uk>
References: <20151123160210.GR8644@n2100.arm.linux.org.uk>
 <E1a0tZd-0006ER-PI@rmk-PC.arm.linux.org.uk>
Message-ID: <20151207170609.GB6535@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:02:37PM +0000, Russell King wrote:
> Now that drivers create an array of component matches at probe time, we
> can retire the old methods.  This involves removing the add_components
> master method, and removing component_master_add_child() from public
> view.  We also remove component_add_master() as that interface is no
> longer useful.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I've been using this patch for a couple of weeks

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew

> ---
>  drivers/base/component.c  | 31 +++++--------------------------
>  include/linux/component.h |  5 -----
>  2 files changed, 5 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index f748430bb654..2ca22738ae92 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -84,7 +84,7 @@ static void component_detach_master(struct master *master, struct component *c)
>   * function and compare data.  This is safe to call for duplicate matches
>   * and will not result in the same component being added multiple times.
>   */
> -int component_master_add_child(struct master *master,
> +static int component_master_add_child(struct master *master,
>  	int (*compare)(struct device *, void *), void *compare_data)
>  {
>  	struct component *c;
> @@ -104,7 +104,6 @@ int component_master_add_child(struct master *master,
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(component_master_add_child);
>  
>  static int find_components(struct master *master)
>  {
> @@ -112,14 +111,6 @@ static int find_components(struct master *master)
>  	size_t i;
>  	int ret = 0;
>  
> -	if (!match) {
> -		/*
> -		 * Search the list of components, looking for components that
> -		 * belong to this master, and attach them to the master.
> -		 */
> -		return master->ops->add_components(master->dev, master);
> -	}
> -
>  	/*
>  	 * Scan the array of match functions and attach
>  	 * any components which are found to this master.
> @@ -290,15 +281,10 @@ int component_master_add_with_match(struct device *dev,
>  	struct master *master;
>  	int ret;
>  
> -	if (ops->add_components && match)
> -		return -EINVAL;
> -
> -	if (match) {
> -		/* Reallocate the match array for its true size */
> -		match = component_match_realloc(dev, match, match->num);
> -		if (IS_ERR(match))
> -			return PTR_ERR(match);
> -	}
> +	/* Reallocate the match array for its true size */
> +	match = component_match_realloc(dev, match, match->num);
> +	if (IS_ERR(match))
> +		return PTR_ERR(match);
>  
>  	master = kzalloc(sizeof(*master), GFP_KERNEL);
>  	if (!master)
> @@ -326,13 +312,6 @@ int component_master_add_with_match(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(component_master_add_with_match);
>  
> -int component_master_add(struct device *dev,
> -	const struct component_master_ops *ops)
> -{
> -	return component_master_add_with_match(dev, ops, NULL);
> -}
> -EXPORT_SYMBOL_GPL(component_master_add);
> -
>  void component_master_del(struct device *dev,
>  	const struct component_master_ops *ops)
>  {
> diff --git a/include/linux/component.h b/include/linux/component.h
> index c00dcc302611..71c434a6a5ee 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -17,18 +17,13 @@ void component_unbind_all(struct device *, void *);
>  struct master;
>  
>  struct component_master_ops {
> -	int (*add_components)(struct device *, struct master *);
>  	int (*bind)(struct device *);
>  	void (*unbind)(struct device *);
>  };
>  
> -int component_master_add(struct device *, const struct component_master_ops *);
>  void component_master_del(struct device *,
>  	const struct component_master_ops *);
>  
> -int component_master_add_child(struct master *master,
> -	int (*compare)(struct device *, void *), void *compare_data);
> -
>  struct component_match;
>  
>  int component_master_add_with_match(struct device *,
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
