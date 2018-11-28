From: liuyun01@kylinos.cn (Jackie Liu)
Date: Wed, 28 Nov 2018 09:09:00 +0800
Subject: [PATCH v5 1/2] arm64/neon: add workaround for ambiguous C99 stdint.h
 types
Message-ID: <20181128010901.1052-1-liuyun01@kylinos.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
for ambiguous C99 stdint.h types"), this patch redefines the macros that
are used in stdint.h so its definitions of uint64_t and int64_t are
compatible with those of the kernel.

This patch comes from: https://patchwork.kernel.org/patch/3540001/
Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

We mark this file as a private file and don't have to override asm/types.h

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 arch/arm64/include/asm/neon-intrinsics.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
new file mode 100644
index 0000000..e378766
--- /dev/null
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -0,0 +1,34 @@
+#ifndef _NEON_INTRINSICS_H
+#define _NEON_INTRINSICS_H
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
+/*
+ * genksyms chokes on the ARM NEON instrinsics system header, but we
+ * don't export anything it defines anyway, so just disregard when genksyms execute.
+ */
+#ifndef __GENKSYMS__
+#include <arm_neon.h>
+#endif
+
+#endif /* ! _NEON_INTRINSICS_H */
-- 
2.7.4
