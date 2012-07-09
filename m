From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Jul 2012 10:27:00 +0200
Subject: [PATCH 1/2] ARM: i.MX5x clocks: Add EPIT support
In-Reply-To: <1340780885-4094-1-git-send-email-shc_work@mail.ru>
References: <1340780885-4094-1-git-send-email-shc_work@mail.ru>
Message-ID: <20120709082700.GM24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Wed, Jun 27, 2012 at 11:08:04AM +0400, Alexander Shiyan wrote:
> This patch adds support for Enhanced Periodic Interrupt Timer (EPIT)
> to clock subsystem.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index a2200c7..2944854 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -81,6 +81,7 @@ enum imx5_clks {
>  	ssi1_root_podf, ssi2_root_pred, ssi2_root_podf, ssi_ext1_pred,
>  	ssi_ext1_podf, ssi_ext2_pred, ssi_ext2_podf, ssi1_root_gate,
>  	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
> +	epit1_ipg_gate, epit1_hf_gate, epit2_ipg_gate, epit2_hf_gate,
>  	clk_max
>  };
>  
> @@ -226,6 +227,10 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk[ssi3_root_gate] = imx_clk_gate2("ssi3_root_gate", "ssi3_root_sel", MXC_CCM_CCGR3, 26);
>  	clk[ssi_ext1_gate] = imx_clk_gate2("ssi_ext1_gate", "ssi_ext1_com_sel", MXC_CCM_CCGR3, 28);
>  	clk[ssi_ext2_gate] = imx_clk_gate2("ssi_ext2_gate", "ssi_ext2_com_sel", MXC_CCM_CCGR3, 30);
> +	clk[epit1_ipg_gate] = imx_clk_gate2("epit1_ipg_gate", "ipg", MXC_CCM_CCGR2, 2);
> +	clk[epit1_hf_gate] = imx_clk_gate2("epit1_hf_gate", "ipg", MXC_CCM_CCGR2, 4);
> +	clk[epit2_ipg_gate] = imx_clk_gate2("epit2_ipg_gate", "ipg", MXC_CCM_CCGR2, 6);
> +	clk[epit2_hf_gate] = imx_clk_gate2("epit2_hf_gate", "ipg", MXC_CCM_CCGR2, 8);

I just noticed this is wrong. The parent for the hf_gate is perclk_root,
not the ipg clock.

>  
>  	for (i = 0; i < ARRAY_SIZE(clk); i++)
>  		if (IS_ERR(clk[i]))
> @@ -279,6 +284,8 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_register_clkdev(clk[dummy], NULL, "imx-keypad");
>  	clk_register_clkdev(clk[tve_gate], NULL, "imx-tve.0");
>  	clk_register_clkdev(clk[ipu_di1_gate], "di1", "imx-tve.0");
> +	clk_register_clkdev(clk[epit1_ipg_gate], NULL, "imx-epit.0");
> +	clk_register_clkdev(clk[epit2_ipg_gate], NULL, "imx-epit.1");

Also, as the EPIT has two clocks you should register both:

	clk_register_clkdev(clk[epit1_ipg_gate], "ipg", "imx-epit.0");
	clk_register_clkdev(clk[epit1_hf_gate], "per", "imx-epit.0");

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
