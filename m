From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 26 Jan 2014 21:30:48 +0100
Subject: [PATCH] arm64: add workaround for ambiguous C99 stdint.h types
Message-ID: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
for ambiguous C99 stdint.h types"), this patch redefines the macros that
are used in stdint.h so its definitions of uint64_t and int64_t are
compatible with those of the kernel.

In order to do so, drop types.h from generic-y and create a specific arm64
version identical to the generic one with just the #define overrides added.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/Kbuild  |  1 -
 arch/arm64/include/asm/types.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/types.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index d0ff25de67ca..93e0653e8c65 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -44,7 +44,6 @@ generic-y += termbits.h
 generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/arm64/include/asm/types.h b/arch/arm64/include/asm/types.h
new file mode 100644
index 000000000000..6519296da003
--- /dev/null
+++ b/arch/arm64/include/asm/types.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_TYPES_H
+#define __ASM_TYPES_H
+
+#include <asm-generic/int-ll64.h>
+
+/*
+ * For Aarch64, there is some ambiguity in the definition of the types below
+ * between the kernel and GCC itself. This is usually not a big deal, but it
+ * causes trouble when including GCC's version of 'stdint.h' (this is the file
+ * that gets included when you #include <stdint.h> on a -ffreestanding build).
+ * As this file also gets included implicitly when including 'arm_neon.h' (the
+ * NEON intrinsics support header), we need the following to work around the
+ * issue if we want to use NEON intrinsics in the kernel.
+ */
+
+#ifdef __INT64_TYPE__
+#undef __INT64_TYPE__
+#define __INT64_TYPE__		__signed__ long long
+#endif
+
+#ifdef __UINT64_TYPE__
+#undef __UINT64_TYPE__
+#define __UINT64_TYPE__		unsigned long long
+#endif
+
+#endif /* __ASM_TYPES_H */
-- 
1.8.3.2
