From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  4 Jan 2017 10:55:51 +0100
Subject: [PATCH 1/2] drm/meson: Fix CVBS initialization when HDMI is
 configured by bootloader
In-Reply-To: <1483523752-14705-1-git-send-email-narmstrong@baylibre.com>
References: <1483523752-14705-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1483523752-14705-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the HDMI output is configured by the bootloader, there is mismatch is the
pipeline configuration and the Vsync interrupt fails to trigger.

This commit disables the HDMI blocks in the probe phase.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index d836b22..f7c87017 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -38,6 +38,11 @@
  * - TV Panel encoding via ENCT
  */
 
+/* HHI Registers */
+#define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
+#define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
+#define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
+
 struct meson_cvbs_enci_mode meson_cvbs_enci_pal = {
 	.mode_tag = MESON_VENC_MODE_CVBS_PAL,
 	.hso_begin = 3,
@@ -242,6 +247,20 @@ void meson_venc_disable_vsync(struct meson_drm *priv)
 
 void meson_venc_init(struct meson_drm *priv)
 {
+	/* Disable CVBS VDAC */
+	regmap_write(priv->hhi, HHI_VDAC_CNTL0, 0);
+	regmap_write(priv->hhi, HHI_VDAC_CNTL1, 8);
+
+	/* Power Down Dacs */
+	writel_relaxed(0xff, priv->io_base + _REG(VENC_VDAC_SETTING));
+
+	/* Disable HDMI PHY */
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
+
+	/* Disable HDMI */
+	writel_bits_relaxed(0x3, 0,
+			    priv->io_base + _REG(VPU_HDMI_SETTING));
+
 	/* Disable all encoders */
 	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
-- 
1.9.1
