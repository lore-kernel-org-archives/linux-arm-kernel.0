From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:37 +0100
Subject: [PATCH 09/51] ARM: mach-ep93xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ep93xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ep93xx/core.c                |   22 ++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/system.h |   10 ----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c60f081..5841c1d 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -904,3 +904,25 @@ void __init ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_ohci_device);
 	platform_device_register(&ep93xx_leds);
 }
+
+static void ep93xx_arch_reset(char mode, const char *cmd)
+{
+	local_irq_disable();
+
+	/*
+	 * Set then clear the SWRST bit to initiate a software reset
+	 */
+	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
+
+	while (1)
+		;
+}
+
+static int __init ep93xx_arch_reset_init(void)
+{
+	arm_arch_reset = ep93xx_arch_reset;
+	return 0;
+}
+
+arch_initcall(ep93xx_arch_reset_init);
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index 6d661fe..ce48083 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -11,14 +11,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
-	/*
-	 * Set then clear the SWRST bit to initiate a software reset
-	 */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_SWRST);
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_SWRST);
-
-	while (1)
-		;
 }
-- 
1.7.4.1
