From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 11:15:14 +0100
Subject: [PATCH 1/2] arm64: fix dump_instr when PAN and UAO are in use
In-Reply-To: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
References: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1465812915-19801-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the kernel is set to show unhandled signals, and a user task does not
handle a SIGILL as a result of an instruction abort, we will attempt to
log the offending instruction with dump_instr before killing the task.

We use dump_instr to log the encoding of the offending userspace
instruction. However, dump_instr is also used to dump instructions from
kernel space, and internally always switches to KERNEL_DS before dumping
the instruction with get_user. When both PAN and UAO are in use, reading
a user instruction via get_user while in KERNEL_DS will result in a
permission fault, which leads to an Oops.

As we have regs corresponding to the context of the original instruction
abort, we can inspect this and only flip to KERNEL_DS if the original
abort was taken from the kernel, avoiding this issue. At the same time,
remove the redundant (and incorrect) comments regarding the order
dump_mem and dump_instr are called in.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 57f4959bad0a154a ("arm64: kernel: Add support for User Access Override")
---
 arch/arm64/kernel/traps.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f7cf463..2a43012 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -64,8 +64,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 
 	/*
 	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
+	 * to safely read from kernel space.
 	 */
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -111,21 +110,12 @@ static void dump_backtrace_entry(unsigned long where)
 	print_ip_sym(where);
 }
 
-static void dump_instr(const char *lvl, struct pt_regs *regs)
+static void __dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
-	mm_segment_t fs;
 	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
@@ -139,8 +129,18 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 		}
 	}
 	printk("%sCode: %s\n", lvl, str);
+}
 
-	set_fs(fs);
+static void dump_instr(const char *lvl, struct pt_regs *regs)
+{
+	if (!user_mode(regs)) {
+		mm_segment_t fs = get_fs();
+		set_fs(KERNEL_DS);
+		__dump_instr(lvl, regs);
+		set_fs(fs);
+	} else {
+		__dump_instr(lvl, regs);
+	}
 }
 
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
-- 
1.9.1
