From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  4 Mar 2011 21:51:19 +0100
Subject: [PATCH 3/6] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <20110304205008.GX22310@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
Message-ID: <1299271882-2130-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to memzero the buffer because dma_alloc_coherent zeros
the memory for us.

This fixes:

	BUG: Your driver calls ioremap() on system memory.  This leads
	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
	<4>will fail in the next kernel release.  Please fix your driver.

Tested-by: Michael Grzeschik <mgr@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm037.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index f07d3bd..497b39b 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -31,6 +31,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/gfp.h>
+#include <linux/memblock.h>
 
 #include <media/soc_camera.h>
 
@@ -410,25 +411,16 @@ struct mx3_camera_pdata camera_pdata = {
 	.mclk_10khz	= 2000,
 };
 
-static int __init pcm037_camera_alloc_dma(const size_t buf_size)
+static phys_addr_t mx3_camera_base __initdata;
+#define MX3_CAMERA_BUF_SIZE SZ_4M
+
+static int __init pcm037_camera_alloc_dma(void)
 {
-	dma_addr_t dma_handle;
-	void *buf;
 	int dma;
 
-	if (buf_size < 2 * 1024 * 1024)
-		return -EINVAL;
-
-	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
-	if (!buf) {
-		pr_err("%s: cannot allocate camera buffer-memory\n", __func__);
-		return -ENOMEM;
-	}
-
-	memset(buf, 0, buf_size);
-
 	dma = dma_declare_coherent_memory(&mx3_camera.dev,
-					dma_handle, dma_handle, buf_size,
+					mx3_camera_base, mx3_camera_base,
+					MX3_CAMERA_BUF_SIZE,
 					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
 
 	/* The way we call dma_declare_coherent_memory only a malloc can fail */
@@ -649,7 +641,7 @@ static void __init pcm037_init(void)
 	else
 		iclink_mt9t031.power = NULL;
 
-	if (!pcm037_camera_alloc_dma(4 * 1024 * 1024))
+	if (!pcm037_camera_alloc_dma())
 		mxc_register_device(&mx3_camera, &camera_pdata);
 
 	platform_device_register(&pcm970_sja1000);
@@ -680,9 +672,19 @@ struct sys_timer pcm037_timer = {
 	.init	= pcm037_timer_init,
 };
 
+static void __init pcm037_reserve(void)
+{
+	/* reserve 4 MiB for mx3-camera */
+	mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
+			MX3_CAMERA_BUF_SIZE);
+	memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+	memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+}
+
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.reserve = pcm037_reserve,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-- 
1.7.2.3
