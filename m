From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Thu, 30 May 2013 20:22:56 +0800
Subject: =?gb2312?B?tPC4tDogQSBidWcgYWJvdXQgc3lzdGVtIGNhbGwgb24gQVJN?=
Message-ID: <ih0015wu30o5nq4ajf437rl7.1369916575726@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

i see your solution,
i Will test it tomorrow,
and report the result to you ASAP!

Thank for your help very much.

Sent from Moxier Mail
(http://www.moxier.com)


----- ???? -----
???: Will Deacon <will.deacon@arm.com>
???: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
??: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch at vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel at vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel at lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
????: 2013-5-30 19:41
??: Re: A bug about system call on ARM



On Thu, May 30, 2013 at 10:09:49AM +0100, Will Deacon wrote:
> On Thu, May 30, 2013 at 02:41:42AM +0100, Wang, Yalin wrote:
> > If you have some patch for this issue,
> > I can do the test for it .
>
> I'll have a look at cooking something which uses an exception table entry
> to rewind the PC and retry the system call. That's simpler than directly
> injecting a user page fault from the system call path.

Ok, please can you try the following?

Will

--->8

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index bc5bc0a..855926e 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -361,6 +361,15 @@ ENTRY(vector_swi)
        str     r8, [sp, #S_PSR]                @ Save CPSR
        str     r0, [sp, #S_OLD_R0]             @ Save OLD_R0
        zero_fp
+       enable_irq
+       ct_user_exit
+
+#ifdef CONFIG_ALIGNMENT_TRAP
+       ldr     ip, __cr_alignment
+       ldr     ip, [ip]
+       mcr     p15, 0, ip, c1, c0              @ update control register
+#endif
+       get_thread_info tsk

        /*
         * Get the system call number.
@@ -375,9 +384,9 @@ ENTRY(vector_swi)
 #ifdef CONFIG_ARM_THUMB
        tst     r8, #PSR_T_BIT
        movne   r10, #0                         @ no thumb OABI emulation
-       ldreq   r10, [lr, #-4]                  @ get SWI instruction
+ USER( ldreq   r10, [lr, #-4]          )       @ get SWI instruction
 #else
-       ldr     r10, [lr, #-4]                  @ get SWI instruction
+ USER( ldr     r10, [lr, #-4]          )       @ get SWI instruction
 #endif
 #ifdef CONFIG_CPU_ENDIAN_BE8
        rev     r10, r10                        @ little endian instruction
@@ -392,22 +401,13 @@ ENTRY(vector_swi)
        /* Legacy ABI only, possibly thumb mode. */
        tst     r8, #PSR_T_BIT                  @ this is SPSR from save_user_regs
        addne   scno, r7, #__NR_SYSCALL_BASE    @ put OS number in
-       ldreq   scno, [lr, #-4]
+ USER( ldreq   scno, [lr, #-4]         )

 #else
        /* Legacy ABI only. */
-       ldr     scno, [lr, #-4]                 @ get SWI instruction
-#endif
-
-#ifdef CONFIG_ALIGNMENT_TRAP
-       ldr     ip, __cr_alignment
-       ldr     ip, [ip]
-       mcr     p15, 0, ip, c1, c0              @ update control register
+ USER( ldr     scno, [lr, #-4]         )       @ get SWI instruction
 #endif
-       enable_irq
-       ct_user_exit

-       get_thread_info tsk
        adr     tbl, sys_call_table             @ load syscall table pointer

 #if defined(CONFIG_OABI_COMPAT)
@@ -442,6 +442,18 @@ local_restart:
        eor     r0, scno, #__NR_SYSCALL_BASE    @ put OS number back
        bcs     arm_syscall
        b       sys_ni_syscall                  @ not private func
+
+#if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
+       /*
+        * We may have faulted trying to load the SWI instruction due to
+        * concurrent page aging on another CPU. In this case, return
+        * back to the swi instruction and fault the page back.
+        */
+9001:
+       sub     lr, lr, #4
+       str     lr, [sp, #S_PC]
+       b       ret_fast_syscall
+#endif
 ENDPROC(vector_swi)

        /*
