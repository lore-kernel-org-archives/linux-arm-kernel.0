From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Jun 2018 21:26:32 +0200
Subject: [PATCH 1/2] ARM: avoid badr macro for switching to Thumb-2 mode
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
Message-ID: <20180619192633.21846-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switching to Thumb-2 mode can be done using a single 'sub' instruction
so use that instead of the badr macro in various places in the code.
This allows us to reimplement the macro in a way that does not allow
it to be used in ARM code sequences when building a Thumb2 kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/common/mcpm_head.S  |  5 ++---
 arch/arm/kernel/head-nommu.S |  7 +++----
 arch/arm/kernel/head.S       | 15 +++++++--------
 arch/arm/kernel/sleep.S      |  7 +++----
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 08b3bb9bc6a2..4c72314e87a3 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -49,10 +49,9 @@
 ENTRY(mcpm_entry_point)
 
  ARM_BE8(setend        be)
- THUMB(	badr	r12, 1f		)
- THUMB(	bx	r12		)
+ THUMB(	sub	pc, pc, #3	)
  THUMB(	.thumb			)
-1:
+
 	mrc	p15, 0, r0, c0, c0, 5		@ MPIDR
 	ubfx	r9, r0, #0, #8			@ r9 = cpu
 	ubfx	r10, r0, #8, #8			@ r10 = cluster
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index dae8fa2f72c5..406dab0b773c 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -47,10 +47,9 @@ ENTRY(stext)
 	.arm
 ENTRY(stext)
 
- THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is always entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 #endif
 
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4b815821ec02..1e44ee9b2074 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -80,10 +80,9 @@
 ENTRY(stext)
  ARM_BE8(setend	be )			@ ensure we are in BE8 mode
 
- THUMB(	badr	r9, 1f		)	@ Kernel is always entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is always entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install
@@ -363,10 +362,10 @@ __turn_mmu_on_loc:
 	.text
 	.arm
 ENTRY(secondary_startup_arm)
- THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
+
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a8257fc9cf2a..76b3d7c1c8d0 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -123,10 +123,9 @@ ENDPROC(cpu_resume_after_mmu)
 #ifdef CONFIG_MMU
 	.arm
 ENTRY(cpu_resume_arm)
- THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
- THUMB(	.thumb			)	@ switch to Thumb now.
- THUMB(1:			)
+ THUMB(	sub	pc, pc, #3	)	@ Kernel is entered in ARM.
+ THUMB(	.thumb			)	@ If this is a Thumb-2 kernel,
+					@ switch to Thumb now.
 #endif
 
 ENTRY(cpu_resume)
-- 
2.17.1
