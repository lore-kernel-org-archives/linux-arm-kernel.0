From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Mar 2017 22:11:40 +0100
Subject: [PATCH] firmware: ti_sci: fix strncat length check
Message-ID: <20170314211157.3424031-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-7 notices that the length we pass to strncat is wrong:

drivers/firmware/ti_sci.c: In function 'ti_sci_probe':
drivers/firmware/ti_sci.c:204:32: error: specified bound 50 equals the size of the destination [-Werror=stringop-overflow=]

Instead of the total length, we must pass the length of the
remaining space here.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally submitted on Jan 11, patch is still needed on Linux-4.11-rc2.
---
 drivers/firmware/ti_sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 874ff32db366..00cfed3c3e1a 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -202,7 +202,8 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	info->debug_buffer[info->debug_region_size] = 0;
 
 	info->d = debugfs_create_file(strncat(debug_name, dev_name(dev),
-					      sizeof(debug_name)),
+					      sizeof(debug_name) -
+					      sizeof("ti_sci_debug@")),
 				      0444, NULL, info, &ti_sci_debug_fops);
 	if (IS_ERR(info->d))
 		return PTR_ERR(info->d);
-- 
2.9.0
