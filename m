From: peda@axentia.se (Peter Rosin)
Date: Mon, 26 Mar 2018 23:24:45 +0200
Subject: [PATCH v2 3/5] drm: of: add display bus-format parser
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
Message-ID: <20180326212447.7380-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a common API to parse display bus format strings into fourcc codes.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bus-format.txt     | 35 +++++++++++++
 drivers/gpu/drm/drm_of.c                           | 59 ++++++++++++++++++++++
 include/drm/drm_of.h                               |  9 ++++
 3 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bus-format.txt

diff --git a/Documentation/devicetree/bindings/display/bus-format.txt b/Documentation/devicetree/bindings/display/bus-format.txt
new file mode 100644
index 000000000000..590e6c73f3dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bus-format.txt
@@ -0,0 +1,35 @@
+Bus formats in the display pipe
+===============================
+
+Various encoders in display controllers output the pixels in different
+formats. Circuits handling display connectors and hardwired panels also
+expect pixel input in various formats. We call these formats bus formats.
+
+Some bus formats are:
+
+Parallel
+--------
+
+rgb888
+	8 parallel lines for red, green and blue respectively. There are
+	also lines for the pixel-clock, horizontal-sync, vertical-sync
+	and data-enable.
+
+rgb666
+	Same as rgb888, but with 6 lines per color.
+
+rgb565
+	Same as rgb888, but with 6 green lines and 5 red and blue lines.
+
+rgb444
+	Same as rgb888, but with 4 lines per color.
+
+
+LVDS
+----
+
+jeida-18
+jeida-24
+vesa-24
+	These are LVDS bus formats, see the data-mapping property in
+	panel/panel-lvds.txt for a description of these bus formats.
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4c191c050e7d..5f65471225bb 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -262,3 +262,62 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
+
+/*
+ * drm_of_bus_formats - parse list of bus format strings into drm fourcc
+ * @np: device tree node containing bus format property
+ * @propname: name of bus format property
+ * @bus_formats: array of parsed fourcc codes
+ *
+ * On success, @bus_formats points to a location where the actual drm
+ * fourcc codes are.
+ * WARNING: The caller is responsible for freeing this memory with kfree.
+ *
+ * Returns the number of parsed bus format entries, or one of the standard
+ * error codes on failure.
+ */
+int drm_of_bus_formats(const struct device_node *np, const char *propname,
+		       u32 **bus_formats)
+{
+	int num_bus_formats = of_property_count_strings(np, propname);
+	const char *fmt;
+	int ret;
+	int i;
+
+	if (num_bus_formats <= 0)
+		return num_bus_formats;
+
+	*bus_formats = kmalloc(num_bus_formats * sizeof(**bus_formats),
+			       GFP_KERNEL);
+	if (!*bus_formats)
+		return -ENOMEM;
+
+	for (i = 0; i < num_bus_formats; ++i) {
+		ret = of_property_read_string_index(np, propname, i, &fmt);
+		if (ret < 0)
+			return ret;
+
+		if (!strcmp(fmt, "rgb444")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB444_1X12;
+		} else if (!strcmp(fmt, "rgb565")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB565_1X16;
+		} else if (!strcmp(fmt, "rgb666")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB666_1X18;
+		} else if (!strcmp(fmt, "rgb888")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X24;
+		} else if (!strcmp(fmt, "jeida-18")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG;
+		} else if (!strcmp(fmt, "jeida-24")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
+		} else if (!strcmp(fmt, "vesa-24")) {
+			*bus_formats[i] = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
+		} else {
+			kfree(*bus_formats);
+			*bus_formats = NULL;
+			return -EINVAL;
+		}
+	}
+
+	return num_bus_formats;
+}
+EXPORT_SYMBOL_GPL(drm_of_bus_formats);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..ccacddc03a2e 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -33,6 +33,8 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge);
+int drm_of_bus_formats(const struct device_node *np, const char *propname,
+		       u32 **bus_formats);
 #else
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 						  struct device_node *port)
@@ -69,6 +71,13 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 {
 	return -EINVAL;
 }
+
+static inline int drm_of_bus_formats(const struct device_node *np,
+				     const char *propname,
+				     u32 **bus_formats)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
-- 
2.11.0
