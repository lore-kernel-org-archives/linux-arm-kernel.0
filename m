From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 10:11:13 +0800
Subject: [PATCH] video: mxsfb: Adapt to new videomode API
In-Reply-To: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
References: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130412021111.GD16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 11:16:18AM -0300, Fabio Estevam wrote:
> commit 6cd2c7db4 (videomode: videomode_from_timing work) changed the name of 
> the function from videomode_from_timing() to videomode_from_timings().
> 
> commit 32ed6ef1 (videomode: create enum for videomode's display flags) changed
> the 'data_flags' field in videomode structure to 'flags'
> 
> Adapt to these changes in order to fix the following errors:
> 
> drivers/video/mxsfb.c:761:3: error: too many arguments to function 'videomode_from_timing'
> drivers/video/mxsfb.c:761:7: error: void value not ignored as it ought to be
> drivers/video/mxsfb.c:768:9: error: 'struct videomode' has no member named 'data_flags'
> drivers/video/mxsfb.c:770:9: error: 'struct videomode' has no member named 'data_flags'
> 
> Also select VIDEOMODE_HELPER in Kconfig to avoid linker errors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/Kconfig |    1 +
>  drivers/video/mxsfb.c |    7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d90e3f5..240f863 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2428,6 +2428,7 @@ config FB_MXS
>  	select FB_CFB_IMAGEBLIT
>  	select FB_MODE_HELPERS
>  	select OF_VIDEOMODE

OF_VIDEOMODE is dead now, and should be removed.

> +	select VIDEOMODE_HELPERS
>  	help
>  	  Framebuffer support for the MXS SoC.
>  
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index eac7c1a..fb559f3 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -43,6 +43,7 @@
>  #include <linux/kernel.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <video/display_timing.h>
>  #include <video/of_display_timing.h>

I messed it up from the beginning.  All these <video/*> should be sorted
after <linux/*>.

Shawn

>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> @@ -758,16 +759,16 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
>  		struct videomode vm;
>  		struct fb_videomode fb_vm;
>  
> -		ret = videomode_from_timing(timings, &vm, i);
> +		ret = videomode_from_timings(timings, &vm, i);
>  		if (ret < 0)
>  			goto put_timings_node;
>  		ret = fb_videomode_from_videomode(&vm, &fb_vm);
>  		if (ret < 0)
>  			goto put_timings_node;
>  
> -		if (vm.data_flags & DISPLAY_FLAGS_DE_HIGH)
> +		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
>  			host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
> -		if (vm.data_flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
>  			host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
>  		fb_add_videomode(&fb_vm, &fb_info->modelist);
>  	}
> -- 
> 1.7.9.5
> 
> 
