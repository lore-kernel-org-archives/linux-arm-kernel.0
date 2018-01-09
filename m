From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 9 Jan 2018 10:19:46 +0100
Subject: [PATCH v7 7/9] clocksource: timer-dm: Hook device platform data
 if not already assigned
In-Reply-To: <1515478987-5786-8-git-send-email-j-keerthy@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-8-git-send-email-j-keerthy@ti.com>
Message-ID: <20180109091946.xxribrhf2ayt3gny@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 09, 2018 at 11:53:05AM +0530, Keerthy wrote:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> In the case of device tree boot the device platform data is usually
> NULL so hook the platform data obtained from the match.
> As part of un-constify the platform_data pointer.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  drivers/clocksource/timer-dm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index 1cbd954..60db173 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -806,14 +806,16 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  	struct omap_dm_timer *timer;
>  	struct resource *mem, *irq;
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	const struct dmtimer_platform_data *pdata;
>  	int ret;
>  
> -	match = of_match_device(of_match_ptr(omap_timer_match), dev);
> -	pdata = match ? match->data : dev->platform_data;
> +	pdata = of_device_get_match_data(dev);
> +	if (!pdata)
> +		pdata = dev_get_platdata(dev);
> +	else
> +		dev->platform_data = (void *)pdata;
>  
> -	if (!pdata && !dev->of_node) {
> +	if (!pdata) {
>  		dev_err(dev, "%s: no platform data.\n", __func__);
>  		return -ENODEV;
>  	}
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/2139532d/attachment.sig>
