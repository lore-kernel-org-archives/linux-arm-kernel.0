From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:32 +0100
Subject: [PATCH 06/16] arm64: compat: Add CNTVCT trap handler
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since people seem to make a point in breaking the userspace visible
counter, we have no choice but to trap the access. We already do this
for 64bit userspace, but this is lacking for compat. Let's provide
the required handler.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  3 +++
 arch/arm64/kernel/traps.c    | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index fc71b89c99f9..43e629fe73dd 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -258,6 +258,9 @@
 					 ESR_ELx_CP15_64_ISS_CRM_MASK | \
 					 ESR_ELx_CP15_64_ISS_DIR_MASK)
 
+#define ESR_ELx_CP15_64_ISS_SYS_CNTVCT	(ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
+					 ESR_ELx_CP15_64_ISS_DIR_READ)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ac91f4ead737..70efd63a5545 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -562,7 +562,23 @@ static struct sys64_hook cp15_32_hooks[] = {
 	{},
 };
 
+static void compat_cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int rt = (esr & ESR_ELx_CP15_64_ISS_RT_MASK) >> ESR_ELx_CP15_64_ISS_RT_SHIFT;
+	int rt2 = (esr & ESR_ELx_CP15_64_ISS_RT2_MASK) >> ESR_ELx_CP15_64_ISS_RT2_SHIFT;
+	u64 val = arch_counter_get_cntvct();
+
+	regs->user_regs.regs[rt]  = lower_32_bits(val);
+	regs->user_regs.regs[rt2] = upper_32_bits(val);
+	regs->pc += 4;
+}
+
 static struct sys64_hook cp15_64_hooks[] = {
+	{
+		.esr_mask = ESR_ELx_CP15_64_ISS_SYS_MASK,
+		.esr_val = ESR_ELx_CP15_64_ISS_SYS_CNTVCT,
+		.handler = compat_cntvct_read_handler,
+	},
 	{},
 };
 
-- 
2.11.0
