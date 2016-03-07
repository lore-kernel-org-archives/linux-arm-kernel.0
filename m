From: dianders@chromium.org (Douglas Anderson)
Date: Mon,  7 Mar 2016 14:00:53 -0800
Subject: [PATCH v2 4/5] drm/rockchip: dw_hdmi: Don't call
 platform_set_drvdata()
In-Reply-To: <1457388054-23077-1-git-send-email-dianders@chromium.org>
References: <1457388054-23077-1-git-send-email-dianders@chromium.org>
Message-ID: <1457388054-23077-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip dw_hdmi driver just called platform_set_drvdata() to get
your hopes up that maybe, somehow, you'd be able to retrieve the 'struct
rockchip_hdmi' from a pointer to the 'struct device'.  You can't.  When
we call dw_hdmi_bind() the main driver calls dev_set_drvdata(), which
clobbers our setting.

Let's just remove the platform_set_drvdata() to avoid dashing people's
hopes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Don't call platform_set_drvdata() new for v2.

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 88776aba984e..d5cfef75fc80 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -271,8 +271,6 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (!iores)
 		return -ENXIO;
 
-	platform_set_drvdata(pdev, hdmi);
-
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
-- 
2.7.0.rc3.207.g0ac5344
