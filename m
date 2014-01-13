From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Jan 2014 09:47:05 +0100
Subject: [RFC PATCH v2] staging: imx-hdmi: use rx sense status for plug
 detection if hpd is unreliable
In-Reply-To: <20140111032328.GL21717@S2101-09.ap.freescale.net>
References: <1389363744-559-1-git-send-email-p.zabel@pengutronix.de>
 <20140111032328.GL21717@S2101-09.ap.freescale.net>
Message-ID: <1389602825.6318.14.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 11.01.2014, 11:23 +0800 schrieb Shawn Guo:
> On Fri, Jan 10, 2014 at 03:22:24PM +0100, Philipp Zabel wrote:
> > Due to the voltage divider on the HPD line, the HDMI connector on
> > imx6q-sabrelite doesn't reliably detect connected DVI monitors.
> > This patch allows to use the RX_SENSE0 signal as a workaround when
> > enabled by a boolean device tree property 'hpd-unreliable'.
> 
> If it's a fsl/imx specific property, it should have a 'fsl,' prefix.
> It should be added into binding doc.  Oh, we do not even have a binding
> doc for this imx-hdmi yet.

Yes, We need to sort out the componentised DT bindings.
I don't think that this property is particularly i.MX specific, since
anybody could wire up their board in a way that the HDMI hotplug detect
pin doesn't work reliably with some DVI monitors.

regards
Philipp

> Shawn
> 
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > This patch is based on Russell's recent 46-patch imx-drm cleanup series.
> > Changes since v1:
> >  - Store the status and polarity bits in struct imx_hdmi
> > ---
> >  drivers/staging/imx-drm/imx-hdmi.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
> > index fb3177d..62cb531 100644
> > --- a/drivers/staging/imx-drm/imx-hdmi.c
> > +++ b/drivers/staging/imx-drm/imx-hdmi.c
> > @@ -140,6 +140,9 @@ struct imx_hdmi {
> >  	struct regmap *regmap;
> >  	struct i2c_adapter *ddc;
> >  	void __iomem *regs;
> > +	u8 sink_detect_polarity;
> > +	u8 sink_detect_status;
> > +	u8 sink_detect_mask;
> >  
> >  	unsigned int sample_rate;
> >  	int ratio;
> > @@ -1317,10 +1320,10 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
> >  		    HDMI_PHY_I2CM_CTLINT_ADDR);
> >  
> >  	/* enable cable hot plug irq */
> > -	hdmi_writeb(hdmi, (u8)~HDMI_PHY_HPD, HDMI_PHY_MASK0);
> > +	hdmi_writeb(hdmi, hdmi->sink_detect_mask, HDMI_PHY_MASK0);
> >  
> >  	/* Clear Hotplug interrupts */
> > -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
> > +	hdmi_writeb(hdmi, hdmi->sink_detect_status, HDMI_IH_PHY_STAT0);
> >  
> >  	return 0;
> >  }
> > @@ -1392,6 +1395,7 @@ static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
> >  {
> >  	struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
> >  					     connector);
> > +
> >  	return hdmi->connector_status;
> >  }
> >  
> > @@ -1530,18 +1534,20 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
> >  
> >  	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
> >  
> > -	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> > -		if (phy_int_pol & HDMI_PHY_HPD) {
> > +	if (intr_stat & hdmi->sink_detect_status) {
> > +		int pol_bit = hdmi->sink_detect_polarity;
> > +
> > +		if (phy_int_pol & pol_bit) {
> >  			dev_dbg(hdmi->dev, "EVENT=plugin\n");
> >  
> > -			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
> > +			hdmi_modb(hdmi, 0, pol_bit, HDMI_PHY_POL0);
> >  
> >  			hdmi->connector_status = connector_status_connected;
> >  			imx_hdmi_poweron(hdmi);
> >  		} else {
> >  			dev_dbg(hdmi->dev, "EVENT=plugout\n");
> >  
> > -			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
> > +			hdmi_modb(hdmi, pol_bit, pol_bit, HDMI_PHY_POL0);
> >  
> >  			hdmi->connector_status = connector_status_disconnected;
> >  			imx_hdmi_poweroff(hdmi);
> > @@ -1550,7 +1556,7 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
> >  	}
> >  
> >  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> > -	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
> > +	hdmi_writeb(hdmi, ~hdmi->sink_detect_status, HDMI_IH_MUTE_PHY_STAT0);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -1702,14 +1708,24 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
> >  	 */
> >  	hdmi_init_clk_regenerator(hdmi);
> >  
> > +	hdmi->sink_detect_status = HDMI_IH_PHY_STAT0_HPD;
> > +	hdmi->sink_detect_polarity = HDMI_PHY_HPD;
> > +	hdmi->sink_detect_mask = ~HDMI_PHY_HPD;
> > +
> > +	if (of_property_read_bool(np, "hpd-unreliable")) {
> > +		hdmi->sink_detect_status = HDMI_IH_PHY_STAT0_RX_SENSE0;
> > +		hdmi->sink_detect_polarity = HDMI_PHY_RX_SENSE0;
> > +		hdmi->sink_detect_mask = ~HDMI_PHY_RX_SENSE0;
> > +	}
> > +
> >  	/*
> >  	 * Configure registers related to HDMI interrupt
> >  	 * generation before registering IRQ.
> >  	 */
> > -	hdmi_writeb(hdmi, HDMI_PHY_HPD, HDMI_PHY_POL0);
> > +	hdmi_writeb(hdmi, hdmi->sink_detect_polarity, HDMI_PHY_POL0);
> >  
> >  	/* Clear Hotplug interrupts */
> > -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
> > +	hdmi_writeb(hdmi, hdmi->sink_detect_status, HDMI_IH_PHY_STAT0);
> >  
> >  	ret = imx_hdmi_fb_registered(hdmi);
> >  	if (ret)
> > @@ -1720,7 +1736,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
> >  		goto err_iahb;
> >  
> >  	/* Unmute interrupts */
> > -	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
> > +	hdmi_writeb(hdmi, ~hdmi->sink_detect_status, HDMI_IH_MUTE_PHY_STAT0);
> >  
> >  	ret = snd_dw_hdmi_probe(&hdmi->audio, dev, hdmi->regs, irq, hdmi);
> >  	if (ret)
> > -- 
> > 1.8.5.2
> > 
> 
> 
