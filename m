From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 13:36:40 +0100
Subject: [PATCH 04/10] ARM: set BE8 if LE in head code
In-Reply-To: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1371645406-16873-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are booting in LE and compiled for BE8, then add code to
set the state to bE8. Since the instruction stream is always LE,
we do not need to do anything special to the instruction.

Also ensure that the secondary processors are started in the same mode.

Note, we do add about 20 bytes to the kernel image, but it seems easier
to do this than adding another configuration to change.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/head.S |    1 +
 arch/arm/kernel/head.S          |    4 ++++
 arch/arm/kernel/sleep.S         |    1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4eb8364..4d83bfd 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -135,6 +135,7 @@ start:
 		.word	_edata			@ zImage end address
  THUMB(		.thumb			)
 1:
+ ARM_BE8(	setend	be )			@ go BE8 if LE, no-op if BE8
 		mrs	r9, cpsr
 #ifdef CONFIG_ARM_VIRT_EXT
 		bl	__hyp_stub_install	@ get into SVC mode, reversibly
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 56ddd47..da09dc0 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -77,6 +77,7 @@
 
 	__HEAD
 ENTRY(stext)
+ ARM_BE8(setend	be )			@ ensure we are in BE8 mode
 
  THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
  THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
@@ -351,6 +352,9 @@ ENTRY(secondary_startup)
 	 * the processor type - there is no need to check the machine type
 	 * as it has already been validated by the primary processor.
 	 */
+
+ ARM_BE8(setend	be)				@ if system starts LE, go BE8
+
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install_secondary
 #endif
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 987dcf3..954c28a 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -81,6 +81,7 @@ ENDPROC(cpu_resume_after_mmu)
 	.data
 	.align
 ENTRY(cpu_resume)
+ARM_BE8(setend be)			@ ensure we are in BE mode
 #ifdef CONFIG_SMP
 	adr	r0, sleep_save_sp
 	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
-- 
1.7.10.4
