From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 17 Aug 2017 15:16:12 +0800
Subject: [PATCH 1/3] media: atmel-isc: Not support RBG format from sensor.
In-Reply-To: <20170817071614.12767-1-wenyou.yang@microchip.com>
References: <20170817071614.12767-1-wenyou.yang@microchip.com>
Message-ID: <20170817071614.12767-2-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 12-bit parallel interface supports the Raw Bayer, YCbCr,
Monochrome and JPEG Compressed pixel formats from the external
sensor, not support RBG pixel format.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

 drivers/media/platform/atmel/atmel-isc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index d4df3d4ccd85..535bb03783fe 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -1478,6 +1478,11 @@ static int isc_formats_init(struct isc_device *isc)
 	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code,
 	       NULL, &mbus_code)) {
 		mbus_code.index++;
+
+		/* Not support the RGB pixel formats from sensor */
+		if ((mbus_code.code & 0xf000) == 0x1000)
+			continue;
+
 		fmt = find_format_by_code(mbus_code.code, &i);
 		if (!fmt)
 			continue;
-- 
2.13.0
