From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Apr 2015 10:43:54 +0200
Subject: [PATCH RFC v9 11/20] drm/bridge: Add Synopsys DesignWare MIPI
 DSI host controller driver
In-Reply-To: <1423720903-24806-12-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-12-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150409084353.GD12103@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 02:01:34PM +0800, Liu Ying wrote:
[...]
> diff --git a/drivers/gpu/drm/bridge/dw_mipi_dsi.c b/drivers/gpu/drm/bridge/dw_mipi_dsi.c
[...]
> +struct dw_mipi_dsi {
> +	struct mipi_dsi_host dsi_host;
> +	struct drm_connector connector;
> +	struct drm_encoder *encoder;
> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
> +	struct device *dev;
> +
> +	void __iomem *base;
> +
> +	struct clk *pllref_clk;
> +	struct clk *cfg_clk;
> +	struct clk *pclk;
> +
> +	unsigned int lane_mbps; /* per lane */
> +	u32 channel;
> +	u32 lanes;
> +	u32 format;
> +	struct drm_display_mode *mode;
> +
> +	const struct dw_mipi_dsi_plat_data *pdata;
> +
> +	bool enabled;
> +};

While reviewing this I kept thinking whether this is really the right
architectural design. This driver is a MIPI DSI host, a connector and
a bridge, all in one. But it seems to me like it should really be an
encoder/connector and a MIPI DSI host. Why the need for a bridge? The
bridge abstraction targets blocks outside of the SoC, but it is my
understanding that these DesignWare IP blocks are designed into SoCs.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/26414472/attachment.sig>
