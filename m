From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 May 2018 15:02:26 +0200
Subject: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
In-Reply-To: <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <c42c4274cfd06297d1699c96d3253125@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.05.2018 03:01, Anson Huang wrote:
> Correct enet clock gates as below:
> 
> CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
> CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
> CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
> 
> Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
> IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.

Are you sure that IMX7D_ENETx_REF_ROOT_CLK are not used?

I understand that the reference manual does not a gate at 0x44e0...

But in a earlier revision of our Colibri iMX7 we actually used clock
out, and referenced this clock to enable the reference clock (see also:
https://patchwork.kernel.org/patch/9211371/).

I guess if the gate really does not exist, then we should/would have to
set IMX7D_ENET1_REF_ROOT_DIV to use the SoC provided ref clock.

--
Stefan

> 
> Based on Andy Duan's patch from the NXP kernel tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c             | 10 ++++++----
>  include/dt-bindings/clock/imx7d-clock.h |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 23d5090a..d4936b9 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -26,6 +26,8 @@ static u32 share_count_sai1;
>  static u32 share_count_sai2;
>  static u32 share_count_sai3;
>  static u32 share_count_nand;
> +static u32 share_count_enet1;
> +static u32 share_count_enet2;
>  
>  static const struct clk_div_table test_div_table[] = {
>  	{ .val = 3, .div = 1, },
> @@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk",
> "mipi_dsi_post_div", base + 0x4650, 0);
>  	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk",
> "mipi_csi_post_div", base + 0x4640, 0);
>  	clks[IMX7D_MIPI_DPHY_ROOT_CLK] = imx_clk_gate4("mipi_dphy_root_clk",
> "mipi_dphy_post_div", base + 0x4660, 0);
> +	clks[IMX7D_ENET1_IPG_ROOT_CLK] =
> imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base
> + 0x4700, 0, &share_count_enet1);
> +	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div",
> base + 0x4700, 0, &share_count_enet1);
> +	clks[IMX7D_ENET2_IPG_ROOT_CLK] =
> imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base
> + 0x4710, 0, &share_count_enet2);
> +	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div",
> base + 0x4710, 0, &share_count_enet2);
>  	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk",
> "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
>  	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk", 
> "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
>  	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk",
> "sai2_post_div", base + 0x48d0, 0, &share_count_sai2);
> @@ -812,10 +818,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk",
> "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
>  	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk", 
> "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
>  	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk",
> "spdif_post_div", base + 0x44d0, 0);
> -	clks[IMX7D_ENET1_REF_ROOT_CLK] = imx_clk_gate4("enet1_ref_root_clk",
> "enet1_ref_post_div", base + 0x44e0, 0);
> -	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base +
> 0x44f0, 0);
> -	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk",
> "enet2_ref_post_div", base + 0x4500, 0);
> -	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base +
> 0x4510, 0);
>  	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
> "eim_post_div", base + 0x4160, 0);
>  	clks[IMX7D_NAND_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base +
> 0x4140, 0, &share_count_nand);
>  	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk",
> base + 0x4140, 0, &share_count_nand);
> diff --git a/include/dt-bindings/clock/imx7d-clock.h
> b/include/dt-bindings/clock/imx7d-clock.h
> index b2325d3e2..0d67f53 100644
> --- a/include/dt-bindings/clock/imx7d-clock.h
> +++ b/include/dt-bindings/clock/imx7d-clock.h
> @@ -168,7 +168,7 @@
>  #define IMX7D_SPDIF_ROOT_SRC		155
>  #define IMX7D_SPDIF_ROOT_CG		156
>  #define IMX7D_SPDIF_ROOT_DIV		157
> -#define IMX7D_ENET1_REF_ROOT_CLK	158
> +#define IMX7D_ENET1_IPG_ROOT_CLK        158
>  #define IMX7D_ENET1_REF_ROOT_SRC	159
>  #define IMX7D_ENET1_REF_ROOT_CG		160
>  #define IMX7D_ENET1_REF_ROOT_DIV	161
> @@ -176,7 +176,7 @@
>  #define IMX7D_ENET1_TIME_ROOT_SRC	163
>  #define IMX7D_ENET1_TIME_ROOT_CG	164
>  #define IMX7D_ENET1_TIME_ROOT_DIV	165
> -#define IMX7D_ENET2_REF_ROOT_CLK	166
> +#define IMX7D_ENET2_IPG_ROOT_CLK        166
>  #define IMX7D_ENET2_REF_ROOT_SRC	167
>  #define IMX7D_ENET2_REF_ROOT_CG		168
>  #define IMX7D_ENET2_REF_ROOT_DIV	169
