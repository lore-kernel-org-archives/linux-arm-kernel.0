From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Jun 2017 17:06:28 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Use define from dt-bindings for pin mux
 function
In-Reply-To: <20170615150628.26723-1-krzk@kernel.org>
References: <20170615150628.26723-1-krzk@kernel.org>
Message-ID: <20170615150628.26723-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have macros for values used by driver and Device Tree
sources for Pin mux configuration.  Use them instead of duplicating
defines.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 6 ++++--
 drivers/pinctrl/samsung/pinctrl-exynos.h  | 1 -
 drivers/pinctrl/samsung/pinctrl-samsung.c | 4 +++-
 drivers/pinctrl/samsung/pinctrl-samsung.h | 4 ----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index d95a746f45d7..bdc4e0310060 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -31,6 +31,8 @@
 #include <linux/err.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
 
@@ -176,7 +178,7 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
 
 	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
-	con |= EXYNOS_EINT_FUNC << shift;
+	con |= EXYNOS_PIN_FUNC_EINT << shift;
 	writel(con, bank->pctl_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
@@ -208,7 +210,7 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
 
 	con = readl(bank->pctl_base + reg_con);
 	con &= ~(mask << shift);
-	con |= FUNC_INPUT << shift;
+	con |= EXYNOS_PIN_FUNC_INPUT << shift;
 	writel(con, bank->pctl_base + reg_con);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index b90139715c8f..7639b926c5c1 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -32,7 +32,6 @@
 #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
 #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
 #define EXYNOS_SVC_OFFSET		0xB08
-#define EXYNOS_EINT_FUNC		0xF
 
 /* helpers to access interrupt service register */
 #define EXYNOS_SVC_GROUP_SHIFT		3
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index a25c3ffae25c..86c98c1dec3a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -30,6 +30,8 @@
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 #include "../core.h"
 #include "pinctrl-samsung.h"
 
@@ -586,7 +588,7 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
 	data = readl(reg);
 	data &= ~(mask << shift);
 	if (!input)
-		data |= FUNC_OUTPUT << shift;
+		data |= EXYNOS_PIN_FUNC_OUTPUT << shift;
 	writel(data, reg);
 
 	return 0;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 61c4cab0ad24..15b26c786b1e 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -25,10 +25,6 @@
 
 #include <linux/gpio.h>
 
-/* pinmux function number for pin as gpio output line */
-#define FUNC_INPUT	0x0
-#define FUNC_OUTPUT	0x1
-
 /**
  * enum pincfg_type - possible pin configuration types supported.
  * @PINCFG_TYPE_FUNC: Function configuration.
-- 
2.9.3
