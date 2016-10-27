From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 27 Oct 2016 10:02:33 +0100
Subject: [PATCH 7/9] Input: wm97xx: split out touchscreen registering
In-Reply-To: <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161027090233.GF28180@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 09:41:45PM +0200, Robert Jarzmik wrote:
> wm97xx-core does several things in it initialization :
>  - touchscreen input device setup
>  - battery device creation
> 
> As the wm97xx is actually a multi-function device handling an audio
> codec, a touchscreen, a gpio block and an ADC, reshape the probing to
> isolate what is truly input/touchscreen specific from the remaining
> part.
> 
> This is only code shuffling, there is no functional change.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/input/touchscreen/wm97xx-core.c | 193 ++++++++++++++++++--------------
>  1 file changed, 112 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index 83cf11312fd9..50a110e2988b 100644
<snip>
> +static void wm97xx_remove_battery(struct wm97xx *wm)
> +{
> +	platform_device_put(wm->battery_dev);
> +}
<snip>
> @@ -724,10 +757,8 @@ static int wm97xx_remove(struct device *dev)
>  {
>  	struct wm97xx *wm = dev_get_drvdata(dev);
>  
> -	platform_device_unregister(wm->battery_dev);
> -	platform_device_unregister(wm->touch_dev);
> -	input_unregister_device(wm->input_dev);
> -	kfree(wm);
> +	wm97xx_remove_battery(wm);

The commit message says this is just shifting code around but the
platform_device_unregister for the battery_dev seems to have
turned into a platform_device_put here.

Thanks,
Charles
