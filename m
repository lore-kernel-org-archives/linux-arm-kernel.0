From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Jul 2014 13:46:23 +0800
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <1406195275.4590.18.camel@weser.hi.pengutronix.de>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
 <1406195275.4590.18.camel@weser.hi.pengutronix.de>
Message-ID: <20140725054605.GE8821@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 11:47:55AM +0200, Lucas Stach wrote:
> > +static int imx_drm_resume(struct device *dev)
> > +{
> > +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> > +	struct drm_connector *connector;
> > +
> > +	drm_modeset_lock_all(drm_dev);
> > +	list_for_each_entry(connector, &drm_dev->mode_config.connector_list, head) {
> > +		if (connector->funcs->dpms)
> > +			connector->funcs->dpms(connector, DRM_MODE_DPMS_ON);
> > +	}
> > +	drm_modeset_unlock_all(drm_dev);
> > +
> This forcefully enables all connectors, which might not have been the
> state before suspend. Have a look at simply using
> drm_helper_resume_force_mode(), which should do the right thing.

With a bit more testing, I found that simply calling
drm_helper_resume_force_mode() from .resume hook can get HDMI back to
work.  So it seems the issue is not caused by that hdmi .dpms function
isn't being called but some mode setting states gets lost and isn't
being restored.

It can fix the HDMI issue we're facing right now, and I will send V2
with this change.  But it doesn't address Russell's concern, the HDMI
hardware isn't actually put into low power mode since hdmi .dpms
function isn't called anywhere during suspend/resume cycle.

Shawn
