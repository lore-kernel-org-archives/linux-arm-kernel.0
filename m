From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:45 +0100
Subject: [PATCH v3 19/24] drm/i2c: tda998x: use global constants
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195845.13b8a0e9@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index ce832f0..324dc13 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -132,6 +132,8 @@ struct tda998x_priv {
 # define VIP_CNTRL_5_CKCASE       (1 << 0)
 # define VIP_CNTRL_5_SP_CNT(x)    (((x) & 3) << 1)
 #define REG_MUX_AP                REG(0x00, 0x26)     /* read/write */
+# define MUX_AP_SELECT_I2S	  0x64
+# define MUX_AP_SELECT_SPDIF	  0x40
 #define REG_MUX_VP_VIP_OUT        REG(0x00, 0x27)     /* read/write */
 #define REG_MAT_CONTRL            REG(0x00, 0x80)     /* write */
 # define MAT_CONTRL_MAT_SC(x)     (((x) & 3) << 0)
@@ -209,10 +211,11 @@ struct tda998x_priv {
 #define REG_I2S_FORMAT            REG(0x00, 0xfc)     /* read/write */
 # define I2S_FORMAT(x)            (((x) & 3) << 0)
 #define REG_AIP_CLKSEL            REG(0x00, 0xfd)     /* write */
-# define AIP_CLKSEL_FS(x)         (((x) & 3) << 0)
-# define AIP_CLKSEL_CLK_POL(x)    (((x) & 1) << 2)
-# define AIP_CLKSEL_AIP(x)        (((x) & 7) << 3)
-
+# define AIP_CLKSEL_AIP_SPDIF     (0 << 3)
+# define AIP_CLKSEL_AIP_I2S       (1 << 3)
+# define AIP_CLKSEL_FS_ACLK       (0 << 0)
+# define AIP_CLKSEL_FS_MCLK       (1 << 0)
+# define AIP_CLKSEL_FS_FS64SPDIF  (2 << 0)
 
 /* Page 02h: PLL settings */
 #define REG_PLL_SERIAL_1          REG(0x02, 0x00)     /* read/write */
@@ -677,20 +680,18 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	/* Set audio input source */
 	switch (priv->audio_format) {
 	case AFMT_SPDIF:
-		reg_write(priv, REG_MUX_AP, 0x40);
-		clksel_aip = AIP_CLKSEL_AIP(0);
-		/* FS64SPDIF */
-		clksel_fs = AIP_CLKSEL_FS(2);
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
+		clksel_aip = AIP_CLKSEL_AIP_SPDIF;
+		clksel_fs = AIP_CLKSEL_FS_FS64SPDIF;
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		aclk = 0;				/* no clock */
 		ca_i2s = 0;
 		break;
 
 	case AFMT_I2S:
-		reg_write(priv, REG_MUX_AP, 0x64);
-		clksel_aip = AIP_CLKSEL_AIP(1);
-		/* ACLK */
-		clksel_fs = AIP_CLKSEL_FS(0);
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
+		clksel_aip = AIP_CLKSEL_AIP_I2S;
+		clksel_fs = AIP_CLKSEL_FS_ACLK;
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		aclk = 1;				/* clock enable */
 		ca_i2s = CA_I2S_CA_I2S(0);
-- 
1.8.5.3
