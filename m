From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 17 Jul 2018 10:52:29 +0200
Subject: [PATCH 1/2] drm/sun4i: sun4i: Register quirks with the backend
 structure
Message-ID: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In prevision for introducing a new quirk that will be used at atomic
plane check time, register the quirks structure with the backend
structure. This way, it can easily be grabbed where needed.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 17dca4df00f2..a3cc398d4d80 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -909,6 +909,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 				    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
 	}
 
+	backend->quirks = quirks;
+
 	return 0;
 
 err_disable_ram_clk:
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index e33be2307c67..71de6147b483 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -187,6 +187,8 @@ struct sun4i_backend {
 	/* Protects against races in the frontend teardown */
 	spinlock_t		frontend_lock;
 	bool			frontend_teardown;
+
+	const struct sun4i_backend_quirks	*quirks;
 };
 
 static inline struct sun4i_backend *
-- 
2.17.1
