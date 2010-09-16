From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Thu, 16 Sep 2010 22:40:18 +0300
Subject: [PATCH v6 2/7] wl1271: propagate set_power's return value
In-Reply-To: <1284592929-29616-3-git-send-email-ohad@wizery.com>
References: <1284592929-29616-1-git-send-email-ohad@wizery.com>
	<1284592929-29616-3-git-send-email-ohad@wizery.com>
Message-ID: <1284666018.8951.66.camel@powerslave>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 01:22 +0200, ext Ohad Ben-Cohen wrote:
> Make it possible for the set power method to indicate a
> success/failure return value. This is needed to support
> more complex power on/off operations such as SDIO
> power manipulations.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Some comments below.


> diff --git a/drivers/net/wireless/wl12xx/wl1271_io.h b/drivers/net/wireless/wl12xx/wl1271_io.h
> index bc806c7..c1f92e6 100644
> --- a/drivers/net/wireless/wl12xx/wl1271_io.h
> +++ b/drivers/net/wireless/wl12xx/wl1271_io.h
> @@ -144,10 +144,13 @@ static inline void wl1271_power_off(struct wl1271 *wl)
>  	clear_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
>  }
>  
> -static inline void wl1271_power_on(struct wl1271 *wl)
> +static inline int wl1271_power_on(struct wl1271 *wl)
>  {
> -	wl->if_ops->power(wl, true);
> -	set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
> +	int ret = wl->if_ops->power(wl, true);

I think it look nicer if you keep the "int ret" in one line by itself
and then do a ret = wl->if_ops... on another one.


> +	if (ret == 0)
> +		set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
> +
> +	return ret;
>  }


> diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
> index b5d9565..1d5dc72 100644
> --- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
> +++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
> @@ -159,35 +159,38 @@ static void wl1271_sdio_raw_write(struct wl1271 *wl, int addr, void *buf,
>  		wl1271_error("sdio write failed (%d)", ret);
>  }
>  
> -static void wl1271_sdio_power_on(struct wl1271 *wl)
> +static int wl1271_sdio_power_on(struct wl1271 *wl)
>  {
>  	struct sdio_func *func = wl_to_func(wl);
>  
>  	sdio_claim_host(func);
>  	sdio_enable_func(func);
>  	sdio_release_host(func);
> +
> +	return 0;
>  }

You seem to always return 0, so the whole chain to pass the value up
seems unnecessary.  Is this just a preparation for a future patch?

-- 
Cheers,
Luca.
