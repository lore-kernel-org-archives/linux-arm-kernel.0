From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:54 +0200
Subject: [RFC PATCH 12/16] Add DEVM_TEGRA_OUTPUT()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-13-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/tegra/drm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 70930d262caf..8427f6b0832b 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -236,6 +236,21 @@ void tegra_output_connector_destroy(struct drm_connector *connector);
 
 void tegra_output_encoder_destroy(struct drm_encoder *encoder);
 
+static inline int devm_acquire_tegra_output(struct device *dev,
+					    const struct devm_resource *resource)
+{
+	struct tegra_output *output = dev_get_drvdata(dev) + resource->offset;
+
+	output->dev = dev;
+
+	return tegra_output_probe(output);
+}
+
+#define DEVM_TEGRA_OUTPUT(_struct, _member) {				\
+	.initfunc = devm_acquire_tegra_output,				\
+	.offset = offsetof_t(struct _struct, _member, struct tegra_output),	\
+}
+
 /* from dpaux.c */
 struct tegra_dpaux;
 struct drm_dp_link;
-- 
2.4.3
