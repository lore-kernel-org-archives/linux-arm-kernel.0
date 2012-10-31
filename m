From: balbi@ti.com (Felipe Balbi)
Date: Wed, 31 Oct 2012 15:46:37 +0200
Subject: [PATCH v3 1/3] drivers: bus: ocp2scp: add pdata support
In-Reply-To: <1351344956-22868-2-git-send-email-kishon@ti.com>
References: <1351344956-22868-1-git-send-email-kishon@ti.com>
 <1351344956-22868-2-git-send-email-kishon@ti.com>
Message-ID: <20121031134637.GA10998@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 07:05:54PM +0530, Kishon Vijay Abraham I wrote:
> ocp2scp was not having pdata support which makes *musb* fail for non-dt
> boot in OMAP platform. The pdata will have information about the devices
> that is connected to ocp2scp. ocp2scp driver will now make use of this
> information to create the devices that is attached to ocp2scp.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

just one small comment below. Other than that:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/bus/omap-ocp2scp.c                 |   67 ++++++++++++++++++++++++++--
>  include/linux/platform_data/omap_ocp2scp.h |   31 +++++++++++++
>  2 files changed, 95 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/platform_data/omap_ocp2scp.h
> 
> diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
> index ff63560..5db8297 100644
> --- a/drivers/bus/omap-ocp2scp.c
> +++ b/drivers/bus/omap-ocp2scp.c
> @@ -22,6 +22,26 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_data/omap_ocp2scp.h>
> +
> +/**
> + * _count_resources - count for the number of resources
> + * @res: struct resource *
> + *
> + * Count and return the number of resources populated for the device that is
> + * connected to ocp2scp.
> + */
> +static unsigned _count_resources(struct resource *res)
> +{
> +	int cnt	= 0;
> +
> +	while (res->start != res->end) {
> +		cnt++;
> +		res++;
> +	}
> +
> +	return cnt;
> +}
>  
>  static int ocp2scp_remove_devices(struct device *dev, void *c)
>  {
> @@ -34,20 +54,61 @@ static int ocp2scp_remove_devices(struct device *dev, void *c)
>  
>  static int __devinit omap_ocp2scp_probe(struct platform_device *pdev)
>  {
> -	int			ret;
> -	struct device_node	*np = pdev->dev.of_node;
> +	int ret;
> +	unsigned res_cnt, i;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct platform_device *pdev_child;
> +	struct omap_ocp2scp_platform_data *pdata = pdev->dev.platform_data;
> +	struct omap_ocp2scp_dev *dev;
>  
>  	if (np) {
>  		ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to add resources for ocp2scp child\n");
> +			dev_err(&pdev->dev,
> +			    "failed to add resources for ocp2scp child\n");
>  			goto err0;
>  		}
> +	} else if (pdata) {
> +		for (i = 0, dev = *pdata->devices; i < pdata->dev_cnt; i++,
> +		    dev++) {
> +			res_cnt = _count_resources(dev->res);
> +
> +			pdev_child = platform_device_alloc(dev->drv_name, -1);

please use PLATFORM_DEVID_AUTO instead.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/31a46a7e/attachment-0001.sig>
