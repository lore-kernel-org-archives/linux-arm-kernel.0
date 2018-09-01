From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 01 Sep 2018 16:08:51 +0200
Subject: [PATCH v3 13/13] drm/tegra: kick out simplefb
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <b5c3972e5774d0d1f8887054a993bbc54e9dbe2a.1535810304.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kick out firmware fb when loading Tegra driver.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/tegra/drm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 7afe2f635f74..b51ec138fed2 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1203,6 +1203,10 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	dev_set_drvdata(&dev->dev, drm);
 
+	err = drm_fb_helper_remove_conflicting_framebuffers(NULL, "tegradrmfb", false);
+	if (err < 0)
+		goto unref;
+
 	err = drm_dev_register(drm, 0);
 	if (err < 0)
 		goto unref;
-- 
2.18.0
