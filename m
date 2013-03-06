From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  6 Mar 2013 12:36:46 +0100
Subject: [PATCH] serial: sh-sci: OF support finishing
Message-ID: <1362569806-11431-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the diff between v3 and v6 of the "serial: sh-sci: Add OF
support" patch. Among other minor changes this includes

- Reworked compatible property
- Added interrupt-names property

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
This is based on git://github.com/pmundt/linux-sh.git branch sh/serial-of.

 .../bindings/tty/serial/renesas,sci-serial.txt     |   40 ++++------
 drivers/tty/serial/sh-sci.c                        |   81 ++++++++++++--------
 2 files changed, 67 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
index 6ad1adf..d80039e 100644
--- a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
@@ -1,10 +1,18 @@
 * Renesas SH-Mobile Serial Communication Interface
 
 Required properties:
-- compatible : Should be "renesas,sci-<port type>-uart", where <port type> may be
-  SCI, SCIF, IRDA, SCIFA or SCIFB.
+- compatible : Should be "renesas,sci-<port type>-uart", where <port type> is
+  "sci", "scif", "irda", "scifa", "scifb"
+  or for legacy devices
+  "sh2_scif_fifodata", "sh3_scif", "sh4_scif", "sh4_scif_no_scsptr",
+  "sh4_scif_fifodata", "sh7705_scif".
 - reg : Address and length of the register set for the device
-- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.
+- interrupts : Should contain the following IRQs in this order:
+	ERI: receive-error interrupt
+	RXI: receive-FIFO-data-full interrupt
+	TXI: transmit-FIFO-data-empty interrupt
+	BRI: break reception interrupt
+- interrupt-names: The IRQ names "eri", "rxi", "txi" and "bri".
 - cell-index : The device id.
 - renesas,scscr : Should contain a bitfield used by the Serial Control Register.
   b7 = SCSCR_TIE
@@ -15,7 +23,7 @@ Required properties:
   b2 = SCSCR_TOIE
   b1 = SCSCR_CKE1
   b0 = SCSCR_CKE0
-- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
+- renesas,scbrr-algorithm : Choose an algorithm ID for the baud rate generator.
   1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
   2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
   3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
@@ -23,31 +31,17 @@ Required properties:
   5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
 
 Optional properties:
-- renesas,autoconf : Set if device is capable of auto configuration
-- renesas,regtype : Overwrite the register layout. In most cases you can rely
-  on auto-probing (omit this property or set to 0) but some legacy devices
-  use a non-default register layout. Possible layouts are
-  0 = SCIx_PROBE_REGTYPE (default)
-  1 = SCIx_SCI_REGTYPE
-  2 = SCIx_IRDA_REGTYPE
-  3 = SCIx_SCIFA_REGTYPE
-  4 = SCIx_SCIFB_REGTYPE
-  5 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
-  6 = SCIx_SH3_SCIF_REGTYPE
-  7 = SCIx_SH4_SCIF_REGTYPE
-  8 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
-  9 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
- 10 = SCIx_SH7705_SCIF_REGTYPE
-
+- renesas,autoconf : Set if device is capable of auto configuration.
 
 Example:
-	sci at 0xe6c50000 {
-		compatible = "renesas,sci-SCIFA-uart";
+	serial at e6c50000 {
+		compatible = "renesas,sci-scifa-uart";
 		interrupt-parent = <&intca>;
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+		interrupt-names = "eri", "rxi", "txi", "bri";
 		cell-index = <1>;
 		renesas,scscr = <0x30>;
-		renesas,scbrr-algo-id = <4>;
+		renesas,scbrr-algorithm = <4>;
 		renesas,autoconf;
 	};
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e3847cc..f1343d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2352,18 +2352,29 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id of_sci_match[] = {
-	{ .compatible = "renesas,sci-SCI-uart",
-		.data = (void *)PORT_SCI },
-	{ .compatible = "renesas,sci-SCIF-uart",
-		.data = (void *)PORT_SCIF },
-	{ .compatible = "renesas,sci-IRDA-uart",
-		.data = (void *)PORT_IRDA },
-	{ .compatible = "renesas,sci-SCIFA-uart",
-		.data = (void *)PORT_SCIFA },
-	{ .compatible = "renesas,sci-SCIFB-uart",
-		.data = (void *)PORT_SCIFB },
+	{ .compatible = "renesas,sci-sci-uart",
+		.data = (void *)SCIx_SCI_REGTYPE },
+	{ .compatible = "renesas,sci-scif-uart",
+		.data = (void *)SCIx_SH4_SCIF_REGTYPE, },
+	{ .compatible = "renesas,sci-irda-uart",
+		.data = (void *)SCIx_IRDA_REGTYPE },
+	{ .compatible = "renesas,sci-scifa-uart",
+		.data = (void *)SCIx_SCIFA_REGTYPE },
+	{ .compatible = "renesas,sci-scifb-uart",
+		.data = (void *)SCIx_SCIFB_REGTYPE },
+	{ .compatible = "renesas,sci-sh2_scif_fifodata-uart",
+		.data = (void *)SCIx_SH2_SCIF_FIFODATA_REGTYPE },
+	{ .compatible = "renesas,sci-sh3_scif-uart",
+		.data = (void *)SCIx_SH3_SCIF_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif-uart",
+		.data = (void *)SCIx_SH4_SCIF_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif_no_scsptr-uart",
+		.data = (void *)SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE },
+	{ .compatible = "renesas,sci-sh4_scif_fifodata-uart",
+		.data = (void *)SCIx_SH4_SCIF_FIFODATA_REGTYPE },
+	{ .compatible = "renesas,sci-sh7705_scif-uart",
+		.data = (void *)SCIx_SH7705_SCIF_REGTYPE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_sci_match);
@@ -2378,6 +2389,9 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	const __be32 *prop;
 	int i, irq, val;
 
+	if (!IS_ENABLED(CONFIG_OF) || !np)
+		return NULL;
+
 	match = of_match_node(of_sci_match, pdev->dev.of_node);
 	if (!match || !match->data) {
 		dev_err(&pdev->dev, "OF match error\n");
@@ -2420,14 +2434,14 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 	p->scscr = be32_to_cpup(prop);
 
-	prop = of_get_property(np, "renesas,scbrr-algo-id", NULL);
+	prop = of_get_property(np, "renesas,scbrr-algorithm", NULL);
 	if (!prop) {
-		dev_err(&pdev->dev, "required DT prop scbrr-algo-id missing\n");
+		dev_err(&pdev->dev, "required DT prop scbrr-algorithm missing\n");
 		return NULL;
 	}
 	val = be32_to_cpup(prop);
 	if (val <= SCBRR_ALGO_INVALID || val >= SCBRR_NR_ALGOS) {
-		dev_err(&pdev->dev, "DT prop scbrr-algo-id out of range\n");
+		dev_err(&pdev->dev, "DT prop clock-algorithm out of range\n");
 		return NULL;
 	}
 	p->scbrr_algo_id = val;
@@ -2436,27 +2450,32 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	if (of_get_property(np, "renesas,autoconf", NULL))
 		p->flags |= UPF_BOOT_AUTOCONF;
 
-	prop = of_get_property(np, "renesas,regtype", NULL);
-	if (prop) {
-		val = be32_to_cpup(prop);
-		if (val < SCIx_PROBE_REGTYPE || val >= SCIx_NR_REGTYPES) {
-			dev_err(&pdev->dev, "DT prop regtype out of range\n");
-			return NULL;
-		}
-		p->regtype = val;
-	}
+	p->regtype = (unsigned int)match->data;
 
-	p->type = (unsigned int)match->data;
+	switch (p->regtype) {
+	case SCIx_SCI_REGTYPE:
+		p->type = PORT_SCI;
+		break;
+	case SCIx_SH4_SCIF_REGTYPE:
+		p->type = PORT_SCIF;
+		break;
+	case SCIx_IRDA_REGTYPE:
+		p->type = PORT_IRDA;
+		break;
+	case SCIx_SCIFA_REGTYPE:
+		p->type = PORT_SCIFA;
+		break;
+	case SCIx_SCIFB_REGTYPE:
+		p->type = PORT_SCIFB;
+		break;
+	default:
+		/* legacy register sets default to PORT_SCIF */
+		p->type = PORT_SCIF;
+		break;
+	}
 
 	return p;
 }
-#else
-static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
-								int *dev_id)
-{
-	return NULL;
-}
-#endif /* CONFIG_OF */
 
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
-- 
1.7.9.5
