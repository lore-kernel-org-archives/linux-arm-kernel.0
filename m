From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 11 Jan 2014 16:48:43 +0800
Subject: [PATCH 2/2] pinctrl: sirf: put gpio interrupt pin into input status
 automatically
In-Reply-To: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
References: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1389430123-8036-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

busses like i2c, spi and so on can parse the virq of their subnode automatically by
irq_of_parse_and_map(). for example, i2c will do that in of_i2c_register_devices().
people can put hwirq number attached to a gpio controller in dts, and drivers can
directly request the parsed virq.

for example, for an i2c client as below,
tangoc-ts at 5c{
	compatible = "pixcir,tangoc-ts";
	interrupt-parent = <&gpio>;
	interrupts = <3 0>;
	reg = <0x5c>;
};
in i2c client probe(), it will request_irq(client->irq, ...) without
calling gpio_direction_input().
so here when we set irq type, we also put the pin to input direction.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 53a3bc5..b637f5a 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -560,7 +560,7 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 	spin_lock_irqsave(&sgpio_lock, flags);
 
 	val = readl(bank->chip.regs + offset);
-	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
+	val &= ~(SIRFSOC_GPIO_CTL_INTR_STS_MASK | SIRFSOC_GPIO_CTL_OUT_EN_MASK);
 
 	switch (type) {
 	case IRQ_TYPE_NONE:
-- 
1.7.5.4
