From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:42 +0100
Subject: [PATCH 14/51] ARM: mach-iop13xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-15-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-iop13xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-iop13xx/include/mach/system.h |    9 ---------
 arch/arm/mach-iop13xx/setup.c               |   14 ++++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
index d0c66ef..6b9bba7 100644
--- a/arch/arm/mach-iop13xx/include/mach/system.h
+++ b/arch/arm/mach-iop13xx/include/mach/system.h
@@ -15,13 +15,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Reset the internal bus (warning both cores are reset)
-	 */
-	write_wdtcr(IOP_WDTCR_EN_ARM);
-	write_wdtcr(IOP_WDTCR_EN);
-	write_wdtsr(IOP13XX_WDTSR_WRITE_EN | IOP13XX_WDTCR_IB_RESET);
-	write_wdtcr(0x1000);
-
-	for(;;);
 }
diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index a5b9897..58388da 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -367,6 +367,19 @@ void __init iop13xx_map_io(void)
 	iotable_init(iop13xx_std_desc, ARRAY_SIZE(iop13xx_std_desc));
 }
 
+static void iop13xx_arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * Reset the internal bus (warning both cores are reset)
+	 */
+	write_wdtcr(IOP_WDTCR_EN_ARM);
+	write_wdtcr(IOP_WDTCR_EN);
+	write_wdtsr(IOP13XX_WDTSR_WRITE_EN | IOP13XX_WDTCR_IB_RESET);
+	write_wdtcr(0x1000);
+
+	for(;;);
+}
+
 static int init_uart;
 static int init_i2c;
 static int init_adma;
@@ -517,6 +530,7 @@ void __init iop13xx_platform_init(void)
 #endif
 
 	platform_add_devices(iop13xx_devices, plat_idx);
+	arm_arch_reset = iop13xx_arch_reset;
 }
 
 static int __init iop13xx_init_uart_setup(char *str)
-- 
1.7.4.1
