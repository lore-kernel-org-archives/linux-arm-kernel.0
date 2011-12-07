From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Dec 2011 23:40:16 +0100
Subject: [PATCH 1/2] ARM: only look for TCM on ARM926 and later
Message-ID: <1323297616-22865-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator AP/CP can have a varying set of core modules, some
(like ARM920T) are so old that trying to read the TCM status register
with CP15 will make them hang. So we need to make sure that we are
running on 926 or later in order to be able to activate this for
the Integrator. (The Integrator with CM926EJ-S has 32+32 kb of TCM
memory.)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/tcm.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index 30e302d..700c876 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -180,9 +180,10 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
  */
 void __init tcm_init(void)
 {
-	u32 tcm_status = read_cpuid_tcmstatus();
-	u8 dtcm_banks = (tcm_status >> 16) & 0x03;
-	u8 itcm_banks = (tcm_status & 0x03);
+	u32 cpuid = read_cpuid_id();
+	u32 tcm_status;
+	u8 dtcm_banks;
+	u8 itcm_banks;
 	size_t dtcm_code_sz = &__edtcm_data - &__sdtcm_data;
 	size_t itcm_code_sz = &__eitcm_text - &__sitcm_text;
 	char *start;
@@ -191,6 +192,18 @@ void __init tcm_init(void)
 	int ret;
 	int i;
 
+	/*
+	 * Prior to ARM926 there is no TCM, and trying to read the status
+	 * register will hang the processor.
+	 */
+	if (((cpuid & 0x0008f000) == 0x00000000) &&
+	    ((cpuid >> 4) < 0x926))
+		return;
+
+	tcm_status = read_cpuid_tcmstatus();
+	dtcm_banks = (tcm_status >> 16) & 0x03;
+	itcm_banks = (tcm_status & 0x03);
+
 	/* Values greater than 2 for D/ITCM banks are "reserved" */
 	if (dtcm_banks > 2)
 		dtcm_banks = 0;
-- 
1.7.6.4
