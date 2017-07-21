From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:33 +0100
Subject: [PATCH 07/16] arm64: compat: Add CNTFRQ trap handler
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like CNTVCT, we need to handle userspace trapping into the
kernel if we're decided that the timer wasn't fit for purpose...
64bit userspace is already dealt with, but we're missing the
equivalent compat handling.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  3 +++
 arch/arm64/kernel/traps.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 43e629fe73dd..64ef4075b597 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -261,6 +261,9 @@
 #define ESR_ELx_CP15_64_ISS_SYS_CNTVCT	(ESR_ELx_CP15_64_ISS_SYS_VAL(1, 14) | \
 					 ESR_ELx_CP15_64_ISS_DIR_READ)
 
+#define ESR_ELx_CP15_32_ISS_SYS_CNTFRQ	(ESR_ELx_CP15_32_ISS_SYS_VAL(0, 0, 14, 0) |\
+					 ESR_ELx_CP15_32_ISS_DIR_READ)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 70efd63a5545..07846d747188 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -558,7 +558,20 @@ static struct sys64_hook sys64_hooks[] = {
 
 
 #ifdef CONFIG_COMPAT
+static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
+
+	regs->user_regs.regs[reg] = arch_timer_get_rate();
+	regs->pc += 4;
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
2.11.0
