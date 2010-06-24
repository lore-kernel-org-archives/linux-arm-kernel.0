From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 21:56:45 +0900
Subject: [PATCH 1/2] ARM: S5PV210: Fix Aquila board UART FIFO mode
	configration
In-Reply-To: <1277354105-13097-1-git-send-email-jy0922.shim@samsung.com>
References: <1277354105-13097-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <012c01cb139c$b6967250$23c356f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> The Aquila board uses max UART FIFO size to each UART channels. UART0
> supports 256 bytes FIFO, but Aquila board supports 128 bytes FIFO
> because of initial chip bug.
> 
> Also, this patch fixes to "s/smdkv210/aquila".
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-aquila.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c
b/arch/arm/mach-s5pv210/mach-
> aquila.c
> index 10bc76e..5795a7c 100644
> --- a/arch/arm/mach-s5pv210/mach-aquila.c
> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
> @@ -39,38 +39,44 @@
> 
>  #define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
> 
> -#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
> -				 S5PV210_UFCON_TXTRIG4 |	\
> -				 S5PV210_UFCON_RXTRIG4)
> +#define S5PV210_UFCON_DEFAULT	S3C2410_UFCON_FIFOMODE
> 
I think it is better to change 'S5PV210_xxx_DEFAULT' to board specific name
later.

But right now, it's ok.

> -static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
> +static struct s3c2410_uartcfg aquila_uartcfgs[] __initdata = {
>  	[0] = {
>  		.hwport		= 0,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		/*
> +		 * Actually UART0 can support 256 bytes fifo, but aquila
board
> +		 * supports 128 bytes fifo because of initial chip bug
> +		 */
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG128 |
> S5PV210_UFCON_RXTRIG128,
>  	},
>  	[1] = {
>  		.hwport		= 1,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG64 |
> S5PV210_UFCON_RXTRIG64,
>  	},
>  	[2] = {
>  		.hwport		= 2,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG16 |
> S5PV210_UFCON_RXTRIG16,
>  	},
>  	[3] = {
>  		.hwport		= 3,
>  		.flags		= 0,
>  		.ucon		= S5PV210_UCON_DEFAULT,
>  		.ulcon		= S5PV210_ULCON_DEFAULT,
> -		.ufcon		= S5PV210_UFCON_DEFAULT,
> +		.ufcon		= S5PV210_UFCON_DEFAULT |
> +			S5PV210_UFCON_TXTRIG16 |
> S5PV210_UFCON_RXTRIG16,
>  	},
>  };
> 
> @@ -124,7 +130,7 @@ static void __init aquila_map_io(void)
>  {
>  	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
>  	s3c24xx_init_clocks(24000000);
> -	s3c24xx_init_uarts(smdkv210_uartcfgs,
> ARRAY_SIZE(smdkv210_uartcfgs));
> +	s3c24xx_init_uarts(aquila_uartcfgs, ARRAY_SIZE(aquila_uartcfgs));
>  }
> 
>  static void __init aquila_machine_init(void)
> --

Will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
