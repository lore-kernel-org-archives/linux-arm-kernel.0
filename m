From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Aug 2015 17:12:21 +0200
Subject: [PATCH] pinctrl: nomadik: reflect current input value
Message-ID: <1439305941-29948-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let us see the current value on the input line in debugfs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 809d88445db5..ad43ea8fd67e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1012,6 +1012,7 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		int irq = gpio_to_irq(gpio);
 		struct irq_desc	*desc = irq_to_desc(irq);
 		int pullidx = 0;
+		int val;
 
 		if (pull)
 			pullidx = data_out ? 1 : 2;
@@ -1021,6 +1022,10 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 			   label ?: "(none)",
 			   pulls[pullidx],
 			   (mode < 0) ? "unknown" : modes[mode]);
+
+		val = nmk_gpio_get_input(chip, offset);
+		seq_printf(s, " VAL %d", val);
+
 		/*
 		 * This races with request_irq(), set_irq_type(),
 		 * and set_irq_wake() ... but those are "rare".
-- 
2.4.3
