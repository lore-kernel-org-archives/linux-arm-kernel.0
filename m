From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Nov 2012 15:40:20 +0000
Subject: [PATCH] ARM: SAMSUNG: Fix build of I2S driver
Message-ID: <1353944420-3972-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 48a2050d36f0da5a7d22e3bd7dbf3bf8a5a538bc (ARM: SAMSUNG: Delete
the unnecessary variable) removed the src_clk field from the platform
data header for the I2S driver without a corresponding change having
been made in the I2S driver to stop using the field, causing build
breaks.

This change should not be being made independently of removal of the
uses of the field since it will cause build failures in any tree where
it has been merged but the removals have not been merged.  Currently
the removal of the users in the ASoC driver has not been merged.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/platform_data/asoc-s3c.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 8827259..aa9875f 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -38,6 +38,12 @@ struct samsung_i2s {
 #define QUIRK_NEED_RSTCLR	(1 << 3)
 	/* Quirks of the I2S controller */
 	u32 quirks;
+
+	/*
+	 * Array of clock names that can be used to generate I2S signals.
+	 * Also corresponds to clocks of I2SMOD[10]
+	 */
+	const char **src_clk;
 	dma_addr_t idma_addr;
 };
 
-- 
1.7.10.4
