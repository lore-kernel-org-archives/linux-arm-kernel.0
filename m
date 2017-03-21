From: nickey.yang@rock-chips.com (Nickey Yang)
Date: Tue, 21 Mar 2017 16:27:03 +0800
Subject: [PATCH] drm/mediatek: fix mtk_hdmi_setup_vendor_specific_infoframe
 mistake
Message-ID: <1490084823-3968-1-git-send-email-nickey.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtk_hdmi_setup_vendor_specific_infoframe will return before handle
mtk_hdmi_hw_send_info_frame.Because hdmi_vendor_infoframe_pack
returns the number of bytes packed into the binary buffer or
a negative error code on failure.
So correct it.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index c262512..b43aa29 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1062,7 +1062,7 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
 	}
 
 	err = hdmi_vendor_infoframe_pack(&frame, buffer, sizeof(buffer));
-	if (err) {
+	if (err < 0) {
 		dev_err(hdmi->dev, "Failed to pack vendor infoframe: %zd\n",
 			err);
 		return err;
-- 
1.9.1
