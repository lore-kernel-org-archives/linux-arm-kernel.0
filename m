From: maninder1.s@samsung.com (Maninder Singh)
Date: Fri, 10 Jul 2015 13:53:59 +0530
Subject: [PATCH v5] arm64:Modify the dump mem for 64 bit addresses
Message-ID: <1436516639-19139-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Thapliyal <r.thapliyal@samsung.com>

On 64bit kernel, the dump_mem gives 32 bit addresses
on the stack dump. This gives unorganized information regarding
the 64bit values on the stack. Hence, modified to get a complete 64bit memory
dump.

With patch:
[   93.534801] Process insmod (pid: 1587, stack limit = 0xffffffc976be4058)
[   93.541441] Stack: (0xffffffc976be7cf0 to 0xffffffc976be8000)
[   93.547136] 7ce0:                                   ffffffc976be7d00 ffffffc00008163c
[   93.554898] 7d00: ffffffc976be7d40 ffffffc0000f8a44 ffffffc00098ef38 ffffffbffc000088
[   93.562659] 7d20: ffffffc00098ef50 ffffffbffc0000c0 0000000000000001 ffffffbffc000070
[   93.570419] 7d40: ffffffc976be7e40 ffffffc0000f935c 0000000000000000 000000002b424090
[   93.578179] 7d60: 000000002b424010 0000007facc555f4 0000000080000000 0000000000000015
[   93.585937] 7d80: 0000000000000116 0000000000000069 ffffffc00097b000 ffffffc976be4000
[   93.593694] 7da0: 0000000000000064 0000000000000072 000000000000006e 000000000000003f
[   93.601453] 7dc0: 000000000000feff 000000000000fff1 ffffffbffc002028 0000000000000124
[   93.609211] 7de0: ffffffc976be7e10 0000000000000001 ffffff8000000000 ffffffbbffff0000
[   93.616969] 7e00: ffffffc976be7e60 0000000000000000 0000000000000000 0000000000000000
[   93.624726] 7e20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   93.632484] 7e40: 0000007fcc474550 ffffffc0000841ec 000000002b424010 0000007facda0710
[   93.640241] 7e60: ffffffffffffffff ffffffc0000be6dc ffffff80007d2000 000000000001c010
[   93.647999] 7e80: ffffff80007e0ae0 ffffff80007e09d0 ffffff80007edf70 0000000000000288
[   93.655757] 7ea0: 00000000000002e8 0000000000000000 0000000000000000 0000001c0000001b
[   93.663514] 7ec0: 0000000000000009 0000000000000007 000000002b424090 000000000001c010
[   93.671272] 7ee0: 000000002b424010 0000007faccd3a48 0000000000000000 0000000000000000
[   93.679030] 7f00: 0000007fcc4743f8 0000007fcc4743f8 0000000000000069 0000000000000003
[   93.686787] 7f20: 0101010101010101 0000000000000004 0000000000000020 00000000000003f3
[   93.694544] 7f40: 0000007facb95664 0000007facda7030 0000007facc555d0 0000000000498378
[   93.702301] 7f60: 0000000000000000 000000002b424010 0000007facda0710 000000002b424090
[   93.710058] 7f80: 0000007fcc474698 0000000000498000 0000007fcc474ebb 0000000000474f58
[   93.717815] 7fa0: 0000000000498000 0000000000000000 0000000000000000 0000007fcc474550
[   93.725573] 7fc0: 00000000004104bc 0000007fcc474430 0000007facc555f4 0000000080000000
[   93.733330] 7fe0: 000000002b424090 0000000000000069 0950020128000244 4104000008000004
[   93.741084] Call trace:

The above output makes a debugger life a lot more easier.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
v1: added new function dump_mem64
v2: remove seprate function, modified dump_mem
v3: Changelog modified
v4: Used compat_user_mode() for setting width to 4 or 8
v5: changed variable wide to compat for readability.

 arch/arm64/kernel/traps.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1ef2940..97e6208 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -52,11 +52,12 @@ int show_unhandled_signals = 1;
  * Dump out the contents of some memory nicely...
  */
 static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
-		     unsigned long top)
+		     unsigned long top, bool compat)
 {
 	unsigned long first;
 	mm_segment_t fs;
 	int i;
+	unsigned int width = compat ? 4 : 8;
 
 	/*
 	 * We need to switch to kernel mode so that we can use __get_user
@@ -75,13 +76,22 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		memset(str, ' ', sizeof(str));
 		str[sizeof(str) - 1] = '\0';
 
-		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
+		for (p = first, i = 0; i < (32 / width)
+					&& p < top; i++, p += width) {
 			if (p >= bottom && p < top) {
-				unsigned int val;
-				if (__get_user(val, (unsigned int *)p) == 0)
-					sprintf(str + i * 9, " %08x", val);
-				else
-					sprintf(str + i * 9, " ????????");
+				unsigned long val;
+
+				if (width == 8) {
+					if (__get_user(val, (unsigned long *)p) == 0)
+						sprintf(str + i * 17, " %016lx", val);
+					else
+						sprintf(str + i * 17, " ????????????????");
+				} else {
+					if (__get_user(val, (unsigned int *)p) == 0)
+						sprintf(str + i * 9, " %08lx", val);
+					else
+						sprintf(str + i * 9, " ????????");
+				}
 			}
 		}
 		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
@@ -95,7 +105,7 @@ static void dump_backtrace_entry(unsigned long where, unsigned long stack)
 	print_ip_sym(where);
 	if (in_exception_text(where))
 		dump_mem("", "Exception stack", stack,
-			 stack + sizeof(struct pt_regs));
+			 stack + sizeof(struct pt_regs), false);
 }
 
 static void dump_instr(const char *lvl, struct pt_regs *regs)
@@ -206,8 +216,9 @@ static int __die(const char *str, int err, struct thread_info *thread,
 		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
-			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
+		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
+			 THREAD_SIZE + (unsigned long)task_stack_page(tsk),
+			 compat_user_mode(regs));
 		dump_backtrace(regs, tsk);
 		dump_instr(KERN_EMERG, regs);
 	}
-- 
1.7.9.5
