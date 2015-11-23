From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Nov 2015 16:22:49 +0000
Subject: [PATCH] backlight: adp88x0: fix uninitialized variable use
In-Reply-To: <3850346.cL1ocQLBvP@wuerfel>
References: <3850346.cL1ocQLBvP@wuerfel>
Message-ID: <20151123162159.GC807@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2015, Arnd Bergmann wrote:

> gcc correctly warns about both the adp8860 and adp8870 backlight
> drivers using an uninitialized variable in their error handling
> path:
> 
> drivers/video/backlight/adp8870_bl.c: In function 'adp8870_bl_ambient_light_zone_store':
> drivers/video/backlight/adp8870_bl.c:811:11: warning: 'reg_val' may be used uninitialized in this function
> 
> This changes the code to only write back the data if it was
> correctly read to start with.
> 
> As a side-note, the drivers are mostly identical, so I think they
> should really be merged into one file to avoid having to fix every
> bug twice.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied with the $SUBJECT line fixed.

> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 98ffe71e8af2..f0d4c0324580 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -621,10 +621,12 @@ static ssize_t adp8860_bl_ambient_light_zone_store(struct device *dev,
>  
>  		/* Set user supplied ambient light zone */
>  		mutex_lock(&data->lock);
> -		adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> -		reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -		adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		ret = adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> +			adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		}
>  		mutex_unlock(&data->lock);
>  	}
>  
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 9d738352d7d4..21acac90fd77 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -807,10 +807,12 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  
>  		/* Set user supplied ambient light zone */
>  		mutex_lock(&data->lock);
> -		adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> -		reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -		adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		ret = adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> +			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		}
>  		mutex_unlock(&data->lock);
>  	}
>  
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
