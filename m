From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 16:35:02 +0100
Subject: [PATCH] sunxi-rsb: Include OF based modalias in device uevent
In-Reply-To: <a99fc4e8-49e3-486a-b508-d764a952d9f8@rwthex-w2-a.rwth-ad.de>
References: <a99fc4e8-49e3-486a-b508-d764a952d9f8@rwthex-w2-a.rwth-ad.de>
Message-ID: <20171127153502.4wcqtimppgpfklmr@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 27, 2017 at 01:17:25PM +0100, Stefan Br?ns wrote:
> Include the OF-based modalias in the uevent sent when registering devices
> on the sunxi RSB bus, so that user space has a chance to autoload the
> kernel module for the device.
> 
> Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
> pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
> the AXP803 PMIC is built as a module, it is not loaded and the system
> ends up with an disfunctional MMC controller.
> 
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  drivers/bus/sunxi-rsb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 328ca93781cf..37cb57244cbe 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -173,11 +173,24 @@ static int sunxi_rsb_device_remove(struct device *dev)
>  	return drv->remove(to_sunxi_rsb_device(dev));
>  }
>  
> +static int sunxi_rsb_device_uevent(struct device *dev,
> +				   struct kobj_uevent_env *env)
> +{
> +	int ret;
> +
> +	ret = of_device_uevent_modalias(dev, env);
> +	if (ret != -ENODEV)
> +		return ret;

A comment explaining why we need to ignore the ENODEV error code would
be great here.

> +	return 0;
> +}
> +
>  static struct bus_type sunxi_rsb_bus = {
>  	.name		= RSB_CTRL_NAME,
>  	.match		= sunxi_rsb_device_match,
>  	.probe		= sunxi_rsb_device_probe,
>  	.remove		= sunxi_rsb_device_remove,
> +	.uevent		= sunxi_rsb_device_uevent,

Any reason to not use of_device_uevent_modalias directly here?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/2f550d85/attachment.sig>
