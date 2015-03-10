From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Mar 2015 10:43:37 +0100
Subject: [PATCH 2/3] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <1425979013.3141.17.camel@pengutronix.de>
References: <1429128.MSqYm0qZ9p@phil> <2297963.iMSNqyfSUx@phil>
 <1425979013.3141.17.camel@pengutronix.de>
Message-ID: <79223422.KFbmI1BzE4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Am Dienstag, 10. M?rz 2015, 10:16:53 schrieb Philipp Zabel:

[cut the obvious stuff I need to fix]

> Am Dienstag, den 10.03.2015, 00:22 +0100 schrieb Heiko Stuebner:
> > @@ -879,6 +883,12 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi)
> > 
> >  	int i, ret;
> >  	bool cscon = false;
> > 
> > +	if (hdmi->nsupplies > 0) {
> > +		ret = regulator_bulk_enable(hdmi->nsupplies, hdmi->supplies);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> Are these really supplies to the PHY or is this just a convenient place
> to enable them? Looking at the i.MX6 docs, I suppose yes.

According to the TRM, the supplies are "DC supply voltage for Analog part of 
HDMI", so I'd think phy supplies.

> 
> >  	/*check csc whether needed activated in HDMI mode */
> >  	cscon = (is_color_space_conversion(hdmi) &&
> >  	
> >  			!hdmi->hdmi_data.video_mode.mdvi);
> > 
> > @@ -1105,6 +1115,9 @@ static void dw_hdmi_phy_disable(struct dw_hdmi
> > *hdmi)
> > 
> >  	dw_hdmi_phy_enable_tmds(hdmi, 0);
> >  	dw_hdmi_phy_enable_power(hdmi, 0);
> > 
> > +	if (hdmi->nsupplies > 0)
> > +		regulator_bulk_disable(hdmi->nsupplies, hdmi->supplies);
> > +
> > 
> >  	hdmi->phy_enabled = false;
> >  
> >  }
> > 
> > @@ -1549,7 +1562,8 @@ static int dw_hdmi_register(struct drm_device *drm,
> > struct dw_hdmi *hdmi)> 
> >  int dw_hdmi_bind(struct device *dev, struct device *master,
> >  
> >  		 void *data, struct drm_encoder *encoder,
> >  		 struct resource *iores, int irq,
> > 
> > -		 const struct dw_hdmi_plat_data *plat_data)
> > +		 const struct dw_hdmi_plat_data *plat_data,
> > +		 struct regulator_bulk_data *supplies, int nsupplies)
> 
> I'm not sure I like this function sprouting so many parameters. Is there
> a good reason not to add this to struct dw_hdmi_plat_data?

Nope, moving this to platdata sound sensible and I'll give this a try :-)


Heiko
