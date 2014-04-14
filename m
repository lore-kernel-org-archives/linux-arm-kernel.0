From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Apr 2014 13:00:27 +0100
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree
 to PLL5
In-Reply-To: <1397119544.3226.6.camel@paszta.hi.pengutronix.de>
References: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
 <1397119544.3226.6.camel@paszta.hi.pengutronix.de>
Message-ID: <20140414120027.GH24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 10:45:44AM +0200, Philipp Zabel wrote:
> I fear this will break LVDS, which depends on being able to set this
> divisor manually (depending on whether it is in single or dual channel
> mode).
> I'd rather route the di clock inputs to the video pll via the
> ipu_di_pre_sel muxes:
> 
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -258,14 +258,14 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>         clk[ipu2_sel]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
>         clk[ldb_di0_sel]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_P
>         clk[ldb_di1_sel]      = imx_clk_mux_flags("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_P
> -       clk[ipu1_di0_pre_sel] = imx_clk_mux("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
> -       clk[ipu1_di1_pre_sel] = imx_clk_mux("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
> -       clk[ipu2_di0_pre_sel] = imx_clk_mux("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
> -       clk[ipu2_di1_pre_sel] = imx_clk_mux("ipu2_di1_pre_sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
> -       clk[ipu1_di0_sel]     = imx_clk_mux("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels));
> -       clk[ipu1_di1_sel]     = imx_clk_mux("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels));
> -       clk[ipu2_di0_sel]     = imx_clk_mux("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels));
> -       clk[ipu2_di1_sel]     = imx_clk_mux("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels));
> +       clk[ipu1_di0_pre_sel] = imx_clk_mux_flags("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_
> +       clk[ipu1_di1_pre_sel] = imx_clk_mux_flags("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_
> +       clk[ipu2_di0_pre_sel] = imx_clk_mux_flags("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_
> +       clk[ipu2_di1_pre_sel] = imx_clk_mux_flags("ipu2_di1_pre_sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_
> +       clk[ipu1_di0_sel]     = imx_clk_mux_flags("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels), CLK_SE
> +       clk[ipu1_di1_sel]     = imx_clk_mux_flags("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels), CLK_SE
> +       clk[ipu2_di0_sel]     = imx_clk_mux_flags("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels), CLK_SE
> +       clk[ipu2_di1_sel]     = imx_clk_mux_flags("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels), CLK_SE
>         clk[hsi_tx_sel]       = imx_clk_mux("hsi_tx_sel",       base + 0x30, 28, 1, hsi_tx_sels,       ARRAY_SIZE(hsi_tx_sels));
>         clk[pcie_axi_sel]     = imx_clk_mux("pcie_axi_sel",     base + 0x18, 10, 1, pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
>         clk[ssi1_sel]         = imx_clk_fixup_mux("ssi1_sel",   base + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),          imx_cscm
> @@ -445,6 +445,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>                 clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
>         }
>  
> +       clk_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
> +       clk_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
> +       clk_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
> +       clk_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
> +       clk_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
> +       clk_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
> +       clk_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
> +       clk_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
> +
>         /*
>          * The gpmi needs 100MHz frequency in the EDO/Sync mode,
>          * We can not get the 100MHz from the pll2_pfd0_352m.

If you'd like the above patch tested, please send the complete patch rather than a version with tabs converted to spaces, and lines longer tha

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
