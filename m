From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Sep 2016 08:14:37 +0800
Subject: [PATCH 1/2] clk: imx6: fix i.MX6DL clock tree to reflect reality
In-Reply-To: <1474017371-28966-1-git-send-email-l.stach@pengutronix.de>
References: <1474017371-28966-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160918001437.GB15478@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Can you please help review/confirm the following clock tree changes
for i.MX6DL?  Thanks.

Shawn

On Fri, Sep 16, 2016 at 11:16:10AM +0200, Lucas Stach wrote:
> The current clock tree only implements the minimal set of differences
> between the i.MX6Q and the i.MX6DL, but that doesn't really reflect
> reality.
> 
> Apply the following fixes to match the RM:
> - DL has no GPU3D_SHADER_SEL/PODF, the shader domain is clocked by
>   GPU3D_CORE
> - GPU3D_SHADER_SEL/PODF has been repurposed as GPU2D_CORE_SEL/PODF
> - GPU2D_CORE_SEL/PODF has been repurposed as MLB_SEL/PODF
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/clk/imx/clk-imx6q.c               | 28 ++++++++++++++++------------
>  include/dt-bindings/clock/imx6qdl-clock.h |  4 +++-
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index ba1c1ae72ac2..64c243173395 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -318,11 +318,16 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		clk[IMX6QDL_CLK_IPG_PER_SEL] = imx_clk_mux("ipg_per_sel", base + 0x1c, 6, 1, ipg_per_sels, ARRAY_SIZE(ipg_per_sels));
>  		clk[IMX6QDL_CLK_UART_SEL] = imx_clk_mux("uart_sel", base + 0x24, 6, 1, uart_sels, ARRAY_SIZE(uart_sels));
>  		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] = imx_clk_mux("gpu2d_core_sel", base + 0x18, 16, 2, gpu2d_core_sels_2, ARRAY_SIZE(gpu2d_core_sels_2));
> +	} else if (clk_on_imx6dl()) {
> +		clk[IMX6QDL_CLK_MLB_SEL] = imx_clk_mux("mlb_sel",   base + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
>  	} else {
>  		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] = imx_clk_mux("gpu2d_core_sel",   base + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
>  	}
>  	clk[IMX6QDL_CLK_GPU3D_CORE_SEL]   = imx_clk_mux("gpu3d_core_sel",   base + 0x18, 4,  2, gpu3d_core_sels,   ARRAY_SIZE(gpu3d_core_sels));
> -	clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
> +	if (clk_on_imx6dl())
> +		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] = imx_clk_mux("gpu2d_core_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
> +	else
> +		clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
>  	clk[IMX6QDL_CLK_IPU1_SEL]         = imx_clk_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
>  	clk[IMX6QDL_CLK_IPU2_SEL]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
>  	clk[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
> @@ -400,9 +405,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		clk[IMX6QDL_CLK_LDB_DI0_DIV_3_5] = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
>  		clk[IMX6QDL_CLK_LDB_DI1_DIV_3_5] = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
>  	}
> -	clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
> +	if (clk_on_imx6dl())
> +		clk[IMX6QDL_CLK_MLB_PODF]  = imx_clk_divider("mlb_podf",  "mlb_sel",    base + 0x18, 23, 3);
> +	else
> +		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
>  	clk[IMX6QDL_CLK_GPU3D_CORE_PODF]  = imx_clk_divider("gpu3d_core_podf",  "gpu3d_core_sel",    base + 0x18, 26, 3);
> -	clk[IMX6QDL_CLK_GPU3D_SHADER]     = imx_clk_divider("gpu3d_shader",     "gpu3d_shader_sel",  base + 0x18, 29, 3);
> +	if (clk_on_imx6dl())
> +		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",     "gpu2d_core_sel",  base + 0x18, 29, 3);
> +	else
> +		clk[IMX6QDL_CLK_GPU3D_SHADER]     = imx_clk_divider("gpu3d_shader",     "gpu3d_shader_sel",  base + 0x18, 29, 3);
>  	clk[IMX6QDL_CLK_IPU1_PODF]        = imx_clk_divider("ipu1_podf",        "ipu1_sel",          base + 0x3c, 11, 3);
>  	clk[IMX6QDL_CLK_IPU2_PODF]        = imx_clk_divider("ipu2_podf",        "ipu2_sel",          base + 0x3c, 16, 3);
>  	clk[IMX6QDL_CLK_LDB_DI0_PODF]     = imx_clk_divider_flags("ldb_di0_podf", "ldb_di0_div_3_5", base + 0x20, 10, 1, 0);
> @@ -473,14 +484,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
>  	clk[IMX6QDL_CLK_GPT_IPG]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
>  	clk[IMX6QDL_CLK_GPT_IPG_PER]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
> -	if (clk_on_imx6dl())
> -		/*
> -		 * The multiplexer and divider of imx6q clock gpu3d_shader get
> -		 * redefined/reused as gpu2d_core_sel and gpu2d_core_podf on imx6dl.
> -		 */
> -		clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu3d_shader", base + 0x6c, 24);
> -	else
> -		clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu2d_core_podf", base + 0x6c, 24);
> +	clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu2d_core_podf", base + 0x6c, 24);
>  	clk[IMX6QDL_CLK_GPU3D_CORE]   = imx_clk_gate2("gpu3d_core",    "gpu3d_core_podf",   base + 0x6c, 26);
>  	clk[IMX6QDL_CLK_HDMI_IAHB]    = imx_clk_gate2("hdmi_iahb",     "ahb",               base + 0x70, 0);
>  	clk[IMX6QDL_CLK_HDMI_ISFR]    = imx_clk_gate2("hdmi_isfr",     "video_27m",         base + 0x70, 4);
> @@ -511,7 +515,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  		 * The multiplexer and divider of the imx6q clock gpu2d get
>  		 * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
>  		 */
> -		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "gpu2d_core_podf",   base + 0x74, 18);
> +		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "mlb_podf",   base + 0x74, 18);
>  	else
>  		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
>  	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
> index 29050337d9d5..da59fd9cdb5e 100644
> --- a/include/dt-bindings/clock/imx6qdl-clock.h
> +++ b/include/dt-bindings/clock/imx6qdl-clock.h
> @@ -269,6 +269,8 @@
>  #define IMX6QDL_CLK_PRG0_APB			256
>  #define IMX6QDL_CLK_PRG1_APB			257
>  #define IMX6QDL_CLK_PRE_AXI			258
> -#define IMX6QDL_CLK_END				259
> +#define IMX6QDL_CLK_MLB_SEL			259
> +#define IMX6QDL_CLK_MLB_PODF			260
> +#define IMX6QDL_CLK_END				261
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
> -- 
> 2.8.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
