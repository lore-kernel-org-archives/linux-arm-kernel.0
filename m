From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:33:00 +0100
Subject: [PATCH 07/11] drm/rockchip: attach rgb bridge to encoders needing it
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-8-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SoCs like the rk3288 the lvds controller needs to be configured even for
just providing rgb data to an attached encoder. As internals of the
rockchip drm driver should not leak into the implementation of generic
i2c encoders etc, go through the list of encoders and attach any necessary
rgb bridges when building the drm device in the load callback.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/video/rockchip-vop.txt     | 16 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 32 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/rockchip-vop.txt b/Documentation/devicetree/bindings/video/rockchip-vop.txt
index d15351f..b7762ed 100644
--- a/Documentation/devicetree/bindings/video/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/video/rockchip-vop.txt
@@ -32,6 +32,11 @@ Required properties:
 - port: A port node with endpoint definitions as defined in
   Documentation/devicetree/bindings/media/video-interfaces.txt.
 
+Optional properties in encoder nodes:
+- rockchip,rgb-bridge: if a separate controller is regulating access
+		to the rgb output interface it should be referenced
+		in the encoder node.
+
 Example:
 SoC specific DT entry:
 	vopb: vopb at ff930000 {
@@ -56,3 +61,14 @@ SoC specific DT entry:
 			};
 		};
 	};
+
+Additional entries when a rgb-bridge is used:
+
+	lvds: lvds at ff96c000 {
+		...
+	};
+
+	external-encoder {
+		...
+		rockchip,rgb-bridge = <&lvds>;
+	};
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 30da781..86a3e61 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -130,6 +130,7 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	struct dma_iommu_mapping *mapping;
 	struct device *dev = drm_dev->dev;
 	struct drm_connector *connector;
+	struct drm_encoder *encoder;
 	int ret;
 
 	private = devm_kzalloc(drm_dev->dev, sizeof(*private), GFP_KERNEL);
@@ -173,6 +174,37 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 		goto err_detach_device;
 
 	/*
+	 * Attach rgb bridge to encoders needing it.
+	 */
+	list_for_each_entry(encoder, &drm_dev->mode_config.encoder_list, head) {
+		struct device_node *rgb_node;
+
+		if (!encoder->of_node)
+			continue;
+
+		rgb_node = of_parse_phandle(encoder->of_node,
+					    "rockchip,rgb-bridge", 0);
+		if (rgb_node) {
+			struct drm_bridge *bridge;
+
+			bridge = of_drm_find_bridge(rgb_node);
+			of_node_put(rgb_node);
+			if (!bridge) {
+				ret = -EPROBE_DEFER;
+				goto err_unbind;
+			}
+
+			encoder->bridge = bridge;
+			bridge->encoder = encoder;
+			ret = drm_bridge_attach(encoder->dev, bridge);
+			if (ret) {
+				DRM_ERROR("Failed to attach bridge to drm\n");
+				goto err_unbind;
+			}
+		}
+	}
+
+	/*
 	 * All components are now added, we can publish the connector sysfs
 	 * entries to userspace.  This will generate hotplug events and so
 	 * userspace will expect to be able to access DRM at this point.
-- 
2.1.1
