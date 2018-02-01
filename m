From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Feb 2018 11:07:37 +0000
Subject: [PATCH v4 5/6] arm: Invalidate icache on prefetch abort outside of
 user mapping on Cortex-A15
In-Reply-To: <20180201110738.5421-1-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
Message-ID: <20180201110738.5421-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent aliasing attacks on the branch predictor,
invalidate the icache on Cortex-A15, which has the side effect
of invalidating the BTB. This requires ACTLR[0] to be set to 1
(secure operation).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/cp15.h | 1 +
 arch/arm/mm/fault.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 9e900ae855aa..07e27f212dc7 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -66,6 +66,7 @@
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
 #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+#define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
 
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2f945c994e25..1b05b4b3e761 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -410,6 +410,10 @@ do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		case ARM_CPU_PART_CORTEX_A17:
 			write_sysreg(0, BPIALL);
 			break;
+
+		case ARM_CPU_PART_CORTEX_A15:
+			write_sysreg(0, ICIALLU);
+			break;
 		}
 	}
 #endif
-- 
2.14.2
