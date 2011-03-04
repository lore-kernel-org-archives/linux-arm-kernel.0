From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  4 Mar 2011 21:51:20 +0100
Subject: [PATCH 4/6] ARM: mx3/mx31moboard: properly allocate memory for
	mx3-camera
In-Reply-To: <20110304205008.GX22310@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
Message-ID: <1299271882-2130-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not allowed to create an alias of system RAM for DMA.  So the memory
used must not be allocated using dma_alloc_coherent but has to be reserved
before using memblock routines.

There is no need to memzero the buffer because dma_alloc_coherent zeros
the memory for us.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31moboard.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 6f3692b..5dca8b4 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/memblock.h>
 
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -471,27 +472,17 @@ static struct mx3_camera_pdata camera_pdata = {
 	.mclk_10khz	= 4800,
 };
 
-#define CAMERA_BUF_SIZE	(4*1024*1024)
+static phys_addr_t mx3_camera_base __initdata;
+#define MX3_CAMERA_BUF_SIZE SZ_4M
 
-static int __init mx31moboard_cam_alloc_dma(const size_t buf_size)
+static int __init mx31moboard_cam_alloc_dma(void)
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
 
 	dma = dma_declare_coherent_memory(&mx3_camera.dev,
-					dma_handle, dma_handle, buf_size,
+					mx3_camera_base, mx3_camera_base,
+					MX3_CAMERA_BUF_SIZE,
 					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
 
 	/* The way we call dma_declare_coherent_memory only a malloc can fail */
@@ -528,7 +519,7 @@ static void __init mx31moboard_init(void)
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
-	if (!mx31moboard_cam_alloc_dma(CAMERA_BUF_SIZE))
+	if (!mx31moboard_cam_alloc_dma())
 		mxc_register_device(&mx3_camera, &camera_pdata);
 
 	usb_xcvr_reset();
@@ -563,9 +554,19 @@ struct sys_timer mx31moboard_timer = {
 	.init	= mx31moboard_timer_init,
 };
 
+static void __init mx31moboard_reserve(void)
+{
+	/* reserve 4 MiB for mx3-camera */
+	mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
+			MX3_CAMERA_BUF_SIZE);
+	memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+	memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+}
+
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.reserve = mx31moboard_reserve,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-- 
1.7.2.3
