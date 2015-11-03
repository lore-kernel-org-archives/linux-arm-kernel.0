From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 14:53:54 +0100
Subject: [PATCH] lightnvm: work around 32-bit built error
Message-ID: <4925999.tpkPGVQaeU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added lightnvm incorrectly uses a sector_t variable to
represent a data structure with fixed length bit fields, which breaks
when sector_t is configured to be 32-bit:

In file included from ../drivers/lightnvm/core.c:29:0:
/include/linux/lightnvm.h:143:4: error: width of 'resved' exceeds its type
    sector_t resved  : 36;
include/linux/lightnvm.h: In function 'ppa_set_empty':
/include/linux/lightnvm.h:120:20: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define ADDR_EMPTY (~0ULL)

This patch resolves the build error, but does not address the fact that
bit fields are not reliable in data structures that are interpreted
by firmware on another architecture. If the layout is meant to be
stable, the bit fields should be replaced with explicit calculations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cd9e9808d18f ("lightnvm: Support for Open-Channel SSDs")
---
Found on ARM randconfig tests in linux-next

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 122b176600fa..b094e9ebf715 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -130,30 +130,31 @@ struct nvm_tgt_instance {
 #define NVM_LUN_BITS (10)
 #define NVM_CH_BITS  (8)
 
+/* FIXME: bit fields are not endian safe! */
 struct ppa_addr {
 	union {
 		/* Channel-based PPA format in nand 4x2x2x2x8x10 */
 		struct {
-			sector_t ch		: 4;
-			sector_t sec		: 2; /* 4 sectors per page */
-			sector_t pl		: 2; /* 4 planes per LUN */
-			sector_t lun		: 2; /* 4 LUNs per channel */
-			sector_t pg		: 8; /* 256 pages per block */
-			sector_t blk		: 10;/* 1024 blocks per plane */
-			sector_t resved		: 36;
+			__u64 ch		: 4;
+			__u64 sec		: 2; /* 4 sectors per page */
+			__u64 pl		: 2; /* 4 planes per LUN */
+			__u64 lun		: 2; /* 4 LUNs per channel */
+			__u64 pg		: 8; /* 256 pages per block */
+			__u64 blk		: 10;/* 1024 blocks per plane */
+			__u64 resved		: 36;
 		} chnl;
 
 		/* Generic structure for all addresses */
 		struct {
-			sector_t sec		: NVM_SEC_BITS;
-			sector_t pl		: NVM_PL_BITS;
-			sector_t pg		: NVM_PG_BITS;
-			sector_t blk		: NVM_BLK_BITS;
-			sector_t lun		: NVM_LUN_BITS;
-			sector_t ch		: NVM_CH_BITS;
+			__u64 sec		: NVM_SEC_BITS;
+			__u64 pl		: NVM_PL_BITS;
+			__u64 pg		: NVM_PG_BITS;
+			__u64 blk		: NVM_BLK_BITS;
+			__u64 lun		: NVM_LUN_BITS;
+			__u64 ch		: NVM_CH_BITS;
 		} g;
 
-		sector_t ppa;
+		__u64 ppa;
 	};
 } __packed;
 
