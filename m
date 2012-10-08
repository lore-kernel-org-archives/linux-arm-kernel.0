From: josh.wu@atmel.com (Josh Wu)
Date: Mon,  8 Oct 2012 14:46:49 +0800
Subject: [PATCH] MTD: atmel_nand: fix compile error when use
 avr32-atstk1006_defconfig
Message-ID: <1349678809-12092-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixed the following compile error when use avr32 config:
drivers/mtd/nand/atmel_nand.c: In function 'pmecc_err_location':
drivers/mtd/nand/atmel_nand.c:639: error: implicit declaration of function 'writel_relaxed'

Since in ARCH avr32, there is no macro "writel_relaxed" defined. In this patch we use macro "writel" instead.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand_ecc.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index 8a1e9a6..e87af84 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -129,8 +129,13 @@
 #define pmerrloc_writel(addr, reg, value) \
 	writel((value), (addr) + ATMEL_PMERRLOC_##reg)
 
+#if defined(CONFIG_ARCH_AT91)
 #define pmerrloc_writel_sigma_relaxed(addr, n, value) \
 	writel_relaxed((value), (addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+#elif defined(CONFIG_AVR32)
+#define pmerrloc_writel_sigma_relaxed(addr, n, value) \
+	writel((value), (addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+#endif
 
 #define pmerrloc_readl_sigma_relaxed(addr, n) \
 	readl_relaxed((addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
-- 
1.7.9.5
