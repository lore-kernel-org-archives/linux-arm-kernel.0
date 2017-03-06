From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:15 +0000
Subject: [PATCH 10/17] arm64: Add CNTVCT_EL0 trap handler
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since people seem to make a point in breaking the userspace visible
counter, we have no choice but to trap the access. Add the required
handler.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  2 ++
 arch/arm64/kernel/traps.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d14c478976d0..ad42e79a5d4d 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -175,6 +175,8 @@
 #define ESR_ELx_SYS64_ISS_SYS_CTR_READ	(ESR_ELx_SYS64_ISS_SYS_CTR | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
 
+#define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e52be6aa44ee..1de444e6c669 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -505,6 +505,14 @@ static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
 	regs->pc += 4;
 }
 
+static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+
+	pt_regs_write_reg(regs, rt, arch_counter_get_cntvct());
+	regs->pc += 4;
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -523,6 +531,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CTR_READ,
 		.handler = ctr_read_handler,
 	},
+	{
+		/* Trap read access to CNTVCT_EL0 */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
+		.handler = cntvct_read_handler,
+	},
 	{},
 };
 
-- 
2.11.0
