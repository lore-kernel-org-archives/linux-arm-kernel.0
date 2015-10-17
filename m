From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Oct 2015 23:51:33 -0700
Subject: [PATCH v7 01/20] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <1443517859-30376-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443517859-30376-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20151017065133.GA18329@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 11:10:39AM +0200, Tomeu Vizoso wrote:
> Lets implementations of the match() callback in struct bus_type to
> return errors and if it's -EPROBE_DEFER then queue the device for
> deferred probing.
> 
> This is useful to buses such as AMBA in which devices are registered
> before their matching information can be retrieved from the HW
> (typically because a clock driver hasn't probed yet).
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> 
>  drivers/base/dd.c      | 24 ++++++++++++++++++++++--
>  include/linux/device.h |  2 +-
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index be0eb4639128..7dc04ee81c8b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -488,6 +488,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  	struct device_attach_data *data = _data;
>  	struct device *dev = data->dev;
>  	bool async_allowed;
> +	int ret;
>  
>  	/*
>  	 * Check if device has already been claimed. This may
> @@ -498,8 +499,17 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>  	if (dev->driver)
>  		return -EBUSY;
>  
> -	if (!driver_match_device(drv, dev))
> +	ret = driver_match_device(drv, dev);
> +	if (!ret)
>  		return 0;
> +	else if (ret < 0) {
> +		if (ret == -EPROBE_DEFER) {
> +			dev_dbg(dev, "Device match requests probe deferral\n");
> +			driver_deferred_probe_add(dev);
> +		} else
> +			dev_warn(dev, "Bus failed to match device: %d", ret);

This is going to start to cause warnings where there were previously
none, which isn't going to be a good idea.  It's completly normal for a
bus to not match a device, let's not be noisy for no good reason, unless
you are going to deal with all of the confused user emails?

You do this a bunch in this patch, please don't.

thanks,

greg k-h
