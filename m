From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 16:24:45 +0800
Subject: [PATCH] ARM i.MX25: Make timer irq work again
In-Reply-To: <1347955531-31304-1-git-send-email-s.hauer@pengutronix.de>
References: <1347955531-31304-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120918082442.GE6377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 10:05:31AM +0200, Sascha Hauer wrote:
> Since i.MX has SPARSE_IRQ enabled the i.MX25 timer is broken. This
> is because the internal irqs now start at an offset of NR_IRQS_LEGACY.
> The patch fixed this up, but missed the i.MX25 timer which used a
> hardcoded value instead of a define. This patch introduces a define
> for the timer irq and uses it.
> 
> This is broken since introduced with 3.6-rc1:
> 
> | commit 8842a9e2869cae14bbb8184004a42fc3070587fb
> | Author: Shawn Guo <shawn.guo@linaro.org>
> | Date:   Thu Jun 14 11:16:14 2012 +0800
> |
> |    ARM: imx: enable SPARSE_IRQ for imx platform
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Yeah, just ran into the problem when trying to see the mx2_camera issue
(Javier reports) on imx25.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  arch/arm/mach-imx/clk-imx25.c         |    2 +-
>  arch/arm/plat-mxc/include/mach/mx25.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index fdd8cc8..0fc72fc 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -243,6 +243,6 @@ int __init mx25_clocks_init(void)
>  	clk_register_clkdev(clk[sdma_ahb], "ahb", "imx35-sdma");
>  	clk_register_clkdev(clk[iim_ipg], "iim", NULL);
>  
> -	mxc_timer_init(MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
> +	mxc_timer_init(MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), MX25_INT_GPT1);
>  	return 0;
>  }
> diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
> index 627d94f..ec46640 100644
> --- a/arch/arm/plat-mxc/include/mach/mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/mx25.h
> @@ -98,6 +98,7 @@
>  #define MX25_INT_UART1		(NR_IRQS_LEGACY + 45)
>  #define MX25_INT_GPIO2		(NR_IRQS_LEGACY + 51)
>  #define MX25_INT_GPIO1		(NR_IRQS_LEGACY + 52)
> +#define MX25_INT_GPT1		(NR_IRQS_LEGACY + 54)
>  #define MX25_INT_FEC		(NR_IRQS_LEGACY + 57)
>  
>  #define MX25_DMA_REQ_SSI2_RX1	22
> -- 
> 1.7.10.4
> 
