From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 Jun 2012 23:54:06 +0200
Subject: [Patch v5 09/13] ARM: imx6q: add usbphy clocks
In-Reply-To: <1339590863-10564-10-git-send-email-richard.zhao@freescale.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-10-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120613215406.GF30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 08:34:19PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index f99509a..8c4166a 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -152,7 +152,7 @@ enum mx6q_clks {
>  	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
>  	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
>  	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
> -	ssi2_ipg, ssi3_ipg, clk_max
> +	ssi2_ipg, ssi3_ipg, usbphy1, usbphy2, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -197,6 +197,9 @@ int __init mx6q_clocks_init(void)
>  	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x2000,   0x3);
>  	clk[pll8_enet]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll8_enet",	"osc", base + 0xe0, 0x182000, 0x3);
>  
> +	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
> +	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
> +
>  	/*                                name              parent_name        reg       idx */
>  	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
>  	clk[pll2_pfd1_594m] = imx_clk_pfd("pll2_pfd1_594m", "pll2_bus",     base + 0x100, 1);
> @@ -395,6 +398,8 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
>  	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
>  	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
> +	clk_register_clkdev(clk[usbphy1], NULL, "20c9000.usbphy");
> +	clk_register_clkdev(clk[usbphy2], NULL, "20ca000.usbphy");

Could you recheck with your hardware guys which input clocks
this device really has. On earlier i.MX there are up to three
clocks this module needs. Sooner or later we want to use this driver on
the other i.MX aswell, and then we'll need support for the other clocks
here, no matter if they are software controllable on i.MX6 or not.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
