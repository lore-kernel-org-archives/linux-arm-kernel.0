From: seokjoo.lee@lge.com (Seokjoo Lee)
Date: Wed, 13 Sep 2017 16:15:57 +0900
Subject: [PATCH] ARM: Fix oops at csum_and_copy_from_user()
Message-ID: <1505286957-11576-1-git-send-email-seokjoo.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "seokjoo.lee" <seokjoo.lee@lge.com>

fix code corruption by fixup part of csum_partial_copy_from_user()
due to invalid stack offset of err_ptr for CONFIG_CPU_SW_DOMAIN_PAN.

For a kernel built for arm architecture with CONFIG_CPU_SW_DOMAIN_PAN,
if an application calls 'sendto' with *invalid parameter* which might
cause fault within csum_paritial_copy_from_user, then the fixup part of
csum_partial_copy_from_user try to overwrite code area stored at 'lr'.
Then, kernel generates oops with undefined instruction 0xfffffff2 at
csum_and_copy_from_iter triggered from the next 'sendto' call.
This behavior is not gracefully returning *err_ptr with -EFAULT value as
designed.

Originally 'save_regs' macro stores 8 registers - (r1, r2, r4 - r8, lr)
and the err_ptr was passed at '[sp, #8*4]'.
Since commit a5e090acbf54 ("ARM: software-based priviledged-no-access
support") introducing CONFIG_CPU_SW_DOMAIN_PAN, this bug lurks in fixup
part below the screen.
If CONFIG_CPU_SW_DOMAIN_PAN is defined, the 'save_regs' macro stores 9
registers - '(r1, r2, r4 - r8, ip, lr)' into stack and the err_ptr is
passed at '[sp, #9*4]' instead of '[sp, #8*4]' because of 'ip' register
adopted to save value of Domain Access Control register.
After then, fault handling mechanism triggered by *invalid parameter*
jumps into fixup part of csum_paritial_copy_from_user, regardlessly
stores -EFAULT value to [[sp, #8*4]] which is actually '[lr]'. Finally,
this try to overwrite caller of 'csum_partial_copy_from_user', i.e.
'csum_and_copy_from_iter' - as 0xfffffff2.

Fix by defining ERR_PTR_OFFSET properly within #if block near
'save_regs/load_regs' pair to reduce the chance of mistake, and
by replacing the constant 8 in fixup part with ERR_PTR_OFFSET to deal
with CONFIG_CPU_SW_DOMAIN_PAN.

---
A kernel with CONFIG_CPU_SW_DOMAIN_PAN produces panic as follows.

Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
CPU: 3 PID: 2685 Comm: connmand Tainted: P           O    4.4.3-132 #1
Hardware name: LG Electronics DTV SoC
task: ab7cc200 ti: bbb40000 task.ti: bbb40000
PC is at csum_and_copy_from_iter+0x140/0x50c
LR is at csum_and_copy_from_iter+0x140/0x50c
pc : [<803b2148>]    lr : [<803b2148>]    psr: 40010013
sp : bbb41c90  ip : 00000051  fp : 00000000
r10: 00000028  r9 : b4921c2c  r8 : b4921c24
r7 : bbb41ee4  r6 : 00000000  r5 : 00000028  r4 : bbb41ef4
r3 : 00000000  r2 : 00000028  r1 : b4921c2c  r0 : 00000000
.....
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5383d  Table: 3b64806a  DAC: 00000051
[<803b2148>] (csum_and_copy_from_iter) from [<80a9aebc>] (ip_generic_getfrag+0x3c/0xc0)
[<80a9aebc>] (ip_generic_getfrag) from [<80a9ac0c>] (__ip_append_data+0x7c8/0x9dc)
[<80a9ac0c>] (__ip_append_data) from [<80a9c730>] (ip_make_skb+0xb0/0xec)
[<80a9c730>] (ip_make_skb) from [<80ac3a4c>] (udp_sendmsg+0x270/0x828)
[<80ac3a4c>] (udp_sendmsg) from [<80a43a8c>] (sock_sendmsg+0x14/0x24)
[<80a43a8c>] (sock_sendmsg) from [<80a44ec8>] (SyS_sendto+0xb4/0xe8)
[<80a44ec8>] (SyS_sendto) from [<80090280>] (ret_fast_syscall+0x0/0x3c)
Code: e58d2000 e1a01009 e1a02005 ebffad40 (fffffff2)
---[ end trace 6870c0e483440b32 ]---

Signed-off-by: Seokjoo Lee <seokjoo.lee@lge.com>
Signed-off-by: Jaeguk Lee <jaeguk.lee@lge.com>
Cc: Jongsung Kim <neidhard.kim@lge.com>
Cc: Chanho Min <chanho.min@lge.com>
---
 arch/arm/lib/csumpartialcopyuser.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1712f13..0772bce 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -29,6 +29,7 @@
 		mcr	p15, 0, ip, c3, c0, 0
 		ret	lr
 		.endm
+#define ERR_PTR_OFFSET 9
 #else
 		.macro	save_regs
 		stmfd	sp!, {r1, r2, r4 - r8, lr}
@@ -37,6 +38,7 @@
 		.macro	load_regs
 		ldmfd	sp!, {r1, r2, r4 - r8, pc}
 		.endm
+#define ERR_PTR_OFFSET 8
 #endif
 
 		.macro	load1b,	reg1
@@ -85,7 +87,7 @@
 		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
-		ldr	r5, [sp, #8*4]		@ *err_ptr
+		ldr	r5, [sp, #ERR_PTR_OFFSET*4]		@ *err_ptr
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
-- 
2.7.4
