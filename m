From: jonghwa3.lee@samsung.com (Jonghwa Lee)
Date: Tue, 26 Aug 2014 14:25:24 +0900
Subject: [PATCH] arm: exynos: Allow rtc alarm and tick wakeup irq for
 exynos3250.
Message-ID: <1409030724-21103-1-git-send-email-jonghwa3.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rtc alarm and tick irq to wakeup sources in exynos3250.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by : Chanwoo choi <cw00.choi@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index fa7218a..d78dcf9 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -66,6 +66,12 @@ static struct sleep_save exynos_core_save[] = {
 
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
+static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
+	{ 105, BIT(1) }, /* RTC alarm */
+	{ 106, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
 static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
 	{ 76, BIT(1) }, /* RTC alarm */
 	{ 77, BIT(2) }, /* RTC tick */
@@ -81,9 +87,10 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
-
 	if (soc_is_exynos5250())
 		wkup_irq = exynos5250_wkup_irq;
+	else if (soc_is_exynos3250())
+		wkup_irq = exynos3250_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
 
-- 
1.7.9.5
