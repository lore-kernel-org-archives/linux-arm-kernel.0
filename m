From: lvqiang.huang@spreadtrum.com (=?gb2312?B?THZxaWFuZyBIdWFuZyAou8bCwMe/KQ==?=)
Date: Fri, 27 Oct 2017 02:00:04 +0000
Subject: [PATCH] ARM: Fix csum_partial_copy_from_user() stack mismatch
In-Reply-To: <20171024073225.17374-1-chunyan.zhang@spreadtrum.com>
References: <20171024073225.17374-1-chunyan.zhang@spreadtrum.com>
Message-ID: <cdc431cae1794be585806bfc4636447c@SHMBX04.spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, 

The bug was introduced by the commit a5e090acbf545c0a3b04080f8a488b17ec41fe02
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Wed Aug 19 20:40:41 2015 +0100

    ARM: software-based priviledged-no-access support
    
    Provide a software-based implementation of the priviledged no access
    support found in ARMv8.1.
    
    Userspace pages are mapped using a different domain number from the
    kernel and IO mappings.  If we switch the user domain to "no access"
    when we enter the kernel, we can prevent the kernel from touching
    userspace.
    
    However, the kernel needs to be able to access userspace via the
    various user accessor functions.  With the wrapping in the previous
    patch, we can temporarily enable access when the kernel needs user
    access, and re-disable it afterwards.
    
    This allows us to trap non-intended accesses to userspace, eg, caused
    by an inadvertent dereference of the LIST_POISON* values, which, with
    appropriate user mappings setup, can be made to succeed.  This in turn
    can allow use-after-free bugs to be further exploited than would
    otherwise be possible.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
...... 
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1d0957e..1712f13 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -17,6 +17,19 @@
 
 		.text
 
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		.macro	save_regs
+		mrc	p15, 0, ip, c3, c0, 0
+		stmfd	sp!, {r1, r2, r4 - r8, ip, lr}
+		uaccess_enable ip
+		.endm
+
+		.macro	load_regs
+		ldmfd	sp!, {r1, r2, r4 - r8, ip, lr}
+		mcr	p15, 0, ip, c3, c0, 0
+		ret	lr
+		.endm
+#else
 		.macro	save_regs
 		stmfd	sp!, {r1, r2, r4 - r8, lr}
 		.endm
@@ -24,6 +37,7 @@
 		.macro	load_regs
 		ldmfd	sp!, {r1, r2, r4 - r8, pc}
 		.endm
+#endif
......

The following is based on CONFIG_CPU_SW_DOMAIN_PAN defined. 

the commit modified the save_reg marco. 
+		stmfd	sp!, {r1, r2, r4 - r8, ip, lr}
So, additional ip will push to the stack. 

The csum_partial_copy_from_user() use the save_reg marco. 
/*
 * unsigned int
 * csum_partial_copy_from_user(const char *src, char *dst, int len, int sum, int *err_ptr)
 *  r0 = src, r1 = dst, r2 = len, r3 = sum, [sp] = *err_ptr
 *  Returns : r0 = checksum, [[sp, #0], #0] = 0 or -EFAULT
 */

The src r0 is from user space. 
and if user buffer become not mapped for some reasons, 
the ldr from r0 will cause an abort, 
the abort handler will return the PC to .fixup entry 9001: 

9001:		mov	r4, #-EFAULT
		ldr	r5, [sp, #8*4]		@ *err_ptr
		str	r4, [r5]
		ldmia	sp, {r1, r2}		@ retrieve dst, len
		add	r2, r2, r1
		mov	r0, #0			@ zero the buffer

the r5 will pointer to the lr pushed. 
		ldr	r5, [sp, #8*4]		@ *err_ptr

then str to lr is the bug.
 		str	r4, [r5]

we hit the bug many times recently. 
Here is a example, 
[  259.378437] c0 Unable to handle kernel paging request at virtual address c0494578
[  259.378460] c0 pgd = dc888000
[  259.378469] c0 [c0494578] *pgd=8041940e(bad)
[  259.378490] c0 Internal error: Oops: 80d [#1] PREEMPT SMP ARM
[  259.384159] c0 Modules linked in: sprdwl_ng(O) mtty marlin2_fm mali_kbase(O)
[  259.384191] c0 CPU: 0 PID: 7068 Comm: AsyncTask #3 Tainted: G        W  O    4.4.83-00113-g5c60505 #1
[  259.384200] c0 Hardware name: sc9850k
[  259.384211] c0 task: e00eb480 task.stack: e0080000
[  259.384228] c0 PC is at csum_partial_copy_from_user+0x3bc/0x3e4
[  259.384242] c0 LR is at csum_and_copy_from_iter+0x340/0x4f4
[  259.384254] c0 pc : [<c04809d8>]    lr : [<c0494578>]    psr: 000d0013
                  sp : e0081d8c  ip : 00000170  fp : e0081e04
[  259.384267] c0 r10: e0081edc  r9 : e0081ecc  r8 : 00000174
[  259.384277] c0 r7 : 00000000  r6 : dd9bda84  r5 : c0494578  r4 : fffffff2
[  259.384287] c0 r3 : 00000000  r2 : 00000174  r1 : dd9bd910  r0 : 8a1779d8
[  259.384298] c0 Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  259.384309] c0 Control: 10c5387d  Table: 9c88806a  DAC: 00000055

The r5 = LR = c0494578, at csum_and_copy_from_iter+0x340/0x4f4
The str to LR cause an kernel crash. 
0xc04809d0 <csum_partial_copy_from_user+0x3b4>:   mvn     r4, #13
0xc04809d4 <csum_partial_copy_from_user+0x3b8>:   ldr     r5, [sp, #32]
0xc04809d8 <csum_partial_copy_from_user+0x3bc>:   str     r4, [r5]

We can see the r0 is not mapped at that time. 
crash> vtop 8a1779d8
VIRTUAL   PHYSICAL
8a1779d8  (not mapped)

The backtrace get from the stack data is
  csum_partial_copy_from_user
  csum_and_copy_from_iter+832
  tcp_sendmsg+1008
  inet_sendmsg+156. 
  sock_sendmsg+68
  sys_sendto+204

the patch for the bug 
9001:		mov	r4, #-EFAULT
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		ldr	r5, [sp, #9*4]		@ *err_ptr
+#else
 		ldr	r5, [sp, #8*4]		@ *err_ptr
+#endif
 		str	r4, [r5]

I'm sure you can provide a better solution. 
looking forward to your reply, thanks. 

Best Wishes,
Lvqiang Huang
-----????-----
???: Chunyan Zhang (???) 
????: 2017?10?24? 15:32
???: Russell King
??: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Orson Zhai (??); Chunyan Zhang; Lvqiang Huang (???)
??: [PATCH] ARM: Fix csum_partial_copy_from_user() stack mismatch

From: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>

An additional 'ip' will be pushed to the stack, for restoring the DACR later, if CONFIG_CPU_SW_DOMAIN_PAN defined.

However, the fixup still get the err_ptr by add #8*4 to sp, which results in the fact that the code area pointed by the LR will be overwritten, or the kernel will crash if CONFIG_DEBUG_RODATA is enabled.

This patch fixes the stack mismatch.

Signed-off-by: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm/lib/csumpartialcopyuser.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1712f13..b83fdc0 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -85,7 +85,11 @@
 		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		ldr	r5, [sp, #9*4]		@ *err_ptr
+#else
 		ldr	r5, [sp, #8*4]		@ *err_ptr
+#endif
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
--
1.7.9.5
