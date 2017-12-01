From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:45 +0100
Subject: [PATCH v2 22/27] drm/sun4i: Add CCSC property to DE2 configuration
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-23-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base addresses of channel output CSC (CCSC) depends whether mixer in
question is first or second and if it is second, if supports VEP or not.
This new property will tell which set of base addresses to take.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index e3296a060352..7f88cf5f97eb 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -337,6 +337,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
 	.scaler_mask = 0x3,
+	.ccsc = 0,
 };
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 9bbd762d26f7..994090858b18 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -98,11 +98,16 @@ struct de2_fmt_info {
  *	First, scaler supports for VI channels is defined and after that, scaler
  *	support for UI channels. For example, if mixer has 2 VI channels without
  *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
+ * @ccsc: select set of CCSC base addresses
+ *	Set value to 0 if this is first mixer or second mixer with VEP support.
+ *	Set value to 1 if this is second mixer without VEP support. Other values
+ *	are invalid.
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
 	int		ui_num;
 	int		scaler_mask;
+	int		ccsc;
 };
 
 struct sun8i_mixer {
-- 
2.15.1
