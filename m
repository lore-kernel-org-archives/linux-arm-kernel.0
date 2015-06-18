From: maninder1.s@samsung.com (Maninder Singh)
Date: Thu, 18 Jun 2015 10:57:06 +0530
Subject: [RFC][PATCH] arm64:Modify the dump mem for 64 bit addresses
Message-ID: <1434605226-17084-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Thapliyal <r.thapliyal@samsung.com>

On 64bit kernel, the dump_mem gives 32 bit addresses
on the stack dump. This gives unorganized information regarding
the 64bit values on the stack. Hence, modified to get a complete
64bit memory dump.

With patch:
Process insmod (pid: 1587, stack limit = 0xffffffc976be4058)
Stack: (0xffffffc976be7cf0 to 0xffffffc976be8000)
7ce0:                                   ffffffc976be7d00 ffffffc00008163c
7d00: ffffffc976be7d40 ffffffc0000f8a44 ffffffc00098ef38 ffffffbffc000088
7d20: ffffffc00098ef50 ffffffbffc0000c0 0000000000000001 ffffffbffc000070
7d40: ffffffc976be7e40 ffffffc0000f935c 0000000000000000 000000002b424090
7d60: 000000002b424010 0000007facc555f4 0000000080000000 0000000000000015
7d80: 0000000000000116 0000000000000069 ffffffc00097b000 ffffffc976be4000
7da0: 0000000000000064 0000000000000072 000000000000006e 000000000000003f
7dc0: 000000000000feff 000000000000fff1 ffffffbffc002028 0000000000000124
7de0: ffffffc976be7e10 0000000000000001 ffffff8000000000 ffffffbbffff0000
7e00: ffffffc976be7e60 0000000000000000 0000000000000000 0000000000000000
7e20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
7e40: 0000007fcc474550 ffffffc0000841ec 000000002b424010 0000007facda0710
7e60: ffffffffffffffff ffffffc0000be6dc ffffff80007d2000 000000000001c010
7e80: ffffff80007e0ae0 ffffff80007e09d0 ffffff80007edf70 0000000000000288
7ea0: 00000000000002e8 0000000000000000 0000000000000000 0000001c0000001b
7ec0: 0000000000000009 0000000000000007 000000002b424090 000000000001c010
7ee0: 000000002b424010 0000007faccd3a48 0000000000000000 0000000000000000
7f00: 0000007fcc4743f8 0000007fcc4743f8 0000000000000069 0000000000000003
7f20: 0101010101010101 0000000000000004 0000000000000020 00000000000003f3
7f40: 0000007facb95664 0000007facda7030 0000007facc555d0 0000000000498378
7f60: 0000000000000000 000000002b424010 0000007facda0710 000000002b424090
7f80: 0000007fcc474698 0000000000498000 0000007fcc474ebb 0000000000474f58
7fa0: 0000000000498000 0000000000000000 0000000000000000 0000007fcc474550
7fc0: 00000000004104bc 0000007fcc474430 0000007facc555f4 0000000080000000
7fe0: 000000002b424090 0000000000000069 0950020128000244 4104000008000004
Call trace:

The above output makes a debugger life a lot more easier.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com> 
---
 arch/arm64/kernel/traps.c |   62 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1ef2940..6e9f19b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -51,6 +51,48 @@ int show_unhandled_signals = 1;
 /*
  * Dump out the contents of some memory nicely...
  */
+
+static void dump_mem64(const char *lvl, const char *str, unsigned long bottom,
+		unsigned long top)
+{
+	unsigned long first;
+	mm_segment_t fs;
+	int i;
+
+	/*
+	 * We need to switch to kernel mode so that we can use __get_user
+	 * to safely read from kernel space.  Note that we now dump the
+	 * code first, just in case the backtrace kills us.
+	 */
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	pr_alert("%s%s(0x%016lx to 0x%016lx)\n", lvl, str, bottom, top);
+
+	for (first = bottom & ~31; first < top; first += 32) {
+		unsigned long p;
+		char str[sizeof(" 1234567812345678") * 8 + 1];
+
+		memset(str, ' ', sizeof(str));
+		str[sizeof(str) - 1] = '\0';
+
+		for (p = first, i = 0; i < 4 && p < top; i++, p += 8) {
+			if (p >= bottom && p < top) {
+				unsigned long val;
+
+				if (__get_user(val, (unsigned long *)p) == 0)
+					sprintf(str + i * 17, " %016lx", val);
+				else
+					sprintf(str + i * 17,
+						" ????????????????");
+			}
+		}
+		pr_alert("%s%04lx:%s\n", lvl, first & 0xffff, str);
+	}
+
+	set_fs(fs);
+}
+
 static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top)
 {
@@ -206,8 +248,24 @@ static int __die(const char *str, int err, struct thread_info *thread,
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+
+		if (regs->sp > (unsigned long)task_stack_page(tsk)) {
+			dump_mem64(KERN_EMERG, "Stack: ", regs->sp,
+				THREAD_SIZE +
+				(unsigned long)task_stack_page(tsk));
+		} else {
+			if (compat_user_mode(regs)) {
+				dump_mem(KERN_EMERG, "Stack: ",
+					(unsigned long)task_stack_page(tsk),
+					THREAD_SIZE +
+					(unsigned long)task_stack_page(tsk));
+			} else {
+				dump_mem64(KERN_EMERG, "Stack: ",
+					(unsigned long)task_stack_page(tsk),
+					THREAD_SIZE +
+					(unsigned long)task_stack_page(tsk));
+			}
+		}
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
1.7.9.5
