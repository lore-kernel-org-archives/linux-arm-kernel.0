From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 3 Nov 2015 13:45:11 +0800
Subject: [PATCH v2 4/5] media: atmel-isi: setup YCC_SWAP correctly when using
 preview path
In-Reply-To: <1446529512-19109-1-git-send-email-josh.wu@atmel.com>
References: <1446529512-19109-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1446529512-19109-5-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The preview path only can convert UYVY format to RGB data.

To make preview path work correctly, we need to set up YCC_SWAP
according to sensor output and convert them to UYVY.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

Changes in v2:
- remove cfg2_yuv_swap for rgb format
- correct the comment style

 drivers/media/platform/soc_camera/atmel-isi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index ae82068..826d04e 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -117,6 +117,20 @@ static u32 setup_cfg2_yuv_swap(struct atmel_isi *isi,
 		case MEDIA_BUS_FMT_YVYU8_2X8:
 			return ISI_CFG2_YCC_SWAP_MODE_1;
 		}
+	} else if (xlate->host_fmt->fourcc == V4L2_PIX_FMT_RGB565) {
+		/*
+		 * Preview path is enabled, it will convert UYVY to RGB format.
+		 * But if sensor output format is not UYVY, we need to set
+		 * YCC_SWAP_MODE to convert it as UYVY.
+		 */
+		switch (xlate->code) {
+		case MEDIA_BUS_FMT_VYUY8_2X8:
+			return ISI_CFG2_YCC_SWAP_MODE_1;
+		case MEDIA_BUS_FMT_YUYV8_2X8:
+			return ISI_CFG2_YCC_SWAP_MODE_2;
+		case MEDIA_BUS_FMT_YVYU8_2X8:
+			return ISI_CFG2_YCC_SWAP_MODE_3;
+		}
 	}
 
 	/*
-- 
1.9.1
