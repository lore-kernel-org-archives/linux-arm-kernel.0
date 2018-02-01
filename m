From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  1 Feb 2018 18:34:58 +0900
Subject: [PATCH 1/2] arm64: kprobes: Remove unneeded address sanity check
In-Reply-To: <20180201093459.20477-1-takahiro.akashi@linaro.org>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
Message-ID: <20180201093459.20477-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Remove unneeded address sanity check in arch_prepare_kprobe().
Since do_debug_exception() is already blacklisted for kprobes, no need
to reject all __exception functions. Also, since generic kprobe
framework already ensures the address is in kernel text, no need to
check it is in rodata again.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/probes/kprobes.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..3c487a389252 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -78,8 +78,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
-	extern char __start_rodata[];
-	extern char __end_rodata[];
 
 	if (probe_addr & 0x3)
 		return -EINVAL;
@@ -87,12 +85,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	/* copy instruction */
 	p->opcode = le32_to_cpu(*p->addr);
 
-	if (in_exception_text(probe_addr))
-		return -EINVAL;
-	if (probe_addr >= (unsigned long) __start_rodata &&
-	    probe_addr <= (unsigned long) __end_rodata)
-		return -EINVAL;
-
 	/* decode instruction */
 	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
 	case INSN_REJECTED:	/* insn not supported */
-- 
2.15.1
