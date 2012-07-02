From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 2 Jul 2012 13:12:41 +0200
Subject: [PATCH, RFC] i.MX DRM support
In-Reply-To: <20120702100506.GI24458@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <20120702100506.GI24458@pengutronix.de>
Message-ID: <4FF18229.7030907@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.07.2012 12:05, Sascha Hauer wrote:
> On Thu, Jun 14, 2012 at 03:43:22PM +0200, Sascha Hauer wrote:
>> Hi All,
>>
>> The following is the state-of-the-art i.MX IPU (Image Processing Unit)
>> DRM support.
>>
>> This code is around for quite some time now and has been posted several
>> times with different APIs, first with plain old framebuffer support, now
>> DRM, first platform device binding, now devicetree. Unfortunately there's
>> quite much code needed to get something useful out of the IPU, so these
>> patches haven't received a lot of attention from people not involved in
>> i.MX. I think we have now come to a point where this code needs more public
>> exposure and where it's easier to talk in incremental changes instead of
>> blobs. Therefore I request this to go to staging for some cycles.
> 
> Dave, Greg,
> 
> Comments to this one? I addressed the comments I received so far and am
> about to respin this series. Is it ok to put this to staging? If yes,
> should I move the whole stuff into drivers/staging/ or should it stay
> in drivers/gpu/drm with just a Kconfig dependency on STAGING?

We are very interested in this, so +1 from my side for this.

Many thanks and best regards

Dirk

Btw.: Based on

http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/work/gpu/imx-drm-ipu-complete

with [1] below I fixed some compiler warnings.

I have some additional warnings

drivers/gpu/drm/drm_edid.c: In function 'drm_find_cea_extension':
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds
drivers/gpu/drm/drm_edid.c: In function 'drm_detect_hdmi_monitor':
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds
drivers/gpu/drm/drm_edid.c: In function 'drm_detect_monitor_audio':
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds
drivers/gpu/drm/drm_edid.c: In function 'drm_edid_to_eld':
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds
drivers/gpu/drm/drm_edid.c: In function 'drm_add_edid_modes':
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds
drivers/gpu/drm/drm_edid.c:1466: warning: array subscript is above array 
bounds

but these seems to be compiler specific and not related to Sacha's patches.

[1]

From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/2] DRM i.MX: ldb: Fix compiler warnings

Fix the compiler warnings

drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_encoder_mode_fixup':
drivers/gpu/drm/imx/imx-ldb.c:118: warning: unused variable 'imx_ldb_ch'
drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_encoder_prepare':
drivers/gpu/drm/imx/imx-ldb.c:134: warning: format '%ld' expects type 
'long int', but argument 6 has type 'int'

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

---
  drivers/gpu/drm/imx/imx-ldb.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

Index: freescale-linux-2.6-imx.git/drivers/gpu/drm/imx/imx-ldb.c
===================================================================
--- freescale-linux-2.6-imx.git.orig/drivers/gpu/drm/imx/imx-ldb.c
+++ freescale-linux-2.6-imx.git/drivers/gpu/drm/imx/imx-ldb.c
@@ -115,9 +115,9 @@ static bool imx_ldb_encoder_mode_fixup(s
                            struct drm_display_mode *mode,
                            struct drm_display_mode *adjusted_mode)
  {
+/*
         struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);

-/*
         adjusted_mode->clock = clk_round_rate(imx_ldb_ch->clk_pll,
                         adjusted_mode->clock * 1000) / 1000;
  */
@@ -131,7 +131,7 @@ static void imx_ldb_encoder_prepare(stru
         int ret;
         struct drm_display_mode *mode = &encoder->crtc->mode;

-       dev_dbg(ldb->dev, "%s: now: %ld want: %ld\n", __func__,
+       dev_dbg(ldb->dev, "%s: now: %ld want: %d\n", __func__,
                         clk_get_rate(imx_ldb_ch->clk_pll),
                         mode->clock * 1000 * 7);
         clk_set_rate(imx_ldb_ch->clk_pll, mode->clock * 1000 * 7);
