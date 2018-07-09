From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  9 Jul 2018 17:57:04 +0200
Subject: [PATCH 3/3] mtd: sunxi_nand: fix build warning
In-Reply-To: <20180709155730.2422841-1-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
Message-ID: <20180709155730.2422841-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

build-testing this driver on x86 shows a new warning:

Fixes: b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when COMPILE_TEST=y")
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_read_chunks_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: error: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744071631273984' to '2216689664' [-Werror=overflow]
 #define NFC_PAGE_OP  (2 << 30)
drivers/mtd/nand/raw/sunxi_nand.c:1040:9: note: in expansion of macro 'NFC_PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD | NFC_DATA_TRANS,
         ^~~~~~~~~~~
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_write_page_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: error: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744071632322560' to '2217738240' [-Werror=overflow]
 #define NFC_PAGE_OP  (2 << 30)
drivers/mtd/nand/raw/sunxi_nand.c:1406:9: note: in expansion of macro 'NFC_PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD |

This is easy to avoid by ensuring that the constants are 'unsigned'.

Fixes: b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d831a141a196..fa5c48502fa8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -125,9 +125,9 @@
 #define NFC_SEND_CMD3		BIT(28)
 #define NFC_SEND_CMD4		BIT(29)
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
-#define NFC_NORMAL_OP		(0 << 30)
-#define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_NORMAL_OP		(0u << 30)
+#define NFC_ECC_OP		(1u << 30)
+#define NFC_PAGE_OP		(2u << 30)
 
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
-- 
2.9.0
