From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 16 Aug 2012 01:27:36 +0530
Subject: [PATCH v2 4/4] ARM: EXYNOS: skip wakeup interrupt setup if pinctrl
 driver is used
In-Reply-To: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
References: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1345060656-32201-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl driver includes support for configuring the external wakeup
interrupts. On exynos platforms that use pinctrl driver, the setup
of wakeup interrupts in the exynos platform code can be skipped.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4eb39cd..ea3a85a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -980,6 +980,32 @@ static int __init exynos_init_irq_eint(void)
 {
 	int irq;
 
+#ifdef CONFIG_OF
+	/*
+	 * The Samsung pinctrl driver provides an integrated gpio/pinmux/pinconf
+	 * functionality along with support for external gpio and wakeup
+	 * interrupts. If the samsung pinctrl driver is enabled and includes
+	 * the wakeup interrupt support, then the setting up external wakeup
+	 * interrupts here can be skipped. This check here is temporary to
+	 * allow exynos4 platforms that do not use Samsung pinctrl driver to
+	 * co-exist with platforms that do. When all of the Samsung Exynos4
+	 * platforms switch over to using the pinctrl driver, the wakeup
+	 * interrupt support code here can be completely removed.
+	 */
+	struct device_node *pctrl_np, *wkup_np;
+	const char *pctrl_compat = "samsung,pinctrl-exynos4210";
+	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
+
+	for_each_compatible_node(pctrl_np, NULL, pctrl_compat) {
+		if (of_device_is_available(pctrl_np)) {
+			wkup_np = of_find_compatible_node(pctrl_np, NULL,
+							wkup_compat);
+			if (wkup_np)
+				return -ENODEV;
+		}
+	}
+#endif
+
 	if (soc_is_exynos5250())
 		exynos_eint_base = ioremap(EXYNOS5_PA_GPIO1, SZ_4K);
 	else
-- 
1.6.6.rc2
