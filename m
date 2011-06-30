From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Jun 2011 16:07:31 +0200
Subject: [PATCH 2/3] ARM: export functions to determine the presence of I/DTCM
Message-ID: <1309442851-4355-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

By allowing code to detect whether DTCM or ITCM is present, code paths
involving TCM can be avoided when running on platforms that lack it.
This is good for creating single kernels across several archs, if some
of them utilize TCM but others don't.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/tcm.h |    2 ++
 arch/arm/kernel/tcm.c      |   21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/tcm.h b/arch/arm/include/asm/tcm.h
index 5929ef5..8578d72 100644
--- a/arch/arm/include/asm/tcm.h
+++ b/arch/arm/include/asm/tcm.h
@@ -27,5 +27,7 @@
 
 void *tcm_alloc(size_t len);
 void tcm_free(void *addr, size_t len);
+bool tcm_dtcm_present(void);
+bool tcm_itcm_present(void);
 
 #endif
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index d402d48..30e302d 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -19,6 +19,8 @@
 #include "tcm.h"
 
 static struct gen_pool *tcm_pool;
+static bool dtcm_present;
+static bool itcm_present;
 
 /* TCM section definitions from the linker */
 extern char __itcm_start, __sitcm_text, __eitcm_text;
@@ -90,6 +92,18 @@ void tcm_free(void *addr, size_t len)
 }
 EXPORT_SYMBOL(tcm_free);
 
+bool tcm_dtcm_present(void)
+{
+	return dtcm_present;
+}
+EXPORT_SYMBOL(tcm_dtcm_present);
+
+bool tcm_itcm_present(void)
+{
+	return itcm_present;
+}
+EXPORT_SYMBOL(tcm_itcm_present);
+
 static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 				  u32 *offset)
 {
@@ -208,6 +222,7 @@ void __init tcm_init(void)
 		memcpy(start, ram, dtcm_code_sz);
 		pr_debug("CPU DTCM: copied data from %p - %p\n",
 			 start, end);
+		dtcm_present = true;
 	} else if (dtcm_code_sz) {
 		pr_info("CPU DTCM: %u bytes of code compiled to DTCM but no "
 			"DTCM banks present in CPU\n", dtcm_code_sz);
@@ -239,6 +254,7 @@ no_dtcm:
 		memcpy(start, ram, itcm_code_sz);
 		pr_debug("CPU ITCM: copied code from %p - %p\n",
 			 start, end);
+		itcm_present = true;
 	} else if (itcm_code_sz) {
 		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
 			"ITCM banks present in CPU\n", itcm_code_sz);
@@ -252,7 +268,6 @@ no_dtcm:
  */
 static int __init setup_tcm_pool(void)
 {
-	u32 tcm_status = read_cpuid_tcmstatus();
 	u32 dtcm_pool_start = (u32) &__edtcm_data;
 	u32 itcm_pool_start = (u32) &__eitcm_text;
 	int ret;
@@ -267,7 +282,7 @@ static int __init setup_tcm_pool(void)
 	pr_debug("Setting up TCM memory pool\n");
 
 	/* Add the rest of DTCM to the TCM pool */
-	if (tcm_status & (0x03 << 16)) {
+	if (dtcm_present) {
 		if (dtcm_pool_start < dtcm_end) {
 			ret = gen_pool_add(tcm_pool, dtcm_pool_start,
 					   dtcm_end - dtcm_pool_start, -1);
@@ -284,7 +299,7 @@ static int __init setup_tcm_pool(void)
 	}
 
 	/* Add the rest of ITCM to the TCM pool */
-	if (tcm_status & 0x03) {
+	if (itcm_present) {
 		if (itcm_pool_start < itcm_end) {
 			ret = gen_pool_add(tcm_pool, itcm_pool_start,
 					   itcm_end - itcm_pool_start, -1);
-- 
1.7.3.2
