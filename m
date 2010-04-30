From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 30 Apr 2010 12:41:16 +0530
Subject: [PATCH] ARM: Fix build break with KPROBES enabled
Message-ID: <mailman.347.1272619656.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_KPROBES enabled two section are getting created which
leads to below build break.

LOG:
 AS      arch/arm/kernel/entry-armv.o
arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:431: Error: symbol ret_from_exception is in a =
different section
arch/arm/kernel/entry-armv.S:490: Error: symbol ret_from_exception is in a =
different section
arch/arm/kernel/entry-armv.S:491: Error: symbol __und_usr_unknown is in a d=
ifferent section

This was introduced by commit 4260415f6a3b92c5c986398d96c314df37a4ccbf

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/kernel/entry-armv.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e6a0fb0..7ee48e7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -676,10 +676,10 @@ do_fpe:
  *  lr  =3D unrecognised FP instruction return address
  */
=20
-	.data
+	.pushsection .data
 ENTRY(fp_enter)
 	.word	no_fp
-	.text
+	.popsection
=20
 ENTRY(no_fp)
 	mov	pc, lr
--=20
1.6.0.4
