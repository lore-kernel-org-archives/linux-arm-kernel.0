From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 Dec 2015 18:57:12 -0500
Subject: [PATCH 3/3] drivers/cpuidle: make cpuidle-exynos.c explicitly
 non-modular
In-Reply-To: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1450051032-32329-4-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

cpuidle/Kconfig.arm:config ARM_EXYNOS_CPUIDLE
cpuidle/Kconfig.arm:    bool "Cpu Idle Driver for the Exynos processors"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modularity so that when reading the
driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/cpuidle/cpuidle-exynos.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index b5f0a9cc8185..00cd129b10a4 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -14,7 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/platform_data/cpuidle-exynos.h>
@@ -142,5 +142,4 @@ static struct platform_driver exynos_cpuidle_driver = {
 		.name = "exynos_cpuidle",
 	},
 };
-
-module_platform_driver(exynos_cpuidle_driver);
+builtin_platform_driver(exynos_cpuidle_driver);
-- 
2.6.1
