From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sat, 13 Sep 2014 14:20:49 +0530
Subject: [PATCH 1/4] pinctrl: exynos: Generalize the eint16_31 demux code
In-Reply-To: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
References: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1410598252-30931-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function exynos_irq_demux_eint16_31 uses pre-defined offsets for external
interrupt pending status and mask registers. So this function is not extensible
for Exynos7 SoC which have these registers at different offsets. So generalize
the exynos_irq_demux_eint16_31 function by using the pending/mask register
offset values from the exynos_irq_chip structure.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c |    6 ++++--
 drivers/pinctrl/samsung/pinctrl-exynos.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 003bfd8..3133a1e 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -387,10 +387,11 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = 0; i < eintd->nr_banks; ++i) {
+		struct exynos_irq_chip *our_chip = eintd->chip;
 		struct samsung_pin_bank *b = eintd->banks[i];
-		pend = readl(d->virt_base + EXYNOS_WKUP_EPEND_OFFSET
+		pend = readl(d->virt_base + our_chip->eint_pend
 				+ b->eint_offset);
-		mask = readl(d->virt_base + EXYNOS_WKUP_EMASK_OFFSET
+		mask = readl(d->virt_base + our_chip->eint_mask
 				+ b->eint_offset);
 		exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
 	}
@@ -508,6 +509,7 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		muxed_data->banks[idx++] = bank;
 	}
 	muxed_data->nr_banks = muxed_banks;
+	muxed_data->chip = &exynos_wkup_irq_chip;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 3c91c35..e060722 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -94,6 +94,7 @@ struct exynos_weint_data {
  * @banks: array of banks being part of the mux
  */
 struct exynos_muxed_weint_data {
+	struct exynos_irq_chip *chip;
 	unsigned int nr_banks;
 	struct samsung_pin_bank *banks[];
 };
-- 
1.7.9.5
