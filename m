From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 12:33:01 +0100
Subject: [PATCH 1/3] arm64: add macro to extract ESR_ELx.EC
In-Reply-To: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
References: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1464694383-31700-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several places open-code extraction of the EC field from an ESR_ELx
value, in subtly different ways. This is unfortunate duplication and
variation, and the precise logic used to extract the field is a
distraction.

This patch adds a new macro, ESR_ELx_EC(), to extract the EC field from
an ESR_ELx value in a consistent fashion.

Existing open-coded extractions in core arm64 code are moved over to the
new helper. KVM code is left as-is for the moment.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Huang Shijie <shijie.huang@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave P Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h | 1 +
 arch/arm64/kernel/traps.c    | 2 +-
 arch/arm64/mm/fault.c        | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 77eeb2c..f772e15 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -74,6 +74,7 @@
 
 #define ESR_ELx_EC_SHIFT	(26)
 #define ESR_ELx_EC_MASK		(UL(0x3F) << ESR_ELx_EC_SHIFT)
+#define ESR_ELx_EC(esr)		(((esr) & ESR_ELx_EC_MASK) >> ESR_ELx_EC_SHIFT)
 
 #define ESR_ELx_IL		(UL(1) << 25)
 #define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c539208..673d8d7 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -465,7 +465,7 @@ static const char *esr_class_str[] = {
 
 const char *esr_get_class_string(u32 esr)
 {
-	return esr_class_str[esr >> ESR_ELx_EC_SHIFT];
+	return esr_class_str[ESR_ELx_EC(esr)];
 }
 
 /*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5954881..6b6f5ec 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -244,7 +244,7 @@ out:
 
 static inline int permission_fault(unsigned int esr)
 {
-	unsigned int ec       = (esr & ESR_ELx_EC_MASK) >> ESR_ELx_EC_SHIFT;
+	unsigned int ec       = ESR_ELx_EC(esr);
 	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
 
 	return (ec == ESR_ELx_EC_DABT_CUR && fsc_type == ESR_ELx_FSC_PERM);
-- 
1.9.1
