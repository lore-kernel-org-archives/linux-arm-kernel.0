From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  2 Oct 2017 12:42:00 +0100
Subject: [PATCH] arm64: fix misleading data abort decoding
Message-ID: <1506944520-21998-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently data_abort_decode() dumps the ISS field as a decimal value
with a '0x' prefix, which is somewhat misleading.

Fix it to print as hexadecimal, as was intended.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 1f9b8936f36f4a8e ("arm64: Decode information from ESR upon mem faults")
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 89993c4b..a6d5281 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -97,7 +97,7 @@ static void data_abort_decode(unsigned int esr)
 			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
 			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
 	} else {
-		pr_alert("  ISV = 0, ISS = 0x%08lu\n", esr & ESR_ELx_ISS_MASK);
+		pr_alert("  ISV = 0, ISS = 0x%08lx\n", esr & ESR_ELx_ISS_MASK);
 	}
 
 	pr_alert("  CM = %lu, WnR = %lu\n",
-- 
1.9.1
