From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Mar 2018 09:21:16 +0100
Subject: [PATCH] drm/pl111: Enable device-specific assigned memory
Message-ID: <20180307082116.13568-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express has 8 MB of dedicated video RAM (VRAM)
on the motherboard, which is what we should be using for the
PL111 if available. On this platform, the memory backplane
is constructed so that only this memory will work properly
with the CLCD on the motherboard, using any other memory
region just gives random snow on the display.

The CA9 Versatile Express also has a PL111 instance on its
core tile. This is OK, it has been tested with the motherboard
VRAM and that works just as fine as regular CMA memory.

The memory is assigned to the device using the memory-region
device tree property and a "shared-dma-pool" reserved
memory pool like this:

reserved-memory {
        #address-cells = <1>;
        #size-cells = <1>;
        ranges;

        vram: vram at 48000000 {
                compatible = "shared-dma-pool";
                reg = <0x48000000 0x00800000>;
                no-map;
        };
};

clcd at 1f000 {
        compatible = "arm,pl111", "arm,primecell";
	(...)
        memory-region = <&vram>;
}?;

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index b469aa317d9d..e301f2a719a3 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -60,6 +60,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
@@ -262,6 +263,10 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	drm->dev_private = priv;
 	priv->variant = variant;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (!ret)
+		dev_info(dev, "using device-specific reserved memory\n");
+
 	if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
 				 &priv->memory_bw)) {
 		dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
-- 
2.14.3
