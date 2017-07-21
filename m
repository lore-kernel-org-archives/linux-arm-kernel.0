From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:29 +0100
Subject: [PATCH 03/16] arm64: compat: Add separate CP15 trapping hook
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly generating an UNDEF when trapping a CP15 access,
let's add a new entry point to that effect (which only generates an
UNDEF for now).

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 14 ++++++++++++--
 arch/arm64/kernel/traps.c | 13 +++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b738880350f9..d78fe4594338 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -560,9 +560,9 @@ el0_sync_compat:
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
 	cmp	x24, #ESR_ELx_EC_CP15_32	// CP15 MRC/MCR trap
-	b.eq	el0_undef
+	b.eq	el0_cp15
 	cmp	x24, #ESR_ELx_EC_CP15_64	// CP15 MRRC/MCRR trap
-	b.eq	el0_undef
+	b.eq	el0_cp15
 	cmp	x24, #ESR_ELx_EC_CP14_MR	// CP14 MRC/MCR trap
 	b.eq	el0_undef
 	cmp	x24, #ESR_ELx_EC_CP14_LS	// CP14 LDC/STC trap
@@ -585,6 +585,16 @@ el0_svc_compat:
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+el0_cp15:
+	/*
+	 * Trapped CP15 (MRC, MCR, MRRC, MCRR) instructions
+	 */
+	enable_dbg_and_irq
+	ct_user_exit
+	mov	x0, x25
+	mov	x1, sp
+	bl	do_cp15instr
+	b	ret_to_user
 #endif
 
 el0_da:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b02295673216..19e4f8d9a73c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -556,6 +556,19 @@ static struct sys64_hook sys64_hooks[] = {
 	{},
 };
 
+
+#ifdef CONFIG_COMPAT
+asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
+{
+	/*
+	 * New cp15 instructions may previously have been undefined at
+	 * EL0. Fall back to our usual undefined instruction handler
+	 * so that we handle these consistently.
+	 */
+	do_undefinstr(regs);
+}
+#endif
+
 asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 {
 	struct sys64_hook *hook;
-- 
2.11.0
