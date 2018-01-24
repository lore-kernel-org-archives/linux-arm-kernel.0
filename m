From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Wed, 24 Jan 2018 13:34:31 +0100
Subject: [PATCH 4/7] arm64: change arm64 probes handler prototype
In-Reply-To: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180124123454eucas1p19746c0c5107d6c3141ad68c63e0d1818@eucas1p1.samsung.com>
Message-ID: <1516797274-20320-5-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A probes_handler_t() handler function prototype differ between ARM32 and ARM64
arch subtrees. Make ARM64 prototype the same as ARM32 prototype and adjust the
ARM64 code to work with the new prototype.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/include/asm/probes.h          |  6 +++++-
 arch/arm64/kernel/probes/kprobes.c       |  2 +-
 arch/arm64/kernel/probes/simulate-insn.c | 32 ++++++++++++++++++++++++--------
 arch/arm64/kernel/probes/simulate-insn.h | 24 ++++++++++++++++--------
 arch/arm64/kernel/probes/uprobes.c       |  3 +--
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 6a5b289..1747e9a 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -16,7 +16,11 @@
 #define _ARM_PROBES_H
 
 typedef u32 probe_opcode_t;
-typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
+struct arch_probe_insn;
+
+typedef void (probes_handler_t) (u32 opcode,
+			   struct arch_probe_insn *api,
+			   struct pt_regs *);
 
 /* architecture specific copy of original instruction */
 struct arch_probe_insn {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d98..fc9f67c 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -69,7 +69,7 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
 	if (p->ainsn.api.handler)
-		p->ainsn.api.handler((u32)p->opcode, (long)p->addr, regs);
+		p->ainsn.api.handler((u32)p->opcode, &p->ainsn.api, regs);
 
 	/* single step simulated, now go for post processing */
 	post_kprobe_handler(kcb, regs);
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index be05868..22dc7a7 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -92,9 +92,11 @@ static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
  * instruction simulation functions
  */
 void __kprobes
-simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
+simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	long imm, xn, val;
+	long addr = instruction_pointer(regs);
 
 	xn = opcode & 0x1f;
 	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
@@ -110,9 +112,11 @@ simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = bbl_displacement(opcode);
+	long addr = instruction_pointer(regs);
 
 	/* Link register is x30 */
 	if (opcode & (1 << 31))
@@ -122,9 +126,11 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
+simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (aarch32_opcode_cond_checks[opcode & 0xf](regs->pstate & 0xffffffff))
 		disp = bcond_displacement(opcode);
@@ -133,9 +139,11 @@ simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
+simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int xn = (opcode >> 5) & 0x1f;
+	long addr = instruction_pointer(regs);
 
 	/* update pc first in case we're doing a "blr lr" */
 	instruction_pointer_set(regs, get_x_reg(regs, xn));
@@ -146,9 +154,11 @@ simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_cbnz(opcode, regs))
@@ -161,9 +171,11 @@ simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
+simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	int disp = 4;
+	long addr = instruction_pointer(regs);
 
 	if (opcode & (1 << 24)) {
 		if (check_tbnz(opcode, regs))
@@ -176,11 +188,13 @@ simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	u64 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (u64 *) (addr + disp);
@@ -194,11 +208,13 @@ simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
+simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs)
 {
 	s32 *load_addr;
 	int xn = opcode & 0x1f;
 	int disp;
+	long addr = instruction_pointer(regs);
 
 	disp = ldr_displacement(opcode);
 	load_addr = (s32 *) (addr + disp);
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index 050bde6..31b3840 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -16,13 +16,21 @@
 #ifndef _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 #define _ARM_KERNEL_KPROBES_SIMULATE_INSN_H
 
-void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_adr_adrp(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_bl(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_b_cond(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_br_blr_ret(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_cbz_cbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_tbz_tbnz(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldr_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
+void simulate_ldrsw_literal(u32 opcode, struct arch_probe_insn *api,
+		struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 636ca01..a83642c 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -112,10 +112,9 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		return false;
 
 	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
-	addr = instruction_pointer(regs);
 
 	if (auprobe->api.handler)
-		auprobe->api.handler(insn, addr, regs);
+		auprobe->api.handler(insn, &auprobe->api, regs);
 
 	return true;
 }
-- 
2.7.4
