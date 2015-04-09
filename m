From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 9 Apr 2015 21:25:57 +0200
Subject: [patch 2/2] leds: netxbig: clean up a data type issue
In-Reply-To: <20150409090712.GF17605@mwanda>
References: <20150409090712.GF17605@mwanda>
Message-ID: <20150409192557.GD1509@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 12:07:12PM +0300, Dan Carpenter wrote:
> This driver is pretty hardware specific so it's unlikely that we're
> going to be using it on 64 big endian systems.  Still, the current code
> causes a static checker warning so we may as well change the type from
> "unsigned long" to "u32" and remove the casting.

Hi Dan,

Thanks for the patch.

Why do you think it would be an issue to use the u32 type for this
variables on a 64-bit big-endian machine ? Note that this LED mechanism
is actually used on ARM 32-bits and x86-64 NAS platforms. The latter are
not mainlined yet. But indeed, for now, there is no plan to use it on a
64-bit big-endian machine.

Since the whole LED code uses the unsigned long type to hold the delay
values, if possible, I would prefer to keep the delay_{on,off} variables
consistent with that.

Is there an another way to make the "static checker" happy ?

Thanks,

Simon

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/include/linux/platform_data/leds-kirkwood-netxbig.h b/include/linux/platform_data/leds-kirkwood-netxbig.h
> index d2be19a..bbd1d99 100644
> --- a/include/linux/platform_data/leds-kirkwood-netxbig.h
> +++ b/include/linux/platform_data/leds-kirkwood-netxbig.h
> @@ -29,9 +29,9 @@ enum netxbig_led_mode {
>  #define NETXBIG_LED_INVALID_MODE NETXBIG_LED_MODE_NUM
>  
>  struct netxbig_led_timer {
> -	unsigned long		delay_on;
> -	unsigned long		delay_off;
> -	enum netxbig_led_mode	mode;
> +	u32 delay_on;
> +	u32 delay_off;
> +	enum netxbig_led_mode mode;
>  };
>  
>  struct netxbig_led {
> diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
> index d0b743c..3da87be 100644
> --- a/drivers/leds/leds-netxbig.c
> +++ b/drivers/leds/leds-netxbig.c
> @@ -447,9 +447,9 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
>  			of_property_read_u32_index(np, "timers", 3 * i,
>  						&timers[i].mode);
>  			of_property_read_u32_index(np, "timers", 3 * i + 1,
> -						(u32 *) &timers[i].delay_on);
> +						   &timers[i].delay_on);
>  			of_property_read_u32_index(np, "timers", 3 * i + 2,
> -						(u32 *) &timers[i].delay_off);
> +						   &timers[i].delay_off);
>  		}
>  		pdata->timer = timers;
>  		pdata->num_timer = num_timers;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/a1670a56/attachment.sig>
