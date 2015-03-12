From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Mar 2015 18:38:07 +0100
Subject: [RFT/RFC PATCH 1/6] ARM: replace PROCINFO embedded branch with
 relative offset
In-Reply-To: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426181892-15440-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the 'branch to setup()' instructions embedded
in the PROCINFO structs with the offset to that setup function
relative to the base of the struct. This preserves the position
independent nature of that field, but uses a data item rather
than an instruction.

This is mainly done to prevent linker failures on large kernels,
where the setup function is out of reach for the branch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/head.S      | 14 ++++++++------
 arch/arm/mm/proc-arm1020.S  |  4 ++--
 arch/arm/mm/proc-arm1020e.S |  4 ++--
 arch/arm/mm/proc-arm1022.S  |  4 ++--
 arch/arm/mm/proc-arm1026.S  |  4 ++--
 arch/arm/mm/proc-arm720.S   |  4 ++--
 arch/arm/mm/proc-arm740.S   |  4 ++--
 arch/arm/mm/proc-arm7tdmi.S |  4 ++--
 arch/arm/mm/proc-arm920.S   |  4 ++--
 arch/arm/mm/proc-arm922.S   |  4 ++--
 arch/arm/mm/proc-arm925.S   |  4 ++--
 arch/arm/mm/proc-arm926.S   |  4 ++--
 arch/arm/mm/proc-arm940.S   |  4 ++--
 arch/arm/mm/proc-arm946.S   |  4 ++--
 arch/arm/mm/proc-arm9tdmi.S |  4 ++--
 arch/arm/mm/proc-fa526.S    |  4 ++--
 arch/arm/mm/proc-feroceon.S |  5 +++--
 arch/arm/mm/proc-macros.S   |  4 ++++
 arch/arm/mm/proc-mohawk.S   |  4 ++--
 arch/arm/mm/proc-sa110.S    |  4 ++--
 arch/arm/mm/proc-sa1100.S   |  4 ++--
 arch/arm/mm/proc-v6.S       |  4 ++--
 arch/arm/mm/proc-v7.S       |  4 ++--
 arch/arm/mm/proc-v7m.S      |  4 ++--
 arch/arm/mm/proc-xsc3.S     |  4 ++--
 arch/arm/mm/proc-xscale.S   |  4 ++--
 26 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 01963273c07a..698b38bfca8f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -138,8 +138,9 @@ ENTRY(stext)
 						@ mmu has been enabled
 	adr	lr, BSYM(1f)			@ return (PIC) address
 	mov	r8, r4				@ set TTBR1 to swapper_pg_dir
- ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
- THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
+	ldr	r12, [r10, #PROCINFO_INITFUNC]
+ ARM(	add	pc, r12, r10			)
+ THUMB(	add	r12, r12, r10			)
  THUMB(	ret	r12				)
 1:	b	__enable_mmu
 ENDPROC(stext)
@@ -386,10 +387,11 @@ ENTRY(secondary_startup)
 	ldr	r8, [r7, lr]			@ get secondary_data.swapper_pg_dir
 	adr	lr, BSYM(__enable_mmu)		@ return address
 	mov	r13, r12			@ __secondary_switched address
- ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
-						  @ (return control reg)
- THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
- THUMB(	ret	r12				)
+	ldr	r12, [r10, #PROCINFO_INITFUNC]
+ ARM(	add	pc, r12, r10		)	@ initialise processor
+						@ (return control reg)
+ THUMB(	add	r12, r12, r10		)
+ THUMB(	ret	r12			)
 ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
 
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 86ee5d47ce3c..7ddd45d6ca52 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -507,7 +507,7 @@ cpu_arm1020_name:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm1020_proc_info,#object
 __arm1020_proc_info:
@@ -519,7 +519,7 @@ __arm1020_proc_info:
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm1020_setup
+	initfn	__arm1020_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index a6331d78601f..d15f556782a8 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -465,7 +465,7 @@ arm1020e_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm1020e_proc_info,#object
 __arm1020e_proc_info:
@@ -479,7 +479,7 @@ __arm1020e_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm1020e_setup
+	initfn	__arm1020e_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_EDSP
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index a126b7a59928..6245e422e95c 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -448,7 +448,7 @@ arm1022_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm1022_proc_info,#object
 __arm1022_proc_info:
@@ -462,7 +462,7 @@ __arm1022_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm1022_setup
+	initfn	__arm1022_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_EDSP
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index fc294067e977..944114b566ef 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -442,7 +442,7 @@ arm1026_crval:
 	string	cpu_arm1026_name, "ARM1026EJ-S"
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm1026_proc_info,#object
 __arm1026_proc_info:
@@ -456,7 +456,7 @@ __arm1026_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm1026_setup
+	initfn	__arm1026_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 2baa66b3ac9b..4bd5f8dcbc29 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -186,7 +186,7 @@ arm720_crval:
  * See <asm/procinfo.h> for a definition of this structure.
  */
 	
-		.section ".proc.info.init", #alloc, #execinstr
+		.section ".proc.info.init", #alloc
 
 .macro arm720_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cpu_flush:req
 		.type	__\name\()_proc_info,#object
@@ -203,7 +203,7 @@ __\name\()_proc_info:
 			PMD_BIT4 | \
 			PMD_SECT_AP_WRITE | \
 			PMD_SECT_AP_READ
-		b	\cpu_flush				@ cpu_flush
+		initfn	\cpu_flush				@ cpu_flush
 		.long	cpu_arch_name				@ arch_name
 		.long	cpu_elf_name				@ elf_name
 		.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB	@ elf_hwcap
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index ac1ea6b3bce4..1dadba6744ec 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -132,14 +132,14 @@ __arm740_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 	.type	__arm740_proc_info,#object
 __arm740_proc_info:
 	.long	0x41807400
 	.long	0xfffffff0
 	.long	0
 	.long	0
-	b	__arm740_setup
+	initfn	__arm740_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_26BIT
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index bf6ba4bc30ff..c322a416cb9a 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -76,7 +76,7 @@ __arm7tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc, #execinstr
+		.section ".proc.info.init", #alloc
 
 .macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
 	extra_hwcaps=0
@@ -86,7 +86,7 @@ __\name\()_proc_info:
 		.long	\cpu_mask
 		.long	0
 		.long	0
-		b	__arm7tdmi_setup
+		initfn	__arm7tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name
 		.long	HWCAP_SWP | HWCAP_26BIT | ( \extra_hwcaps )
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 22bf8dde4f84..f129bdede5cc 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -448,7 +448,7 @@ arm920_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm920_proc_info,#object
 __arm920_proc_info:
@@ -464,7 +464,7 @@ __arm920_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm920_setup
+	initfn	__arm920_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 0c6d5ac5a6d4..53b5bddb0ee9 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -426,7 +426,7 @@ arm922_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm922_proc_info,#object
 __arm922_proc_info:
@@ -442,7 +442,7 @@ __arm922_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm922_setup
+	initfn	__arm922_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index c32d073282ea..94a88a734210 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -494,7 +494,7 @@ arm925_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 .macro arm925_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
@@ -510,7 +510,7 @@ __\name\()_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm925_setup
+	initfn	__arm925_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 252b2503038d..0fe423de5118 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -474,7 +474,7 @@ arm926_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm926_proc_info,#object
 __arm926_proc_info:
@@ -490,7 +490,7 @@ __arm926_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__arm926_setup
+	initfn	__arm926_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index e5212d489377..7ad2642dfcda 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -354,14 +354,14 @@ __arm940_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__arm940_proc_info,#object
 __arm940_proc_info:
 	.long	0x41009400
 	.long	0xff00fff0
 	.long	0
-	b	__arm940_setup
+	initfn	__arm940_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index b3dd9b2d0b8e..f129dcadb8e8 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -409,14 +409,14 @@ __arm946_setup:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 	.type	__arm946_proc_info,#object
 __arm946_proc_info:
 	.long	0x41009460
 	.long	0xff00fff0
 	.long	0
 	.long	0
-	b	__arm946_setup
+	initfn	__arm946_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 8227322bbb8f..a8828b63a981 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -70,7 +70,7 @@ __arm9tdmi_setup:
 
 		.align
 
-		.section ".proc.info.init", #alloc, #execinstr
+		.section ".proc.info.init", #alloc
 
 .macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 		.type	__\name\()_proc_info, #object
@@ -79,7 +79,7 @@ __\name\()_proc_info:
 		.long	\cpu_mask
 		.long	0
 		.long	0
-		b	__arm9tdmi_setup
+		initfn	__arm9tdmi_setup
 		.long	cpu_arch_name
 		.long	cpu_elf_name
 		.long	HWCAP_SWP | HWCAP_THUMB | HWCAP_26BIT
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index c494886892ba..afb100b96081 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -190,7 +190,7 @@ fa526_cr1_set:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__fa526_proc_info,#object
 __fa526_proc_info:
@@ -206,7 +206,7 @@ __fa526_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__fa526_setup
+	initfn	__fa526_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 03a1b75f2e16..5bd769a2bbbe 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -584,7 +584,7 @@ feroceon_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 .macro feroceon_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache:req
 	.type	__\name\()_proc_info,#object
@@ -601,7 +601,8 @@ __\name\()_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__feroceon_setup
+	initfn	__feroceon_setup
+	.long __feroceon_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 082b9f2f7e90..5bed45aeac40 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -331,3 +331,7 @@ ENTRY(\name\()_tlb_fns)
 	.globl	\x
 	.equ	\x, \y
 .endm
+
+.macro	initfn, initfunc
+	.long	\initfunc - . + PROCINFO_INITFUNC
+.endm
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 53d393455f13..a15a2c150460 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -427,7 +427,7 @@ mohawk_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__88sv331x_proc_info,#object
 __88sv331x_proc_info:
@@ -443,7 +443,7 @@ __88sv331x_proc_info:
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__mohawk_setup
+	initfn	__mohawk_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index 8008a0461cf5..4668067e7a08 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -199,7 +199,7 @@ sa110_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	.type	__sa110_proc_info,#object
 __sa110_proc_info:
@@ -213,7 +213,7 @@ __sa110_proc_info:
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__sa110_setup
+	initfn	__sa110_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT | HWCAP_FAST_MULT
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 89f97ac648a9..4acd3cbaa7fe 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -242,7 +242,7 @@ sa1100_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 .macro sa1100_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
 	.type	__\name\()_proc_info,#object
@@ -257,7 +257,7 @@ __\name\()_proc_info:
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__sa1100_setup
+	initfn	__sa1100_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT | HWCAP_FAST_MULT
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index d0390f4b3f18..5c05a2948dfa 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -264,7 +264,7 @@ v6_crval:
 	string	cpu_elf_name, "v6"
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	/*
 	 * Match any ARMv6 processor core.
@@ -287,7 +287,7 @@ __v6_proc_info:
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__v6_setup
+	initfn	__v6_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	/* See also feat_v6_fixup() for HWCAP_TLS */
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 8b4ee5e81c14..eda1eba132c6 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -462,7 +462,7 @@ __v7_setup_stack:
 	string	cpu_elf_name, "v7"
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	/*
 	 * Standard v7 proc info content
@@ -474,7 +474,7 @@ __v7_setup_stack:
 			PMD_SECT_AF | PMD_FLAGS_UP | \mm_mmuflags)
 	.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | PMD_SECT_AF | \io_mmuflags
-	W(b)	\initfunc
+	initfn	\initfunc
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index d1e68b553d3b..89119d50f57d 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -135,7 +135,7 @@ __v7m_setup_stack_top:
 	string cpu_elf_name "v7m"
 	string cpu_v7m_name "ARMv7-M"
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 	/*
 	 * Match any ARMv7-M processor core.
@@ -146,7 +146,7 @@ __v7m_proc_info:
 	.long	0x000f0000		@ Mask for ID
 	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
 	.long   0			@ proc_info_list.__cpu_io_mmu_flags
-	b	__v7m_setup		@ proc_info_list.__cpu_flush
+	initfn	__v7m_setup		@ proc_info_list.__cpu_flush
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index f8acdfece036..1b0b945126f8 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -499,7 +499,7 @@ xsc3_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 .macro xsc3_proc_info name:req, cpu_val:req, cpu_mask:req
 	.type	__\name\()_proc_info,#object
@@ -514,7 +514,7 @@ __\name\()_proc_info:
 	.long	PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__xsc3_setup
+	initfn	__xsc3_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index afa2b3c4df4a..7805cd098140 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -612,7 +612,7 @@ xscale_crval:
 
 	.align
 
-	.section ".proc.info.init", #alloc, #execinstr
+	.section ".proc.info.init", #alloc
 
 .macro xscale_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
 	.type	__\name\()_proc_info,#object
@@ -627,7 +627,7 @@ __\name\()_proc_info:
 	.long	PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	b	__xscale_setup
+	initfn	__xscale_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-- 
1.8.3.2
