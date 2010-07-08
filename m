From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu,  8 Jul 2010 23:17:19 +0200
Subject: [PATCH 2/2] ARM: support multiple TCM banks
Message-ID: <1278623839-17384-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs v6 and up support multiple TCM banks, for example an ITCM of
8k is supplied in two 4k banks. This makes the TCM work on the
1176JZF-S devchip.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
The idea to split TCMs in banks may seem odd but it is likely so
that since each bank can be controlled individually, one of them
can be set to secure mode and hidden for TrustZone usage.
---
 arch/arm/kernel/tcm.c |   68 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 0c62aa2..f2ead32 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -92,14 +92,24 @@ void tcm_free(void *addr, size_t len)
 }
 EXPORT_SYMBOL(tcm_free);
 
-
-static void __init setup_tcm_bank(u8 type, u32 offset, u32 expected_size)
+static void __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
+				  u32 offset, u32 expected_size)
 {
 	const int tcm_sizes[16] = { 0, -1, -1, 4, 8, 16, 32, 64, 128,
 				    256, 512, 1024, -1, -1, -1, -1 };
 	u32 tcm_region;
 	int tcm_size;
 
+	/*
+	 * If there are more than one TCM bank of this type,
+	 * select the TCM bank to operate on in the TCM selection
+	 * register.
+	 */
+	if (banks > 1)
+		asm("mcr	p15, 0, %0, c9, c2, 0"
+		    : /* No output operands */
+		    : "r" (bank));
+
 	/* Read the special TCM region register c9, 0 */
 	if (!type)
 		asm("mrc	p15, 0, %0, c9, c1, 0"
@@ -110,21 +120,23 @@ static void __init setup_tcm_bank(u8 type, u32 offset, u32 expected_size)
 
 	tcm_size = tcm_sizes[(tcm_region >> 2) & 0x0f];
 	if (tcm_size < 0) {
-		pr_err("CPU: %sTCM of unknown size!\n",
-			type ? "I" : "D");
+		pr_err("CPU: %sTCM%d of unknown size!\n",
+		       type ? "I" : "D", bank);
 	} else {
-		pr_info("CPU: found %sTCM %dk @ %08x, %senabled\n",
+		pr_info("CPU: found %sTCM%d %dk @ %08x, %senabled\n",
 			type ? "I" : "D",
+			bank,
 			tcm_size,
 			(tcm_region & 0xfffff000U),
 			(tcm_region & 1) ? "" : "not ");
 	}
 
-	if (tcm_size != expected_size) {
-		pr_crit("CPU: %sTCM was detected %dk but expected %dk!\n",
-		       type ? "I" : "D",
-		       tcm_size,
-		       expected_size);
+	if (tcm_size != (expected_size >> 10)) {
+		pr_crit("CPU: %sTCM%d was detected %dk but expected %dk!\n",
+			type ? "I" : "D",
+			bank,
+			tcm_size,
+			(expected_size >> 10));
 		/* Adjust to the expected size? what can we do... */
 	}
 
@@ -140,26 +152,37 @@ static void __init setup_tcm_bank(u8 type, u32 offset, u32 expected_size)
 		    : /* No output operands */
 		    : "r" (tcm_region));
 
-	pr_debug("CPU: moved %sTCM %dk to %08x, enabled\n",
-		 type ? "I" : "D",
-		 tcm_size,
-		 (tcm_region & 0xfffff000U));
+	pr_info("CPU: moved %sTCM%d %dk to %08x, enabled\n",
+		type ? "I" : "D",
+		bank,
+		tcm_size,
+		(tcm_region & 0xfffff000U));
 }
 
+/* We expect to find what is configured for the platform */
+#define DTCM_EXPECTED (DTCM_END - DTCM_OFFSET + 1)
+#define ITCM_EXPECTED (ITCM_END - ITCM_OFFSET + 1)
+
 /*
  * This initializes the TCM memory
  */
 void __init tcm_init(void)
 {
 	u32 tcm_status = read_cpuid_tcmstatus();
+	u8 dtcm_banks = (tcm_status >> 16) & 0x03;
+	u32 dtcm_banksize = DTCM_EXPECTED / dtcm_banks;
+	u8 itcm_banks = (tcm_status & 0x03);
+	u32 itcm_banksize = ITCM_EXPECTED / itcm_banks;
 	char *start;
 	char *end;
 	char *ram;
+	int i;
 
 	/* Setup DTCM if present */
-	if (tcm_status & (1 << 16)) {
-		setup_tcm_bank(0, DTCM_OFFSET,
-			       (DTCM_END - DTCM_OFFSET + 1) >> 10);
+	for (i = 0; i < dtcm_banks; i++) {
+		setup_tcm_bank(0, i, dtcm_banks,
+			       DTCM_OFFSET + (i * dtcm_banksize),
+			       dtcm_banksize);
 		request_resource(&iomem_resource, &dtcm_res);
 		iotable_init(dtcm_iomap, 1);
 		/* Copy data from RAM to DTCM */
@@ -171,9 +194,10 @@ void __init tcm_init(void)
 	}
 
 	/* Setup ITCM if present */
-	if (tcm_status & 1) {
-		setup_tcm_bank(1, ITCM_OFFSET,
-			       (ITCM_END - ITCM_OFFSET + 1) >> 10);
+	for (i = 0; i < itcm_banks; i++) {
+		setup_tcm_bank(1, i, itcm_banks,
+			       ITCM_OFFSET + (i * itcm_banksize),
+			       itcm_banksize);
 		request_resource(&iomem_resource, &itcm_res);
 		iotable_init(itcm_iomap, 1);
 		/* Copy code from RAM to ITCM */
@@ -207,7 +231,7 @@ static int __init setup_tcm_pool(void)
 	pr_debug("Setting up TCM memory pool\n");
 
 	/* Add the rest of DTCM to the TCM pool */
-	if (tcm_status & (1 << 16)) {
+	if (tcm_status & (0x03 << 16)) {
 		if (dtcm_pool_start < DTCM_END) {
 			ret = gen_pool_add(tcm_pool, dtcm_pool_start,
 					   DTCM_END - dtcm_pool_start + 1, -1);
@@ -224,7 +248,7 @@ static int __init setup_tcm_pool(void)
 	}
 
 	/* Add the rest of ITCM to the TCM pool */
-	if (tcm_status & 1) {
+	if (tcm_status & 0x03) {
 		if (itcm_pool_start < ITCM_END) {
 			ret = gen_pool_add(tcm_pool, itcm_pool_start,
 					   ITCM_END - itcm_pool_start + 1, -1);
-- 
1.7.1
