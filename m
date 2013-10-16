From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Oct 2013 19:07:35 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016170341.GH25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
Message-ID: <20131016180735.GI25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 06:03:42PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 15, 2013 at 10:17:07AM -0300, Fabio Estevam wrote:
> > On Tue, Oct 15, 2013 at 10:10 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > Another point on patch 1.  Sorry, I don't have patch 1 to reply to, it
> > > seems it was deleted from linux-arm-kernel's moderation queue.
> > >
> > > drm_mode_connector_attach_encoder() is called too early, before the
> > > base.id field in the encoder has been initialised.  This causes the
> > > connectors encoder array to be empty, and userspace KMS to fail.
> > >
> > > There's also bugs in the CSC setting too - it runs off the end of the
> > > array and gcc warns about this.  The code was clearly wrong.
> > >
> > > You may wish to combine this patch with patch 1 to sort all that out.
> > > For the patch below:
> > >
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Thanks, Russell.
> > 
> > Will submit v3 when I am back to the office.
> 
> Okay, I still have a problem with HDMI: I have a magenta vertical line
> down the left hand side of the frame, the displayed frame is shifted
> right by the width of that line and the right hand side is missing some
> pixels.
> 
> First off, the hsync position programmed into the HDMI registers appears
> to be wrong.
> 
> I'm at a loss why imx-hdmi is obfuscated with a conversion from a
> drm_display_mode structure to a fb_videomode.  This adds additional
> confusion and additional opportunities for bugs; this is probably
> exactly why the hsync position is wrong.
> 
> In CEA-861-B for 720p @60Hz:
> 
> DE: ^^^^__________^^^^^^^
> HS: _______^^^___________
>          ^  ^  ^
>          |  |  220 clocks
>          |  40 clocks
>          110 clocks
> 
> The IMX6 manual says HSYINCINDELAY0 is "Hsync active edge delay.  Integer
> number of pixel clock cycles from de non-active edge".  So, this should be
> 110.  Yet it ends up being programmed as 220, leading to a magenta vertical
> bar down the left hand side of the display.
> 
> Now, if you look at Documentation/fb/framebuffer.txt, in this case, the
> right margin should be 110 clocks, hsync len should be 40 and the left
> margin should be 220 clocks.
> 
> However, this is not what your conversion to a fb_videomode does.  It
> reverses the left and right margin.  A similar confusion also exists
> in the conversion of the upper/lower margins too.
> 
> The DRM model is this (for 720p @60Hz):
> 
> 0                             1280         1390 1430      1650
> |===============================|------------|---|----------|
> ^                               ^            ^   ^          ^
> start                       hdisplay hsync_start hsync_end htotal
> 
> The fb model is the same as the above but rotated:
> 
> left margin            displayed            right margin hsync_len
> |----------|===============================|------------|---|
> 
> So, the left margin is the bit between hsync_end and htotal, and the
> right margin is the bit between hdisplay and hsync_start.  Exactly
> the same analysis applies to the upper/lower margins.
> 
> What I suggest is that the use of fb_videomode is entirely killed off
> in this driver to remove this layer of confusion and instead the DRM
> model is stuck to within this DRM driver.
> 
> Now on to the next problem.  HSYNC/VSYNC polarity.
> 
> So, this is the mode which is set:
> 
>   1280x720 (0x41)   74.2MHz +HSync +VSync *current +preferred
>         h: width  1280 start 1390 end 1430 total 1650 skew    0 clock   45.0KHz
>         v: height  720 start  725 end  730 total  750           clock   60.0Hz
> 
> Note the positive HSync and VSync polarity - this is correct, backed
> up by CEA-861-B.
> 
> The IPU DI0 is configured thusly in its general control register:
> 0x2640000 = 0x200006, which is what is set when the requested mode
> has DRM_MODE_FLAG_PHSYNC and DRM_MODE_FLAG_PVSYNC flags set.
> 
> However, if we look at the HDMI config: 0x121000 = 0x18.  Active low
> hsync/vsync.  This is quite obvious when you look at the code -
> convert_to_video_timing() does *nothing* at all when converting the
> sync polarities, which means hdmi_av_composer() doesn't program them
> appropriately.  And yes, poking 0x78 into this register finally fixes
> the problem.
> 
> Yet another reason why this silly conversion from one structure form
> to another is a Very Bad Idea.  Until I found this, I was merely going
> to send a patch to sort out convert_to_video_timing(), but quite frankly
> I'm going to kill this thing off right now.
> 
> Another thing:
> 
> static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
> {
>         int ret;
>         convert_to_video_timing(&hdmi->fb_mode, mode);
> 
>         hdmi_disable_overflow_interrupts(hdmi);
>         
>         hdmi->vic = 6;
> 
> It's quite wrong to force every video mode set to be CEA mode 6.  IIRC,
> There is a function in DRM which will tell you the CEA mode number.
> Again, I'll fix this in my patch rewriting this bit of the driver to
> be correct.
> 
> I'm also suspicious of the "HDMI Initialization Step" comments, because
> they make no sense:
> 
> /* HDMI Initialization Step B.4 */
> static void imx_hdmi_enable_video_path(struct imx_hdmi *hdmi)
> {
> 
> yet:
> 
>         /* HDMI Initialization Step B.3 */
>         imx_hdmi_enable_video_path(hdmi);
> 
> One's left wondering whether Step B.3 really is to just call a function
> with a particular name, but B.4 is to actually do something with the
> hardware.  I'm quite sure that if this is a documented procedure, that
> it doesn't say that and these comments are wrong (and probably the code
> too.)
> 
> Even after all this, I still haven't got rid of that magenta line - in
> as far as I can tell, nothing has changed as a result of any of these
> (although reading back the register values, they're now much better.)
> What I do find is if I poke 0x78 back into the INVIDCONF register
> (which already contains 0x78) the magenta line disappears.
> 
> I'm beginning to suspect that there's some ordering dependency that
> isn't being satisfied - but as the i.MX6Solo/DualLite manual doesn't
> seem to contain any of these details, I'm running out of ideas.

More issues: 720x576p @50Hz doesn't work very well, there's speckles
over the display, with the odd random line of corruption, and the
display occasionally blanks.  1280x720p at 50Hz or 60Hz is fine (apart
from the magenta line).  However, the magenta line disappears after
playing around setting various modes.

Sorry, but I don't think imx-drm is driving the hardware correctly, and
I know that Greg wants it moved out of drivers/staging, but frankly it
seems to be far from ready for that.  Certainly the HDMI parts seems to
be especially problematical.

In any case, here's my patch so far, which applies on top of the previous
I sent for the array overflow/encoder attachment:

 drivers/staging/imx-drm/imx-hdmi.c |   86 ++++++++++++------------------------
 1 files changed, 28 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index ca0450b..942dda6 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -133,7 +133,6 @@ struct imx_hdmi {
 	struct i2c_adapter *ddc;
 	void __iomem *regs;
 
-	struct fb_videomode fb_mode;
 	spinlock_t enable_lock;
 	spinlock_t lock;
 	unsigned long pixel_clk_rate;
@@ -1221,20 +1220,18 @@ static void hdmi_config_AVI(struct imx_hdmi *hdmi)
 	hdmi_writeb(hdmi, 0, HDMI_FC_AVISRB1);
 }
 
-static void hdmi_av_composer(struct imx_hdmi *hdmi)
+static void hdmi_av_composer(struct imx_hdmi *hdmi,
+	const struct drm_display_mode *mode)
 {
 	u8 inv_val;
-	struct fb_videomode *fb_mode = &hdmi->fb_mode;
 	struct hdmi_vmode *vmode = &hdmi->hdmi_data.video_mode;
-	int hblank, vblank;
+	int hblank, vblank, h_de_hs, v_de_vs, hsync_len, vsync_len;
 
-	vmode->mhsyncpolarity = ((fb_mode->sync & FB_SYNC_HOR_HIGH_ACT) != 0);
-	vmode->mvsyncpolarity = ((fb_mode->sync & FB_SYNC_VERT_HIGH_ACT) != 0);
-	vmode->minterlaced = ((fb_mode->vmode & FB_VMODE_INTERLACED) != 0);
-	vmode->mpixelclock = (fb_mode->xres + fb_mode->left_margin +
-		fb_mode->right_margin + fb_mode->hsync_len) * (fb_mode->yres +
-		fb_mode->upper_margin + fb_mode->lower_margin +
-		fb_mode->vsync_len) * fb_mode->refresh;
+	vmode->mhsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
+	vmode->mvsyncpolarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
+	vmode->minterlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	vmode->mpixelclock = mode->htotal * mode->vtotal *
+		drm_mode_vrefresh(mode);
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
@@ -1272,38 +1269,40 @@ static void hdmi_av_composer(struct imx_hdmi *hdmi)
 
 	hdmi_writeb(hdmi, inv_val, HDMI_FC_INVIDCONF);
 
-	/* Set up horizontal active pixel region width */
-	hdmi_writeb(hdmi, fb_mode->xres >> 8, HDMI_FC_INHACTV1);
-	hdmi_writeb(hdmi, fb_mode->xres, HDMI_FC_INHACTV0);
+	/* Set up horizontal active pixel width */
+	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
+	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
 
-	/* Set up vertical blanking pixel region width */
-	hdmi_writeb(hdmi, fb_mode->yres >> 8, HDMI_FC_INVACTV1);
-	hdmi_writeb(hdmi, fb_mode->yres, HDMI_FC_INVACTV0);
+	/* Set up vertical active lines */
+	hdmi_writeb(hdmi, mode->vdisplay >> 8, HDMI_FC_INVACTV1);
+	hdmi_writeb(hdmi, mode->vdisplay, HDMI_FC_INVACTV0);
 
 	/* Set up horizontal blanking pixel region width */
-	hblank = fb_mode->left_margin + fb_mode->right_margin +
-		fb_mode->hsync_len;
+	hblank = mode->htotal - mode->hdisplay;
 	hdmi_writeb(hdmi, hblank >> 8, HDMI_FC_INHBLANK1);
 	hdmi_writeb(hdmi, hblank, HDMI_FC_INHBLANK0);
 
 	/* Set up vertical blanking pixel region width */
-	vblank = fb_mode->upper_margin + fb_mode->lower_margin +
-		fb_mode->vsync_len;
+	vblank = mode->vtotal - mode->vdisplay;
 	hdmi_writeb(hdmi, vblank, HDMI_FC_INVBLANK);
 
 	/* Set up HSYNC active edge delay width (in pixel clks) */
-	hdmi_writeb(hdmi, fb_mode->right_margin >> 8, HDMI_FC_HSYNCINDELAY1);
-	hdmi_writeb(hdmi, fb_mode->right_margin, HDMI_FC_HSYNCINDELAY0);
+	h_de_hs = mode->hsync_start - mode->hdisplay;
+	hdmi_writeb(hdmi, h_de_hs >> 8, HDMI_FC_HSYNCINDELAY1);
+	hdmi_writeb(hdmi, h_de_hs, HDMI_FC_HSYNCINDELAY0);
 
 	/* Set up VSYNC active edge delay (in pixel clks) */
-	hdmi_writeb(hdmi, fb_mode->lower_margin, HDMI_FC_VSYNCINDELAY);
+	v_de_vs = mode->vsync_start - mode->vdisplay;
+	hdmi_writeb(hdmi, v_de_vs, HDMI_FC_VSYNCINDELAY);
 
 	/* Set up HSYNC active pulse width (in pixel clks) */
-	hdmi_writeb(hdmi, fb_mode->hsync_len >> 8, HDMI_FC_HSYNCINWIDTH1);
-	hdmi_writeb(hdmi, fb_mode->hsync_len, HDMI_FC_HSYNCINWIDTH0);
+	hsync_len = mode->hsync_end - mode->hsync_start;
+	hdmi_writeb(hdmi, hsync_len >> 8, HDMI_FC_HSYNCINWIDTH1);
+	hdmi_writeb(hdmi, hsync_len, HDMI_FC_HSYNCINWIDTH0);
 
 	/* Set up VSYNC active edge delay (in pixel clks) */
-	hdmi_writeb(hdmi, fb_mode->vsync_len, HDMI_FC_VSYNCINWIDTH);
+	vsync_len = mode->vsync_end - mode->vsync_start;
+	hdmi_writeb(hdmi, vsync_len, HDMI_FC_VSYNCINWIDTH);
 }
 
 static void imx_hdmi_phy_disable(struct imx_hdmi *hdmi)
@@ -1383,42 +1382,13 @@ static void hdmi_disable_overflow_interrupts(struct imx_hdmi *hdmi)
 		    HDMI_IH_MUTE_FC_STAT2);
 }
 
-static inline void
-convert_to_video_timing(struct fb_videomode *timing,
-			struct drm_display_mode *mode)
-{
-	memset(timing, 0, sizeof(*timing));
-
-	timing->pixclock = mode->clock * 1000;
-	timing->refresh = drm_mode_vrefresh(mode);
-
-	timing->xres = mode->hdisplay;
-	timing->left_margin = mode->hsync_start - mode->hdisplay;
-	timing->hsync_len = mode->hsync_end - mode->hsync_start;
-	timing->right_margin = mode->htotal - mode->hsync_end;
-
-	timing->yres = mode->vdisplay;
-	timing->upper_margin = mode->vsync_start - mode->vdisplay;
-	timing->vsync_len = mode->vsync_end - mode->vsync_start;
-	timing->lower_margin = mode->vtotal - mode->vsync_end;
-
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		timing->vmode = FB_VMODE_INTERLACED;
-	else
-		timing->vmode = FB_VMODE_NONINTERLACED;
-
-	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
-		timing->vmode |= FB_VMODE_DOUBLE;
-}
-
 static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
-	convert_to_video_timing(&hdmi->fb_mode, mode);
 
 	hdmi_disable_overflow_interrupts(hdmi);
 
-	hdmi->vic = 6;
+	hdmi->vic = drm_match_cea_mode(mode);
 
 	if (!hdmi->vic) {
 		dev_dbg(hdmi->dev, "Non-CEA mode used in HDMI\n");
@@ -1461,7 +1431,7 @@ static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
 	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;
 
 	/* HDMI Initialization Step B.1 */
-	hdmi_av_composer(hdmi);
+	hdmi_av_composer(hdmi, mode);
 
 	/* HDMI Initializateion Step B.2 */
 	ret = imx_hdmi_phy_init(hdmi);
