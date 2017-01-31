From: john@metanate.com (John Keeping)
Date: Tue, 31 Jan 2017 12:03:49 +0000
Subject: [PATCH v3 12/24] drm/rockchip: dw-mipi-dsi: allow commands in
 panel_disable
In-Reply-To: <20170130201953.GO20076@art_vandelay>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-13-john@metanate.com>
 <20170130201953.GO20076@art_vandelay>
Message-ID: <20170131120349.6e291624.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jan 2017 15:19:53 -0500, Sean Paul wrote:

> On Sun, Jan 29, 2017 at 01:24:32PM +0000, John Keeping wrote:
> > Panel drivers may want to sent commands during the disable function, for
> > example MIPI_DCS_SET_DISPLAY_OFF before the video signal ends.  In order
> > to send commands we need to write to registers, so pclk must be enabled.
> > 
> > While changing this, remove the unnecessary code after the panel
> > unprepare call which seems to be a workaround for a specific panel and
> > thus belongs in the panel driver.  
> 
> Do you know which panel? If the panel driver is upstream, we should make sure we
> migrate this hack before removing it here. If it's downstream somewhere,

I'm just going by the comment in the code that this patch deletes and
the fact that this delay was not needed on any of the three panels I
tested.

Given the way the modes change, I think this should be a 120ms disable
delay if the affected panel is supported by the simple-panel driver.

> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> 
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> > ---
> > v3:
> > - Add Chris' Reviewed-by
> > Unchanged in v2
> > 
> >  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > index 7ada6d8ed143..290282e86d16 100644
> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > @@ -846,24 +846,16 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
> >  {
> >  	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
> >  
> > -	drm_panel_disable(dsi->panel);
> > -
> >  	if (clk_prepare_enable(dsi->pclk)) {
> >  		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
> >  		return;
> >  	}
> >  
> > +	drm_panel_disable(dsi->panel);
> > +
> >  	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
> >  	drm_panel_unprepare(dsi->panel);
> > -	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
> >  
> > -	/*
> > -	 * This is necessary to make sure the peripheral will be driven
> > -	 * normally when the display is enabled again later.
> > -	 */
> > -	msleep(120);
> > -
> > -	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
> >  	dw_mipi_dsi_disable(dsi);
> >  	clk_disable_unprepare(dsi->pclk);
> >  }
> > -- 
> > 2.11.0.197.gb556de5.dirty
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel  
> 
