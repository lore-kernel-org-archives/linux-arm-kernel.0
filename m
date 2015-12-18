From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:50 +0100
Subject: [PATCH 37/69] clocksource/drivers/h8300: Cleanup startup and remove
 module code.
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-37-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Remove some legacy code and replace it by the clksrc-of code.

Do some cleanup and code consolidation.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 141 +++++++++++++--------------------
 drivers/clocksource/h8300_timer8.c  | 150 ++++++++++++------------------------
 drivers/clocksource/h8300_tpu.c     | 117 ++++++++++------------------
 3 files changed, 144 insertions(+), 264 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index 0e076c6..cdf0d83 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -17,6 +17,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/segment.h>
 #include <asm/irq.h>
@@ -47,9 +49,7 @@
 #define ABSOLUTE 1
 
 struct timer16_priv {
-	struct platform_device *pdev;
 	struct clocksource cs;
-	struct irqaction irqaction;
 	unsigned long total_cycles;
 	unsigned long mapbase;
 	unsigned long mapcommon;
@@ -144,110 +144,77 @@ static void timer16_disable(struct clocksource *cs)
 	p->cs_enabled = false;
 }
 
+static struct timer16_priv timer16_priv = {
+	.cs = {
+		.name = "h8300_16timer",
+		.rating = 200,
+		.read = timer16_clocksource_read,
+		.enable = timer16_enable,
+		.disable = timer16_disable,
+		.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8),
+		.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	},
+};
+
 #define REG_CH   0
 #define REG_COMM 1
 
-static int timer16_setup(struct timer16_priv *p, struct platform_device *pdev)
+static void __init h8300_16timer_init(struct device_node *node)
 {
-	struct resource *res[2];
+	void __iomem *base[2];
 	int ret, irq;
 	unsigned int ch;
+	struct clk *clk;
 
-	p->pdev = pdev;
-
-	res[REG_CH] = platform_get_resource(p->pdev,
-					    IORESOURCE_MEM, REG_CH);
-	res[REG_COMM] = platform_get_resource(p->pdev,
-					      IORESOURCE_MEM, REG_COMM);
-	if (!res[REG_CH] || !res[REG_COMM]) {
-		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
-	}
-	irq = platform_get_irq(p->pdev, 0);
-	if (irq < 0) {
-		dev_err(&p->pdev->dev, "failed to get irq\n");
-		return irq;
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clocksource\n");
+		return;
 	}
 
-	p->clk = clk_get(&p->pdev->dev, "fck");
-	if (IS_ERR(p->clk)) {
-		dev_err(&p->pdev->dev, "can't get clk\n");
-		return PTR_ERR(p->clk);
+	base[REG_CH] = of_iomap(node, 0);
+	if (!base[REG_CH]) {
+		pr_err("failed to map registers for clocksource\n");
+		goto free_clk;
 	}
-	of_property_read_u32(p->pdev->dev.of_node, "renesas,channel", &ch);
-
-	p->pdev = pdev;
-	p->mapbase = res[REG_CH]->start;
-	p->mapcommon = res[REG_COMM]->start;
-	p->enb = 1 << ch;
-	p->imfa = 1 << ch;
-	p->imiea = 1 << (4 + ch);
-	p->cs.name = pdev->name;
-	p->cs.rating = 200;
-	p->cs.read = timer16_clocksource_read;
-	p->cs.enable = timer16_enable;
-	p->cs.disable = timer16_disable;
-	p->cs.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
-	p->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
-	ret = request_irq(irq, timer16_interrupt,
-			  IRQF_TIMER, pdev->name, p);
-	if (ret < 0) {
-		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
-		return ret;
+	base[REG_COMM] = of_iomap(node, 1);
+	if (!base[REG_COMM]) {
+		pr_err("failed to map registers for clocksource\n");
+		goto unmap_ch;
 	}
 
-	clocksource_register_hz(&p->cs, clk_get_rate(p->clk) / 8);
-
-	return 0;
-}
-
-static int timer16_probe(struct platform_device *pdev)
-{
-	struct timer16_priv *p = platform_get_drvdata(pdev);
-
-	if (p) {
-		dev_info(&pdev->dev, "kept as earlytimer\n");
-		return 0;
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq < 0) {
+		pr_err("failed to get irq for clockevent\n");
+		goto unmap_comm;
 	}
 
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	of_property_read_u32(node, "renesas,channel", &ch);
 
-	return timer16_setup(p, pdev);
-}
+	timer16_priv.mapbase = (unsigned long)base[REG_CH];
+	timer16_priv.mapcommon = (unsigned long)base[REG_COMM];
+	timer16_priv.enb = 1 << ch;
+	timer16_priv.imfa = 1 << ch;
+	timer16_priv.imiea = 1 << (4 + ch);
 
-static int timer16_remove(struct platform_device *pdev)
-{
-	return -EBUSY;
-}
-
-static const struct of_device_id timer16_of_table[] = {
-	{ .compatible = "renesas,16bit-timer" },
-	{ }
-};
-static struct platform_driver timer16_driver = {
-	.probe		= timer16_probe,
-	.remove		= timer16_remove,
-	.driver		= {
-		.name	= "h8300h-16timer",
-		.of_match_table = of_match_ptr(timer16_of_table),
+	ret = request_irq(irq, timer16_interrupt,
+			  IRQF_TIMER, timer16_priv.cs.name, &timer16_priv);
+	if (ret < 0) {
+		pr_err("failed to request irq %d of clocksource\n", irq);
+		goto unmap_comm;
 	}
-};
 
-static int __init timer16_init(void)
-{
-	return platform_driver_register(&timer16_driver);
-}
+	clocksource_register_hz(&timer16_priv.cs,
+				clk_get_rate(timer16_priv.clk) / 8);
+	return;
 
-static void __exit timer16_exit(void)
-{
-	platform_driver_unregister(&timer16_driver);
+unmap_comm:
+	iounmap(base[REG_COMM]);
+unmap_ch:
+	iounmap(base[REG_CH]);
+free_clk:
+	clk_put(clk);
 }
 
-subsys_initcall(timer16_init);
-module_exit(timer16_exit);
-MODULE_AUTHOR("Yoshinori Sato");
-MODULE_DESCRIPTION("H8/300H 16bit Timer Driver");
-MODULE_LICENSE("GPL v2");
+CLOCKSOURCE_OF_DECLARE(h8300_16bit, "renesas,16bit-timer", h8300_16timer_init);
diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 44375d8..f0680eb 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -12,13 +12,14 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clockchips.h>
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/irq.h>
 
@@ -39,10 +40,10 @@
 #define RELATIVE 0
 #define ABSOLUTE 1
 
+#define SCALE 64
+
 struct timer8_priv {
-	struct platform_device *pdev;
 	struct clock_event_device ced;
-	struct irqaction irqaction;
 	unsigned long mapbase;
 	raw_spinlock_t lock;
 	unsigned long flags;
@@ -111,7 +112,7 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 
 static int timer8_enable(struct timer8_priv *p)
 {
-	p->rate = clk_get_rate(p->pclk) / 64;
+	p->rate = clk_get_rate(p->pclk) / SCALE;
 	ctrl_outw(0xffff, p->mapbase + TCORA);
 	ctrl_outw(0x0000, p->mapbase + _8TCNT);
 	ctrl_outw(0x0c02, p->mapbase + _8TCR);
@@ -179,7 +180,7 @@ static int timer8_clock_event_periodic(struct clock_event_device *ced)
 {
 	struct timer8_priv *p = ced_to_priv(ced);
 
-	dev_info(&p->pdev->dev, "used for periodic clock events\n");
+	pr_info("%s: used for periodic clock events\n", ced->name);
 	timer8_stop(p);
 	timer8_clock_event_start(p, PERIODIC);
 
@@ -190,7 +191,7 @@ static int timer8_clock_event_oneshot(struct clock_event_device *ced)
 {
 	struct timer8_priv *p = ced_to_priv(ced);
 
-	dev_info(&p->pdev->dev, "used for oneshot clock events\n");
+	pr_info("%s: used for oneshot clock events\n", ced->name);
 	timer8_stop(p);
 	timer8_clock_event_start(p, ONESHOT);
 
@@ -208,110 +209,61 @@ static int timer8_clock_event_next(unsigned long delta,
 	return 0;
 }
 
-static int timer8_setup(struct timer8_priv *p,
-			struct platform_device *pdev)
+static struct timer8_priv timer8_priv = {
+	.ced = {
+		.name = "h8300_8timer",
+		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+		.rating = 200,
+		.set_next_event = timer8_clock_event_next,
+		.set_state_shutdown = timer8_clock_event_shutdown,
+		.set_state_periodic = timer8_clock_event_periodic,
+		.set_state_oneshot = timer8_clock_event_oneshot,
+	},
+};
+
+static void __init h8300_8timer_init(struct device_node *node)
 {
-	struct resource *res;
+	void __iomem *base;
 	int irq;
-	int ret;
+	int ret = 0;
+	int rate;
+	struct clk *clk;
 
-	p->pdev = pdev;
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clockevent\n");
+		return;
+	}
 
-	res = platform_get_resource(p->pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("failed to map registers for clockevent\n");
+		goto free_clk;
 	}
 
-	irq = platform_get_irq(p->pdev, 0);
+	irq = irq_of_parse_and_map(node, 0);
 	if (irq < 0) {
-		dev_err(&p->pdev->dev, "failed to get irq\n");
-		return -ENXIO;
+		pr_err("failed to get irq for clockevent\n");
+		goto unmap_reg;
 	}
 
-	p->mapbase = res->start;
-
-	p->irqaction.name = dev_name(&p->pdev->dev);
-	p->irqaction.handler = timer8_interrupt;
-	p->irqaction.dev_id = p;
-	p->irqaction.flags = IRQF_TIMER;
-
-	p->pclk = clk_get(&p->pdev->dev, "fck");
-	if (IS_ERR(p->pclk)) {
-		dev_err(&p->pdev->dev, "can't get clk\n");
-		return PTR_ERR(p->pclk);
-	}
+	timer8_priv.mapbase = (unsigned long)base;
+	timer8_priv.pclk = clk;
 
-	p->ced.name = pdev->name;
-	p->ced.features = CLOCK_EVT_FEAT_PERIODIC |
-		CLOCK_EVT_FEAT_ONESHOT;
-	p->ced.rating = 200;
-	p->ced.cpumask = cpumask_of(0);
-	p->ced.set_next_event = timer8_clock_event_next;
-	p->ced.set_state_shutdown = timer8_clock_event_shutdown;
-	p->ced.set_state_periodic = timer8_clock_event_periodic;
-	p->ced.set_state_oneshot = timer8_clock_event_oneshot;
-
-	ret = setup_irq(irq, &p->irqaction);
+	ret = request_irq(irq, timer8_interrupt,
+			  IRQF_TIMER, timer8_priv.ced.name, &timer8_priv);
 	if (ret < 0) {
-		dev_err(&p->pdev->dev,
-			"failed to request irq %d\n", irq);
-		return ret;
+		pr_err("failed to request irq %d for clockevent\n", irq);
+		goto unmap_reg;
 	}
-	clockevents_register_device(&p->ced);
-	platform_set_drvdata(pdev, p);
-
-	return 0;
-}
-
-static int timer8_probe(struct platform_device *pdev)
-{
-	struct timer8_priv *p = platform_get_drvdata(pdev);
-
-	if (p) {
-		dev_info(&pdev->dev, "kept as earlytimer\n");
-		return 0;
-	}
-
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
-	return timer8_setup(p, pdev);
-}
-
-static int timer8_remove(struct platform_device *pdev)
-{
-	return -EBUSY;
-}
-
-static const struct of_device_id timer8_of_table[] __maybe_unused = {
-	{ .compatible = "renesas,8bit-timer" },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, timer8_of_table);
-static struct platform_driver timer8_driver = {
-	.probe		= timer8_probe,
-	.remove		= timer8_remove,
-	.driver		= {
-		.name	= "h8300-8timer",
-		.of_match_table = of_match_ptr(timer8_of_table),
-	}
-};
-
-static int __init timer8_init(void)
-{
-	return platform_driver_register(&timer8_driver);
-}
-
-static void __exit timer8_exit(void)
-{
-	platform_driver_unregister(&timer8_driver);
+	rate = clk_get_rate(clk) / SCALE;
+	clockevents_config_and_register(&timer8_priv.ced, rate, 1, 0x0000ffff);
+	return;
+
+unmap_reg:
+	iounmap(base);
+free_clk:
+	clk_put(clk);
 }
 
-subsys_initcall(timer8_init);
-module_exit(timer8_exit);
-MODULE_AUTHOR("Yoshinori Sato");
-MODULE_DESCRIPTION("H8/300 8bit Timer Driver");
-MODULE_LICENSE("GPL v2");
+CLOCKSOURCE_OF_DECLARE(h8300_8bit, "renesas,8bit-timer", h8300_8timer_init);
diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index 5487410..ed0b493 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -1,5 +1,5 @@
 /*
- *  H8/300 TPU Driver
+ *  H8S TPU Driver
  *
  *  Copyright 2015 Yoshinori Sato <ysato@users.sourcefoge.jp>
  *
@@ -17,8 +17,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-
-#include <asm/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #define TCR	0
 #define TMDR	1
@@ -32,9 +32,7 @@
 #define TGRD	14
 
 struct tpu_priv {
-	struct platform_device *pdev;
 	struct clocksource cs;
-	struct clk *clk;
 	unsigned long mapbase1;
 	unsigned long mapbase2;
 	raw_spinlock_t lock;
@@ -116,91 +114,54 @@ static void tpu_clocksource_disable(struct clocksource *cs)
 	p->cs_enabled = false;
 }
 
+static struct tpu_priv tpu_priv = {
+	.cs = {
+		.name = "H8S_TPU",
+		.rating = 200,
+		.read = tpu_clocksource_read,
+		.enable = tpu_clocksource_enable,
+		.disable = tpu_clocksource_disable,
+		.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8),
+		.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	},
+};
+
 #define CH_L 0
 #define CH_H 1
 
-static int __init tpu_setup(struct tpu_priv *p, struct platform_device *pdev)
+static void __init h8300_tpu_init(struct device_node *node)
 {
-	struct resource *res[2];
-
-	p->pdev = pdev;
+	void __iomem *base[2];
+	struct clk *clk;
 
-	res[CH_L] = platform_get_resource(p->pdev, IORESOURCE_MEM, CH_L);
-	res[CH_H] = platform_get_resource(p->pdev, IORESOURCE_MEM, CH_H);
-	if (!res[CH_L] || !res[CH_H]) {
-		dev_err(&p->pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
+	clk = of_clk_get(node, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clocksource\n");
+		return;
 	}
 
-	p->clk = clk_get(&p->pdev->dev, "fck");
-	if (IS_ERR(p->clk)) {
-		dev_err(&p->pdev->dev, "can't get clk\n");
-		return PTR_ERR(p->clk);
+	base[CH_L] = of_iomap(node, CH_L);
+	if (!base[CH_L]) {
+		pr_err("failed to map registers for clocksource\n");
+		goto free_clk;
 	}
-
-	p->mapbase1 = res[CH_L]->start;
-	p->mapbase2 = res[CH_H]->start;
-
-	p->cs.name = pdev->name;
-	p->cs.rating = 200;
-	p->cs.read = tpu_clocksource_read;
-	p->cs.enable = tpu_clocksource_enable;
-	p->cs.disable = tpu_clocksource_disable;
-	p->cs.mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
-	p->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
-	clocksource_register_hz(&p->cs, clk_get_rate(p->clk) / 64);
-	platform_set_drvdata(pdev, p);
-
-	return 0;
-}
-
-static int tpu_probe(struct platform_device *pdev)
-{
-	struct tpu_priv *p = platform_get_drvdata(pdev);
-
-	if (p) {
-		dev_info(&pdev->dev, "kept as earlytimer\n");
-		return 0;
+	base[CH_H] = of_iomap(node, CH_H);
+	if (!base[CH_H]) {
+		pr_err("failed to map registers for clocksource\n");
+		goto unmap_L;
 	}
 
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	tpu_priv.mapbase1 = (unsigned long)base[CH_L];
+	tpu_priv.mapbase2 = (unsigned long)base[CH_H];
 
-	return tpu_setup(p, pdev);
-}
+	clocksource_register_hz(&tpu_priv.cs, clk_get_rate(clk) / 64);
 
-static int tpu_remove(struct platform_device *pdev)
-{
-	return -EBUSY;
-}
+	return;
 
-static const struct of_device_id tpu_of_table[] = {
-	{ .compatible = "renesas,tpu" },
-	{ }
-};
-
-static struct platform_driver tpu_driver = {
-	.probe		= tpu_probe,
-	.remove		= tpu_remove,
-	.driver		= {
-		.name	= "h8s-tpu",
-		.of_match_table = of_match_ptr(tpu_of_table),
-	}
-};
-
-static int __init tpu_init(void)
-{
-	return platform_driver_register(&tpu_driver);
-}
-
-static void __exit tpu_exit(void)
-{
-	platform_driver_unregister(&tpu_driver);
+unmap_L:
+	iounmap(base[CH_H]);
+free_clk:
+	clk_put(clk);
 }
 
-subsys_initcall(tpu_init);
-module_exit(tpu_exit);
-MODULE_AUTHOR("Yoshinori Sato");
-MODULE_DESCRIPTION("H8S Timer Pulse Unit Driver");
-MODULE_LICENSE("GPL v2");
+CLOCKSOURCE_OF_DECLARE(h8300_tpu, "renesas,tpu", h8300_tpu_init);
-- 
1.9.1
