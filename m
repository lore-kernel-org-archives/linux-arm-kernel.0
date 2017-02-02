From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:12 +0100
Subject: [PATCH 02/13] ARM: at91: pm: move at91_ramc_read/write to pm.c
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those macros are only used in pm.c, move them there so we can remove the
test on __ASSEMBLY__.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c |  6 ++++++
 arch/arm/mach-at91/pm.h | 10 ----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3d28d1957e41..ca141f9873f2 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -45,6 +45,12 @@ static struct {
 } at91_pm_data;
 
 void __iomem *at91_ramc_base[2];
+#define at91_ramc_read(id, field) \
+	__raw_readl(at91_ramc_base[id] + field)
+
+#define at91_ramc_write(id, field, value) \
+	__raw_writel(value, at91_ramc_base[id] + field)
+
 
 static int at91_pm_valid_state(suspend_state_t state)
 {
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3fcf8810f14e..8eed156ef19a 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -17,16 +17,6 @@
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
 
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_ramc_base[];
-
-#define at91_ramc_read(id, field) \
-	__raw_readl(at91_ramc_base[id] + field)
-
-#define at91_ramc_write(id, field, value) \
-	__raw_writel(value, at91_ramc_base[id] + field)
-#endif
-
 #define AT91_MEMCTRL_MC		0
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
-- 
2.11.0
