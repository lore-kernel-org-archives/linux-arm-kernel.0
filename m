From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 12:38:47 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: Read register before writing to it in
 irq_set_type
In-Reply-To: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375612728-20501-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current irq_set_type code doesn't read the current register value
before writing to it, leading to the older programmed values being
overwritten and everything but the latest value being reset.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index ea4a4749..8ed4b4a 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -532,6 +532,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
+	u32 regval;
 	u8 mode;
 
 	switch (type) {
@@ -554,7 +555,9 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 		return -EINVAL;
 	}
 
-	writel((mode & IRQ_CFG_IRQ_MASK) << index, pctl->membase + reg);
+	regval = readl(pctl->membase + reg);
+	regval &= ~IRQ_CFG_IRQ_MASK;
+	writel(regval | (mode << index), pctl->membase + reg);
 
 	return 0;
 }
-- 
1.8.3.4
