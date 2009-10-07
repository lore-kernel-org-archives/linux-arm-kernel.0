From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Wed, 7 Oct 2009 11:08:34 +0100
Subject: [PATCH] arm: use unified discard definition in linker script
Message-ID: <mailman.57.1254911358.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 023bf6f "linker script: unify usage of discard definition"
changed the linker scripts for all architectures except for ARM.
I can find no discussion about this exception, so here are the changes
for ARM.

These changes are exactly parallel to the ia64 case.

"ia64 is notable because it first throws away some ia64 specific
 subsections and then include the rest of the sections into the final
 image, so those sections must be discarded before the inclusion."

Not boot-tested.  In build testing, the modified linker script generated
an identical vmlinux file.


[I would like to be able to rely on this unified discard definition.
 I want to sort the kernel symbol tables to allow faster symbol
 resolution during module loading. The simplest way appears to be
 to generate sorted versions from vmlinux.o, link them in to vmlinux,
 _and discard the original unsorted tables_.

 This work is driven by my x86 netbook, but it is implemented at a
 generic level. It is possible it will benefit some ARM systems also.]


Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Tejun Heo <tj@kernel.org>
---
 arch/arm/kernel/vmlinux.lds.S |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index aecf87d..ec511d4 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -79,11 +79,11 @@ SECTIONS
 #endif
 	}
 
-	/DISCARD/ : {			/* Exit code and data		*/
-		EXIT_TEXT
-		EXIT_DATA
-		*(.exitcall.exit)
-		*(.discard)
+	/*
+	 * unwind exit sections must be discarded before the rest of the
+	 * unwind sections get included.
+	 */
+	/DISCARD/ : {
 		*(.ARM.exidx.exit.text)
 		*(.ARM.extab.exit.text)
 #ifndef CONFIG_HOTPLUG_CPU
@@ -271,6 +271,9 @@ SECTIONS
 	.stab.index 0 : { *(.stab.index) }
 	.stab.indexstr 0 : { *(.stab.indexstr) }
 	.comment 0 : { *(.comment) }
+
+	/* Default discards */
+	DISCARDS
 }
 
 /*
-- 
1.6.3.2
