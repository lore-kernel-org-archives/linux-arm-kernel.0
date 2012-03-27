From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Mar 2012 14:56:02 +0530
Subject: [PATCH 1/4] ARM: Exynos: Use CHIP_ID to detect cpu type during
 decompression setup
In-Reply-To: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332840365-24827-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config option MACH_SMDK5250 is not available for Exynos5 since only
a device tree based machine is supported and selected by MACH_EXYNOS5_DT.
Hence, the detection of the cpu type based on machine_is_smdk5250 always
fails and boot hangs due to incorrect uart base being used. Fix this by
reading the chip id to determine the cpu type and setup the uart_base
accordingly.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/include/mach/uncompress.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 493f4f3..603ea9b 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -14,15 +14,19 @@
 
 #include <asm/mach-types.h>
 
+#include <plat/cpu.h>
 #include <mach/map.h>
 
 volatile u8 *uart_base;
 
 #include <plat/uncompress.h>
 
+#define __raw_readl(addr)		\
+	(*((volatile unsigned int __force *)(addr)))
+
 static void arch_detect_cpu(void)
 {
-	if (machine_is_smdk5250())
+	if ((__raw_readl(EXYNOS_PA_CHIPID) & EXYNOS5_SOC_MASK) == EXYNOS5250_SOC_ID)
 		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 	else
 		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-- 
1.6.6.rc2
