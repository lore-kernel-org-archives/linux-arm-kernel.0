From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 12:03:45 +0900
Subject: [PATCH 1/1] drivers: i2c: silence a compile warning in i2c-s3c2410.c
Message-ID: <1389323025-4478-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If used 64 bit compiler GCC warns that:

drivers/i2c/busses/i2c-s3c2410.c: In function ?s3c24xx_get_device_quirks?:
drivers/i2c/busses/i2c-s3c2410.c:168:10: warning: cast from pointer to integer
of different size [-Wpointer-to-int-cast]

This patch fixes this by converting "unsigned int" to "unsigned long".

CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Wolfram Sang <wsa@the-dreams.de>
CC: linux-i2c at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/i2c/busses/i2c-s3c2410.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index bf8fb94..447dd98 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -101,7 +101,7 @@ enum s3c24xx_i2c_state {
 
 struct s3c24xx_i2c {
 	wait_queue_head_t	wait;
-	unsigned int            quirks;
+	unsigned long            quirks;
 	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
@@ -160,12 +160,13 @@ MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
  * Get controller type either from device tree or platform device variant.
 */
 
-static inline unsigned int s3c24xx_get_device_quirks(struct platform_device *pdev)
+static inline unsigned long
+	s3c24xx_get_device_quirks(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(s3c24xx_i2c_match, pdev->dev.of_node);
-		return (unsigned int)match->data;
+		return (unsigned long)match->data;
 	}
 
 	return platform_get_device_id(pdev)->driver_data;
-- 
1.7.10.4
