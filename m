From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 15:00:56 +0100
Subject: Can't boot when THUMB-2 mode at 2.6.32.12
In-Reply-To: <j2q9c9fda241005060535u668dd4ccw328781b77685f6a3@mail.gmail.com>
References: <j2q9c9fda241005060535u668dd4ccw328781b77685f6a3@mail.gmail.com>
Message-ID: <1273154456.2094.8.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-06 at 21:35 +0900, Kyungmin Park wrote:
> I'm turn on the thumb-2 mode with "Use kernel mem{cpy,set}() for
> {copy_to,clear}_user()"
> 
> Then I got the following message. Of course without
> CONFIG_UACCESS_WITH_MEMCPY. it boots well"
> 
> Do you have any hints?
> 
> I used the cortex-A8 cpu.
> 
> [    3.090000] Freeing init memory: 92K
> [    3.100000] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
> [    3.100000] last sysfs file:
> [    3.100000] Modules linked in:
> [    3.100000] CPU: 0    Not tainted  (2.6.32.12 #28)
> [    3.100000] PC is at __copy_to_user_std+0x10/0x418
> [    3.100000] LR is at 0x18e0
> [    3.100000] pc : [<c00fd230>]    lr : [<000018e0>]    psr: 20000013
> [    3.100000] sp : e7835cf8  ip : 000000de  fp : 00000000
> [    3.100000] r10: 00000114  r9 : e718cc00  r8 : 00000013
> [    3.100000] r7 : 00000114  r6 : 00000013  r5 : c036e100  r4 : e7835d74
> [    3.100000] r3 : c0000018  r2 : 00000013  r1 : c0008114  r0 : e7277b80
> [    3.100000] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
                                                             ^^^^^^^
The kernel jumped to the __copy_to_user_std function in ARM mode and it
got an undefined instruction since the code is Thumb-2.

The patch below should solve it (at least this part of the problem). If
it works for you, I'll add some comments and send it to Russell.


diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 1a71e15..5941fbc 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -93,6 +93,7 @@ WEAK(__copy_to_user)
 #include "copy_template.S"
 
 ENDPROC(__copy_to_user)
+ENDPROC(__copy_to_user_std)
 
 	.section .fixup,"ax"
 	.align 0


-- 
Catalin
