From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:15 +0000
Subject: [PATCH 1/9] arm64: Fix efi kernel entry
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <873e73a998c198de69f6f01f92176be2b613c500.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent addition of EFI support has changed the way the arm64 kernel
image is entered based on whether or not CONFIG_EFI is defined.  To support
this conditional entry point add a new global symbol start to head.S that
marks the entry, and change the the linker script ENTRY() command to define
start as the kernel entry.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/head.S        | 4 ++++
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 144f105..4019b85 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -100,6 +100,8 @@
  */
 	__HEAD
 
+.globl start
+
 	/*
 	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
 	 */
@@ -110,8 +112,10 @@ efi_head:
 	 * its opcode forms the magic "MZ" signature required by UEFI.
 	 */
 	add	x13, x18, #0x16
+start:
 	b	stext
 #else
+start:
 	b	stext				// branch to kernel start, magic
 	.long	0				// reserved
 #endif
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 97f0c04..fbb1af7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -15,7 +15,7 @@
 #define ARM_EXIT_DISCARD(x)	x
 
 OUTPUT_ARCH(aarch64)
-ENTRY(_text)
+ENTRY(start)
 
 jiffies = jiffies_64;
 
-- 
1.9.1
