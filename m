From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 3 Jul 2018 17:14:05 +0100
Subject: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
In-Reply-To: <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
Message-ID: <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/18 14:49, Nipun Gupta wrote:
> This patch adds support of dma configuration for devices on fsl-mc
> bus using 'dma_configure' callback for busses. Also, directly calling
> arch_setup_dma_ops is removed from the fsl-mc bus.

Looks like this is the final arch_setup_dma_ops offender, yay!

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..fa43c7d 100644
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
> @@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   			goto error_cleanup_dev;
>   	}
>   
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))

Although it seems we do end up without any handling of this 
"non-coherent object behind coherent MC" case, and I'm not sure how 
easily that could be accommodated by generic code... :/ How important is 
the quirk?

Robin.

> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>   	/*
>   	 * The device-specific probe callback will get invoked by device_add()
>   	 */
> 
