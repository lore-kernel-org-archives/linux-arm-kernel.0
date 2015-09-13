From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Sep 2015 12:14:33 +0100
Subject: [PATCH 3/3] irqchip/GICv2m: Fix GICv2m build warning on 32 bits
In-Reply-To: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
References: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442142873-20213-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Fedin <p.fedin@samsung.com>

After GICv2m was enabled for 32-bit ARM kernel, a warning popped up:

drivers/irqchip/irq-gic-v2m.c: In function ?gicv2m_compose_msi_msg?:
drivers/irqchip/irq-gic-v2m.c:100:2: warning: right shift count >= width
of type [enabled by default]
  msg->address_hi = (u32) (addr >> 32);
  ^

This patch fixes it by using proper macros for splitting up the value.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index db04fc1..12985da 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -95,8 +95,8 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
 	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
 
-	msg->address_hi = (u32) (addr >> 32);
-	msg->address_lo = (u32) (addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->address_lo = lower_32_bits(addr);
 	msg->data = data->hwirq;
 }
 
-- 
2.1.4
