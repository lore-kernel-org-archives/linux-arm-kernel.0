From: marex@denx.de (Marek Vasut)
Date: Mon,  7 Jan 2013 15:29:49 +0100
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based probe
Message-ID: <1357568989-16237-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of a DT-based probe of the stmpe MFD driver, the irq_gpio was zero,
which resulted in the driver failing to probe.

Implement DT properties "irq-over-gpio" and "irq-gpios" which are already used
in "arch/arm/boot/dts/spear320-hmi.dts" to circumvent these problems. The new
behaviour is the expected one and copies the behavior of platform_data-based
probe.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mfd/stmpe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 4b11202..fb9cd6f 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1018,6 +1018,11 @@ void stmpe_of_probe(struct stmpe_platform_data *pdata, struct device_node *np)
 	pdata->id = -1;
 	pdata->irq_trigger = IRQF_TRIGGER_NONE;
 
+	pdata->irq_over_gpio = of_get_property(np, "irq-over-gpio", NULL);
+	pdata->irq_gpio = of_get_named_gpio(np, "irq-gpios", 0);
+	if (!gpio_is_valid(pdata->irq_gpio))
+		pdata->irq_gpio = -1;
+
 	of_property_read_u32(np, "st,autosleep-timeout",
 			&pdata->autosleep_timeout);
 
-- 
1.7.10.4
