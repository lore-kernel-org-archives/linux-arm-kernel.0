From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 2 Dec 2015 23:17:10 +0100
Subject: [RFC PATCH 7/9] drm/rockchip: force enable vop when do mode
 setting
In-Reply-To: <20151202165536.GA14019@ulmo>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940721-23488-1-git-send-email-mark.yao@rock-chips.com>
 <20151202165536.GA14019@ulmo>
Message-ID: <20151202221710.GB10243@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 05:55:36PM +0100, Thierry Reding wrote:
> On Tue, Dec 01, 2015 at 11:32:01AM +0800, Mark Yao wrote:
> > When do mode setting, mean that we want to enable display output,
> > but sometimes, vop_crtc_enable is after mode_set, we can't allow
> > that, so force enable vop in mode setting.
> > 
> > Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index c65b454..7c07537 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -1110,6 +1110,7 @@ static void vop_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >  	u16 vact_end = vact_st + vdisplay;
> >  	uint32_t val;
> >  
> > +	vop_crtc_enable(crtc);
> >  	/*
> >  	 * If dclk rate is zero, mean that scanout is stop,
> >  	 * we don't need wait any more.
> 
> Have you considered simply moving everything into ->enable()? That's
> what I did for Tegra, for much the same reasons that you gave in the
> commit message. Doing so gives you a much simpler call graph. Really
> the only thing you need to do is move around the code, and perhaps a
> different way to get ahold of the display mode, but you can use the
> Tegra driver as a reference for how to do that.

Yeah if writing mode related registers requires the thing to be on on your
hw then you can't use the ->mode_set hooks. Those are explicitly called
when everything is off (not just sometimes, at least with atomic helpers).

Like Thierry said the recommendation is to just shovel that code into
->enable hooks. ->mode_set_nofb is mostly there to support easier
transition for drivers which started with the legacy crtc helpers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
