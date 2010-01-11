From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 12 Jan 2010 08:42:50 +1300
Subject: [PATCH] ep93xx: register the pwm devices on the edb93xx dev boards
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090208990C@mi8nycmail19.Mi8.com>
References: <201001051508.41896.hartleys@visionengravers.com>
	<4B4A7A59.5080600@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE19090208990C@mi8nycmail19.Mi8.com>
Message-ID: <4B4B7F3A.1020009@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> ep93xx: register the pwm devices on the edb93xx dev boards
> 
> Add the platform init code to register the pwm devices that exist
> on the various edb93xx development boards.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> V2 - fix 'if/else if' typo spotted by Ryan Mallon.
> 
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
> index a4a7be3..d22d67a 100644
> --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -118,12 +118,33 @@ static void __init edb93xx_register_i2c(void)
>  	}
>  }
>  
> +
> +/*************************************************************************
> + * EDB93xx pwm
> + *************************************************************************/
> +static void __init edb93xx_register_pwm(void)
> +{
> +	if (machine_is_edb9301() ||
> +	    machine_is_edb9302() || machine_is_edb9302a()) {
> +		/* EP9301 and EP9302 only have pwm.1 (EGPIO14) */
> +		ep93xx_register_pwm(0, 1);
> +	} else if (machine_is_edb9307() || machine_is_edb9307a()) {
> +		/* EP9307 only has pwm.0 (PWMOUT) */
> +		ep93xx_register_pwm(1, 0);
> +	} else {
> +		/* EP9312 and EP9315 have both */
> +		ep93xx_register_pwm(1, 1);
> +	}
> +}
> +
> +
>  static void __init edb93xx_init_machine(void)
>  {
>  	ep93xx_init_devices();
>  	edb93xx_register_flash();
>  	ep93xx_register_eth(&edb93xx_eth_data, 1);
>  	edb93xx_register_i2c();
> +	edb93xx_register_pwm();
>  }
>  
>  

Looks good.

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
