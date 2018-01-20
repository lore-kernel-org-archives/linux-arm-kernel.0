From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Sat, 20 Jan 2018 19:50:21 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE correctly
In-Reply-To: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On previous handling, if specified DRM_MODE_FLAG_N*SYNC,
it was ignored,
because only PHSYNC and PVSYNC were taken into account.
DRM_MODE_FLAG_P*SYNC and DRM_MODE_FLAG_N*SYNC are not exclusive.

If flags contains PVSYNC, it doesn't mean it is NVSYNC.
And it's true also the contrary.
Also, as I've checked with scope on A20,
if (flags & PVSYNC) then SUN4I_TCON0_IO_POL_VSYNC_POSITIVE
must be set, as name suggests.
It seems all display io polarities starts inverted if 0.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

PVSYNC and PHSYNC only

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 6121210..e873a37 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -224,10 +224,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 		     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
 
 	/* Setup the polarity of the various signals */
-	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
 
-	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
 	if(display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
-- 
2.7.4
