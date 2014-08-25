From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Aug 2014 18:41:24 +0200
Subject: [PATCH] i2c: mv64xxx: continue probe when clock-frequency is
 missing
In-Reply-To: <1408981819-3477-1-git-send-email-wens@csie.org>
References: <1408981819-3477-1-git-send-email-wens@csie.org>
Message-ID: <20140825164124.GA22771@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 11:50:19PM +0800, Chen-Yu Tsai wrote:
> The "clock-frequency" DT property is listed as optional, However,
> the current code stores the return value of of_property_read_u32 in
> the return code of mv64xxx_of_config, but then forgets to clear it
> after setting the default value of "clock-frequency". It is then
> passed out to the main probe function, resulting in a probe failure
> when "clock-frequency" is missing.
> 
> This patch checks and then throws away the result of
> of_property_read_u32, instead of storing it and having to clear it
> afterwards.
> 
> This issue was discovered after the property was removed from all
> sunxi DTs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Cc: stable at vger.kernel.org

It would be good to add

Fixes: 4c730a06c19bb ("i2c: mv64xxx: Set bus frequency to 100kHz if clock-frequency is not provided")

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew


> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 6dc5ded..2f64273 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -746,8 +746,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	}
>  	tclk = clk_get_rate(drv_data->clk);
>  
> -	rc = of_property_read_u32(np, "clock-frequency", &bus_freq);
> -	if (rc)
> +	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
>  		bus_freq = 100000; /* 100kHz by default */
>  
>  	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
