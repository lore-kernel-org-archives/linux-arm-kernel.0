From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:15 +0200
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orion_nand_read_buf uses an inline assembly with the "ldrd"
instruction, which is only available from ARMv5 upwards. This
used to be fine, since all users have an ARMv5 or ARMv7 CPU,
but now we can also build a multiplatform kernel with ARMv4
support enabled in addition to the "kirkwood" (mvebu) platform.

This provides an alternative to call the readsl() function that
is supposed to have the same effect and is also optimized for
performance.

This patch is untested, and it would be worthwhile to check
if there is any performance impact, especially in case the readsl
version is actually faster.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mtd at lists.infradead.org
---
 drivers/mtd/nand/orion_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index dd7fe81..c7b5e8a 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -56,6 +56,7 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 		*buf++ = readb(io_base);
 		len--;
 	}
+#if __LINUX_ARM_ARCH__ >= 5
 	buf64 = (uint64_t *)buf;
 	while (i < len/8) {
 		/*
@@ -68,6 +69,10 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 		asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
 		buf64[i++] = x;
 	}
+#else
+	readsl(io_base, buf, len/8);
+	i = len / 8 * 8;
+#endif
 	i *= 8;
 	while (i < len)
 		buf[i++] = readb(io_base);
-- 
1.8.3.2
