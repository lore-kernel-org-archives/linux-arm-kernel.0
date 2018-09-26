From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Wed, 26 Sep 2018 14:11:59 +0200
Subject: [PATCH v2 1/7] arm64: move arm uprobes code to be reused by arm64
In-Reply-To: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce@eucas1p2.samsung.com>
Message-ID: <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move ARM32 uprobes code from arch/arm/probes/ to a more common location -
lib/probes/arm/. This code will be used by ARM64 code when uprobing 32-bit
applications.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm/probes/Makefile                                  | 8 ++++----
 arch/arm/probes/kprobes/actions-arm.c                     | 2 +-
 arch/arm/probes/kprobes/checkers-arm.c                    | 4 ++--
 arch/arm/probes/kprobes/checkers-common.c                 | 4 ++--
 arch/arm/probes/kprobes/checkers-thumb.c                  | 2 +-
 arch/arm/probes/kprobes/checkers.h                        | 2 +-
 arch/arm/probes/kprobes/core.c                            | 2 +-
 arch/arm/probes/kprobes/core.h                            | 2 +-
 arch/arm/probes/kprobes/test-core.c                       | 2 +-
 arch/arm/probes/uprobes/Makefile                          | 2 +-
 arch/arm/probes/uprobes/core.c                            | 4 ++--
 lib/Makefile                                              | 2 ++
 lib/probes/Makefile                                       | 1 +
 lib/probes/arm/Makefile                                   | 6 ++++++
 {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c | 4 ++--
 {arch/arm/probes => lib/probes/arm}/decode-arm.c          | 0
 {arch/arm/probes => lib/probes/arm}/decode-arm.h          | 0
 {arch/arm/probes => lib/probes/arm}/decode.c              | 0
 {arch/arm/probes => lib/probes/arm}/decode.h              | 0
 19 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (99%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (100%)

diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
index 8b0ea5a..9e22de6 100644
--- a/arch/arm/probes/Makefile
+++ b/arch/arm/probes/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o uprobes/
-obj-$(CONFIG_KPROBES)		+= decode.o kprobes/
+subdir-ccflags-y := -I$(srctree)/lib/probes/arm/
+
+obj-$(CONFIG_UPROBES)		+= uprobes/
+obj-$(CONFIG_KPROBES)		+= kprobes/
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)		+= decode-thumb.o
-else
-obj-$(CONFIG_KPROBES)		+= decode-arm.o
 endif
diff --git a/arch/arm/probes/kprobes/actions-arm.c b/arch/arm/probes/kprobes/actions-arm.c
index b9056d6..fb1179e 100644
--- a/arch/arm/probes/kprobes/actions-arm.c
+++ b/arch/arm/probes/kprobes/actions-arm.c
@@ -62,7 +62,7 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "core.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers-arm.c b/arch/arm/probes/kprobes/checkers-arm.c
index 7b98173..29520a2 100644
--- a/arch/arm/probes/kprobes/checkers-arm.c
+++ b/arch/arm/probes/kprobes/checkers-arm.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 static enum probes_insn __kprobes arm_check_stack(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 971119c..afc3a38 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 enum probes_insn checker_stack_use_none(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-thumb.c b/arch/arm/probes/kprobes/checkers-thumb.c
index d608e3b..847f1ee 100644
--- a/arch/arm/probes/kprobes/checkers-thumb.c
+++ b/arch/arm/probes/kprobes/checkers-thumb.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
+#include "decode.h"
 #include "../decode-thumb.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers.h b/arch/arm/probes/kprobes/checkers.h
index cf6c9e7..9bbab0d 100644
--- a/arch/arm/probes/kprobes/checkers.h
+++ b/arch/arm/probes/kprobes/checkers.h
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include "../decode.h"
+#include "decode.h"
 
 extern probes_check_t checker_stack_use_none;
 extern probes_check_t checker_stack_use_unknown;
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index f8bd523..de5e854 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -34,7 +34,7 @@
 #include <asm/patch.h>
 #include <asm/sections.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "../decode-thumb.h"
 #include "core.h"
 
diff --git a/arch/arm/probes/kprobes/core.h b/arch/arm/probes/kprobes/core.h
index ec5d1f2..4da60f0 100644
--- a/arch/arm/probes/kprobes/core.h
+++ b/arch/arm/probes/kprobes/core.h
@@ -20,7 +20,7 @@
 #define _ARM_KERNEL_KPROBES_H
 
 #include <asm/kprobes.h>
-#include "../decode.h"
+#include "decode.h"
 
 /*
  * These undefined instructions must be unique and
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index cc237fa..c19df9f 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -212,7 +212,7 @@
 
 #include "core.h"
 #include "test-core.h"
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "../decode-thumb.h"
 
 
diff --git a/arch/arm/probes/uprobes/Makefile b/arch/arm/probes/uprobes/Makefile
index e1dc3d0..0d05ba9 100644
--- a/arch/arm/probes/uprobes/Makefile
+++ b/arch/arm/probes/uprobes/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_UPROBES)		+= core.o actions-arm.o
+obj-$(CONFIG_UPROBES)		+= core.o
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index bf99226..90d0954 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -17,8 +17,8 @@
 #include <asm/opcodes.h>
 #include <asm/traps.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 #define UPROBE_TRAP_NR	UINT_MAX
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7eb..cf2c5d6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -129,6 +129,8 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd/
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd/
 obj-$(CONFIG_XZ_DEC) += xz/
 obj-$(CONFIG_RAID6_PQ) += raid6/
+obj-$(CONFIG_UPROBES) += probes/
+obj-$(CONFIG_KPROBES) += probes/
 
 lib-$(CONFIG_DECOMPRESS_GZIP) += decompress_inflate.o
 lib-$(CONFIG_DECOMPRESS_BZIP2) += decompress_bunzip2.o
diff --git a/lib/probes/Makefile b/lib/probes/Makefile
new file mode 100644
index 0000000..534a2b7
--- /dev/null
+++ b/lib/probes/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM)		+= arm/
diff --git a/lib/probes/arm/Makefile b/lib/probes/arm/Makefile
new file mode 100644
index 0000000..1c97b8f
--- /dev/null
+++ b/lib/probes/arm/Makefile
@@ -0,0 +1,6 @@
+ccflags-y += -I$(srctree)/arch/arm/probes/uprobes/
+obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o actions-arm.o
+obj-$(CONFIG_KPROBES)		+= decode.o
+ifndef CONFIG_THUMB2_KERNEL
+obj-$(CONFIG_KPROBES)		+= decode-arm.o
+endif
diff --git a/arch/arm/probes/uprobes/actions-arm.c b/lib/probes/arm/actions-arm.c
similarity index 99%
rename from arch/arm/probes/uprobes/actions-arm.c
rename to lib/probes/arm/actions-arm.c
index 76eb449..a25795a 100644
--- a/arch/arm/probes/uprobes/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -13,8 +13,8 @@
 #include <linux/uprobes.h>
 #include <linux/module.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
diff --git a/arch/arm/probes/decode-arm.c b/lib/probes/arm/decode-arm.c
similarity index 100%
rename from arch/arm/probes/decode-arm.c
rename to lib/probes/arm/decode-arm.c
diff --git a/arch/arm/probes/decode-arm.h b/lib/probes/arm/decode-arm.h
similarity index 100%
rename from arch/arm/probes/decode-arm.h
rename to lib/probes/arm/decode-arm.h
diff --git a/arch/arm/probes/decode.c b/lib/probes/arm/decode.c
similarity index 100%
rename from arch/arm/probes/decode.c
rename to lib/probes/arm/decode.c
diff --git a/arch/arm/probes/decode.h b/lib/probes/arm/decode.h
similarity index 100%
rename from arch/arm/probes/decode.h
rename to lib/probes/arm/decode.h
-- 
2.7.4
