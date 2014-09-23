From: asierra@xes-inc.com (Aaron Sierra)
Date: Tue, 23 Sep 2014 16:43:25 -0500 (CDT)
Subject: [RFT PATCH v2] mtd: ixp4xx: Unrequire CONFIG_MTD_CFI_BE_BYTE_SWAP
In-Reply-To: <474471133.324147.1411508523465.JavaMail.zimbra@xes-inc.com>
Message-ID: <1800715024.324263.1411508605796.JavaMail.zimbra@xes-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .swap member of the map_info structure is provided for situations
where a mapping must always be big or little endian regardless of the
endianness of the system performing the access.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
v2: Account for 32-bit swapping

 drivers/mtd/maps/ixp4xx.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
index 6a589f1..541727e 100644
--- a/drivers/mtd/maps/ixp4xx.c
+++ b/drivers/mtd/maps/ixp4xx.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/cfi_endian.h>
 
 #include <asm/io.h>
 #include <asm/mach/flash.h>
@@ -48,43 +49,30 @@
  *     | C | D | 2
  *     +---+---+
  * This means that on LE systems each 16 bit word must be swapped. Note that
- * this requires CONFIG_MTD_CFI_BE_BYTE_SWAP to be enabled to 'unswap' the CFI
- * data and other flash commands which are always in D7-D0.
+ * this is accounted for by defining map_info.swap to be CFI_BIG_ENDIAN to
+ * 'unswap' the CFI commands and using cpu_to_be16/be16_to_cpu to 'unswap'
+ * the data.
  */
-#ifndef __ARMEB__
-#ifndef CONFIG_MTD_CFI_BE_BYTE_SWAP
-#  error CONFIG_MTD_CFI_BE_BYTE_SWAP required
+
+#ifdef __ARMEB__
+#define fixup_32(io) (io)
+#else
+#define fixup_32(io) (void __iomem *)((unsigned long)(io) ^ 2)
 #endif
 
 static inline u16 flash_read16(void __iomem *addr)
 {
-	return be16_to_cpu(__raw_readw((void __iomem *)((unsigned long)addr ^ 0x2)));
+	return be16_to_cpu(__raw_readw(fixup_32(addr)));
 }
 
 static inline void flash_write16(u16 d, void __iomem *addr)
 {
-	__raw_writew(cpu_to_be16(d), (void __iomem *)((unsigned long)addr ^ 0x2));
+	__raw_writew(cpu_to_be16(d), fixup_32(addr));
 }
 
 #define	BYTE0(h)	((h) & 0xFF)
 #define	BYTE1(h)	(((h) >> 8) & 0xFF)
 
-#else
-
-static inline u16 flash_read16(const void __iomem *addr)
-{
-	return __raw_readw(addr);
-}
-
-static inline void flash_write16(u16 d, void __iomem *addr)
-{
-	__raw_writew(d, addr);
-}
-
-#define	BYTE0(h)	(((h) >> 8) & 0xFF)
-#define	BYTE1(h)	((h) & 0xFF)
-#endif
-
 static map_word ixp4xx_read16(struct map_info *map, unsigned long ofs)
 {
 	map_word val;
@@ -200,6 +188,7 @@ static int ixp4xx_flash_probe(struct platform_device *dev)
 	 * Tell the MTD layer we're not 1:1 mapped so that it does
 	 * not attempt to do a direct access on us.
 	 */
+	info->map.swap = CFI_BIG_ENDIAN;
 	info->map.phys = NO_XIP;
 	info->map.size = resource_size(dev->resource);
 
-- 
1.9.1
