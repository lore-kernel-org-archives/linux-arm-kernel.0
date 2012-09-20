From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:41 +0200
Subject: [PATCH 3/6] pinctrl: exynos: Handle only unmasked wakeup interrupts
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit in EINTxx_PEND register is set regardless of interrupt mask, which
causes spurious interrupts. To avoid them, the read value of pending
register must be masked with current interrupt mask manually.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 46cd637..5648971 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -395,12 +395,15 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 	struct exynos_weint_data *eintd = irq_get_handler_data(irq);
 	struct samsung_pinctrl_drv_data *d = eintd->domain->host_data;
 	unsigned long pend;
+	unsigned long mask;
 
 	chained_irq_enter(chip, desc);
 	pend = readl(d->virt_base + d->ctrl->weint_pend + 0x8);
-	exynos_irq_demux_eint(16, pend, eintd->domain);
+	mask = readl(d->virt_base + d->ctrl->weint_mask + 0x8);
+	exynos_irq_demux_eint(16, pend & ~mask, eintd->domain);
 	pend = readl(d->virt_base + d->ctrl->weint_pend + 0xC);
-	exynos_irq_demux_eint(24, pend, eintd->domain);
+	mask = readl(d->virt_base + d->ctrl->weint_mask + 0xC);
+	exynos_irq_demux_eint(24, pend & ~mask, eintd->domain);
 	chained_irq_exit(chip, desc);
 }
 
-- 
1.7.12
