From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 27 May 2018 21:34:56 +0200
Subject: [PATCH] ARM: pxa: add the missing AC97 clocks
Message-ID: <20180527193456.3799-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AC97 bit clock is added as the pxa internally generated 13MHz
clock. This is a consequence of the new ac97 framework.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/devices.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d7c9a8476d57..018fbfc64851 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/platform_data/i2c-pxa.h>
@@ -496,6 +497,18 @@ struct platform_device pxa_device_ac97 = {
 
 void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
 {
+	int ret;
+
+	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:0", "AC97CLK",
+			   &pxa_device_ac97.dev);
+	if (ret)
+		pr_err("PXA AC97 clock1 alias error: %d\n", ret);
+
+	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:1", "AC97CLK",
+			    &pxa_device_ac97.dev);
+	if (ret)
+		pr_err("PXA AC97 clock2 alias error: %d\n", ret);
+
 	pxa_register_device(&pxa_device_ac97, ops);
 }
 
-- 
2.11.0
