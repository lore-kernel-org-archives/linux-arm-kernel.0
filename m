From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 19:46:16 +0900
Subject: [PATCH] ARM: shmobile: MULTIPLATFORM KZM9D with no clocks prototype
 hack
Message-ID: <20130709104616.1929.47755.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Ugly prototype hack to allow boot of KZM9D without clock framework
in case of ARCH_SHMOBILE_MULTI. Obviously not for upstream merge,
but may be useful for people working on common clock framework.

Not-even-remotely-signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/em_sti.c      |   14 ++++++++++----
 drivers/tty/serial/8250/8250_em.c |   13 ++++++++++---
 2 files changed, 20 insertions(+), 7 deletions(-)

--- 0001/drivers/clocksource/em_sti.c
+++ work/drivers/clocksource/em_sti.c	2013-07-09 13:04:04.000000000 +0900
@@ -77,6 +77,7 @@ static int em_sti_enable(struct em_sti_p
 {
 	int ret;
 
+#if 0
 	/* enable clock */
 	ret = clk_enable(p->clk);
 	if (ret) {
@@ -86,7 +87,9 @@ static int em_sti_enable(struct em_sti_p
 
 	/* configure channel, periodic mode and maximum timeout */
 	p->rate = clk_get_rate(p->clk);
-
+#else
+	p->rate = 32768;
+#endif
 	/* reset the counter */
 	em_sti_write(p, STI_SET_H, 0x40000000);
 	em_sti_write(p, STI_SET_L, 0x00000000);
@@ -105,9 +108,10 @@ static void em_sti_disable(struct em_sti
 {
 	/* mask interrupts */
 	em_sti_write(p, STI_INTENCLR, 3);
-
+#if 0
 	/* stop clock */
 	clk_disable(p->clk);
+#endif
 }
 
 static cycle_t em_sti_count(struct em_sti_priv *p)
@@ -348,7 +352,7 @@ static int em_sti_probe(struct platform_
 		ret = -ENXIO;
 		goto err0;
 	}
-
+#if 0
 	/* get hold of clock */
 	p->clk = clk_get(&pdev->dev, "sclk");
 	if (IS_ERR(p->clk)) {
@@ -356,7 +360,7 @@ static int em_sti_probe(struct platform_
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
-
+#endif
 	if (request_irq(irq, em_sti_interrupt,
 			IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
 			dev_name(&pdev->dev), p)) {
@@ -371,7 +375,9 @@ static int em_sti_probe(struct platform_
 	return 0;
 
 err2:
+#if 0
 	clk_put(p->clk);
+#endif
 err1:
 	iounmap(p->base);
 err0:
--- 0001/drivers/tty/serial/8250/8250_em.c
+++ work/drivers/tty/serial/8250/8250_em.c	2013-07-09 13:04:04.000000000 +0900
@@ -108,14 +108,14 @@ static int serial8250_em_probe(struct pl
 		ret = -ENOMEM;
 		goto err0;
 	}
-
+#if 0
 	priv->sclk = clk_get(&pdev->dev, "sclk");
 	if (IS_ERR(priv->sclk)) {
 		dev_err(&pdev->dev, "unable to get clock\n");
 		ret = PTR_ERR(priv->sclk);
 		goto err1;
 	}
-
+#endif
 	memset(&up, 0, sizeof(up));
 	up.port.mapbase = regs->start;
 	up.port.irq = irq->start;
@@ -123,9 +123,12 @@ static int serial8250_em_probe(struct pl
 	up.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_IOREMAP;
 	up.port.dev = &pdev->dev;
 	up.port.private_data = priv;
-
+#if 0
 	clk_enable(priv->sclk);
 	up.port.uartclk = clk_get_rate(priv->sclk);
+#else
+	up.port.uartclk = 114688000;
+#endif
 
 	up.port.iotype = UPIO_MEM32;
 	up.port.serial_in = serial8250_em_serial_in;
@@ -144,8 +147,10 @@ static int serial8250_em_probe(struct pl
 	return 0;
 
  err2:
+#if 0
 	clk_disable(priv->sclk);
 	clk_put(priv->sclk);
+#endif
  err1:
 	kfree(priv);
  err0:
@@ -157,8 +162,10 @@ static int serial8250_em_remove(struct p
 	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
+#if 0
 	clk_disable(priv->sclk);
 	clk_put(priv->sclk);
+#endif
 	kfree(priv);
 	return 0;
 }
