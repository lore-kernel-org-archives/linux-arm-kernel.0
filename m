From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 29 Mar 2012 11:32:28 -0500
Subject: [PATCH 3/3] ep93xx: Add IDE support to edb93xx boards
In-Reply-To: <4F741B3F.4000507@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741B3F.4000507@metasoft.pl>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206970255C3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 29, 2012 1:20 AM, Rafal Prylowski wrote:
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> ---
>  arch/arm/mach-ep93xx/edb93xx.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> Index: linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/edb93xx.c
> +++ linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
> @@ -233,6 +233,28 @@ static void __init edb93xx_register_fb(v
>  }
>  
>  
> +/*************************************************************************
> + * EDB93xx IDE
> + *************************************************************************/
> +static int __init edb93xx_has_ide(void)
> +{
> +	/*
> +	 * Although EDB9312 and EDB9315 do have IDE capability, they have
> +	 * INTRQ line wired as pull-up, which makes using IDE interface
> +	 * problematic.
> +	 */
> +	return machine_is_edb9315a();

Allow the driver to be loaded on the EDB9312 and EDB9315 but leave the comment.
If a use of these boards wishes to use the IDE they could remove the pull-up and add
a pull-down to their board.

> +}
> +
> +static void __init edb93xx_register_ide(void)
> +{
> +	if (!edb93xx_has_ide())
> +		return;
> +
> +	ep93xx_register_ide();
> +}
> +
> +
>  static void __init edb93xx_init_machine(void)
>  {
>  	ep93xx_init_devices();
> @@ -243,6 +265,7 @@ static void __init edb93xx_init_machine(
>  	edb93xx_register_i2s();
>  	edb93xx_register_pwm();
>  	edb93xx_register_fb();
> +	edb93xx_register_ide();
>  }

Regards,
Hartley

 
