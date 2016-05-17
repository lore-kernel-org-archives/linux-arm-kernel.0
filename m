From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 23:56:06 +0800
Subject: [PATCH 1/6] drm: sun4i: do cleanup if RGB output init fails
In-Reply-To: <1463500571-28970-1-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
Message-ID: <1463500571-28970-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_rgb_init() can fail, which results in TCON failing to bind.
In this case we need to do cleanup, specificly unregistering the
dotclock, which is regmap based, and the regmap is registered as
part of the sun4i_tcon_bind().

Failing to do so results in a NULL pointer reference when the CCF
tries to turn off unused clocks.

Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9f19b0e08560..dea673275356 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -490,7 +490,11 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		return 0;
 	}
 
-	return sun4i_rgb_init(drm);
+	ret = sun4i_rgb_init(drm);
+	if (ret < 0)
+		goto err_free_clocks;
+
+	return 0;
 
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
-- 
2.8.1
