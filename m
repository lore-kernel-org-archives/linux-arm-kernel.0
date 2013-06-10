From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:19:36 +0900
Subject: [PATCH 01/06] ARM: shmobile: Add SMP boot function and argument
In-Reply-To: <20130610091925.18944.68117.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
Message-ID: <20130610091936.18944.66463.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add code for mach-shmobile to allow specifying boot function
and argument. Will initially be used for SMP together with SCU
but may in the future also be used for deep sleep resume. This
patch removes one inline virtual to physical address conversion.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp.S             |   13 ++++++++++---
 arch/arm/mach-shmobile/include/mach/common.h |    4 +++-
 2 files changed, 13 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2013-06-05 13:21:14.000000000 +0900
@@ -27,7 +27,14 @@ ENDPROC(shmobile_invalidate_start)
  * We need _long_ jump to the physical address.
  */
 	.align  12
-ENTRY(shmobile_secondary_vector)
+ENTRY(shmobile_boot_vector)
+	ldr     r0, 2f
 	ldr     pc, 1f
-1:	.long   shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
-ENDPROC(shmobile_secondary_vector)
+ENDPROC(shmobile_boot_vector)
+
+	.globl	shmobile_boot_fn
+shmobile_boot_fn:
+1:	.space	4
+	.globl	shmobile_boot_arg
+shmobile_boot_arg:
+2:	.space	4
--- 0016/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-06-05 13:19:52.000000000 +0900
@@ -7,7 +7,9 @@ extern void shmobile_setup_delay(unsigne
 			 unsigned int mult, unsigned int div);
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
-extern void shmobile_secondary_vector(void);
+extern void shmobile_boot_vector(void);
+extern unsigned long shmobile_boot_fn;
+extern unsigned long shmobile_boot_arg;
 extern void shmobile_secondary_vector_scu(void);
 struct clk;
 extern int shmobile_clk_init(void);
