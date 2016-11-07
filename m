From: panand@redhat.com (Pratyush Anand)
Date: Mon,  7 Nov 2016 23:07:22 +0530
Subject: [PATCH] arm64: fix error: conflicting types for 'kprobe_fault_handler'
Message-ID: <7dcc7652817db90bab2df463f856acff41d270fe.1478540228.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_KPROBE is disabled but CONFIG_UPROBE_EVENT is enabled, we get
following compilation error:

In file included from
.../arch/arm64/kernel/probes/decode-insn.c:20:0:
.../arch/arm64/include/asm/kprobes.h:52:5: error:
conflicting types for 'kprobe_fault_handler'
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
     ^~~~~~~~~~~~~~~~~~~~
In file included from
.../arch/arm64/kernel/probes/decode-insn.c:17:0:
.../include/linux/kprobes.h:398:90: note:
previous definition of 'kprobe_fault_handler' was here
 static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
                                                                                          ^
.../scripts/Makefile.build:290: recipe for target
'arch/arm64/kernel/probes/decode-insn.o' failed

<asm/kprobes.h> is already included from <linux/kprobes.h> under #ifdef
CONFIG_KPROBE. So, this patch fixes the error by removing it from
decode-insn.c.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 8a29d2982eec..6bf6657a5a52 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -17,7 +17,6 @@
 #include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
-#include <asm/kprobes.h>
 #include <asm/insn.h>
 #include <asm/sections.h>
 
-- 
2.7.4
