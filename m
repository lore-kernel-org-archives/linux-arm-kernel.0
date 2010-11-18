From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 18 Nov 2010 18:20:53 +0900
Subject: [PATCH 3/9] ARM: Samsung: Prepare audio header for new I2S driver
In-Reply-To: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
Message-ID: <1290072053-17377-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add new defined and data structures in order to prepare for
new I2S driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-samsung/include/plat/audio.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/audio.h b/arch/arm/plat-samsung/include/plat/audio.h
index 7712ff6..a0826ed 100644
--- a/arch/arm/plat-samsung/include/plat/audio.h
+++ b/arch/arm/plat-samsung/include/plat/audio.h
@@ -25,10 +25,34 @@ extern void s3c64xx_ac97_setup_gpio(int);
 #define S5PC100_SPDIF_GPG3 1
 extern void s5pc100_spdif_setup_gpio(int);
 
+struct samsung_i2s {
+/* If the Primary DAI has 5.1 Channels */
+#define QUIRK_PRI_6CHAN		(1 << 0)
+/* If the I2S block has a Stereo Overlay Channel */
+#define QUIRK_SEC_DAI		(1 << 1)
+/*
+ * If the I2S block has no internal prescalar or MUX (I2SMOD[10] bit)
+ * The Machine driver must provide suitably set clock to the I2S block.
+ */
+#define QUIRK_NO_MUXPSR		(1 << 2)
+#define QUIRK_NEED_RSTCLR	(1 << 3)
+	/* Quirks of the I2S controller */
+	u32 quirks;
+
+	/*
+	 * Array of clock names that can be used to generate I2S signals.
+	 * Also corresponds to clocks of I2SMOD[10]
+	 */
+	const char **src_clk;
+};
+
 /**
  * struct s3c_audio_pdata - common platform data for audio device drivers
  * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
+	union {
+		struct samsung_i2s i2s;
+	} type;
 };
-- 
1.6.2.5
