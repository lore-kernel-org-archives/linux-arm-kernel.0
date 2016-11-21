From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 18:16:16 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121175602.GM1041@n2100.armlinux.org.uk>
References: <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
 <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
 <20161121140349.GG1041@n2100.armlinux.org.uk>
 <20161121173231.GM1005@e106497-lin.cambridge.arm.com>
 <20161121175602.GM1041@n2100.armlinux.org.uk>
Message-ID: <20161121181616.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 05:56:02PM +0000, Russell King - ARM Linux wrote:
> For me, the image shift was 100% reproducable.  With the above patch
> and a call to drm_crtc_vblank_on() in the enable path, it seems to
> behave correctly - I can alternately switch between 1920x1080 and
> 1280x1024 and it behaves correctly.  Indeed, my debug prints show that
> the right thing is happening wrt disabling the controller:

Here's my version of your patch:

8<=============
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] drm/arm: hdlcd: fix plane base address update

While testing HDMI with Xorg on the Juno board, I find that when Xorg
starts up or shuts down, the display is shifted significantly to the
right and wrapped in the active region.  (No sync bars are visible.)
The timings are correct, it behaves as if the start address has been
shifted many pixels _into_ the framebuffer.

This occurs whenever the display mode size is changed - using xrandr
in Xorg shows that changing the resolution triggers the problem
almost every time, but changing the refresh rate does not.

Using devmem2 to disable and re-enable the HDLCD resolves the issue,
and repeated disable/enable cycles do not make the issue re-appear.
Further debugging shows that we try to update the controller
configuration while enabled.

Alwys ensure that the HDLCD is disabled prior to updating the
controller timings, and use drm_crtc_vblank_off()/drm_crtc_vblank_on()
so that DRM knows whether it can expect vblank interrupts.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/arm/hdlcd_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index c239616f5334..9d683be2e5d3 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -151,15 +151,14 @@ static void hdlcd_crtc_enable(struct drm_crtc *crtc)
 	clk_prepare_enable(hdlcd->clk);
 	hdlcd_crtc_mode_set_nofb(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
+	drm_crtc_vblank_on(crtc);
 }
 
 static void hdlcd_crtc_disable(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 
-	if (!crtc->state->active)
-		return;
-
+	drm_crtc_vblank_off(crtc);
 	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
 	clk_disable_unprepare(hdlcd->clk);
 }
-- 
2.7.4

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
