From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 29 Oct 2018 15:49:18 +0100
Subject: [RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
In-Reply-To: <20181023092025.32463-2-tudor.ambarus@microchip.com>
References: <20181023092025.32463-1-tudor.ambarus@microchip.com>
 <20181023092025.32463-2-tudor.ambarus@microchip.com>
Message-ID: <20181029144918.3iukhksa522xna2e@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 11:20:39AM +0200, Tudor Ambarus - M18064 wrote:
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in the device tree, the buses __usually__ assume it's 100kHZ
> (see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
> clock-frequency, so the default clock frequency varies from bus to bus.
> 
> There are i2c clients that need to know the bus clock frequency in order to
> compute their wake token (see atecc508a i2c client).
> 
> The clock-frequency value has to be propagated to the i2c clients, otherwise,
> if they will not find the i2c bus clock frequency in the device tree, they
> will have to make their own assumption of the clock frequency.
> 
> Spare the i2c clients of making wrong assumptions of the i2c bus clock
> frequency and enable the buses to save their clock frequency in adapter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviwed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  include/linux/i2c.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..f238da204c49 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -677,6 +677,7 @@ struct i2c_adapter {
>  	struct rt_mutex bus_lock;
>  	struct rt_mutex mux_lock;
>  
> +	u32 bus_freq_hz;
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> -- 
> 2.9.4
> 
