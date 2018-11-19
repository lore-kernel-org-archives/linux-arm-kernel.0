From: plaes@plaes.org (Priit Laes)
Date: Mon, 19 Nov 2018 08:50:43 +0000
Subject: [PATCH] drm/sun4i: hdmi: Improve compatibility with non-hotplug
 capable connectors
In-Reply-To: <20181119081934.ohjg36zjcb52nrrq@flea>
References: <20181116171830.23465-1-plaes@plaes.org>
 <20181119081934.ohjg36zjcb52nrrq@flea>
Message-ID: <20181119085043.ptypvtr2wybqcjxi@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 09:19:34AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Nov 16, 2018 at 07:18:29PM +0200, Priit Laes wrote:
> > From: Priit Laes <priit.laes@paf.com>
> > 
> > Even though HDMI connector features hotplug detect pin (HPD), there are
> > devices that which do not support it.
> 
> Which devices?

Device I have here is labelled "AMATIC INDUSTRIES PT-MULTI-1" and
based on the TFP401APZP chip.

> 
> > For these devices fall back to additional check on I2C bus. Of
> > course, there might be also devices that do not wire DDC pins too,
> > so we don't really know whether cable has been connected.
> 
> Again, which devices?

OK, let's skip the part without DDC. I was probably thinking about
VGA cables when I was writing that..

> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > Signed-off-by: Priit Laes <priit.laes@paf.com>
> 
> You only need one :)
> 
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > index 061d2e0d9011..bded09af1340 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > @@ -238,14 +238,18 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >  	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
> >  	unsigned long reg;
> >  
> > -	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
> > +	if (!readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
> >  			       reg & SUN4I_HDMI_HPD_HIGH,
> >  			       0, 500000)) {
> > -		cec_phys_addr_invalidate(hdmi->cec_adap);
> > -		return connector_status_disconnected;
> > +		return connector_status_connected;
> >  	}
> >  
> > -	return connector_status_connected;
> > +	if (!IS_ERR(hdmi->i2c) && drm_probe_ddc(hdmi->i2c))
> > +		return connector_status_connected;
> > +
> > +	cec_phys_addr_invalidate(hdmi->cec_adap);
> > +
> > +	return connector_status_unknown;
> 
> You're doing basically two things in that patch, first adding the
> fallback to the DDC probe if the hotplug mechanism couldn't detect the
> display, and then returning a status unknown if both fail.

Agreed. 'connector_status_disconnected' is the way to go.

> While I don't really have an opinion on the first one, it's mandatory
> for every HDMI device to be able to retrieve the EDID through the
> DDC. If a device was to disallow that, it would violate the HDMI, and
> I'm not sure we want to start supporting those devices.

Yes, Even if someone runs into those non-spec devices, then there's
also possibility to use the force argument.

Thanks for review!

> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
