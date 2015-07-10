From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 10 Jul 2015 18:59:49 +0200
Subject: [PATCH v6 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <DM2PR0301MB1229FD0A506ABD3AE7A0C7DF9F9F0@DM2PR0301MB1229.namprd03.prod.outlook.com>
References: <1436513215-43423-1-git-send-email-jianwei.wang@freescale.com>
 <20150710075941.GB3736@phenom.ffwll.local>
 <DM2PR0301MB1229FD0A506ABD3AE7A0C7DF9F9F0@DM2PR0301MB1229.namprd03.prod.outlook.com>
Message-ID: <20150710165949.GE3736@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 10:43:11AM +0000, Wang J.W. wrote:
> Hi Daniel,
> 
> Thank you very much for your review!
> See below...
> 
> > -----Original Message-----
> > From: Daniel Vetter [mailto:daniel.vetter at ffwll.ch] On Behalf Of Daniel
> > Vetter
> > Sent: Friday, July 10, 2015 4:00 PM
> > To: Wang Jianwei-B52261
> > Cc: dri-devel at lists.freedesktop.org; linux-kernel at vger.kernel.org; linux-
> > arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> > airlied at linux.ie; daniel.vetter at ffwll.ch; mark.yao at rock-chips.com; Wood
> > Scott-B07421; Wang Huan-B18965; Xiubo Li
> > Subject: Re: [PATCH v6 1/4] drm/layerscape: Add Freescale DCU DRM driver
> > 
> > On Fri, Jul 10, 2015 at 03:26:52PM +0800, Jianwei Wang wrote:
> > > +	.atomic_check = fsl_dcu_drm_encoder_atomic_check,
> > 
> > .atomic_check is optional
> > 
> 
> I try to remove .atomic_check, but it will cause CPU hang when starting up
> And I find this in drivers/gpu/drm/drm_atomic_helper.c
> 
>  293                 if (funcs->atomic_check) {
>  294                         ret = funcs->atomic_check(encoder, crtc_state,
>  295                                                   conn_state);
>  296                         if (ret) {
>  297                                 DRM_DEBUG_ATOMIC("[ENCODER:%d:%s] check failed\n",
>  298                                                  encoder->base.id, encoder->name);
>  299                                 return ret;
>  300                         }
>  301                 } else {
>  302                         ret = funcs->mode_fixup(encoder, &crtc_state->mode,
>  303                                                 &crtc_state->adjusted_mode);
>  304                         if (!ret) {
>  305                                 DRM_DEBUG_ATOMIC("[ENCODER:%d:%s] fixup failed\n",
>  306                                                  encoder->base.id, encoder->name);
>  307                                 return -EINVAL;
>  308                         }
>  309                 }
> It means that I have to implement at least one of atomic_check and mode_fixup.
> So I reserve atomic_check.
> Is there problem? Please give me some more comments if necessary. Thanks!

Ah sorry you are right, atomic check is not optional. Unfortunately the
optional-or-not thing has grown a bit organically so there's no clear
rules.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
