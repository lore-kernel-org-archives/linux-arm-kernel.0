From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 15:51:09 -0700
Subject: [PATCH 07/10] opp: Add OPP sharing information to OPP library
In-Reply-To: <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
Message-ID: <55A986DD.3010104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2015 04:57 AM, Viresh Kumar wrote:
> @@ -112,12 +129,14 @@ struct dev_pm_opp {
>   struct device_opp {
>   	struct list_head node;
>   
> -	struct device *dev;
>   	struct srcu_notifier_head srcu_head;
>   	struct rcu_head rcu_head;
> +	struct list_head dev_list;
>   	struct list_head opp_list;
>   
> +	struct device_node *np;
>   	unsigned long clock_latency_ns_max;
> +	bool shared_opp;
>   };
>   
>   /*
> @@ -137,6 +156,40 @@ do {									\
>   			   "dev_opp_list_lock protection");		\
>   } while (0)
>   
> +static struct device_list_opp *_find_list_dev(struct device *dev,

const device?

> +					      struct device_opp *dev_opp)
> +{
> +	struct device_list_opp *list_dev;
> +
> +	list_for_each_entry(list_dev, &dev_opp->dev_list, node)
> +		if (list_dev->dev == dev)
> +			return list_dev;
> +
> +	return NULL;
> +}
> +
> +static struct device_opp *_managed_opp(struct device_node *np)

const device_node?

> +{
> +	struct device_opp *dev_opp;
> +
> +	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
> +		if (dev_opp->np == np) {
> +			/*
> +			 * Multiple devices can point to the same OPP table and
> +			 * so will have same node-pointer, np.
> +			 *
> +			 * But the OPPs will be considered as shared only if the
> +			 * OPP table contains a "opp-shared" property.
> +			 */
> +			if (dev_opp->shared_opp)
> +				return dev_opp;
> +			else
> +				return NULL;
> +		}
> +
> +	return NULL;
> +}
> +
>   /**
>    * _find_device_opp() - find device_opp struct using device pointer
>    * @dev:	device pointer used to lookup device OPPs
> @@ -454,6 +504,39 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>   
> +/* List-dev Helpers */
> +static void _kfree_list_dev_rcu(struct rcu_head *head)
> +{
> +	struct device_list_opp *list_dev;
> +
> +	list_dev = container_of(head, struct device_list_opp, rcu_head);
> +	kfree_rcu(list_dev, rcu_head);
> +}
> +
> +static void _remove_list_dev(struct device_list_opp *list_dev,
> +			     struct device_opp *dev_opp)
> +{
> +	list_del(&list_dev->node);
> +	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
> +		  _kfree_list_dev_rcu);
> +}
> +
> +static struct device_list_opp *_add_list_dev(struct device *dev,

Can dev be const here too?

> +					     struct device_opp *dev_opp)
> +{
> +	struct device_list_opp *list_dev;
> +
> +	list_dev = kzalloc(sizeof(*list_dev), GFP_KERNEL);
> +	if (!list_dev)
> +		return NULL;
> +
> +	/* Initialize list-dev */
> +	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
> +	list_dev->dev = dev;
> +
> +	return list_dev;
> +}
> +
>   /**
>    * _add_device_opp() - Returns device OPP table
>    * @dev:	device for which we do this operation
> @@ -466,6 +549,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>   static struct device_opp *_add_device_opp(struct device *dev)
>   {
>   	struct device_opp *dev_opp;
> +	struct device_list_opp *list_dev;
>   
>   	/* Check for existing list for 'dev' first */
>   	dev_opp = _find_device_opp(dev);
> @@ -621,7 +722,8 @@ static struct dev_pm_opp *_allocate_opp(struct device *dev,
>   	return opp;
>   }
>   
> -static int _opp_add(struct dev_pm_opp *new_opp, struct device_opp *dev_opp)
> +static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> +		    struct device_opp *dev_opp)
>   {
>   	struct dev_pm_opp *opp = NULL;
>   	struct list_head *head = &dev_opp->opp_list;
>
>
>
> @@ -1100,8 +1217,19 @@ static int _of_init_opp_table_v2(struct device *dev,
>   	if (WARN_ON(!count))
>   		goto put_opp_np;
>   
> -	if (ret)
> +	if (!ret) {
> +		if (!dev_opp) {
> +			dev_opp = _find_device_opp(dev);
> +			if (WARN_ON(!dev_opp))
> +				goto put_opp_np;
> +		}
> +
> +		dev_opp->np = opp_np;
> +		if (of_get_property(opp_np, "opp-shared", NULL))

dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared")?

> +			dev_opp->shared_opp = true;
> +	} else {
>   		of_free_opp_table(dev);
> +	}
>   
>   put_opp_np:
>   	of_node_put(opp_np);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
