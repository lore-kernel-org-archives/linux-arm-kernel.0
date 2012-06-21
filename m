From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jun 2012 08:52:42 +0200
Subject: [PATCH 1/5] DRM: Add i.MX drm core support
In-Reply-To: <20120621053014.GB3971@S2101-09.ap.freescale.net>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-2-git-send-email-s.hauer@pengutronix.de>
 <20120621053014.GB3971@S2101-09.ap.freescale.net>
Message-ID: <20120621065242.GX28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 01:30:16PM +0800, Shawn Guo wrote:
> On Thu, Jun 14, 2012 at 03:43:23PM +0200, Sascha Hauer wrote:
> ...
> > +struct drm_device *imx_drm_device_get(void)
> > +{
> > +	struct imx_drm_device *imxdrm = __imx_drm_device();
> > +	struct imx_drm_encoder *enc;
> > +	struct imx_drm_connector *con;
> > +	struct imx_drm_crtc *crtc;
> > +
> > +	mutex_lock(&imxdrm->mutex);
> > +
> > +	list_for_each_entry(enc, &imxdrm->encoder_list, list) {
> > +		if (!try_module_get(enc->owner)) {
> > +			dev_err(imxdrm->dev, "could not get module %s\n",
> > +					module_name(enc->owner));
> > +			goto unwind_enc;
> > +		}
> > +	}
> > +
> > +	list_for_each_entry(con, &imxdrm->connector_list, list) {
> > +		if (!try_module_get(con->owner)) {
> > +			dev_err(imxdrm->dev, "could not get module %s\n",
> > +					module_name(con->owner));
> > +			goto unwind_con;
> > +		}
> > +	}
> > +
> > +	list_for_each_entry(crtc, &imxdrm->crtc_list, list) {
> > +		if (!try_module_get(crtc->owner)) {
> > +			dev_err(imxdrm->dev, "could not get module %s\n",
> > +					module_name(crtc->owner));
> > +			goto unwind_crtc;
> > +		}
> > +	}
> > +
> > +	imxdrm->references++;
> > +
> > +	mutex_unlock(&imxdrm->mutex);
> > +
> > +	return imx_drm_device->drm;
> 
> Though I'm not quite sure about the point of retrieving the static
> variable imx_drm_device from calling __imx_drm_device(), shouldn't
> imxdrm be used here since you already retrieve it?

The point of calling __imx_drm_device() instead of using imx_drm_device
directly is that I thought it might be easier to convert to a non global
variable later should we have (or want) to. I'm also unsure about the
value of having such a function, but you are right, it should be used
consistently if we have it.

I'll fix the remaining things you mentioned in the next round. Thanks
for looking at it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
