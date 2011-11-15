From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Tue, 15 Nov 2011 10:06:22 +0800
Subject: [PATCH 3/6] ARM: early_printk: pl01x: fix big endian support
In-Reply-To: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1321322785-2981-3-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The waituart and busyuart need to get one bit flag from UART flag
register. For this, we don't need do endian conversion for the entire
flag register, providing that flag definition in big-endian mode is
enough.

Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/include/asm/assembler.h            |    6 ++++++
 arch/arm/include/asm/hardware/debug-pl01x.S |   12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 3ddee22..2c7e8fa 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -329,4 +329,10 @@
 	.endm
 #endif
 
+#define asm_constant_swab32(x) \
+	((((x) & 0xff000000) >> 24) | \
+	(((x) & 0x00ff0000) >> 8) | \
+	(((x) & 0x0000ff00) << 8) | \
+	(((x) & 0x000000ff) << 24))
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/include/asm/hardware/debug-pl01x.S b/arch/arm/include/asm/hardware/debug-pl01x.S
index f9fd083..25fa0ec 100644
--- a/arch/arm/include/asm/hardware/debug-pl01x.S
+++ b/arch/arm/include/asm/hardware/debug-pl01x.S
@@ -11,19 +11,27 @@
  *
 */
 #include <linux/amba/serial.h>
+#include <asm/assembler.h>
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define _UART01x_FR_TXFF asm_constant_swab32(UART01x_FR_TXFF)
+#define _UART01x_FR_BUSY asm_constant_swab32(UART01x_FR_BUSY)
+#else
+#define _UART01x_FR_TXFF UART01x_FR_TXFF
+#define _UART01x_FR_BUSY UART01x_FR_BUSY
+#endif
 		.macro	senduart,rd,rx
 		strb	\rd, [\rx, #UART01x_DR]
 		.endm
 
 		.macro	waituart,rd,rx
 1001:		ldr	\rd, [\rx, #UART01x_FR]
-		tst	\rd, #UART01x_FR_TXFF
+		tst	\rd, #_UART01x_FR_TXFF
 		bne	1001b
 		.endm
 
 		.macro	busyuart,rd,rx
 1001:		ldr	\rd, [\rx, #UART01x_FR]
-		tst	\rd, #UART01x_FR_BUSY
+		tst	\rd, #_UART01x_FR_BUSY
 		bne	1001b
 		.endm
-- 
1.7.0.4
