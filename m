From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Jun 2013 16:02:39 +0530
Subject: [PATCH v2 1/5] ARM: davinci: uart: move to devid based clk_get
In-Reply-To: <1369729686-6595-2-git-send-email-prakash.pm@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
 <1369729686-6595-2-git-send-email-prakash.pm@ti.com>
Message-ID: <51B06547.8030709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prakash,

It appears that this patch was not tested thoroughly. See below:

On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
> For modules having single clock, clk_get should be done with dev_id.
> But current davinci implementation handles multiple instances
> of the UART devices with single platform_device_register. Hence clk_get
> is based on con_id rather than dev_id, this is not correct. Do
> platform_device_register for each instance and clk_get on dev_id.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---

> -static struct plat_serial8250_port da8xx_serial_pdata[] = {
> +static struct plat_serial8250_port da8xx_serial0_pdata[] = {
>  	{
>  		.mapbase	= DA8XX_UART0_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT0,
> @@ -75,7 +75,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  					UPF_IOREMAP,
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
> -	},
> +	}
> +};
> +static struct plat_serial8250_port da8xx_serial1_pdata[] = {
>  	{
>  		.mapbase	= DA8XX_UART1_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT1,
> @@ -83,7 +85,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  					UPF_IOREMAP,
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
> -	},
> +	}
> +};
> +static struct plat_serial8250_port da8xx_serial2_pdata[] = {
>  	{
>  		.mapbase	= DA8XX_UART2_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT2,
> @@ -91,18 +95,31 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  					UPF_IOREMAP,
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
> -	},
> -	{
> -		.flags	= 0,
> -	},
> +	}

8250_core.c relies on sentinel value with p->flags = 0 to terminate
looking for more ports. You don't have sentinel values in any of pdata
the arrays you introduced so the code basically goes looking into areas
of memory not its own. This caused bunch of "cannot register port"
errors for me but I can easily imagine more serious errors.

Thanks,
Sekhar
