From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Wed, 24 Jan 2018 13:34:33 +0100
Subject: [PATCH 6/7] arm64: change arm_probe_decode_insn() function name
In-Reply-To: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180124123456eucas1p152faddb1afc94d8841ebaf5112c6f26b@eucas1p1.samsung.com>
Message-ID: <1516797274-20320-7-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM probe decoding function has similar name in arm32 -
arm_probes_decode_insn(), and arm64 - arm_probe_decode_insn(). Change arm64
probes decoding function name from arm_probe_decode_insn() to
arm64_probes_decode_insn() to minimize the risk of confusion.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 4 ++--
 arch/arm64/kernel/probes/decode-insn.h | 2 +-
 arch/arm64/kernel/probes/uprobes.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index a0597a2..37be1a9 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -78,7 +78,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
  */
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
 {
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
@@ -162,7 +162,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
+	decoded = arm64_probes_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 93e021f..e6c7b9e 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -32,7 +32,7 @@ enum probes_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
 
 extern const union decode_action uprobes_probes_actions[];
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index f99b50b..e7b8912 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -47,7 +47,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
 
-	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
+	switch (arm64_probes_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
 		return -EINVAL;
 
-- 
2.7.4
