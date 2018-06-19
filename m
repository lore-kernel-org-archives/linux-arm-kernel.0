From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 18 Jun 2018 22:07:08 -0700
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr address
 calculation
Message-ID: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern assemblers may take the ISA into account when resolving local
symbols. This can result in bad address calculations when using badr
in the wrong location since the offset + 1 may be added twice, resulting
in an even address target for THUMB instructions. This in turn results
in an exception at (destination address + 2).

Unhandled exception: IPSR = 00000006 LR = fffffff1
CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
Hardware name: MPS2 (Device Tree Support)
PC is at ret_fast_syscall+0x2/0x58
LR is at tty_ioctl+0x2a5/0x528
pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
sp : 21825fa8  ip : 0000001c  fp : 21a95892
r10: 00000000  r9 : 21824000  r8 : 210091c0
r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
xPSR: 4000000b
CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
Hardware name: MPS2 (Device Tree Support)
[<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
[<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)

Fix the problem by using a logical or instead of an addition. This is
less efficient but guaranteed to work.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC: I don't really like this, but my ARM assembler knowledge is quite
limited. Just dropping the "+ 1" from badr doesn't work because some
other code needs it (the image hangs completely if I try that).
Ultimately I don't even know if the invoke_syscall macro should just
have used adr instead of badr (but then how did this ever work ?).

Seen with various toolchains based on gcc 7.x and binutils 2.30 when
building and testing MPS2 images.

 arch/arm/include/asm/assembler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 0cd4dccbae78..24c87ff2060f 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,7 +195,8 @@
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
+	adr\c	\rd, \sym
+	orr	\rd, #1
 #else
 	adr\c	\rd, \sym
 #endif
-- 
2.7.4
