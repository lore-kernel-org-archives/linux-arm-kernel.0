From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 2 May 2018 09:35:27 +0000
Subject: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
Message-ID: <5AE98603.6020007@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---

If my understanding is correct, the kbuild error is triggered by this 
missing dependency patch:

https://patchwork.kernel.org/patch/10370081/

Apart from that, patch looks good to me, so

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

>   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return 0;
>   }
>
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev = dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev = dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>   static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>   			     char *buf)
>   {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
>   	.name = "fsl-mc",
>   	.match = fsl_mc_bus_match,
>   	.uevent = fsl_mc_bus_uevent,
> +	.dma_configure  = fsl_mc_dma_configure,
>   	.dev_groups = fsl_mc_dev_groups,
>   };
>   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   		mc_dev->icid = parent_mc_dev->icid;
>   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   			goto error_cleanup_dev;
>   	}
>
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>   	/*
>   	 * The device-specific probe callback will get invoked by device_add()
>   	 */
>
