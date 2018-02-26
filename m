From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 26 Feb 2018 16:20:24 +0800
Subject: [PATCH 50/52] arm: Invalidate icache on prefetch abort outside of
 user mapping on Cortex-A15
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519633227-29832-51-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

** Not yet queued for inclusion in mainline **

In order to prevent aliasing attacks on the branch predictor,
invalidate the icache on Cortex-A15, which has the side effect
of invalidating the BTB. This requires ACTLR[0] to be set to 1
(secure operation).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/cp15.h | 1 +
 arch/arm/mm/fault.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 0672ddc..b74b174 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -65,6 +65,7 @@
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
 #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+#define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
 
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 17fd0c7..a9c924b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -409,6 +409,10 @@ do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
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
2.7.4
