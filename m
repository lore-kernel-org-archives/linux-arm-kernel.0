From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 20 Nov 2016 12:03:50 -0500 (EST)
Subject: commit 4dd1837d7589f468ed109556513f476e7a7f9121 breaks build
In-Reply-To: <20161120132502.GV1041@n2100.armlinux.org.uk>
References: <58310EC6.4020402@math.uni-bielefeld.de>
 <20161120113007.GS1041@n2100.armlinux.org.uk>
 <58318C6A.50104@math.uni-bielefeld.de>
 <20161120123422.GT1041@n2100.armlinux.org.uk>
 <58319D70.7030106@math.uni-bielefeld.de>
 <20161120132502.GV1041@n2100.armlinux.org.uk>
Message-ID: <alpine.LFD.2.20.1611201131300.1814@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Nov 2016, Russell King - ARM Linux wrote:

> On Sun, Nov 20, 2016 at 01:56:16PM +0100, Tobias Jakobi wrote:
> > Hey Russell,
> > 
> > thanks for the quick reply and looking into this!
> > 
> > Added Nicolas Pitre to Cc since the ksym trim stuff came from him.
> 
> Arnd's patch "kbuild: provide include/asm/asm-prototypes.h for ARM" fixes
> it, but I think it's a mixture of fixes, and partially dependent on some
> other patches.  I don't know what the status of his patch is, but my
> feeling is that it consists of more than a single fix, and needs
> splitting.  Certainly the asm-prototypes.h is not relevant to this
> problem, but the rest of it seems to be.

Well... the problem for the current breakage was identified a while ago:

https://lkml.org/lkml/2016/2/10/686

I'm surprised that Al didn't fold my patch into his.  Now that this has 
hit mainline, CONFIG_TRIM_UNUSED_KSYMS is now broken on ARM.

And I don't see how the asm-prototypes.h is going to fix it either (if 
anything, at the moment it looks like it might be another source of 
breakage).

So I think the folowing patch should go into mainline:

----- >8
>From 3225f625c116a350c54f361df491bf3e1c6d32b3 Mon Sep 17 00:00:00 2001
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Wed, 10 Feb 2016 17:40:04 -0500
Subject: [PATCH] ARM: don't use assembler macro arguments with EXPORT_SYMBOL()

Committ 4dd1837d75 ("arm: move exports to definitions") added
EXPORT_SYMBOL(\name) to bitops.h. Here \name is an assembler macro
argument which is not subject to preprocessor substitutions. And the
assembler doesn't handle preprocessor macros either. That has the effect
of breaking CONFIG_TRIM_UNUSED_KSYMS=y.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index df06638b32..7d807cfd8e 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,6 +1,5 @@
 #include <asm/assembler.h>
 #include <asm/unwind.h>
-#include <asm/export.h>
 
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
@@ -26,7 +25,6 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
@@ -57,7 +55,6 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -77,7 +74,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -106,6 +102,5 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #endif
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f402786217..1cfdb138d2 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_change_bit, eor
+
+EXPORT_SYMBOL(_change_bit)
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d..e901ca5af0 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_clear_bit, bic
+
+EXPORT_SYMBOL(_clear_bit)
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b..3c8b11240f 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
 		.text
 
 bitop	_set_bit, orr
+
+EXPORT_SYMBOL(_set_bit)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59..e3d19b87fb 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+EXPORT_SYMBOL(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce..d247e6f70f 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+EXPORT_SYMBOL(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e4..76800ff601 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+EXPORT_SYMBOL(_test_and_set_bit)
