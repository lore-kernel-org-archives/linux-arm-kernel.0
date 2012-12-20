From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Thu, 20 Dec 2012 17:56:18 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS5: save CLK_TOP_SRC3 register before
 powergating
In-Reply-To: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
References: <CAPmaG0uqkRcoUBR8Gjv_+BSJ3hwxUCz0G-YKNQX=qvx83i6QOQ@mail.gmail.com>
Message-ID: <1356006378-17441-4-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a software workaround to the hardware
problem found in exynos5 while powergating.

It is observed that CLK_TOP_SRC3 register gets modified if
the G-Scaler/MFC devices are power gated. The clock for G-Scaler gets
set to XXTI which results in the device running very slow .
A big drop in performance is noticed whilerunning the video.
This issue also occurs while powergating MFC.

The value of clock source register is restored once the powergating
operation is completed.

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 9f1351d..bd8a41e 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -24,6 +24,8 @@
 
 #include <mach/regs-pmu.h>
 #include <plat/devs.h>
+#include <mach/regs-clock.h>
+#include <plat/cpu.h>
 
 /*
  * Exynos specific wrapper around the generic power domain
@@ -41,6 +43,24 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	void __iomem *base;
 	u32 timeout, pwr;
 	char *op;
+	u32 tmp = 0;
+
+	/*
+	 *It is found that the CLK SRC register in exynos5
+	 *gets modified when power domain of gsc/mfc/isp/disp1
+	 *is powered off.This happens only after the system is
+	 *suspended and resumed and not before that.
+	 *The following fix adresses this hardware issue.
+	 *It saves the value of clock source register and
+	 *resores it later
+	 */
+
+	if (of_machine_is_compatible("samsung,exynos5250")) {
+		if (!power_on) {
+			/* save clock source register */
+			tmp = __raw_readl(EXYNOS5_CLKSRC_TOP3);
+		}
+	}
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
@@ -61,6 +81,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		cpu_relax();
 		usleep_range(80, 100);
 	}
+
+	if (of_machine_is_compatible("samsung,exynos5250")) {
+		if (!power_on) {
+			/* restore clock source register */
+			__raw_writel(tmp, EXYNOS5_CLKSRC_TOP3);
+		}
+	}
 	return 0;
 }
 
-- 
1.7.0.4
