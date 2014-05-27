From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 May 2014 14:18:29 +0100
Subject: [PATCHv2 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1401196710-6290-1-git-send-email-mark.rutland@arm.com>
References: <1401196710-6290-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1401196710-6290-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the kernel Image is stripped of everything past the initial
stack, and at runtime the memory is initialised and used by the kernel.
This makes the effective minimum memory footprint of the kernel larger
than the size of the loaded binary, though bootloaders have no mechanism
to identify how large this minimum memory footprint is. This makes it
difficult to choose safe locations to place both the kernel and other
binaries required at boot (DTB, initrd, etc), such that the kernel won't
clobber said binaries or other reserved memory during initialisation.

Additionally when big endian support was added the image load offset was
overlooked, and is currently of an arbitrary endianness, which makes it
difficult for bootloaders to make use of it. It seems that bootloaders
aren't respecting the image load offset at present anyway, and are
assuming that offset 0x80000 will always be correct.

This patch adds an effective image size to the kernel header which
describes the amount of memory from the start of the kernel Image binary
which the kernel expects to use before detecting memory and handling any
memory reservations. This can be used by bootloaders to choose suitable
locations to load the kernel and/or other binaries such that the kernel
will not clobber any memory unexpectedly. As before, memory reservations
are required to prevent the kernel from clobbering these locations
later.

Both the image load offset and the effective image size are forced to be
little-endian regardless of the native endianness of the kernel to
enable bootloaders to load a kernel of arbitrary endianness. Bootloaders
which wish to make use of the load offset can inspect the effective
image size field for a non-zero value to determine if the offset is of a
known endianness.

The documentation is updated to clarify these details. To discourage
future assumptions regarding the value of text_offset, the value at this
point in time is removed from the main flow of the documentation (though
kept as a compatibility note).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Tom Rini <trini@ti.com>
---
 Documentation/arm64/booting.txt | 29 ++++++++++++++++++++++++-----
 arch/arm64/kernel/head.S        |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S | 28 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 37fc4f6..a446843 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -72,8 +72,8 @@ The decompressed kernel image contains a 64-byte header as follows:
 
   u32 code0;			/* Executable code */
   u32 code1;			/* Executable code */
-  u64 text_offset;		/* Image load offset */
-  u64 res0	= 0;		/* reserved */
+  u64 text_offset;		/* Image load offset, little endian */
+  u64 image_size;		/* Effective Image size, little endian */
   u64 res1	= 0;		/* reserved */
   u64 res2	= 0;		/* reserved */
   u64 res3	= 0;		/* reserved */
@@ -90,9 +90,28 @@ Header notes:
   entry point (efi_stub_entry). When the stub has done its work, it
   jumps to code0 to resume the normal boot process.
 
-The image must be placed at the specified offset (currently 0x80000)
-from the start of the system RAM and called there. The start of the
-system RAM must be aligned to 2MB.
+- Older kernel versions did not define the endianness of text_offset.
+  In these cases image_size is zero and text_offset is 0x80000 in the
+  endianness of the kernel. Where image_size is non-zero image_size is
+  little-endian and must be respected. Where image_size is zero,
+  text_offset can be assumed to be 0x80000.
+
+- When image_size is zero, a bootloader should attempt to keep as much
+  memory as possible free for use by the kernel immediately after the
+  end of the kernel image. The amount of space required will vary
+  depending on selected features, and is effectively unbound.
+
+The Image must be placed text_offset bytes from a 2MB aligned base
+address near the start of usable system RAM and called there. Memory
+below that base address is currently unusable by Linux, and therefore it
+is strongly recommended that this location is the start of system RAM.
+At least image_size bytes from the start of the image must be free for
+use by the kernel.
+
+Any memory described to the kernel (even that below the 2MB aligned base
+address) which is not marked as reserved from the kernel e.g. with a
+memreserve region in the device tree) will be considered as available to
+the kernel.
 
 Before jumping into the kernel, the following conditions must be met:
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 36ecee2..2c13d3b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -108,8 +108,8 @@ efi_head:
 	b	stext				// branch to kernel start, magic
 	.long	0				// reserved
 #endif
-	.quad	TEXT_OFFSET			// Image load offset from start of RAM
-	.quad	0				// reserved
+	.quad	_kernel_offset_le		// Image load offset from start of RAM, little-endian
+	.quad	_kernel_size_le			// Effective size of kernel image, little-endian
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 51258bc..21a8ad1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -30,6 +30,25 @@ jiffies = jiffies_64;
 	*(.hyp.text)					\
 	VMLINUX_SYMBOL(__hyp_text_end) = .;
 
+/*
+ * There aren't any ELF relocations we can use to endian-swap values known only
+ * at link time (e.g. the subtraction of two symbol addresses), so we must get
+ * the linker to endian-swap certain values before emitting them.
+ */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define DATA_LE64(data)					\
+	((((data) & 0x00000000000000ff) << 56) |	\
+	 (((data) & 0x000000000000ff00) << 40) |	\
+	 (((data) & 0x0000000000ff0000) << 24) |	\
+	 (((data) & 0x00000000ff000000) << 8)  |	\
+	 (((data) & 0x000000ff00000000) >> 8)  |	\
+	 (((data) & 0x0000ff0000000000) >> 24) |	\
+	 (((data) & 0x00ff000000000000) >> 40) |	\
+	 (((data) & 0xff00000000000000) >> 56))
+#else
+#define DATA_LE64(data) ((data) & 0xffffffffffffffff)
+#endif
+
 SECTIONS
 {
 	/*
@@ -114,6 +133,15 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+
+	/*
+	 * These will output as part of the Image header, which should be
+	 * little-endian regardless of the endianness of the kernel. While
+	 * constant values could be endian swapped in head.S, all are done here
+	 * for consistency.
+	 */
+	_kernel_size_le = DATA_LE64(_end - _text);
+	_kernel_offset_le = DATA_LE64(TEXT_OFFSET);
 }
 
 /*
-- 
1.9.1
