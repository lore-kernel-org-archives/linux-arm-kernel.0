From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Fri,  4 May 2018 14:32:03 +0530
Subject: [PATCH v1] drm/kms/mode: added a new helper for calculating
 videomode from crtc's display mode
In-Reply-To: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
References: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
 <CGME20180504090214epcas5p4e9c362da6cc7b65effcc042fc4f82d2a@epcas5p4.samsung.com>
Message-ID: <1525424523-3367-1-git-send-email-satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 11:36:39 +0100, Liviu Dudau wrote:
> On Thu, May 03, 2018 at 11:28:37AM +0530, Satendra Singh Thakur wrote:
> > 1.
> > -Added a new helper drm_display_mode_crtc_to_videomode
> > -This helper calculates mode parameters like
> >   horizontal front_porch, back_porch, sync length
> >   vertical front_porch, back_porch, sync length
> >   using crtc_* fields of struct drm_display_mode
> > -It uses following fields of crtc mode
> >  horizontal sync start/end, active and total length
> >  vertical sync start/end, active and total length
> > 2.
> > -Most of the driver use user-supplied mode for calculating videomode
> > -However, few drivers use HW (crtc) mode for calculating videomode
> > -This helper will be useful for such drivers
> > 3.
> > -Currently following drivers will be using this new helper
> > -arm hdlcd
> > -atmel hlcdc
> > -exynos 5433 decon
> > -exynos7 decon
> > -exynos fimd
> > 4.
> > -This patch removes related duplicate code from above mentioned drivers
> > 
> > Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> > Cc: Madhur Verma <madhur.verma@samsung.com>
> > Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> > ---
> >  drivers/gpu/drm/arm/hdlcd_crtc.c               |  8 +-------
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  7 +------
> >  drivers/gpu/drm/drm_modes.c                    | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/exynos/exynos5433_drm_decon.c  | 22 ++++++++++------------
> >  drivers/gpu/drm/exynos/exynos7_drm_decon.c     | 23 ++++++++++-------------
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c       | 22 +++++++++-------------
> >  include/drm/drm_modes.h                        |  2 ++
> >  7 files changed, 53 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > index cf5cbd6..d20e471 100644
> > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > @@ -130,13 +130,7 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >  	struct videomode vm;
> >  	unsigned int polarities, err;
> >  
> > -	vm.vfront_porch = m->crtc_vsync_start - m->crtc_vdisplay;
> > -	vm.vback_porch = m->crtc_vtotal - m->crtc_vsync_end;
> > -	vm.vsync_len = m->crtc_vsync_end - m->crtc_vsync_start;
> > -	vm.hfront_porch = m->crtc_hsync_start - m->crtc_hdisplay;
> > -	vm.hback_porch = m->crtc_htotal - m->crtc_hsync_end;
> > -	vm.hsync_len = m->crtc_hsync_end - m->crtc_hsync_start;
> > -
> > +	drm_display_mode_crtc_to_videomode(m, &vm);
> >  	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
> >  
> >  	if (m->flags & DRM_MODE_FLAG_PHSYNC)
>
> For the HDLCD part:
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> If you're not sending the final version through drm-misc then let me
> know and I can pick up the HDLCD part separately.
>
> Best regards,
> Liviu
>
>

Hi Mr Liviu,
Thanks for accepting the patch.
I don't know how to send patch through drm-misc.
You may please go ahead and pick HDLCD part separately.

Thanks
-Satendra
