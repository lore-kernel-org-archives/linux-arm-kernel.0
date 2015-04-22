From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Apr 2015 14:13:53 +0200
Subject: [PATCH RFC v9 11/20] drm/bridge: Add Synopsys DesignWare MIPI DSI
 host controller driver
In-Reply-To: <552F4B2E.2000209@codeaurora.org>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <20150409084353.GD12103@ulmo> <552F4B2E.2000209@codeaurora.org>
Message-ID: <54991164.nrScLQEecU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 16. April 2015, 11:09:58 schrieb Archit Taneja:
> On 04/09/2015 02:13 PM, Thierry Reding wrote:
> > On Thu, Feb 12, 2015 at 02:01:34PM +0800, Liu Ying wrote:
> > [...]
> > 
> >> diff --git a/drivers/gpu/drm/bridge/dw_mipi_dsi.c
> >> b/drivers/gpu/drm/bridge/dw_mipi_dsi.c> 
> > [...]
> > 
> >> +struct dw_mipi_dsi {
> >> +	struct mipi_dsi_host dsi_host;
> >> +	struct drm_connector connector;
> >> +	struct drm_encoder *encoder;
> >> +	struct drm_bridge *bridge;
> >> +	struct drm_panel *panel;
> >> +	struct device *dev;
> >> +
> >> +	void __iomem *base;
> >> +
> >> +	struct clk *pllref_clk;
> >> +	struct clk *cfg_clk;
> >> +	struct clk *pclk;
> >> +
> >> +	unsigned int lane_mbps; /* per lane */
> >> +	u32 channel;
> >> +	u32 lanes;
> >> +	u32 format;
> >> +	struct drm_display_mode *mode;
> >> +
> >> +	const struct dw_mipi_dsi_plat_data *pdata;
> >> +
> >> +	bool enabled;
> >> +};
> > 
> > While reviewing this I kept thinking whether this is really the right
> > architectural design. This driver is a MIPI DSI host, a connector and
> > a bridge, all in one. But it seems to me like it should really be an
> > encoder/connector and a MIPI DSI host. Why the need for a bridge? The
> > bridge abstraction targets blocks outside of the SoC, but it is my
> > understanding that these DesignWare IP blocks are designed into SoCs.
> 
> The msm driver uses bridges for blocks within the SoC too. We have too
> many sub blocks in the display controller that use up crtcs and encoder
> entities. A bridge is the only option one has if an encoder in the
> display chain is already taken.
> 
> In the above designware configuration, if some one created a board that
> used an external chip to further convert DSI to some other output
> format, then we would be completely exhausted of all entities.
> 
> I posted a patch that allows us to create a chain of bridges for such
> cases. It seems to work well as an interim solution. Ideally, it would
> be better if we could make bridge a special case of an encoder, and let
> one encoder connect to another encoder.
> 
> Such a thing would also help us unify i2c slave encoders and bridge
> drivers too. A chip designed as an i2c slave encoder would work well
> with a drm driver that doesn't have an encoder, but won't work for SoCs
> SoCs that already have an encoder and were expecting a bridge entity
> instead.

Yeah, having encoder-after-encoder chains would be great. I have the same 
issue on Rockchip where on the rk3288 the lvds-IP hogs the lcd-pins of the soc 
which are used both for panels as well as external encoders, while on the 
older Rockchip SoCs these pins are used by external encoders directly.

So in my current (pending review) patchset the lvds acts as encoder for panels 
and as bridge if external encoders are in use.
