From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 24 May 2017 10:15:37 +0200
Subject: [patch V3 26/32] arm64: Prevent cpu hotplug rwsem recursion
References: <20170524081511.203800767@linutronix.de>
Message-ID: <20170524081549.197070135@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The text patching functions which are invoked from jump_label and kprobes
code are protected against cpu hotplug at the call sites.

Use stop_machine_cpuslocked() to avoid recursion on the cpu hotplug
rwsem. stop_machine_cpuslocked() contains a lockdep assertion to catch any
unprotected callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/include/asm/insn.h |    1 -
 arch/arm64/kernel/insn.c      |    5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -433,7 +433,6 @@ u32 aarch64_set_branch_offset(u32 insn,
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
-int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
 s32 aarch64_insn_adrp_get_offset(u32 insn);
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -255,6 +255,7 @@ static int __kprobes aarch64_insn_patch_
 	return ret;
 }
 
+static
 int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
 {
 	struct aarch64_insn_patch patch = {
@@ -267,8 +268,8 @@ int __kprobes aarch64_insn_patch_text_sy
 	if (cnt <= 0)
 		return -EINVAL;
 
-	return stop_machine(aarch64_insn_patch_text_cb, &patch,
-			    cpu_online_mask);
+	return stop_machine_cpuslocked(aarch64_insn_patch_text_cb, &patch,
+				       cpu_online_mask);
 }
 
 int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
