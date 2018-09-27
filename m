From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 17:15:33 +0100
Subject: [PATCH 6/7] arm64: compat: Add CNTFRQ trap handler
In-Reply-To: <20180927161534.247926-1-marc.zyngier@arm.com>
References: <20180927161534.247926-1-marc.zyngier@arm.com>
Message-ID: <20180927161534.247926-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like CNTVCT, we need to handle userspace trapping into the
kernel if we're decided that the timer wasn't fit for purpose...
64bit userspace is already dealt with, but we're missing the
equivalent compat handling.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  3 +++
 arch/arm64/kernel/traps.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 67faae88f953..6c764616b2a2 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -304,6 +304,9 @@
 #define ESR_ELx_CP15_64_ISS_SYS_CNTVCT	(ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
 					 ESR_ELx_CP15_64_ISS_DIR_READ)
 
+#define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ	(ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
+					 ESR_ELx_CP15_32_ISS_DIR_READ)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cc0ad028caf3..923468c585a6 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -607,7 +607,20 @@ static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
 	arm64_skip_faulting_instruction(regs, sz);
 }
 
+static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
+
+	pt_regs_write_reg(regs, reg, arch_timer_get_rate());
+	arm64_compat_skip_faulting_instruction(regs, 4);
+}
+
 static struct sys64_hook cp15_32_hooks[] = {
+	{
+		.esr_mask = ESR_ELx_CP15_32_ISS_SYS_MASK,
+		.esr_val = ESR_ELx_CP15_32_ISS_SYS_CNTFRQ,
+		.handler = compat_cntfrq_read_handler,
+	},
 	{},
 };
 
-- 
2.19.0
