From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jul 2018 18:05:40 +0200
Subject: [PATCH 5/6] staging: rtl: Use existing define with polynomial
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
References: <20180717160541.3843-1-krzk@kernel.org>
Message-ID: <20180717160541.3843-6-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not define again the polynomial but use header with existing define.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Not tested

It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
and Freescale's Ethernet driver were tested on HW.  Rest got just different
builds.

 drivers/staging/rtl8712/rtl871x_security.c    | 5 ++---
 drivers/staging/rtl8723bs/core/rtw_security.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 7bc74d7d8a3a..1075eacdb441 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -40,6 +40,7 @@
 #include <linux/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/atomic.h>
+#include <linux/crc32poly.h>
 #include <linux/semaphore.h>
 
 #include "osdep_service.h"
@@ -49,8 +50,6 @@
 
 /* =====WEP related===== */
 
-#define CRC32_POLY 0x04c11db7
-
 struct arc4context {
 	u32 x;
 	u32 y;
@@ -135,7 +134,7 @@ static void crc32_init(void)
 	for (i = 0; i < 256; ++i) {
 		k = crc32_reverseBit((u8)i);
 		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
+			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
 		p1 = (u8 *)&crc32_table[i];
 		p1[0] = crc32_reverseBit(p[3]);
 		p1[1] = crc32_reverseBit(p[2]);
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 612277a555d2..6c8ac9e86c9f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -6,6 +6,7 @@
  ******************************************************************************/
 #define  _RTW_SECURITY_C_
 
+#include <linux/crc32poly.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 
@@ -87,8 +88,6 @@ const char *security_type_str(u8 value)
 
 /* WEP related ===== */
 
-#define CRC32_POLY 0x04c11db7
-
 struct arc4context {
 	u32 x;
 	u32 y;
@@ -178,7 +177,7 @@ static void crc32_init(void)
 		for (i = 0; i < 256; ++i) {
 			k = crc32_reverseBit((u8)i);
 			for (c = ((u32)k) << 24, j = 8; j > 0; --j) {
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
+				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
 			}
 			p1 = (u8 *)&crc32_table[i];
 
-- 
2.14.1
