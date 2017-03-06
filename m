From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 6 Mar 2017 18:44:38 -0500
Subject: [PATCH 2/3] drm/rockchip: Fix link error when
 CONFIG_DRM_ANALOGIX_DP undefined
In-Reply-To: <20170306231512.GB20329@art_vandelay>
References: <20170306202722.9301-1-seanpaul@chromium.org>
 <20170306202722.9301-3-seanpaul@chromium.org>
 <CACvgo53paS0-5PbT-bmPoSMyx+r0jCQqMVUNFsPJQXZ+QXtB_g@mail.gmail.com>
 <20170306231512.GB20329@art_vandelay>
Message-ID: <20170306234438.GE20329@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 06:15:12PM -0500, Sean Paul wrote:
> On Mon, Mar 06, 2017 at 08:58:14PM +0000, Emil Velikov wrote:
> > On 6 March 2017 at 20:27, Sean Paul <seanpaul@chromium.org> wrote:
> > > Fixes the following link error when CONFIG_DRM_ANALOGIX_DP is not defined:
> > >
> > > ERROR: "analogix_dp_start_crc" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> > > ERROR: "analogix_dp_stop_crc" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> > >
> > > Fixes: 3190e58dafaf ("drm/rockchip: Implement CRC debugfs API")
> > > Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> > > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > > Cc: Mark Yao <mark.yao@rock-chips.com>
> > > Cc: Sean Paul <seanpaul@chromium.org>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: dri-devel at lists.freedesktop.org
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-rockchip at lists.infradead.org
> > > Cc: Emil Velikov <emil.l.velikov@gmail.com>
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > ---
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index 17ab16c4b922..2151e1cee4b4 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > @@ -19,7 +19,9 @@
> > >  #include <drm/drm_crtc_helper.h>
> > >  #include <drm/drm_flip_work.h>
> > >  #include <drm/drm_plane_helper.h>
> > > +#ifdef CONFIG_DRM_ANALOGIX_DP
> > >  #include <drm/bridge/analogix_dp.h>
> > > +#endif
> > >
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > > @@ -1112,6 +1114,7 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
> > >         kfree(s);
> > >  }
> > >
> > > +#ifdef CONFIG_DRM_ANALOGIX_DP
> > >  static struct drm_connector *vop_get_edp_connector(struct vop *vop)
> > >  {
> > Similar to 3/3 adding stubs for
> > analogix_dp_start_crc/analogix_dp_stop_crc will be shorter/cleaner
> > than ifdef spaghetti.
> > 
> 
> Thanks for the review, Emil.
> 
> I think given that there's only one driver that supports crc in
> rockchip-land, it makes sense to target that driver specifically.
> If/when there is more than one, I agree we should have a shim/stub.
> 
> That said, if Tomeu or anyone else wants to follow on with an ifdef
> cleanup, I'm happy to review.
> 

Applied to drm-misc-next

Thanks for the review,

Sean


> Sean
> 
> > At the same these fix the problems so, for the series:
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > 
> > -Emil
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
