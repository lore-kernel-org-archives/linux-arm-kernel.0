From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 11:51:33 +0100
Subject: alignment faults in 3.6
In-Reply-To: <20121005072914.GE4625@n2100.arm.linux.org.uk>
References: <506E1762.3010601@gmail.com>
 <20121005072914.GE4625@n2100.arm.linux.org.uk>
Message-ID: <20121005105133.GP4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 08:29:14AM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 04, 2012 at 06:10:26PM -0500, Rob Herring wrote:
> > I would think the scheduling while atomic messages are harmless in this
> > case. However, in addition to spewing out BUG messages this commit also
> > seems to eventually cause a kernel panic in __napi_complete. That panic
> > seems to go away if I put barrier() between the 2 accesses above which
> > eliminates the alignment faults. I haven't figured that part out yet.
> > 
> > There's at least a couple of problems here:
> > 
> > This seems like an overly aggressive compiler optimization considering
> > unaligned accesses are not supported by ldm/stm.
> > 
> > The alignment fault handler should handle kernel address faults atomically.
> 
> This is bad news.  do_alignment() can be called in almost any kernel
> context, and it must work.  die() and oops dumps - specifically dump_mem()
> and dump_instr() will suffer from exactly the same problem.

Okay, this should fix the issue...  I've only compile tested it so far.
Rob, as you have a way to trigger this easily, can you give this patch
a go and let me know if it solves your problem?  Thanks.

 arch/arm/kernel/traps.c |   34 +++++++---------------------------
 arch/arm/mm/alignment.c |   11 ++++-------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index b0179b8..62f429e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -89,17 +89,8 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top)
 {
 	unsigned long first;
-	mm_segment_t fs;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	printk("%s%s(0x%08lx to 0x%08lx)\n", lvl, str, bottom, top);
 
 	for (first = bottom & ~31; first < top; first += 32) {
@@ -112,7 +103,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
 			if (p >= bottom && p < top) {
 				unsigned long val;
-				if (__get_user(val, (unsigned long *)p) == 0)
+				if (probe_kernel_address(p, val) == 0)
 					sprintf(str + i * 9, " %08lx", val);
 				else
 					sprintf(str + i * 9, " ????????");
@@ -120,8 +111,6 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		}
 		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
-
-	set_fs(fs);
 }
 
 static void dump_instr(const char *lvl, struct pt_regs *regs)
@@ -129,25 +118,18 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 	unsigned long addr = instruction_pointer(regs);
 	const int thumb = thumb_mode(regs);
 	const int width = thumb ? 4 : 8;
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
 	for (i = -4; i < 1 + !!thumb; i++) {
 		unsigned int val, bad;
 
-		if (thumb)
-			bad = __get_user(val, &((u16 *)addr)[i]);
-		else
-			bad = __get_user(val, &((u32 *)addr)[i]);
+		if (thumb) {
+			u16 instr;
+			bad = probe_kernel_address(addr, instr);
+			val = instr;
+		} else
+			bad = probe_kernel_address(addr, val);
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
@@ -158,8 +140,6 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 		}
 	}
 	printk("%sCode: %s\n", lvl, str);
-
-	set_fs(fs);
 }
 
 #ifdef CONFIG_ARM_UNWIND
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b9f60eb..f8f14fc 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -749,7 +749,6 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-	mm_segment_t fs;
 	unsigned int fault;
 	u16 tinstr = 0;
 	int isize = 4;
@@ -760,16 +759,15 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	instrptr = instruction_pointer(regs);
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
 	if (thumb_mode(regs)) {
-		fault = __get_user(tinstr, (u16 *)(instrptr & ~1));
+		unsigned long ptr = instrptr;
+		fault = probe_kernel_address(ptr, tinstr);
 		if (!fault) {
 			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
 			    IS_T32(tinstr)) {
 				/* Thumb-2 32-bit */
 				u16 tinst2 = 0;
-				fault = __get_user(tinst2, (u16 *)(instrptr+2));
+				fault = probe_kernel_address(ptr + 2, tinst2);
 				instr = (tinstr << 16) | tinst2;
 				thumb2_32b = 1;
 			} else {
@@ -778,8 +776,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			}
 		}
 	} else
-		fault = __get_user(instr, (u32 *)instrptr);
-	set_fs(fs);
+		fault = probe_kernel_address(instrptr, instr);
 
 	if (fault) {
 		type = TYPE_FAULT;
