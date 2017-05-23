From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 23 May 2017 20:41:39 +0200
Subject: [PATCH 1/3] pinctrl: samsung: Constify wakeup driver specific data
Message-ID: <20170523184141.24284-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Static exynos_irq_chip structures, containing driver specific data, are
referenced only through opaque data pointer in const of_device_id table.
The contents of pointed memory (exynos_irq_chip structure itself) is
then copied with kmemdup() during wakeup initialization so
exynos_irq_chip can be made const for code safenes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 7b0e6cc35e04..cdea07af308a 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -387,7 +387,7 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 /*
  * irq_chip for wakeup interrupts
  */
-static struct exynos_irq_chip exynos4210_wkup_irq_chip __initdata = {
+static const struct exynos_irq_chip exynos4210_wkup_irq_chip __initconst = {
 	.chip = {
 		.name = "exynos4210_wkup_irq_chip",
 		.irq_unmask = exynos_irq_unmask,
@@ -403,7 +403,7 @@ static struct exynos_irq_chip exynos4210_wkup_irq_chip __initdata = {
 	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
 };
 
-static struct exynos_irq_chip exynos7_wkup_irq_chip __initdata = {
+static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
 	.chip = {
 		.name = "exynos7_wkup_irq_chip",
 		.irq_unmask = exynos_irq_unmask,
-- 
2.9.3
