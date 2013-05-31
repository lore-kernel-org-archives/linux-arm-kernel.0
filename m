From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 17:49:28 +0200
Subject: [PATCH] ARM: nomadik: fix clocksource warning
Message-ID: <41518453.ApMFpK6n11@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocksource API has changed slightly, which causes a harmless
warning:

/git/arm-soc/drivers/clocksource/nomadik-mtu.c:259:28: warning: 'nmdk_timer_match' defined but not used [-Wunused-variable]
 static struct of_device_id nmdk_timer_match[] __initconst = {
                            ^

Fortunately, the same API change also lets us simplify the code
while removing the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

I've applied this patch on top of next/dt to remove the warning introduced
by Linus' patch.

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 7982cb0..b9415b6 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -256,23 +256,13 @@ void __init nmdk_timer_init(void __iomem *base, int irq)
 	__nmdk_timer_init(base, irq, pclk0, clk0);
 }
 
-static struct of_device_id nmdk_timer_match[] __initconst = {
-	{ .compatible = "st,nomadik-mtu" },
-	{}
-};
-
-static void __init nmdk_timer_of_init(void)
+static void __init nmdk_timer_of_init(struct device_node *node)
 {
-	struct device_node *node;
 	struct clk *pclk;
 	struct clk *clk;
 	void __iomem *base;
 	int irq;
 
-	node = of_find_matching_node(NULL, nmdk_timer_match);
-	if (!node)
-		panic("No timer node");
-
 	base = of_iomap(node, 0);
 	if (!base)
 		panic("Can't remap registers");
