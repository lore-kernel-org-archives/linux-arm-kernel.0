From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 18 Oct 2017 15:59:14 +0900
Subject: [RFC PATCH 3/4] extcon: add possibility to get extcon device by
 of node
In-Reply-To: <20170928130730.8747-4-a.hajda@samsung.com>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130736eucas1p250bb9d854204ea142a2160cd9ab56194@eucas1p2.samsung.com>
 <20170928130730.8747-4-a.hajda@samsung.com>
Message-ID: <59E6FBC2.6080102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017? 09? 28? 22:07, Andrzej Hajda wrote:
> Since extcon property is not allowed in DT, extcon subsystem requires
> another way to get extcon device. Lets try the simplest approach - get
> edev by of_node.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
>  include/linux/extcon.h  |  6 ++++++
>  2 files changed, 40 insertions(+), 10 deletions(-)

Looks good to me. Just I added the minor comment.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index cb38c2747684..fdb8c1d767c1 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
>  EXPORT_SYMBOL_GPL(extcon_dev_unregister);
>  
>  #ifdef CONFIG_OF
> +
> +/*
> + * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
> + * @node	: OF node identyfying edev
> + *
> + * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
> + */
> +struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
> +{
> +	struct extcon_dev *edev;
> +
> +	mutex_lock(&extcon_dev_list_lock);
> +	list_for_each_entry(edev, &extcon_dev_list, entry)
> +		if (edev->dev.parent && edev->dev.parent->of_node == node)
> +			goto end;
> +	edev = ERR_PTR(-EPROBE_DEFER);
> +end:

The extcon.c already use the 'out' statement for goto.
I'd like you to use 'out' instead of 'end'.

> +	mutex_unlock(&extcon_dev_list_lock);
> +
> +	return edev;
> +}
> +
>  /*
>   * extcon_get_edev_by_phandle - Get the extcon device from devicetree.
>   * @dev		: the instance to the given device
> @@ -1363,25 +1385,27 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	mutex_lock(&extcon_dev_list_lock);
> -	list_for_each_entry(edev, &extcon_dev_list, entry) {
> -		if (edev->dev.parent && edev->dev.parent->of_node == node) {
> -			mutex_unlock(&extcon_dev_list_lock);
> -			of_node_put(node);
> -			return edev;
> -		}
> -	}
> -	mutex_unlock(&extcon_dev_list_lock);
> +	edev = extcon_get_edev_by_of_node(node);
>  	of_node_put(node);
>  
> -	return ERR_PTR(-EPROBE_DEFER);
> +	return edev;
>  }
> +
>  #else
> +
> +struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
>  struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> +
>  #endif /* CONFIG_OF */
> +
> +EXPORT_SYMBOL_GPL(extcon_get_edev_by_of_node);
>  EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
>  
>  /**
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 744d60ca80c3..2f88e7491672 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -261,6 +261,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
>   * Following APIs get the extcon_dev from devicetree or by through extcon name.
>   */
>  extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
> +extern struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node);
>  extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  						     int index);
>  
> @@ -382,6 +383,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +static inline struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  				int index)
>  {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
