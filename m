From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Oct 2010 15:32:31 +0200
Subject: [PATCH] ARM: SAMSUNG: Fix on default of s3c24xx_uart_devs
In-Reply-To: <1286281736-29821-1-git-send-email-jc.lee@samsung.com>
References: <1286281736-29821-1-git-send-email-jc.lee@samsung.com>
Message-ID: <014301cb6491$c649ec40$52ddc4c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, October 05, 2010 2:29 PM Jaecheol Lee wrote:

> This patch adds default dev->bus, platform_bus_type of s3c24xx_uart_devs.
> If there is no default dev->bus, we cannot get the proper clock 'id' from
> clk_get() in the console_initcall().
> This problem occurs when only defined 'uclk1' as uart clock.
> 
> Reported-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-uart.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
> index 3776cd9..519e1bc 100644
> --- a/arch/arm/plat-samsung/dev-uart.c
> +++ b/arch/arm/plat-samsung/dev-uart.c
> @@ -19,18 +19,22 @@
> 
>  static struct platform_device s3c24xx_uart_device0 = {
>  	.id		= 0,
> +	.dev		= { .bus = &platform_bus_type },
>  };
> 
>  static struct platform_device s3c24xx_uart_device1 = {
>  	.id		= 1,
> +	.dev		= { .bus = &platform_bus_type },
>  };
> 
>  static struct platform_device s3c24xx_uart_device2 = {
>  	.id		= 2,
> +	.dev		= { .bus = &platform_bus_type },
>  };
> 
>  static struct platform_device s3c24xx_uart_device3 = {
>  	.id		= 3,
> +	.dev		= { .bus = &platform_bus_type },
>  };
> 
>  struct platform_device *s3c24xx_uart_src[4] = {

I've ran into the same problem and I considered the same approach to solve
this issue. However I found that such solution is an ugly hack rather a real
fix or workaround. Nobody can grant that platform device framework would
accept registering a device with .bus already set in the future version
of the kernel. This might also cause other strange problems in the future.

My proposition for a real workaround is in the patch named "[PATCH] ARM:
Samsung: add a workaround for get_clock() for serial driver" 
(see http://www.spinics.net/lists/linux-samsung-soc/msg03050.html ).

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
