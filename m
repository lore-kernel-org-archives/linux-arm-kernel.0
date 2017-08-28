From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 28 Aug 2017 10:51:08 +0200
Subject: [RESEND PATCH] drm/hisilicon: Ensure LDI regs are properly
 configured.
In-Reply-To: <CAGd==07ygp97ggXSAK5JCYweRZPFwjqa2WNV3g1fdyY6736pPw@mail.gmail.com>
References: <1502806465-17772-1-git-send-email-peter.griffin@linaro.org>
 <CAGd==07ygp97ggXSAK5JCYweRZPFwjqa2WNV3g1fdyY6736pPw@mail.gmail.com>
Message-ID: <20170828085108.zp4pjkmt6gbewwgm@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 04:44:30PM +0800, Xinliang Liu wrote:
> Hi,
> 
> On 15 August 2017 at 22:14, Peter Griffin <peter.griffin@linaro.org> wrote:
> 
> > This patch fixes the following soft lockup:
> >   BUG: soft lockup - CPU#0 stuck for 23s! [weston:307]
> >
> > On weston idle-timeout the IP is powered down and reset
> > asserted. On weston resume we get a massive vblank
> > IRQ storm due to the LDI registers having lost some state.
> >
> > This state loss is caused by ade_crtc_atomic_begin() not
> > calling ade_ldi_set_mode(). With this patch applied
> > resuming from Weston idle-timeout works well.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Tested-by: John Stultz <john.stultz@linaro.org>
> >
> 
> ??Thanks Peter,
> This patch looks good to me.
> Reviewed-by: Xinliang Liu <xinliang.liu@linaro.org>?
> 
> @Sean, could you please help to apply to drm-misc if others has no more
> comments, thanks.

hisilicon isn't maintained in drm-misc, and you're the maintainer. This is
not how it works. So either
a) pick up the patch and send out a pull request to Dave Airlie
b) move hisilicon over to drm-misc and become a drm-misc maintainer
yourself. This needs a MAINTAINERS update to point the git tree at
drm-misc.

drm-misc maintainers don't maintain everyone else's driver as a service,
that simply doesn't scale.

Thanks, Daniel

> 
> Thanks,
> Xinliang
> ?
> 
> > Cc: stable at vger.kernel.org
> > ---
> >  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > index c96c228..72c6357 100644
> > --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> > @@ -519,9 +519,12 @@ static void ade_crtc_atomic_begin(struct drm_crtc
> > *crtc,
> >  {
> >         struct ade_crtc *acrtc = to_ade_crtc(crtc);
> >         struct ade_hw_ctx *ctx = acrtc->ctx;
> > +       struct drm_display_mode *mode = &crtc->state->mode;
> > +       struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
> >
> >         if (!ctx->power_on)
> >                 (void)ade_power_up(ctx);
> > +       ade_ldi_set_mode(acrtc, mode, adj_mode);
> >  }
> >
> >  static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
