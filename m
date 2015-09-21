From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:39 +0200
Subject: [PATCH v5 6/6] irqchip, gicv3-its: Use new jump label API
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-7-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Use newly introduced jump label API.

Make this a separate patch for easier backporting to older kernels of
the errata patch set.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5899e471df4c..8954763ef08a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -144,11 +144,11 @@ static u64 gic_read_iar_cavium_thunderx(void)
 	return irqstat;
 }
 
-static struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;
+static DEFINE_STATIC_KEY_FALSE(is_cavium_thunderx);
 
 static u64 __maybe_unused gic_read_iar(void)
 {
-	if (static_key_false(&is_cavium_thunderx))
+	if (static_branch_unlikely(&is_cavium_thunderx))
 		return gic_read_iar_cavium_thunderx();
 	else
 		return gic_read_iar_common();
@@ -874,7 +874,7 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 static void gicv3_enable_quirks(void)
 {
 	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
-		static_key_slow_inc(&is_cavium_thunderx);
+		static_branch_enable(&is_cavium_thunderx);
 }
 
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
-- 
2.1.1
