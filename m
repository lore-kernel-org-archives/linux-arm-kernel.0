From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue,  4 Jun 2013 09:49:11 +0530
Subject: [PATCH v2 2/3] ARM: SAMSUNG: Consolidate uncompress subroutine
In-Reply-To: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1370319552-17694-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For mach-exynos, uart_base is a pointer and the value is calculated
in the machine folder. For other machines, uart_base is defined as
a macro in platform directory. For symmetry, the uart_base macro
definition is removed and the uart_base calculation is moved to
specific machine folders.

This would help us consolidating uncompress subroutine for s5p64x0.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
Changes for v2:
* Remove ifdef's while calculating uart_base value.

 arch/arm/mach-exynos/include/mach/uncompress.h  |    3 ---
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |    3 +++
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |    3 +++
 arch/arm/mach-s5pc100/include/mach/uncompress.h |    2 ++
 arch/arm/mach-s5pv210/include/mach/uncompress.h |    2 ++
 arch/arm/plat-samsung/include/plat/uncompress.h |    6 ++----
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 2979995..d405762 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -15,9 +15,6 @@
 #include <asm/mach-types.h>
 
 #include <mach/map.h>
-
-volatile u8 *uart_base;
-
 #include <plat/uncompress.h>
 
 static unsigned int __raw_readl(unsigned int ptr)
diff --git a/arch/arm/mach-s3c24xx/include/mach/uncompress.h b/arch/arm/mach-s3c24xx/include/mach/uncompress.h
index 8b283f8..7d2ce20 100644
--- a/arch/arm/mach-s3c24xx/include/mach/uncompress.h
+++ b/arch/arm/mach-s3c24xx/include/mach/uncompress.h
@@ -49,6 +49,9 @@ static void arch_detect_cpu(void)
 		fifo_mask = S3C2410_UFSTAT_TXMASK;
 		fifo_max = 15 << S3C2410_UFSTAT_TXSHIFT;
 	}
+
+	uart_base = (volatile u8 *) S3C_PA_UART +
+		(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/uncompress.h b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
index c6a82a2..1c95673 100644
--- a/arch/arm/mach-s3c64xx/include/mach/uncompress.h
+++ b/arch/arm/mach-s3c64xx/include/mach/uncompress.h
@@ -23,6 +23,9 @@ static void arch_detect_cpu(void)
 	/* we do not need to do any cpu detection here at the moment. */
 	fifo_mask = S3C2440_UFSTAT_TXMASK;
 	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
+
+	uart_base = (volatile u8 *)S3C_PA_UART +
+		(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/mach-s5pc100/include/mach/uncompress.h
index 01ccf53..720e133 100644
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pc100/include/mach/uncompress.h
@@ -23,6 +23,8 @@ static void arch_detect_cpu(void)
 	/* we do not need to do any cpu detection here at the moment. */
 	fifo_mask = S3C2440_UFSTAT_TXMASK;
 	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
+
+	uart_base = (volatile u8 *)S5P_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/uncompress.h b/arch/arm/mach-s5pv210/include/mach/uncompress.h
index ef977ea..231cb07 100644
--- a/arch/arm/mach-s5pv210/include/mach/uncompress.h
+++ b/arch/arm/mach-s5pv210/include/mach/uncompress.h
@@ -21,6 +21,8 @@ static void arch_detect_cpu(void)
 	/* we do not need to do any cpu detection here at the moment. */
 	fifo_mask = S5PV210_UFSTAT_TXMASK;
 	fifo_max = 63 << S5PV210_UFSTAT_TXSHIFT;
+
+	uart_base = (volatile u8 *)S5P_PA_UART(CONFIG_S3C_LOWLEVEL_UART_PORT);
 }
 
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 02b66d7..2ace0d5 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -21,6 +21,8 @@ typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
 unsigned int fifo_mask;
 unsigned int fifo_max;
 
+volatile u8 *uart_base;
+
 /* forward declerations */
 
 static void arch_detect_cpu(void);
@@ -37,10 +39,6 @@ static void arch_detect_cpu(void);
 /* how many bytes we allow into the FIFO@a time in FIFO mode */
 #define FIFO_MAX	 (14)
 
-#ifdef S3C_PA_UART
-#define uart_base S3C_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT)
-#endif
-
 static __inline__ void
 uart_wr(unsigned int reg, unsigned int val)
 {
-- 
1.7.9.5
