From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Wed,  9 May 2018 17:22:05 +0530
Subject: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
In-Reply-To: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
References: <1525777110-11378-1-git-send-email-satendra.t@samsung.com>
 <CGME20180509115224epcas5p1c958418bc36fd224e8d36b9511c5beea@epcas5p1.samsung.com>
Message-ID: <1525866725-16685-1-git-send-email-satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2018 at 16:28:30 +0530, Satendra Singh Thakur wrote:
> On Thu, May 07, 2018 at 15:46:02 +0200, Daniel Vetter wrote:
> > On Thu, May 03, 2018 at 01:53:55PM +0530, Satendra Singh Thakur wrote:
> > > 1.There is a function in drm-core to calculate display timing parameters:
> > > horizontal front porch, back porch, sync length,
> > > vertical front porch, back porch, sync length and
> > > clock in Hz.
> > > However, some drivers are still calculating these parameters themselves.
> > > Therefore, there is a duplication of the code.
> > > This patch series replaces this redundant code with the function
> > > drm_display_mode_to_videomode.
> > > This removes nearly 100 redundant lines from the related drivers.
> > > 2.For some drivers (sun4i) the reverse helper
> > > drm_display_mode_from_videomode is used.
> > > 3.For some drivers it replaces arithmatic operators (*, /) with shifting
> > > operators (>>, <<).
> > > 4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
> > > 5.These changes apply to following crtc and encoder drivers:
> > > atmel-hlcdc
> > > bridge-tc358767
> > > exynos-dsi
> > > fsl-dcu
> > > gma500-mdfld_dsi_dpi
> > > hisilicon-kirin_dsi, ade
> > > meson-encoder
> > > pl111-display
> > > sun4i-tv
> > > ti lcdc
> > > tegra dc
> > > mediatek dpi dsi
> > > bridge-adv7533
> > 
> > The drm_mode_to_videomode helper is meant for interop between drm and v4l,
> > which have different internal structures to represent modes.
> > 
> > For drivers that only use drm I think the better option would be to add
> > these fields to struct drm_display_mode as another set of crtc_* values
> > (the computed values are stored in crtc_ prefixed members). And compute
> > front/back porch in drm_mode_set_crtcinfo.
> > 
> > Then we can use these new drm_display_mode->crtc_h|vfront|back_porch
> > fields in all the drivers you're changing. This way you avoid having to
> > change all the drm drivers to use v4l #defines.
> > 
> > Thanks,
> > Daniel
>
> Hi Daniel,
> Thanks for the comments.
> I will look into it.
> 
> Thanks
> -Satendra

Hi Daniel,
Thanks for the comments.
Please find below my understanding in this direction.

1. Currently struct videomode is being used in 50 drm drivers and 14 fbdev drivers.
   Since, it's already being used by so many drm drivers, that is the reason 
   these fbdev objects (struct videmode and func drm_display_mode_to_videomode) were used in this patch series.

2. Anyway, if fbdev related objects (struct/func) are not encouraged in drm drivers, then we may add 
   h/v front/back porches in struct drm_display_mode as adviced by you.

3. We can calculate these params in func drm_mode_set_crtcinfo at the end of it.
   int drm_mode_set_crtcinfo ()
   {
   .
   .
   crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
   crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay; 
   .
   .
   crtc_clock_hz = crtc_clock*1000;
   };

4. Normally mode is programmed in HW in following callbacks of crtc and encoder drivers
   -mode_set
   -mode_set_nofb
   -atomic_enable

   
   Normally drm_mode_set_crtcinfo is used in
   -mode_fixup callbacks (CBs) 
   of encoder and crtc drivers.

   if mode_fixup CBs are called before mode_set CBs then
   drm_mode_set_crtcinfo is right place to calculate sync/porch params. 
   We can use crtc_hfront/back_porches directly and program them to HW
   in above mentioned callbacks.
   
   int my_mode_set () 
   {
   	REG_WRITE(crtc_hfront_porch);
        REG_WRITE(crtc_hback_porch);
        .
        .
   } 	

 6.  However, if these params are being modified after calling drm_set_crtcinfo as mentioned below:

   bool amdgpu_atombios_encoder_mode_fixup(struct drm_encoder *encoder,
				 const struct drm_display_mode *mode,
				 struct drm_display_mode *adjusted_mode)
   {
	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);

	/* set the active encoder to connector routing */
	amdgpu_encoder_set_active_device(encoder);
	***drm_mode_set_crtcinfo(adjusted_mode, 0);****

	/* hw bug */
	if ((mode->flags & DRM_MODE_FLAG_INTERLACE)
	    && (mode->crtc_vsync_start < (mode->crtc_vdisplay + 2)))
		adjusted_mode->crtc_vsync_start = adjusted_mode->crtc_vdisplay + 2;

  Then we may need to define new func like

  void drm_calc_hv_porches_sync()
  {
   crtc_hfront_porch = crtc_hsync_start - crtc_hdisplay;
   crtc_vfront_porch = crtc_vsync_start - crtc_vdisplay; 
   .
   . 
   crtc_clock_hz = crtc_clock*1000;
  }  and call this func in mode_set*, atomic_enable CBS before programming the HW with this mode.

  
  Should I create patches around this idea ?
  Please let me know your comments. 


Thanks
-Satendra
