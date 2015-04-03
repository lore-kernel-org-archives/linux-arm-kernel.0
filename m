From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 3 Apr 2015 19:11:52 +0530
Subject: [PATCH v2 1/3] phy: phy-core: allow specifying supply at port
 level
In-Reply-To: <1427921457-18235-2-git-send-email-arun.ramamurthy@broadcom.com>
References: <1427921457-18235-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1427921457-18235-2-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <551E98A0.4000106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 02 April 2015 02:20 AM, Arun Ramamurthy wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
>
> Multi-port phy's may have per-port power supplies. Let's change phy core
> to first attempt to look up the supply at the port level, and then, if
> not found, check parent device.

This commit log is no longer valid.

-Kishon

>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   drivers/phy/phy-core.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 3791838..c7aa297 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -651,16 +651,6 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
>   		goto free_phy;
>   	}
>
> -	/* phy-supply */
> -	phy->pwr = regulator_get_optional(dev, "phy");
> -	if (IS_ERR(phy->pwr)) {
> -		if (PTR_ERR(phy->pwr) == -EPROBE_DEFER) {
> -			ret = -EPROBE_DEFER;
> -			goto free_ida;
> -		}
> -		phy->pwr = NULL;
> -	}
> -
>   	device_initialize(&phy->dev);
>   	mutex_init(&phy->mutex);
>
> @@ -674,6 +664,16 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
>   	if (ret)
>   		goto put_dev;
>
> +	/* phy-supply */
> +	phy->pwr = regulator_get_optional(&phy->dev, "phy");
> +	if (IS_ERR(phy->pwr)) {
> +		ret = PTR_ERR(phy->pwr);
> +		if (ret == -EPROBE_DEFER)
> +			goto put_dev;
> +
> +		phy->pwr = NULL;
> +	}
> +
>   	ret = device_add(&phy->dev);
>   	if (ret)
>   		goto put_dev;
> @@ -689,9 +689,6 @@ put_dev:
>   	put_device(&phy->dev);  /* calls phy_release() which frees resources */
>   	return ERR_PTR(ret);
>
> -free_ida:
> -	ida_simple_remove(&phy_ida, phy->id);
> -
>   free_phy:
>   	kfree(phy);
>   	return ERR_PTR(ret);
>
