From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 28 May 2015 11:36:00 +0200
Subject: [PATCH] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
Message-ID: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the TCM initialisation code to handle TCM banks that are
present but inaccessible due to TrustZone configuration.  This is
the default case when enabling the non-secure world.  It may also
be the case that that the user decided to use TCM for TrustZone.

This change has exposed a bug in handling of TCM where no TCM bank
was usable (the 0 size TCM case).  This change addresses the
resulting hang.

Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/tcm.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 7a3be1d..af1dd5a 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 #include <asm/memory.h>
 #include <asm/system_info.h>
+#include <asm/traps.h>
 
 static struct gen_pool *tcm_pool;
 static bool dtcm_present;
@@ -175,6 +176,21 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
 	return 0;
 }
 
+static int __init tcm_handler(struct pt_regs *regs, unsigned int instr)
+{
+	regs->uregs[(instr >> 12) & 0xf] = 0;
+	regs->ARM_pc += 4;
+	return 0;
+}
+
+static const struct undef_hook tcm_hook __initconst = {
+	.instr_mask	= 0xffff0fdf,
+	.instr_val	= 0xee190f11,
+	.cpsr_mask	= MODE_MASK,
+	.cpsr_val	= SVC_MODE,
+	.fn		= tcm_handler
+};
+
 /*
  * This initializes the TCM memory
  */
@@ -207,6 +223,8 @@ void __init tcm_init(void)
 	dtcm_banks = (tcm_status >> 16) & 0x03;
 	itcm_banks = (tcm_status & 0x03);
 
+	register_undef_hook(&tcm_hook);
+
 	/* Values greater than 2 for D/ITCM banks are "reserved" */
 	if (dtcm_banks > 2)
 		dtcm_banks = 0;
@@ -218,7 +236,7 @@ void __init tcm_init(void)
 		for (i = 0; i < dtcm_banks; i++) {
 			ret = setup_tcm_bank(0, i, dtcm_banks, &dtcm_end);
 			if (ret)
-				return;
+				goto unregister;
 		}
 		/* This means you compiled more code than fits into DTCM */
 		if (dtcm_code_sz > (dtcm_end - DTCM_OFFSET)) {
@@ -227,6 +245,10 @@ void __init tcm_init(void)
 				dtcm_code_sz, (dtcm_end - DTCM_OFFSET));
 			goto no_dtcm;
 		}
+		/* This means that the DTCM sizes were 0 or the DTCM banks
+		 * were inaccessible due to TrustZone configuration */
+		if (!(dtcm_end - DTCM_OFFSET))
+			goto no_dtcm;
 		dtcm_res.end = dtcm_end - 1;
 		request_resource(&iomem_resource, &dtcm_res);
 		dtcm_iomap[0].length = dtcm_end - DTCM_OFFSET;
@@ -250,15 +272,19 @@ no_dtcm:
 		for (i = 0; i < itcm_banks; i++) {
 			ret = setup_tcm_bank(1, i, itcm_banks, &itcm_end);
 			if (ret)
-				return;
+				goto unregister;
 		}
 		/* This means you compiled more code than fits into ITCM */
 		if (itcm_code_sz > (itcm_end - ITCM_OFFSET)) {
 			pr_info("CPU ITCM: %u bytes of code compiled to "
 				"ITCM but only %lu bytes of ITCM present\n",
 				itcm_code_sz, (itcm_end - ITCM_OFFSET));
-			return;
+			goto unregister;
 		}
+		/* This means that the ITCM sizes were 0 or the ITCM banks
+		 * were inaccessible due to TrustZone configuration */
+		if (!(itcm_end - ITCM_OFFSET))
+			goto unregister;
 		itcm_res.end = itcm_end - 1;
 		request_resource(&iomem_resource, &itcm_res);
 		itcm_iomap[0].length = itcm_end - ITCM_OFFSET;
@@ -275,6 +301,9 @@ no_dtcm:
 		pr_info("CPU ITCM: %u bytes of code compiled to ITCM but no "
 			"ITCM banks present in CPU\n", itcm_code_sz);
 	}
+
+unregister:
+	unregister_undef_hook(&tcm_hook);
 }
 
 /*
-- 
2.1.4
