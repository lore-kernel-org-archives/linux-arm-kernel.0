From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:28:57 +0100
Subject: [PATCH 7/9] clk: sa1111: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T29-0003wj-Jr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 0569de6..61691cd 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -718,6 +718,10 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 		goto err_free;
 	}
 
+	ret = clk_prepare(sachip->clk);
+	if (ret)
+		goto err_clkput;
+
 	spin_lock_init(&sachip->lock);
 
 	sachip->dev = me;
@@ -733,7 +737,7 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	sachip->base = ioremap(mem->start, PAGE_SIZE * 2);
 	if (!sachip->base) {
 		ret = -ENOMEM;
-		goto err_clkput;
+		goto err_clk_unprep;
 	}
 
 	/*
@@ -809,6 +813,8 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
  err_unmap:
 	iounmap(sachip->base);
+ err_clk_unprep:
+	clk_unprepare(sachip->clk);
  err_clkput:
 	clk_put(sachip->clk);
  err_free:
@@ -835,6 +841,7 @@ static void __sa1111_remove(struct sa1111 *sachip)
 	sa1111_writel(0, irqbase + SA1111_WAKEEN1);
 
 	clk_disable(sachip->clk);
+	clk_unprepare(sachip->clk);
 
 	if (sachip->irq != NO_IRQ) {
 		irq_set_chained_handler(sachip->irq, NULL);
-- 
1.7.4.4
