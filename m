From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 17:24:36 +0100
Subject: [PATCH] MPILIB: avoid assembler warning
Message-ID: <16372019.BFlLRod3Eu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A wrapper around the umull assembly instruction might reuse
the input register as an output, which is undefined on
some ARM machines, as pointed out by this assembler warning:

  CC      lib/mpi/generic_mpih-mul1.o
/tmp/ccxJuxIy.s: Assembler messages:
/tmp/ccxJuxIy.s:53: rdhi, rdlo and rm must all be different
  CC      lib/mpi/generic_mpih-mul2.o
/tmp/ccI0scAD.s: Assembler messages:
/tmp/ccI0scAD.s:53: rdhi, rdlo and rm must all be different
  CC      lib/mpi/generic_mpih-mul3.o
/tmp/ccMvVQcp.s: Assembler messages:
/tmp/ccMvVQcp.s:53: rdhi, rdlo and rm must all be different

This changes the constraints to force different registers to
be used as output.

Signed-off-by: Arnd Bergmann <arnd@arnd.de>
---
Not sure who would be the best person to pick this patch up.

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index aac511417ad1..c4dbdb506174 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -216,7 +216,7 @@ extern UDItype __udiv_qrnnd(UDItype *, UDItype, UDItype, UDItype);
 	__asm__ ("%@ Inlined umul_ppmm\n" \
 		"umull %r1, %r0, %r2, %r3" \
 	: "=&r" ((USItype)(xh)), \
-			"=r" ((USItype)(xl)) \
+			"=&r" ((USItype)(xl)) \
 	: "r" ((USItype)(a)), \
 			"r" ((USItype)(b)) \
 	: "r0", "r1")
