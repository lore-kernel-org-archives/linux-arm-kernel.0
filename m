From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 06 Oct 2013 23:11:56 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131006220728.GG12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
Message-ID: <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/armada/Kconfig      |    9 +++++++
 drivers/gpu/drm/armada/armada_drv.c |   42 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
index c7a0a94..87e62dd 100644
--- a/drivers/gpu/drm/armada/Kconfig
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -13,3 +13,12 @@ config DRM_ARMADA
 	  This driver provides no built-in acceleration; acceleration is
 	  performed by other IP found on the SoC.  This driver provides
 	  kernel mode setting and buffer management to userspace.
+
+config DRM_ARMADA_TDA1998X
+	bool "Support TDA1998X HDMI output"
+	depends on DRM_ARMADA != n
+	depends on I2C && DRM_I2C_NXP_TDA998X = y
+	default y
+	help
+	  Support the TDA1998x HDMI output device found on the Solid-Run
+	  CuBox.
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index db62f1b..69517cf 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -16,6 +16,42 @@
 #include <drm/armada_drm.h>
 #include "armada_ioctlP.h"
 
+#ifdef CONFIG_DRM_ARMADA_TDA1998X
+#include <drm/i2c/tda998x.h>
+#include "armada_slave.h"
+
+static struct tda998x_encoder_params params = {
+	/* With 0x24, there is no translation between vp_out and int_vp
+	FB	LCD out	Pins	VIP	Int Vp
+	R:23:16	R:7:0	VPC7:0	7:0	7:0[R]
+	G:15:8	G:15:8	VPB7:0	23:16	23:16[G]
+	B:7:0	B:23:16	VPA7:0	15:8	15:8[B]
+	*/
+	.swap_a = 2,
+	.swap_b = 3,
+	.swap_c = 4,
+	.swap_d = 5,
+	.swap_e = 0,
+	.swap_f = 1,
+	.audio_cfg = BIT(2),
+	.audio_frame[1] = 1,
+	.audio_format = AFMT_SPDIF,
+	.audio_sample_rate = 44100,
+};
+
+static const struct armada_drm_slave_config tda19988_config = {
+	.i2c_adapter_id = 0,
+	.crtcs = 1 << 0, /* Only LCD0@the moment */
+	.polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT,
+	.interlace_allowed = true,
+	.info = {
+		.type = "tda998x",
+		.addr = 0x70,
+		.platform_data = &params,
+	},
+};
+#endif
+
 static void armada_drm_unref_work(struct work_struct *work)
 {
 	struct armada_private *priv =
@@ -134,6 +170,12 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 			goto err_kms;
 	}
 
+#ifdef CONFIG_DRM_ARMADA_TDA1998X
+	ret = armada_drm_connector_slave_create(dev, &tda19988_config);
+	if (ret)
+		goto err_kms;
+#endif
+
 	ret = drm_vblank_init(dev, n);
 	if (ret)
 		goto err_kms;
-- 
1.7.4.4
