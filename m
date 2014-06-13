From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 13 Jun 2014 22:36:04 +0200
Subject: [PATCH v2 4/4] pinctrl: sunxi: Define enable / disable irq callbacks
 for level triggered irqs
In-Reply-To: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
References: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1402691764-17562-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers use disable_irq / enable_irq and do the work clearing the source
in another thread instead of using a threaded interrupt handler.

The irqchip used not having irq_disable and irq_enable callbacks in this case,
will lead to unnecessary spurious interrupts:

On a disable_irq in a chip without a handller for this, the irq core will
remember the disable, but not actually call into the irqchip. With a level
triggered interrupt (where the source has not been cleared) this will lead
to an immediate retrigger, at which point the irq-core will mask the irq.
So having an irq_disable callback in the irqchip will save us the interrupt
firing a 2nd time for nothing.

Drivers using disable / enable_irq like this, will call enable_irq when
they finally have cleared the interrupt source, without an enable_irq callback,
this will turn into an unmask, at which point the irq will trigger immediately
because when it was originally acked the level was still high, so the ack was
a nop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index aebd2f2..4c74e13 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -34,6 +34,7 @@
 static void sunxi_pinctrl_irq_ack(struct irq_data *d);
 static void sunxi_pinctrl_irq_mask(struct irq_data *d);
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d);
+static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d);
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type);
 
 static struct sunxi_pinctrl_group *
@@ -565,6 +566,10 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 	.irq_eoi		= sunxi_pinctrl_irq_ack,
 	.irq_mask		= sunxi_pinctrl_irq_mask,
 	.irq_unmask		= sunxi_pinctrl_irq_unmask,
+	/* Define irq_enable / disable to avoid spurious irqs for drivers
+	 * using these to suppress irqs while they clear the irq source */
+	.irq_enable		= sunxi_pinctrl_irq_ack_unmask,
+	.irq_disable		= sunxi_pinctrl_irq_mask,
 	.irq_request_resources	= sunxi_pinctrl_irq_request_resources,
 	.irq_set_type		= sunxi_pinctrl_irq_set_type,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED
@@ -664,6 +669,12 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
+static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d)
+{
+	sunxi_pinctrl_irq_ack(d);
+	sunxi_pinctrl_irq_unmask(d);
+}
+
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
-- 
2.0.0
