From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 11 Mar 2014 12:42:08 +0100
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140311034607.GA26502@S2101-09.ap.freescale.net>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
Message-ID: <1394538128.3772.15.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Dienstag, den 11.03.2014, 11:46 +0800 schrieb Shawn Guo:
> On Wed, Mar 05, 2014 at 10:20:51AM +0100, Philipp Zabel wrote:
> > Hi,
> > 
> > this latest version of the imx-drm DT binding patches applies
> > on top of staging-next and also depends on the OF graph binding
> > patchset that moves the v4l2_of helpers to drivers/of.
> > Currently, the two patchsets are also available at:
> >     git://git.pengutronix.de/git/pza/linux.git topic/of-graph
> >     git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt
> 
> Hi Philipp,
> 
> I just came across a couple problems when testing the series on
> my imx6dl-sabresd board in dual display case - HDMI + LVDS.  I tested it
> using Russell's branch below, which I believe has all the pieces put
> together.
> 
>   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
> 
> - When I enable HDMI and LVDS support in both kernel build and device
>   tree, HDMI seems working fine but LVDS color is corrupted quite badly.
> 
> - When I enable HDMI and LVDS support in kernel build but only LVDS in
>   device tree (keep HDMI disabled in device tree by not changing
>   'status' of HDMI node to 'okay'), LVDS does not even work.  In this
>   case, it seems that the binding of display-subsystem does not succeed.

Can you check if you get the bound messages from
drivers/base/component.c:

imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)

I have tried this branch with a Phytec phyFLEX i.MX6S on PBAB01
baseboard with EDT 800x480 LVDS panel, and it seems to work.
The check in drivers/staging/imx-drm/imx-drm-core.c:675 should make sure
that unavailable (status="disabled") devices are just skipped.

> Please confirm if they are real problems or I'm missing something here.

If the devices are bound, can you check in debugfs whether the panel
(ldb_di) clock is set correctly?
I wonder if Russell's DI code makes a decision that the panel clock
can't be supported from the IPU internal clock. Then you'd need
something like this to allow setting the video PLL:

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f6c5af5..f9b90e7 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -258,14 +258,14 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[ipu2_sel]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[ldb_di0_sel]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
 	clk[ldb_di1_sel]      = imx_clk_mux_flags("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
-	clk[ipu1_di0_pre_sel] = imx_clk_mux("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
-	clk[ipu1_di1_pre_sel] = imx_clk_mux("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
-	clk[ipu2_di0_pre_sel] = imx_clk_mux("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
-	clk[ipu2_di1_pre_sel] = imx_clk_mux("ipu2_di1_pre_sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
-	clk[ipu1_di0_sel]     = imx_clk_mux("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels));
-	clk[ipu1_di1_sel]     = imx_clk_mux("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels));
-	clk[ipu2_di0_sel]     = imx_clk_mux("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels));
-	clk[ipu2_di1_sel]     = imx_clk_mux("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels));
+	clk[ipu1_di0_pre_sel] = imx_clk_mux_flags("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
+	clk[ipu1_di1_pre_sel] = imx_clk_mux_flags("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di0_pre_sel] = imx_clk_mux_flags("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di1_pre_sel] = imx_clk_mux_flags("ipu2_di1_pre_sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
+	clk[ipu1_di0_sel]     = imx_clk_mux_flags("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels), CLK_SET_RATE_PARENT);
+	clk[ipu1_di1_sel]     = imx_clk_mux_flags("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di0_sel]     = imx_clk_mux_flags("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di1_sel]     = imx_clk_mux_flags("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels), CLK_SET_RATE_PARENT);
 	clk[hsi_tx_sel]       = imx_clk_mux("hsi_tx_sel",       base + 0x30, 28, 1, hsi_tx_sels,       ARRAY_SIZE(hsi_tx_sels));
 	clk[pcie_axi_sel]     = imx_clk_mux("pcie_axi_sel",     base + 0x18, 10, 1, pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
 	clk[ssi1_sel]         = imx_clk_fixup_mux("ssi1_sel",   base + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),          imx_cscmr1_fixup);

regards
Philipp
