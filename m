From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 08:24:23 +0200
Subject: [PATCH v2 2/2] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <1403529927-13868-2-git-send-email-denis@eukrea.com>
References: <1403529927-13868-1-git-send-email-denis@eukrea.com>
 <1403529927-13868-2-git-send-email-denis@eukrea.com>
Message-ID: <20140625062423.GH15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:25:27PM +0200, Denis Carikli wrote:
> Replace .init_time() hook with of_clk_init() for DT targets.
> 
> Based on:
>   d4347ee ARM: i.MX27 clk: Use of_clk_init() for DT case
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - Rebased.
> - Removing the warning about the useless int i declaration.
> ---
>  arch/arm/mach-imx/clk-imx25.c |  287 +++++++++++++++++++++--------------------
>  arch/arm/mach-imx/common.h    |    1 -
>  arch/arm/mach-imx/imx25-dt.c  |    6 -
>  3 files changed, 144 insertions(+), 150 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index e759a6d..49ab1d6 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -32,31 +32,29 @@
>  #include "hardware.h"
>  #include "mx25.h"
>  
> -#define CRM_BASE	MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
> +static void __iomem *ccm __initdata;
>  
> -#define CCM_MPCTL	0x00
> -#define CCM_UPCTL	0x04
> -#define CCM_CCTL	0x08
> -#define CCM_CGCR0	0x0C
> -#define CCM_CGCR1	0x10
> -#define CCM_CGCR2	0x14
> -#define CCM_PCDR0	0x18
> -#define CCM_PCDR1	0x1C
> -#define CCM_PCDR2	0x20
> -#define CCM_PCDR3	0x24
> -#define CCM_RCSR	0x28
> -#define CCM_CRDR	0x2C
> -#define CCM_DCVR0	0x30
> -#define CCM_DCVR1	0x34
> -#define CCM_DCVR2	0x38
> -#define CCM_DCVR3	0x3c
> -#define CCM_LTR0	0x40
> -#define CCM_LTR1	0x44
> -#define CCM_LTR2	0x48
> -#define CCM_LTR3	0x4c
> -#define CCM_MCR		0x64
> -
> -#define ccm(x)	(CRM_BASE + (x))
> +#define CCM_MPCTL	(ccm + 0x00)
> +#define CCM_UPCTL	(ccm + 0x04)
> +#define CCM_CCTL	(ccm + 0x08)
> +#define CCM_CGCR0	(ccm + 0x0C)
> +#define CCM_CGCR1	(ccm + 0x10)
> +#define CCM_CGCR2	(ccm + 0x14)
> +#define CCM_PCDR0	(ccm + 0x18)
> +#define CCM_PCDR1	(ccm + 0x1C)
> +#define CCM_PCDR2	(ccm + 0x20)
> +#define CCM_PCDR3	(ccm + 0x24)
> +#define CCM_RCSR	(ccm + 0x28)
> +#define CCM_CRDR	(ccm + 0x2C)
> +#define CCM_DCVR0	(ccm + 0x30)
> +#define CCM_DCVR1	(ccm + 0x34)
> +#define CCM_DCVR2	(ccm + 0x38)
> +#define CCM_DCVR3	(ccm + 0x3c)
> +#define CCM_LTR0	(ccm + 0x40)
> +#define CCM_LTR1	(ccm + 0x44)
> +#define CCM_LTR2	(ccm + 0x48)
> +#define CCM_LTR3	(ccm + 0x4c)
> +#define CCM_MCR		(ccm + 0x64)
>  
>  static struct clk_onecell_data clk_data;
>  
> @@ -93,134 +91,136 @@ static struct clk *clk[clk_max];
>  
>  static int __init __mx25_clocks_init(unsigned long osc_rate)
>  {
> +	BUG_ON(!ccm);
> +
>  	clk[dummy] = imx_clk_fixed("dummy", 0);
>  	clk[osc] = imx_clk_fixed("osc", osc_rate);
> -	clk[mpll] = imx_clk_pllv1("mpll", "osc", ccm(CCM_MPCTL));
> -	clk[upll] = imx_clk_pllv1("upll", "osc", ccm(CCM_UPCTL));
> +	clk[mpll] = imx_clk_pllv1("mpll", "osc", CCM_MPCTL);
> +	clk[upll] = imx_clk_pllv1("upll", "osc", CCM_UPCTL);

This huge diffstat could be avoided by doing:

#define ccm(x)	((ccm_base) + (x))

And passing ccm_base as argument to __mx25_clocks_init.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
