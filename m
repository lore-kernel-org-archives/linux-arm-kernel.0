From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Jun 2011 16:07:19 +0200
Subject: [PATCH 1/3] ARM: enhance TCM robustness
Message-ID: <1309442839-4314-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The PB11MPCore reports "3" DTCM banks, but anything above 2 is an
"undefined" value, so push this to become 0. Further add some checks
if code is compiled to TCM even if there is no D/ITCM present in the
system, and if we can really fit the compiled code. We don't do the
BUG() since it's not helpful, it's better to deal with non-present
TCM dynamically. If there is nothing compiled to the TCM and no TCM
is detected, it will now just shut up even if TCM support is enabled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/tcm.c |   47 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index f5cf660..d402d48 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -134,6 +134,10 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 			(tcm_region & 1) ? "" : "not ");
 	}
 
+	/* Not much fun you can do with a size 0 bank */
+	if (tcm_size == 0)
+		return 0;
+
 	/* Force move the TCM bank to where we want it, enable */
 	tcm_region = *offset | (tcm_region & 0x00000ffeU) | 1;
 
@@ -165,12 +169,20 @@ void __init tcm_init(void)
 	u32 tcm_status = read_cpuid_tcmstatus();
 	u8 dtcm_banks = (tcm_status >> 16) & 0x03;
 	u8 itcm_banks = (tcm_status & 0x03);
+	size_t dtcm_code_sz = &__edtcm_data - &__sdtcm_data;
+	size_t itcm_code_sz = &__eitcm_text - &__sitcm_text;
 	char *start;
 	char *end;
 	char *ram;
 	int ret;
 	int i;
 
+	/* Values greater than 2 for D/ITCM banks are "reserved" */
+	if (dtcm_banks > 2)
+		dtcm_banks = 0;
+	if (itcm_banks > 2)
+		itcm_banks = 0;
+
 	/* Setup DTCM if present */
 	if (dtcm_banks > 0) {
 		for (i = 0; i < dtcm_banks; i++) {
@@ -178,6 +190,13 @@ void __init tcm_init(void)
 			if (ret)
 				return;
 		}
+		/* This means you compiled more code than fits into DTCM */
+		if (dtcm_code_sz > (dtcm_end - DTCM_OFFSET)) {
+			pr_info("CPU DTCM: %u bytes of code compiled to "
+				"DTCM but only %lu bytes of DTCM present\n",
+				dtcm_code_sz, (dtcm_end - DTCM_OFFSET));
+			goto no_dtcm;
+		}
 		dtcm_res.end = dtcm_end - 1;
 		request_resource(&iomem_resource, &dtcm_res);
 		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
@@ -186,12 +205,15 @@ void __init tcm_init(void)
 		start = &__sdtcm_data;
 		end   = &__edtcm_data;
 		ram   = &__dtcm_start;
-		/* This means you compiled more code than fits into DTCM */
-		BUG_ON((end - start) > (dtcm_end - DTCM_OFFSET));
-		memcpy(start, ram, (end-start));
-		pr_debug("CPU DTCM: copied data from %p - %p\n", start, end);
+		memcpy(start, ram, dtcm_code_sz);
+		pr_debug("CPU DTCM: copied data from %p - %p\n",
+			 start, end);
+	} else if (dtcm_code_sz) {
+		pr_info("CPU DTCM: %u bytes of code compiled to DTCM but no "
+			"DTCM banks present in CPU\n", dtcm_code_sz);
 	}
 
+no_dtcm:
 	/* Setup ITCM if present */
 	if (itcm_banks > 0) {
 		for (i = 0; i < itcm_banks; i++) {
@@ -199,6 +221,13 @@ void __init tcm_init(void)
 			if (ret)
 				return;
 		}
+		/* This means you compiled more code than fits into ITCM */
+		if (itcm_code_sz > (itcm_end - ITCM_OFFSET)) {
+			pr_info("CPU ITCM: %u bytes of code compiled to "
+				"ITCM but only %lu bytes of ITCM present\n",
+				itcm_code_sz, (itcm_end - ITCM_OFFSET));
+			return;
+		}
 		itcm_res.end = itcm_end - 1;
 		request_resource(&iomem_resource, &itcm_res);
 		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
@@ -207,10 +236,12 @@ void __init tcm_init(void)
 		start = &__sitcm_text;
 		end   = &__eitcm_text;
 		ram   = &__itcm_start;
-		/* This means you compiled more code than fits into ITCM */
-		BUG_ON((end - start) > (itcm_end - ITCM_OFFSET));
-		memcpy(start, ram, (end-start));
-		pr_debug("CPU ITCM: copied code from %p - %p\n", start, end);
+		memcpy(start, ram, itcm_code_sz);
+		pr_debug("CPU ITCM: copied code from %p - %p\n",
+			 start, end);
+	} else if (itcm_code_sz) {
+		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
+			"ITCM banks present in CPU\n", itcm_code_sz);
 	}
 }
 
-- 
1.7.3.2
