From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:11 +0300
Subject: [PATCH 19/22] serial: clps711x: Remove board support
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-20-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since board support for the CLPS711X platform was removed,
remove the board support from the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index ac13286..b8be687 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -446,12 +446,15 @@ static struct console clps711x_console = {
 static int uart_clps711x_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret, index = np ? of_alias_get_id(np, "serial") : pdev->id;
 	struct clps711x_port *s;
 	struct resource *res;
 	struct clk *uart_clk;
-	int irq;
+	int irq, ret, index;
 
+	if (!np)
+		return -ENODEV;
+
+	index = of_alias_get_id(np, "serial");
 	if (index < 0 || index >= UART_CLPS711X_NR)
 		return -EINVAL;
 
@@ -477,18 +480,9 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (s->rx_irq < 0)
 		return s->rx_irq;
 
-	if (!np) {
-		char syscon_name[9];
-
-		sprintf(syscon_name, "syscon.%i", index + 1);
-		s->syscon = syscon_regmap_lookup_by_pdevname(syscon_name);
-		if (IS_ERR(s->syscon))
-			return PTR_ERR(s->syscon);
-	} else {
-		s->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
-		if (IS_ERR(s->syscon))
-			return PTR_ERR(s->syscon);
-	}
+	s->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(s->syscon))
+		return PTR_ERR(s->syscon);
 
 	s->port.line		= index;
 	s->port.dev		= &pdev->dev;
-- 
2.4.9
