From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Feb 2018 18:23:56 +0100
Subject: [PATCH v2] drm: exynos: Use proper macro definition for
 HDMI_I2S_PIN_SEL_1
References: <CGME20180214172410epcas1p25bc3b963d508a4d34666f25f325af54d@epcas1p2.samsung.com>
Message-ID: <20180214172356.7013-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit field [2:0] of HDMI_I2S_PIN_SEL_1 corresponds to SDATA_0,
not SDATA_2. This patch removes redefinition of HDMI_I2S_SEL_DATA2
constant and adds missing HDMI_I2S_SEL_DATA0.
The value of bit field selecting SDATA_1 (pin_sel_3) is also changed,
so it is 3 as suggested in the Exynos TRMs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 7 +++++--
 drivers/gpu/drm/exynos/regs-hdmi.h   | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index a4b75a46f946..abd84cbcf1c2 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1068,10 +1068,13 @@ static void hdmi_audio_config(struct hdmi_context *hdata)
 	/* Configuration I2S input ports. Configure I2S_PIN_SEL_0~4 */
 	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_0, HDMI_I2S_SEL_SCLK(5)
 			| HDMI_I2S_SEL_LRCK(6));
-	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(1)
-			| HDMI_I2S_SEL_SDATA2(4));
+
+	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(3)
+			| HDMI_I2S_SEL_SDATA0(4));
+
 	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_2, HDMI_I2S_SEL_SDATA3(1)
 			| HDMI_I2S_SEL_SDATA2(2));
+
 	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_3, HDMI_I2S_SEL_DSD(0));
 
 	/* I2S_CON_1 & 2 */
diff --git a/drivers/gpu/drm/exynos/regs-hdmi.h b/drivers/gpu/drm/exynos/regs-hdmi.h
index 04be0f7e8193..4420c203ac85 100644
--- a/drivers/gpu/drm/exynos/regs-hdmi.h
+++ b/drivers/gpu/drm/exynos/regs-hdmi.h
@@ -464,7 +464,7 @@
 
 /* I2S_PIN_SEL_1 */
 #define HDMI_I2S_SEL_SDATA1(x)		(((x) & 0x7) << 4)
-#define HDMI_I2S_SEL_SDATA2(x)		((x) & 0x7)
+#define HDMI_I2S_SEL_SDATA0(x)		((x) & 0x7)
 
 /* I2S_PIN_SEL_2 */
 #define HDMI_I2S_SEL_SDATA3(x)		(((x) & 0x7) << 4)
-- 
2.14.2
