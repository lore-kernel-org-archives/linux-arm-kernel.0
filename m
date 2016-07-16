From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 16 Jul 2016 10:00:13 -0700
Subject: [v2,1/4] hwmon: iio_hwmon: defer probe when no channel is found
In-Reply-To: <1468576754-3273-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1468576754-3273-2-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160716170013.GA27490@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 11:59:11AM +0200, Quentin Schulz wrote:
> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
> properties in the Device Tree or channels whose consumer_dev_name matches
> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> which might be probed after iio_hwmon.
> 
> It is better to defer the probe of iio_hwmon if such error is returned by
> iio_channel_get_all in order to let a chance to iio drivers to expose
> channels in iio_map_list.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> No modifications for this patch since we did not settled for a solution.
> What should we do?
> 
AFAICS the only thing we can do is to replace module_platform_driver() with
its explicitly coded variant, and to use use late_initcall() instead of
module_init(). Anything else would result in endless probe deferrals if
there are no channels.

Guenter

>  drivers/hwmon/iio_hwmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index b550ba5..c0da4d9 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		name = dev->of_node->name;
>  
>  	channels = iio_channel_get_all(dev);
> -	if (IS_ERR(channels))
> +	if (IS_ERR(channels)) {
> +		if (PTR_ERR(channels) == -ENODEV)
> +			return -EPROBE_DEFER;
>  		return PTR_ERR(channels);
> +	}
>  
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>  	if (st == NULL) {
