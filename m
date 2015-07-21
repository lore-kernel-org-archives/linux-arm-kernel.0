From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:53 +0200
Subject: [RFC PATCH 11/16] Add DEVM_TEGRA_DPAUX()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-12-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/tegra/dpaux.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/tegra/drm.h   |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 07b26972f487..512322c58c43 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -569,3 +569,27 @@ int tegra_dpaux_train(struct tegra_dpaux *dpaux, struct drm_dp_link *link,
 
 	return 0;
 }
+
+int devm_acquire_tegra_dpaux(struct device *dev,
+			     const struct devm_resource *resource)
+{
+	struct device_node *np;
+	struct tegra_dpaux *dpaux, **dpauxp;
+
+	np = of_parse_phandle(dev->of_node, resource->name, 0);
+	if (!np)
+		return 0;
+
+	dpaux = tegra_dpaux_find_by_of_node(np);
+	of_node_put(np);
+
+	dev_warn(dev, "dpaux device '%s' not probed yet\n", of_node_full_name(np));
+
+	if (!dpaux)
+		return -EPROBE_DEFER;
+
+	dpauxp = dev_get_drvdata(dev) + resource->offset;
+	*dpauxp = dpaux;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 659b2fcc986d..70930d262caf 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -250,6 +250,15 @@ int tegra_dpaux_prepare(struct tegra_dpaux *dpaux, u8 encoding);
 int tegra_dpaux_train(struct tegra_dpaux *dpaux, struct drm_dp_link *link,
 		      u8 pattern);
 
+int devm_acquire_tegra_dpaux(struct device *dev,
+			     const struct devm_resource *resource);
+
+#define DEVM_TEGRA_DPAUX(_struct, _member, _name) {			\
+	.initfunc = devm_acquire_tegra_dpaux,				\
+	.offset = offsetof_t(struct _struct, _member, struct tegra_dpaux *),\
+	.name = _name,							\
+}
+
 /* from fb.c */
 struct tegra_bo *tegra_fb_get_plane(struct drm_framebuffer *framebuffer,
 				    unsigned int index);
-- 
2.4.3
