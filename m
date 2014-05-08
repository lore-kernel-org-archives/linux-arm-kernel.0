From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 22:07:22 -0500
Subject: [PATCH v2 2/7] reset: sunxi: allow MFD subdevices probe
In-Reply-To: <1399483554-8824-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140508030722.GL7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 07:25:49PM +0200, Boris BREZILLON wrote:
> The current implementation uses sunxi_reset_init function for both early
> init and platform device probe.
> 
> The sunxi_reset_init function uses DT to retrieve device resources, which
> will be an issue if reset controllers are registered from an MFD device
> that define resources from mfd_cell definition.
> 
> Moreover, we can make of devm functions when we're in the probe context.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/reset/reset-sunxi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
> index 695bd34..1b5fea6 100644
> --- a/drivers/reset/reset-sunxi.c
> +++ b/drivers/reset/reset-sunxi.c
> @@ -145,7 +145,24 @@ MODULE_DEVICE_TABLE(of, sunxi_reset_dt_ids);
>  
>  static int sunxi_reset_probe(struct platform_device *pdev)
>  {
> -	return sunxi_reset_init(pdev->dev.of_node);
> +	struct sunxi_reset_data *data;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->membase = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!data->membase)
> +		return -ENOMEM;

You'd probably be better off using devm_ioremap_resource so that you
get a meaningful error code.

Apart from this, you have my 
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/d8717fa6/attachment.sig>
