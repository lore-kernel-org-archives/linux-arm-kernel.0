From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 21 Mar 2017 15:58:18 -0400
Subject: [PATCH 10/41] drm/bridge: analogix_dp: Don't change psr while
 bridge is disabled
In-Reply-To: <e7b7ef5b-7935-a74c-c046-27c56ae16774@samsung.com>
References: <20170310043305.17216-1-seanpaul@chromium.org>
 <CGME20170310044738epcas5p254ae086c7ed81ec88e4ba3211f86c014@epcas5p2.samsung.com>
 <20170310043305.17216-11-seanpaul@chromium.org>
 <e7b7ef5b-7935-a74c-c046-27c56ae16774@samsung.com>
Message-ID: <20170321195818.GE19389@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 02:40:21PM +0100, Andrzej Hajda wrote:
> On 10.03.2017 05:32, Sean Paul wrote:
> > From: zain wang <wzz@rock-chips.com>
> >
> > There is a race between AUX CH bring-up and enabling bridge which will
> > cause link training to fail. To avoid hitting it, don't change psr state
> > while enabling the bridge.
> >
> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: zain wang <wzz@rock-chips.com>
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > [seanpaul fixed up the commit message a bit and renamed *_supported to *_enabled]
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> 
> Hmm, beside resetting psr_enable in analogix_dp_bridge_disable I do not
> see functional change, or am I blind?

The patch also adds a check of psr_enable in analogix_dp_commit. This will avoid
trying to enable psr when the bridge is disabled (that's why psr_enable is
reset).

Sean

> 
> Regards
> Andrzej
> 
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 15 ++++++++-------
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 +-
> >  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  2 +-
> >  include/drm/bridge/analogix_dp.h                   |  2 +-
> >  4 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index 8a8f05fe9da3..64d94a34874d 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -98,20 +98,20 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
> >  	return 0;
> >  }
> >  
> > -int analogix_dp_psr_supported(struct device *dev)
> > +int analogix_dp_psr_enabled(struct device *dev)
> >  {
> >  	struct analogix_dp_device *dp = dev_get_drvdata(dev);
> >  
> > -	return dp->psr_support;
> > +	return dp->psr_enable;
> >  }
> > -EXPORT_SYMBOL_GPL(analogix_dp_psr_supported);
> > +EXPORT_SYMBOL_GPL(analogix_dp_psr_enabled);
> >  
> >  int analogix_dp_enable_psr(struct device *dev)
> >  {
> >  	struct analogix_dp_device *dp = dev_get_drvdata(dev);
> >  	struct edp_vsc_psr psr_vsc;
> >  
> > -	if (!dp->psr_support)
> > +	if (!dp->psr_enable)
> >  		return 0;
> >  
> >  	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
> > @@ -134,7 +134,7 @@ int analogix_dp_disable_psr(struct device *dev)
> >  	struct edp_vsc_psr psr_vsc;
> >  	int ret;
> >  
> > -	if (!dp->psr_support)
> > +	if (!dp->psr_enable)
> >  		return 0;
> >  
> >  	/* Prepare VSC packet as per EDP 1.4 spec, Table 6.9 */
> > @@ -878,8 +878,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
> >  	/* Enable video */
> >  	analogix_dp_start_video(dp);
> >  
> > -	dp->psr_support = analogix_dp_detect_sink_psr(dp);
> > -	if (dp->psr_support)
> > +	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
> > +	if (dp->psr_enable)
> >  		analogix_dp_enable_sink_psr(dp);
> >  }
> >  
> > @@ -1120,6 +1120,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
> >  	if (ret)
> >  		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
> >  
> > +	dp->psr_enable = false;
> >  	dp->dpms_mode = DRM_MODE_DPMS_OFF;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> > index b039b28d8fcc..e135a42cb19e 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> > @@ -170,7 +170,7 @@ struct analogix_dp_device {
> >  	int			dpms_mode;
> >  	int			hpd_gpio;
> >  	bool                    force_hpd;
> > -	bool			psr_support;
> > +	bool			psr_enable;
> >  
> >  	struct mutex		panel_lock;
> >  	bool			panel_is_modeset;
> > diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > index 64e7e2c0bc58..f44756029478 100644
> > --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > @@ -83,7 +83,7 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
> >  	int vact_end;
> >  	int ret;
> >  
> > -	if (!analogix_dp_psr_supported(dp->dev))
> > +	if (!analogix_dp_psr_enabled(dp->dev))
> >  		return;
> >  
> >  	dev_dbg(dp->dev, "%s PSR...\n", enabled ? "enable" : "disable");
> > diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> > index c99d6eaef1ac..4fc0165ed3f5 100644
> > --- a/include/drm/bridge/analogix_dp.h
> > +++ b/include/drm/bridge/analogix_dp.h
> > @@ -38,7 +38,7 @@ struct analogix_dp_plat_data {
> >  			 struct drm_connector *);
> >  };
> >  
> > -int analogix_dp_psr_supported(struct device *dev);
> > +int analogix_dp_psr_enabled(struct device *dev);
> >  int analogix_dp_enable_psr(struct device *dev);
> >  int analogix_dp_disable_psr(struct device *dev);
> >  
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
