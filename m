From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 13 Nov 2014 10:52:04 +0800
Subject: [PATCH] clk: rockchip: ensure HCLK_VIO2_H2P and PCLK_VIO2_H2P
 stay enabled
In-Reply-To: <20141112213845.GA14153@dtor-ws>
References: <20141112213845.GA14153@dtor-ws>
Message-ID: <54641CD4.9070901@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 11/13/2014 05:38 AM, Dmitry Torokhov wrote:
> Currently there is no driver owning these clocks and they have to stay
> up for the system to function properly, so let's mark them as
> CLK_IGNORE_UNUSED.
>
> Without this patch we have trouble with suspend/resume and we have
> trouble turning the eDP back on if it ever idles off.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>   drivers/clk/rockchip/clk-rk3288.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 2327829..d79d52f 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -724,14 +724,14 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>   	GATE(HCLK_VIP, "hclk_vip", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 15, GFLAGS),
>   	GATE(HCLK_IEP, "hclk_iep", "hclk_vio", 0, RK3288_CLKGATE_CON(15), 3, GFLAGS),
>   	GATE(HCLK_ISP, "hclk_isp", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 1, GFLAGS),
> -	GATE(HCLK_VIO2_H2P, "hclk_vio2_h2p", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 10, GFLAGS),
> +	GATE(HCLK_VIO2_H2P, "hclk_vio2_h2p", "hclk_vio", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(16), 10, GFLAGS),
>   	GATE(PCLK_MIPI_DSI0, "pclk_mipi_dsi0", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 4, GFLAGS),
>   	GATE(PCLK_MIPI_DSI1, "pclk_mipi_dsi1", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 5, GFLAGS),
>   	GATE(PCLK_MIPI_CSI, "pclk_mipi_csi", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 6, GFLAGS),
>   	GATE(PCLK_LVDS_PHY, "pclk_lvds_phy", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 7, GFLAGS),
>   	GATE(PCLK_EDP_CTRL, "pclk_edp_ctrl", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 8, GFLAGS),
>   	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 9, GFLAGS),
> -	GATE(PCLK_VIO2_H2P, "pclk_vio2_h2p", "hclk_vio", 0, RK3288_CLKGATE_CON(16), 11, GFLAGS),
> +	GATE(PCLK_VIO2_H2P, "pclk_vio2_h2p", "hclk_vio", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(16), 11, GFLAGS),
>   
>   	/* aclk_vio0 gates */
>   	GATE(ACLK_VOP0, "aclk_vop0", "aclk_vio0", 0, RK3288_CLKGATE_CON(15), 5, GFLAGS),
The H/PCLK_VIO2_H2P is some kind of bus clock for a ahb2apb bridge 
inside the VIO,
it should be on when some of VIO logic is working, but it is not easy to 
assign these
two clocks to module driver. I think it is reasonable to mark with 
CLK_IGNORE_UNUSED
tag so far.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
