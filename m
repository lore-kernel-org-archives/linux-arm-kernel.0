From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Jul 2018 10:50:57 +0100
Subject: [PATCH 1/2] ARM: NOMMU: Extend check for VBAR support
In-Reply-To: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
References: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1531129858-8341-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8R adds support for VBAR and updates ID_PFR1 with the new filed
Sec_frac (bits [23:20]):

Security fractional field. When the Security field is 0000, determines
the support for features from the ARMv7 Security Extensions. Permitted
values are:

0000 No features from the ARMv7 Security Extensions are implemented.
     This value is not supported in ARMv8 if ID_PFR1 bits [7:4] are zero.

0001 The implementation includes the VBAR, and the TCR.PD0 and TCR.PD1
     bits.

0010 As for 0001, plus the ability to access Secure or Non-secure
     physical memory is supported.

All other values are reserved.

This field is only valid when ID_PFR1[7:4] == 0, otherwise it holds
the value 0000.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/nommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 5dd6c58..7d67c70 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -53,7 +53,8 @@ static inline bool security_extensions_enabled(void)
 {
 	/* Check CPUID Identification Scheme before ID_PFR1 read */
 	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
-		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
+			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
 	return 0;
 }
 
-- 
2.0.0
