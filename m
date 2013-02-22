From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Feb 2013 12:36:37 +0000
Subject: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY +
 !DEBUG_[SPINLOCK|MUTEXES] = BUG()
In-Reply-To: <20130221094819.GA4580@luxor.wired.org>
References: <20130221094819.GA4580@luxor.wired.org>
Message-ID: <20130222123637.GA30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> any idea how can i debug this?

Please try this patch, and report back whether it solves your problem.
Thanks.

 arch/arm/mm/alignment.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b820eda..db26e2e 100644
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
+		u16 *ptr = (u16 *)(instrptr & ~1);
+		fault = probe_kernel_address(ptr, tinstr);
 		if (!fault) {
 			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
 			    IS_T32(tinstr)) {
 				/* Thumb-2 32-bit */
 				u16 tinst2 = 0;
-				fault = __get_user(tinst2, (u16 *)(instrptr+2));
+				fault = probe_kernel_address(ptr + 1, tinst2);
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
