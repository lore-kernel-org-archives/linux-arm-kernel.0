From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Mar 2014 14:39:51 +0100
Subject: [PATCH] arm64: add appropriate asm/unaligned.h
Message-ID: <1395927591-20938-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic asm/unaligned.h does not allow unaligned accesses, resulting in all
invocations of get_unaligned_xxx() and put_unaligned_xxx() to be expanded into
byte size accesses. On arm64, this is unnecessary, so provide a more permissive
asm/unaligned.h instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/arm64/include/asm/unaligned.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/unaligned.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 43a2c9d2d6f4..f88986a0c1dd 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -46,7 +46,6 @@ generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += types.h
-generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
 generic-y += xor.h
diff --git a/arch/arm64/include/asm/unaligned.h b/arch/arm64/include/asm/unaligned.h
new file mode 100644
index 000000000000..00c4a4e02fd1
--- /dev/null
+++ b/arch/arm64/include/asm/unaligned.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_UNALIGNED_H
+#define __ASM_UNALIGNED_H
+
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#if defined(__LITTLE_ENDIAN)
+#define get_unaligned		__get_unaligned_le
+#define put_unaligned		__put_unaligned_le
+#elif defined(__BIG_ENDIAN)
+#define get_unaligned		__get_unaligned_be
+#define put_unaligned		__put_unaligned_be
+#else
+#error need to define endianess
+#endif
+
+#endif /* __ASM_UNALIGNED_H */
-- 
1.8.3.2
