From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 14:26:16 +0000
Subject: [PATCH 3/3] ARM: PXA27x: Zipit Z2: disable wake on GPIO0
In-Reply-To: <1330264062-5750-3-git-send-email-anarsoul@gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-3-git-send-email-anarsoul@gmail.com>
Message-ID: <20120226142616.GM22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 04:47:42PM +0300, Vasily Khoruzhick wrote:
> We don't want machine to wake up on AC state change

NAK.  Stop polluting the machine callback methods.  Use the right one.

> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/z2.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 0fb5617..bb672ee 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -746,6 +746,13 @@ static void z2_power_off(void)
>  #define z2_power_off   NULL
>  #endif
>  
> +static void __init z2_map_io(void)
> +{
> +	pxa27x_map_io();
> +
> +	PWER &= ~(1 << 0);
> +}
> +
>  /******************************************************************************
>   * Machine init
>   ******************************************************************************/
> @@ -776,7 +783,7 @@ static void __init z2_init(void)
>  
>  MACHINE_START(ZIPIT2, "Zipit Z2")
>  	.atag_offset	= 0x100,
> -	.map_io		= pxa27x_map_io,
> +	.map_io		= z2_map_io,
>  	.init_irq	= pxa27x_init_irq,
>  	.handle_irq	= pxa27x_handle_irq,
>  	.timer		= &pxa_timer,
> -- 
> 1.7.9.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
