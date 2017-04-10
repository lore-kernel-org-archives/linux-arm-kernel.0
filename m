From: stefan@agner.ch (Stefan Agner)
Date: Mon, 10 Apr 2017 09:50:43 -0700
Subject: [PATCH 1/2] clk: clk-imx7d: fix ahb clk definition
In-Reply-To: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
References: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <04f76039b582a75d33e4142333d3a37f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-10 19:37, Dong Aisheng wrote:
> MX7D ahb clk actually has no LPCG gate, current LPCG offset 0x4200
> used actually is for adc, not ahb. After fix, correct ocram_s_clk
> parent accordingly as well.

Reviewed-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>

> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index ae1d31b..ad04483 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -725,7 +725,7 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_DISP_AXI_ROOT_DIV] =
> imx_clk_divider2("disp_axi_post_div", "disp_axi_pre_div", base +
> 0x8880, 0, 6);
>  	clks[IMX7D_ENET_AXI_ROOT_DIV] =
> imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base +
> 0x8900, 0, 6);
>  	clks[IMX7D_NAND_USDHC_BUS_ROOT_DIV] =
> imx_clk_divider2("nand_usdhc_post_div", "nand_usdhc_pre_div", base +
> 0x8980, 0, 6);
> -	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_post_div",
> "ahb_pre_div", base + 0x9000, 0, 6);
> +	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk",
> "ahb_pre_div", base + 0x9000, 0, 6);
>  	clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div",
> "dram_cg", base + 0x9880, 0, 3);
>  	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] =
> imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div",
> base + 0xa000, 0, 3);
>  	clks[IMX7D_DRAM_ALT_ROOT_DIV] =
> imx_clk_divider2("dram_alt_post_div", "dram_alt_pre_div", base +
> 0xa080, 0, 3);
> @@ -796,9 +796,8 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk",
> "disp_axi_post_div", base + 0x4050, 0);
>  	clks[IMX7D_ENET_AXI_ROOT_CLK] = imx_clk_gate4("enet_axi_root_clk",
> "enet_axi_post_div", base + 0x4060, 0);
>  	clks[IMX7D_OCRAM_CLK] = imx_clk_gate4("ocram_clk", "axi_post_div",
> base + 0x4110, 0);
> -	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk",
> "ahb_post_div", base + 0x4120, 0);
> +	clks[IMX7D_OCRAM_S_CLK] = imx_clk_gate4("ocram_s_clk",
> "ahb_root_clk", base + 0x4120, 0);
>  	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] =
> imx_clk_gate4("nand_usdhc_root_clk", "nand_usdhc_post_div", base +
> 0x4130, 0);
> -	clks[IMX7D_AHB_CHANNEL_ROOT_CLK] = imx_clk_gate4("ahb_root_clk",
> "ahb_post_div", base + 0x4200, 0);
>  	clks[IMX7D_DRAM_ROOT_CLK] = imx_clk_gate4("dram_root_clk",
> "dram_post_div", base + 0x4130, 0);
>  	clks[IMX7D_DRAM_PHYM_ROOT_CLK] = imx_clk_gate4("dram_phym_root_clk",
> "dram_phym_cg", base + 0x4130, 0);
>  	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] =
> imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div", base
> + 0x4130, 0);
