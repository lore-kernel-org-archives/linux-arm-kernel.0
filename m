From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  2 Sep 2015 18:28:10 +0200
Subject: [PATCH] ARM: disable GCC SRA optimization
Message-ID: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While working on the 32-bit ARM port of UEFI, I noticed a strange
corruption in the kernel log. The following snprintf() statement
(in drivers/firmware/efi/efi.c:efi_md_typeattr_format())

	snprintf(pos, size, "|%3s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",

was producing the following output in the log:

	|    |   |   |   |    |WB|WT|WC|UC]
	|    |   |   |   |    |WB|WT|WC|UC]
	|    |   |   |   |    |WB|WT|WC|UC]
	|RUN|   |   |   |    |WB|WT|WC|UC]*
	|RUN|   |   |   |    |WB|WT|WC|UC]*
	|    |   |   |   |    |WB|WT|WC|UC]
	|RUN|   |   |   |    |WB|WT|WC|UC]*
	|    |   |   |   |    |WB|WT|WC|UC]
	|RUN|   |   |   |    |   |   |   |UC]
	|RUN|   |   |   |    |   |   |   |UC]

As it turns out, this is caused by incorrect code being emitted for
the string() function in lib/vsprintf.c. The following code

	if (!(spec.flags & LEFT)) {
		while (len < spec.field_width--) {
			if (buf < end)
				*buf = ' ';
			++buf;
		}
	}
	for (i = 0; i < len; ++i) {
		if (buf < end)
			*buf = *s;
		++buf; ++s;
	}
	while (len < spec.field_width--) {
		if (buf < end)
			*buf = ' ';
		++buf;
	}

when called with len == 0, triggers an issue in the GCC SRA optimization
pass (Scalar Replacement of Aggregates), which handles promotion of signed
struct members incorrectly. This is a known but as yet unresolved issue.
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932). In this particular
case, it is causing the second while loop to be executed erroneously a
single time, causing the additional space characters to be printed.

So disable the optimization by passing -fno-ipa-sra.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Needs to go to stable perhaps?
The emitted asm is at the end of this patch.

 arch/arm/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7451b447cc2d..2c2b28ee4811 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -54,6 +54,14 @@ AS		+= -EL
 LD		+= -EL
 endif
 
+#
+# The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
+# later may result in code being generated that handles signed short and signed
+# char struct members incorrectly. So disable it.
+# (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932)
+#
+KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
+
 # This selects which instruction set is used.
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
-- 
1.9.1


000014d0 <string.isra.5>:
    14d0:       e3520a01        cmp     r2, #4096       ; 0x1000
    14d4:       e92d41f0        push    {r4, r5, r6, r7, r8, lr}
    14d8:       e3007000        movw    r7, #0
    14dc:       e3407000        movt    r7, #0
    14e0:       21a07002        movcs   r7, r2
    14e4:       e1a05000        mov     r5, r0
    14e8:       e1a06001        mov     r6, r1
    14ec:       e1a00007        mov     r0, r7
    14f0:       e1dd11fc        ldrsh   r1, [sp, #28]
    14f4:       e1a08003        mov     r8, r3
    14f8:       e1dd41f8        ldrsh   r4, [sp, #24]
    14fc:       ebfffffe        bl      0 <strnlen>
    1500:       e3180002        tst     r8, #2
    1504:       1a00000d        bne     1540 <string.isra.5+0x70>
    1508:       e1500004        cmp     r0, r4
    150c:       e2443001        sub     r3, r4, #1
    1510:       e6bf4073        sxth    r4, r3
    1514:       aa000009        bge     1540 <string.isra.5+0x70>
    1518:       e3a02020        mov     r2, #32
    151c:       e2443001        sub     r3, r4, #1
    1520:       e1560005        cmp     r6, r5
    1524:       85c52000        strbhi  r2, [r5]
    1528:       e1500004        cmp     r0, r4
    152c:       e6ff3073        uxth    r3, r3
    1530:       e2855001        add     r5, r5, #1
    1534:       e6bf4073        sxth    r4, r3
    1538:       bafffff7        blt     151c <string.isra.5+0x4c>
    153c:       e1a04003        mov     r4, r3
    1540:       e3500000        cmp     r0, #0
    1544:       da000016        ble     15a4 <string.isra.5+0xd4>
    1548:       e085c000        add     ip, r5, r0
    154c:       e1560005        cmp     r6, r5
    1550:       e2855001        add     r5, r5, #1
    1554:       e2877001        add     r7, r7, #1
    1558:       85573001        ldrbhi  r3, [r7, #-1]
    155c:       85453001        strbhi  r3, [r5, #-1]
    1560:       e155000c        cmp     r5, ip
    1564:       1afffff8        bne     154c <string.isra.5+0x7c>
    1568:       e2443001        sub     r3, r4, #1
    156c:       e1500004        cmp     r0, r4
    1570:       e6bf3073        sxth    r3, r3
    1574:       aa000008        bge     159c <string.isra.5+0xcc>
    1578:       e3a01020        mov     r1, #32
    157c:       e156000c        cmp     r6, ip
    1580:       e1a02003        mov     r2, r3
    1584:       85cc1000        strbhi  r1, [ip]
    1588:       e2433001        sub     r3, r3, #1
    158c:       e1500002        cmp     r0, r2
    1590:       e28cc001        add     ip, ip, #1
    1594:       e6bf3073        sxth    r3, r3
    1598:       bafffff7        blt     157c <string.isra.5+0xac>
    159c:       e1a0000c        mov     r0, ip
    15a0:       e8bd81f0        pop     {r4, r5, r6, r7, r8, pc}
    15a4:       e1a0c005        mov     ip, r5
    15a8:       eaffffee        b       1568 <string.isra.5+0x98>
