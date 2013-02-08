From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:32 +0000
Subject: [PATCH 02/17] ARM: set BE8 if LE in head code
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are booting in LE and compiled for BE8, then change the processor
state in the head code. Since the instruction stream is always LE, we
do not need to do anything special.

Also ensure that the secondary processors are started in the same mode.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/head.S |    3 +++
 arch/arm/kernel/head.S          |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..39940a7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -134,6 +134,9 @@ start:
 		.word	_edata			@ zImage end address
  THUMB(		.thumb			)
 1:
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+		setend	be			@ go BE-8 if we booted LE / no-op if already BE-8
+#endif
 		mrs	r9, cpsr
 #ifdef CONFIG_ARM_VIRT_EXT
 		bl	__hyp_stub_install	@ get into SVC mode, reversibly
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 486a15a..f1ab279 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -333,6 +333,9 @@ ENTRY(secondary_startup)
 	 * the processor type - there is no need to check the machine type
 	 * as it has already been validated by the primary processor.
 	 */
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+	setend	be				@ if system starts LE, go to BE-8
+#endif
 #ifdef CONFIG_ARM_VIRT_EXT
 	bl	__hyp_stub_install_secondary
 #endif
-- 
1.7.10.4
