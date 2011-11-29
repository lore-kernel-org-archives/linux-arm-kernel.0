From: thomas@m3y3r.de (Thomas Meyer)
Date: Tue, 29 Nov 2011 22:08:00 +0100
Subject: [PATCH] [media] v4l: s5p-tv: Use kcalloc instead of kzalloc to
 allocate array
Message-ID: <1322600880.1534.314.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The advantage of kcalloc is, that will prevent integer overflows which could
result from the multiplication of number of elements and size and it is also
a bit nicer to read.

The semantic patch that makes this change is available
in https://lkml.org/lkml/2011/11/25/107

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/media/video/s5p-tv/hdmi_drv.c b/drivers/media/video/s5p-tv/hdmi_drv.c
--- a/drivers/media/video/s5p-tv/hdmi_drv.c 2011-11-13 11:07:31.380232715 +0100
+++ b/drivers/media/video/s5p-tv/hdmi_drv.c 2011-11-28 19:58:21.305922829 +0100
@@ -838,8 +838,8 @@ static int hdmi_resources_init(struct hd
 		dev_err(dev, "failed to get clock 'hdmiphy'\n");
 		goto fail;
 	}
-	res->regul_bulk = kzalloc(ARRAY_SIZE(supply) *
-		sizeof res->regul_bulk[0], GFP_KERNEL);
+	res->regul_bulk = kcalloc(ARRAY_SIZE(supply),
+				  sizeof(res->regul_bulk[0]), GFP_KERNEL);
 	if (!res->regul_bulk) {
 		dev_err(dev, "failed to get memory for regulators\n");
 		goto fail;
