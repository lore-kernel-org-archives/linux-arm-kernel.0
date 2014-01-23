From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:15 +0100
Subject: [PATCH v3 11/15] at91: dt: Adds support for the bus matrix
 declaration in the device tree
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-12-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/setup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 7d3f7cc..f61638d 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -483,6 +483,28 @@ end:
 	of_node_put(np);
 }
 
+static struct of_device_id matrix_ids[] = {
+	{ .compatible = "atmel,at91sam9261-bus-matrix", },
+	{ /*sentinel*/ }
+};
+
+static void at91_dt_matrix(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, matrix_ids);
+	if (!np) {
+		pr_debug("AT91: unable to find compatible bus matrix controller node in dtb\n");
+		return;
+	}
+
+	at91_matrix_base = of_iomap(np, 0);
+	if (!at91_matrix_base)
+		panic("Impossible to ioremap at91_matrix_base\n");
+
+	of_node_put(np);
+}
+
 void __init at91rm9200_dt_initialize(void)
 {
 	at91_dt_ramc();
@@ -502,6 +524,7 @@ void __init at91_dt_initialize(void)
 	at91_dt_rstc();
 	at91_dt_ramc();
 	at91_dt_shdwc();
+	at91_dt_matrix();
 
 	/* Init clock subsystem */
 	at91_dt_clock_init();
-- 
1.8.5.2
