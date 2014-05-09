From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 11:31:10 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140508233300.GI2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
Message-ID: <536C924E.5000307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 02:33, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140507 11:00]:
>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
>>> On 07/05/14 18:03, Tony Lindgren wrote:
>>>>
>>>> BTW, I'm also personally fine with all five gpios showing in a single
>>>> gpios property, I'm not too exited about naming anything in DT..
>>>
>>> I don't have a strong opinion here. I don't have much experience with
>>> DT, especially with making bindings compatible with other ones.
>>>
>>> I'd just forget the simple-panel, and have single gpio array.
>>
>> Well if it's a don't care flag for both of us, let's try to use
>> the existing standard for simple-panel.txt and add mode-gpios
>> property. I'll post a patch for that.
> 
> Here's an updated version using enable-gpios, reset-gpios and
> mode-gpios. So it follows simple-panel.txt and adds mode-gpios
> that's currently specific to this panel only.
> 
> Also updated for -EPROBE_DEFER handling, tested that by changing
> one of the GPIOs to be a twl4030 GPIO.

To speed things up a bit, I made the changes I suggested. Compile tested
only.


>From f8360778e8bc96096cbb1793a18a8c240376ca09 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2014 20:22:21 -0700
Subject: [PATCH] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support

Add device tree support for sharp-ls037v7dw01 panel.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../bindings/video/sharp,ls037v7dw01.txt           | 44 ++++++++++
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 95 +++++++++++++++++++++-
 2 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt

diff --git a/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
new file mode 100644
index 000000000000..2a60fd9a2607
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
@@ -0,0 +1,44 @@
+SHARP LS037V7DW01 TFT-LCD panel
+===================================
+
+Required properties:
+- compatible: "sharp,ls037v7dw01"
+
+Optional properties:
+- label: a symbolic name for the panel
+- enable-gpios: a GPIO spec for the optional enable pin
+  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
+- reset-gpios: a GPIO spec for the optional reset pin
+  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
+- mode-gpios: a GPIO
+  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
+
+Required nodes:
+- Video port for DPI input
+
+This panel can have zero to five GPIOs to configure
+to change configuration between QVGA and VGA mode
+and the scan direction. As these pins can be also
+configured with external pulls, all the GPIOs are
+considered optional with holes in the array.
+
+Example
+-------
+
+Example when connected to a omap2+ based device:
+
+lcd0: display {
+	compatible = "sharp,ls037v7dw01";
+	power-supply = <&lcd_3v3>;
+	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
index 8adde628ad38..91eeb2ec93a8 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -12,15 +12,18 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
+	struct regulator *vcc;
 
 	int data_lines;
 
@@ -95,12 +98,21 @@ static int sharp_ls_enable(struct omap_dss_device *dssdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
 
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
 
+	if (ddata->vcc) {
+		r = regulator_enable(ddata->vcc);
+		if (r != 0)
+			return r;
+	}
+
 	r = in->ops.dpi->enable(in);
-	if (r)
+	if (r) {
+		regulator_disable(ddata->vcc);
 		return r;
+	}
 
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
@@ -136,6 +148,9 @@ static void sharp_ls_disable(struct omap_dss_device *dssdev)
 
 	in->ops.dpi->disable(in);
 
+	if (ddata->vcc)
+		regulator_disable(ddata->vcc);
+
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
@@ -243,6 +258,68 @@ static int sharp_ls_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static struct gpio_desc *
+sharp_ls_get_gpio_of(struct device *dev, int index, int val, char *desc)
+{
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get_index(dev, desc, index);
+	if (IS_ERR(gpio))
+		return gpio;
+
+	gpiod_direction_output(gpio, val);
+
+	return gpio;
+}
+
+static int sharp_ls_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+
+	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
+	if (IS_ERR(ddata->vcc)) {
+		dev_err(&pdev->dev, "failed to get regulator\n");
+		return PTR_ERR(ddata->vcc);
+	}
+
+	/* lcd INI */
+	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 3, 0, "enable");
+	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd RESB */
+	ddata->resb_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "reset");
+	if (PTR_ERR(ddata->resb_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd MO */
+	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "mode");
+	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd LR */
+	ddata->lr_gpio = sharp_ls_get_gpio_of(&pdev->dev, 1, 1, "mode");
+	if (PTR_ERR(ddata->lr_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd UD */
+	ddata->ud_gpio = sharp_ls_get_gpio_of(&pdev->dev, 2, 1, "mode");
+	if (PTR_ERR(ddata->ud_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	return 0;
+}
+
 static int sharp_ls_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -259,6 +336,10 @@ static int sharp_ls_probe(struct platform_device *pdev)
 		r = sharp_ls_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = sharp_ls_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -302,12 +383,20 @@ static int __exit sharp_ls_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sharp_ls_of_match[] = {
+	{ .compatible = "omapdss,sharp,ls037v7dw01", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sharp_ls_of_match);
+
 static struct platform_driver sharp_ls_driver = {
 	.probe = sharp_ls_probe,
 	.remove = __exit_p(sharp_ls_remove),
 	.driver = {
 		.name = "panel-sharp-ls037v7dw01",
 		.owner = THIS_MODULE,
+		.of_match_table = sharp_ls_of_match,
 	},
 };
 
-- 
1.9.1


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/b5256261/attachment-0001.sig>
