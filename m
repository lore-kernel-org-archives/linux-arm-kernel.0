From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:30 +1100
Subject: [PATCH 05/11] ep93xx: Move arch_reset to core.c
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-6-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the arch_reset function from include/mach/system.h to core.c.
This removes the need for the EP93XX_SYSCON_DEVCFG defines to be
exported in the include/mach headers.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c                |   18 ++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/system.h |   14 +-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 978c5a6..bd59696 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -240,6 +240,24 @@ unsigned int ep93xx_chip_revision(void)
 }
 
 /*************************************************************************
+ * Reset handling for EP93xx
+ *************************************************************************/
+
+void arch_reset(char mode, const char *cmd)
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
+/*************************************************************************
  * EP93xx GPIO
  *************************************************************************/
 static struct resource ep93xx_gpio_resource[] = {
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
index 6d661fe..3d1ec74 100644
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ b/arch/arm/mach-ep93xx/include/mach/system.h
@@ -9,16 +9,4 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
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
-}
+extern void arch_reset(char mode, const char *cmd);
-- 
1.7.0.4
