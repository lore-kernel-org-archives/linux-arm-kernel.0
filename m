From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 May 2014 10:50:39 +0100
Subject: [PATCH 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 Image header contains a text_offset field which bootloaders
are supposed to read to determine the offset (from a 2MB aligned "start
of memory" per booting.txt) at which to load the kernel. The offset is
not well respected by bootloaders at present, and due to the lack of
variation there is little incentive to support it. This is unfortunate
for the sake of future kernels where we may wish to vary the text offset
(even zeroing it).

This patch adds options to arm64 to enable fuzz-testing of text_offset.
CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET forces the text offset to a random
value upon a build of the kernel, and CONFIG_ARM64_TEXT_OFFSET can be
used to set the text offset to a specific value (between 16B and 2MB).
It is recommended that distribution kernels enable randomization to test
bootloaders such that any compliance issues can be fixed early.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig.debug        | 31 +++++++++++++++++++++++++++++++
 arch/arm64/Makefile             |  6 +++++-
 arch/arm64/kernel/head.S        |  8 ++++++--
 arch/arm64/kernel/vmlinux.lds.S |  5 +++++
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d10ec33..471ef0d 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -37,4 +37,35 @@ config PID_IN_CONTEXTIDR
 	  instructions during context switch. Say Y here only if you are
 	  planning to use hardware trace tools with this kernel.
 
+config ARM64_RANDOMIZE_TEXT_OFFSET
+	bool "Randomize TEXT_OFFSET at build time (EXPERIMENTAL)"
+	default N
+	help
+	  Say Y here if you want the image load offset (AKA TEXT_OFFSET)
+	  of the kernel to be randomized at build-time. When selected,
+	  this option will cause TEXT_OFFSET to be randomized upon any
+	  build of the kernel, and the offset will be reflected in the
+	  text_offset field of the resulting Image. This can be used to
+	  fuzz-test bootloaders which respect text_offset.
+
+	  This option is intended for bootloader and/or kernel testing
+	  only. Bootloaders must make no assumptions regarding the value
+	  of TEXT_OFFSET and platforms must not require a specific
+	  value.
+
+config ARM64_TEXT_OFFSET
+	hex "Required image load offset"
+	depends on !ARM64_RANDOMIZE_TEXT_OFFSET
+	default "0x0000000000080000"
+	help
+	  The image load offset (AKA TEXT_OFFSET) of the kernel. The
+	  load offset will be reflected in the text_offset field of the
+	  Image. TEXT_OFFSET must be a 16-byte aligned value less than
+	  2MB.
+
+	  This option is intended for bootloader and/or kernel testing
+	  only. Bootloaders must make no assumptions regarding the value
+	  of TEXT_OFFSET and platforms must not require a specific
+	  value.
+
 endmenu
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..a4962d5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -38,7 +38,11 @@ CHECKFLAGS	+= -D__aarch64__
 head-y		:= arch/arm64/kernel/head.o
 
 # The byte offset of the kernel image in RAM from the start of RAM.
-TEXT_OFFSET := 0x00080000
+ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
+TEXT_OFFSET := $(shell awk 'BEGIN {srand(); printf "0x%05x\n", and(int(0xfffff * rand()), 0xffff0)}')
+else
+TEXT_OFFSET := $(CONFIG_ARM64_TEXT_OFFSET)
+endif
 
 export	TEXT_OFFSET GZFLAGS
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 542ca97..1a731bc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -37,8 +37,12 @@
 
 #define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
 
-#if (KERNEL_RAM_VADDR & 0xfffff) != 0x80000
-#error KERNEL_RAM_VADDR must start at 0xXXX80000
+#if (TEXT_OFFSET & 0xf) != 0
+#error TEXT_OFFSET must be at least 16B aligned
+#elif (PAGE_OFFSET & 0xfffff) != 0
+#error PAGE_OFFSET must be at least 2MB aligned
+#elif TEXT_OFFSET > 0xfffff
+#error TEXT_OFFSET must be less than 2MB
 #endif
 
 	.macro	pgtbl, ttb0, ttb1, virt_to_phys
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 21a8ad1..05fc047 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -149,3 +149,8 @@ SECTIONS
  */
 ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) > __hyp_idmap_text_end),
        "HYP init code too big")
+
+/*
+ * If padding is applied before .head.text, virt<->phys conversions will fail.
+ */
+ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
-- 
1.9.1
