From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 21 Sep 2018 16:18:05 +0200
Subject: [PATCH 02/10] phy: Add configuration interface
In-Reply-To: <20180919121436.ztjnxofe66quddeq@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
 <20180906145622.kwxvkcuerbeqsj6b@flea>
 <1a169fad-72b7-fac0-1254-cac5d8304740@ti.com>
 <20180912084242.skxbwbgluakakyg6@flea>
 <e0d7db11-7ec1-cb98-4e62-12d78d1ba65b@ti.com>
 <20180919121436.ztjnxofe66quddeq@flea>
Message-ID: <20180921141805.s4u224xzmtii66dg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 02:14:36PM +0200, Maxime Ripard wrote:
> > I'm sorry but I'm not convinced a consumer driver should have all the details
> > that are added in phy_configure_opts_mipi_dphy.
> 
> If it can convince you, here is the parameters that are needed by all
> the MIPI-DSI drivers currently in Linux to configure their PHY:
> 
>   - cdns-dsi (drivers/gpu/drm/bridge/cdns-dsi.c)
>     - hs_clk_rate
>     - lanes
>     - videomode
> 
>   - kirin (drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c)
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - wakeup
> 
>   - msm (drivers/gpu/drm/msm/dsi/*)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lp_clk_rate
>     - ta_get
>     - ta_go
>     - ta_sure
> 
>   - mtk (drivers/gpu/drm/mediatek/mtk_dsi.c)
>     - hs_clk_rate
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
> 
>   - sun4i (drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_zero
>     - hs_prepare
>     - hs_trail
>     - lanes
>     - lp_clk_rate
> 
>   - tegra (drivers/gpu/drm/tegra/dsi.c)
>     - clk_post
>     - clk_pre
>     - clk_prepare
>     - clk_trail
>     - clk_zero
>     - hs_exit
>     - hs_prepare
>     - hs_trail
>     - hs_zero
>     - lpx
>     - ta_get
>     - ta_go
>     - ta_sure
> 
>   - vc4 (drivers/gpu/drm/vc4/vc4_dsi.c)
>     - hs_clk_rate
>     - lanes
> 
> Now, for MIPI-CSI receivers:
> 
>   - marvell-ccic (drivers/media/platform/marvell-ccic/mcam-core.c)
>     - clk_term_en
>     - clk_settle
>     - d_term_en
>     - hs_settle
>     - lp_clk_rate
> 
>   - omap4iss (drivers/staging/media/omap4iss/iss_csiphy.c)
>     - clk_miss
>     - clk_settle
>     - clk_term
>     - hs_settle
>     - hs_term
>     - lanes
> 
>   - rcar-vin (drivers/media/platform/rcar-vin/rcar-csi2.c)
>     - hs_clk_rate
>     - lanes
> 
>   - ti-vpe (drivers/media/platform/ti-vpe/cal.c)
>     - clk_term_en
>     - d_term_en
>     - hs_settle
>     - hs_term
> 
> So the timings expressed in the structure are the set of all the ones
> currently used in the tree by DSI and CSI drivers. I would consider
> that a good proof that it would be useful.
> 
> Note that at least cdns-dsi, exynos4-is
> (drivers/media/platform/exynos4-is/mipi-csis.c), kirin, sun4i, msm,
> mtk, omap4iss, plus the v4l2 drivers cdns-csi2tx and cdns-csi2rx I
> want to convert, have already either a driver for their DPHY using the
> phy framework plus a configuration function, or a design very similar
> that could be migrated to such an API.

There's also a patch set currently being submitted that uses a phy
driver + custom functions:
https://lore.kernel.org/patchwork/cover/988959/

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/7d79ac8e/attachment.sig>
