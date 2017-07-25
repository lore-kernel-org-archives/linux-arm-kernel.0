From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Jul 2017 11:55:41 +0100
Subject: [PATCH 4/6] arm64: Handle trapped DC CVAP
In-Reply-To: <cover.1500397441.git.robin.murphy@arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
Message-ID: <181991f972700b41a9fef9b5bbc1d23d0b5f0083.1500397441.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache clean to PoP is subject to the same access controls as to PoC, so
if we are trapping userspace cache maintenance with SCTLR_EL1.UCI, we
need to be prepared to handle it. To avoid getting into complicated
fights with binutils about ARMv8.2 options, we'll just cheat and use the
raw SYS instruction rather than the 'proper' DC alias.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/esr.h | 3 ++-
 arch/arm64/kernel/traps.c    | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 8cabd57b6348..2636df9a4d6b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -157,9 +157,10 @@
 /*
  * User space cache operations have the following sysreg encoding
  * in System instructions.
- * op0=1, op1=3, op2=1, crn=7, crm={ 5, 10, 11, 14 }, WRITE (L=0)
+ * op0=1, op1=3, op2=1, crn=7, crm={ 5, 10, 11, 12, 14 }, WRITE (L=0)
  */
 #define ESR_ELx_SYS64_ISS_CRM_DC_CIVAC	14
+#define ESR_ELx_SYS64_ISS_CRM_DC_CVAP	12
 #define ESR_ELx_SYS64_ISS_CRM_DC_CVAU	11
 #define ESR_ELx_SYS64_ISS_CRM_DC_CVAC	10
 #define ESR_ELx_SYS64_ISS_CRM_IC_IVAU	5
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c7c7088097be..dc53a8ba1882 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -480,6 +480,9 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAC:	/* DC CVAC, gets promoted */
 		__user_cache_maint("dc civac", address, ret);
 		break;
+	case ESR_ELx_SYS64_ISS_CRM_DC_CVAP:	/* DC CVAP */
+		__user_cache_maint("sys 3, c7, c12, 1", address, ret);
+		break;
 	case ESR_ELx_SYS64_ISS_CRM_DC_CIVAC:	/* DC CIVAC */
 		__user_cache_maint("dc civac", address, ret);
 		break;
-- 
2.12.2.dirty
