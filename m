From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  1 Aug 2013 11:51:11 -0600
Subject: [PATCH V2] ARM: allow DEBUG_UNCOMPRESS for Tegra
Message-ID: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

DEBUG_UNCOMPRESS was previously disallowed for Tegra due to tegra.S's
use of global data that was not linked into the decompressor. Solve this
by declaring this symbol in tegra.S when it is being built into the
decompressor. For the kernel proper, leave the declaration in
mach-tegra/common.c as explained in the comment.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Don't select DEBUG_UNCOMPRESS with DEBUG_TEGRA_UART unless
    !ZBOOT_ROM. Add notes on ZBOOT_ROM to comment.

Russell, I assume this should go in through the ARM patch tracker. Or,
do you want me to take it through the Tegra tree?

 arch/arm/Kconfig.debug         |  2 +-
 arch/arm/include/debug/tegra.S | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index af5d084..7f92c84 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1052,7 +1052,7 @@ config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || ARCH_MSM
 	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
-		     !DEBUG_TEGRA_UART
+		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
 	  This option influences the normal decompressor output for
 	  multiplatform kernels.  Normally, multiplatform kernels disable
diff --git a/arch/arm/include/debug/tegra.S b/arch/arm/include/debug/tegra.S
index 883d7c2..be6a720 100644
--- a/arch/arm/include/debug/tegra.S
+++ b/arch/arm/include/debug/tegra.S
@@ -221,3 +221,32 @@
 1002:
 #endif
 		.endm
+
+/*
+ * Storage for the state maintained by the macros above.
+ *
+ * In the kernel proper, this data is located in arch/arm/mach-tegra/common.c.
+ * That's because this header is included from multiple files, and we only
+ * want a single copy of the data. In particular, the UART probing code above
+ * assumes it's running using physical addresses. This is true when this file
+ * is included from head.o, but not when included from debug.o. So we need
+ * to share the probe results between the two copies, rather than having
+ * to re-run the probing again later.
+ *
+ * In the decompressor, we put the symbol/storage right here, since common.c
+ * isn't included in the decompressor build. This symbol gets put in .text
+ * even though it's really data, since .data is discarded from the
+ * decompressor. Luckily, .text is writeable in the decompressor, unless
+ * CONFIG_ZBOOT_ROM. That dependency is handled in arch/arm/Kconfig.debug.
+ */
+#if defined(ZIMAGE)
+tegra_uart_config:
+	/* Debug UART initialization required */
+	.word 1
+	/* Debug UART physical address */
+	.word 0
+	/* Debug UART virtual address */
+	.word 0
+	/* Scratch space for debug macro */
+	.word 0
+#endif
-- 
1.8.1.5
