From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 22:33:42 +0900
Subject: [PATCH] ARM: S3C24XX: Fix the S3C24XX_VA_GPIO mapping
Message-ID: <1287581622-8335-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the S3C24XX_VA_GPIO for to fix following BUG.
BUG: not creating mapping for 0x56000000 at 0x01000000 in user region

It is due to commit 8fecfe9d(ARM: SAMSUNG: Move the start address of
Samsung SoCs' VA space) which changes S3C_ADDR_BASE from 0xF4000000
to 0xFA000000.

Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/include/plat/map.h |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/include/plat/map.h b/arch/arm/plat-s3c24xx/include/plat/map.h
index bd534d3..771491e 100644
--- a/arch/arm/plat-s3c24xx/include/plat/map.h
+++ b/arch/arm/plat-s3c24xx/include/plat/map.h
@@ -61,17 +61,9 @@
 
 /* GPIO ports */
 
-/* the calculation for the VA of this must ensure that
- * it is the same distance apart from the UART in the
- * phsyical address space, as the initial mapping for the IO
- * is done as a 1:1 mapping. This puts it (currently) at
- * 0xFA800000, which is not in the way of any current mapping
- * by the base system.
-*/
-
-#define S3C2410_PA_GPIO	   (0x56000000)
-#define S3C24XX_VA_GPIO	   ((S3C24XX_PA_GPIO - S3C24XX_PA_UART) + S3C24XX_VA_UART)
-#define S3C24XX_SZ_GPIO	   SZ_1M
+#define S3C2410_PA_GPIO		(0x56000000)
+#define S3C24XX_VA_GPIO		S3C2410_ADDR(0x00F00000)
+#define S3C24XX_SZ_GPIO		SZ_1M
 
 
 /* ISA style IO, for each machine to sort out mappings for, if it
-- 
1.6.2.5
