From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 12:08:09 +0200
Subject: [PATCH] spi-orion: add device tree binding
In-Reply-To: <20120723093747.GD4435@opensource.wolfsonmicro.com>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
Message-ID: <20120723100809.GC18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 528a19e9eda968cc673331d566cbfe20962d3b32 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Wed, 6 Jun 2012 19:16:28 +0200
Subject: [PATCHv3] spi-orion: add device tree binding

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
---
v2: Add interrupts properties as optional. Not used at the moment.
    Add cell-index, since some SoCs have multiple SPI busses.
v3: Rebased onto 3.5-rc7 without the refactor patch.

---
 Documentation/devicetree/bindings/spi/spi-orion.txt |   19 +++++++++++++++++++
 drivers/spi/spi-orion.c                             |   17 +++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
new file mode 100644
index 0000000..a3ff50f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -0,0 +1,19 @@
+Marvell Orion SPI device
+
+Required properties:
+- compatible : should be "marvell,orion-spi".
+- reg : offset and length of the register set for the device
+- cell-index : Which of multiple SPI controllers is this.
+Optional properties:
+- interrupts : Is currently not used.
+
+Example:
+       spi at 10600 {
+	       compatible = "marvell,orion-spi";
+	       #address-cells = <1>;
+	       #size-cells = <0>;
+	       cell-index = <0>;
+	       reg = <0x10600 0x28>;
+	       interrupts = <23>;
+	       status = "disabled";
+       };
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index dfd04e9..74312a8 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <asm/unaligned.h>
 
@@ -453,6 +454,8 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	struct orion_spi_info *spi_info;
 	unsigned long tclk_hz;
 	int status = 0;
+	const u32 *iprop;
+	int size;
 
 	spi_info = pdev->dev.platform_data;
 
@@ -464,6 +467,12 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 
 	if (pdev->id != -1)
 		master->bus_num = pdev->id;
+	if (pdev->dev.of_node) {
+		iprop = of_get_property(pdev->dev.of_node, "cell-index",
+					&size);
+		if (iprop && size == sizeof(*iprop))
+			master->bus_num = *iprop;
+	}
 
 	/* we support only mode 0, and no options */
 	master->mode_bits = 0;
@@ -511,6 +520,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	if (orion_spi_reset(spi) < 0)
 		goto out_rel_mem;
 
+	master->dev.of_node = pdev->dev.of_node;
 	status = spi_register_master(master);
 	if (status < 0)
 		goto out_rel_mem;
@@ -552,10 +562,17 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
+static const struct of_device_id orion_spi_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,orion-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
+
 static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.remove		= __exit_p(orion_spi_remove),
 };
-- 
1.7.10.4
