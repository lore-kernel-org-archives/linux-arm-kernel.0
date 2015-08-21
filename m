From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 21 Aug 2015 20:24:25 +0200
Subject: [PATCH] clk: rockchip: Add pclk_peri to critical clocks on
 RK3066/RK3188
In-Reply-To: <1440180627-4566-1-git-send-email-romain.perier@gmail.com>
References: <1440180627-4566-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1855234.LF6EVPIbW1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

Am Freitag, 21. August 2015, 18:10:27 schrieb Romain Perier:
> Clocks for bank GPIO3 and GPIO4 are supplied by pclk_peri. These clocks need
> to stay on, otherwise pinctrl hangs the system when the driver is probed.

I don't agree with the commit message.

The issue you see does not originate from the pinctrl driver itself. Instead 
only the new flexible clock handling causes some other (still unhandled) 
component reyling on pclk_peri to hang the system.

In the past the clocks for the gpio banks were simply enabled once during 
probe, so pclk_peri as parent clock would also stay enabled for eternity. Now 
we enable the gpio clocks only when necessary, which results in that pclk_peri 
might get disabled too when no other component has claimed it - hence its 
addition to critical clocks.

Also, please note that Stephen Boyd is now also clock maintainer.


> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  drivers/clk/rockchip/clk-rk3188.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> b/drivers/clk/rockchip/clk-rk3188.c index f63a642..596be81 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -717,6 +717,7 @@ static const char *const rk3188_critical_clocks[]
> __initconst = { "aclk_peri",
>  	"hclk_peri",
>  	"pclk_cpu",
> +	"pclk_peri",
>  };
> 
>  static void __init rk3188_common_clk_init(struct device_node *np)
