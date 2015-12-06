From: alchaiken@gmail.com (alchaiken at gmail.com)
Date: Sat,  5 Dec 2015 19:30:56 -0800
Subject: [PATCH 1/2] bus: imx-weim: assert GPIO at boot in order to connect NOR
In-Reply-To: <1449372657-18496-1-git-send-email-alison_chaiken@mentor.com>
References: <1449372657-18496-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <1449372657-18496-2-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

PAD_EIM_D18 must be pulled low at boot in order for the parallel NOR
connected to the EIM switch to probe properly.  Otherwise
cfi_qry_present() may return "U-V-]" rather than "Q-R-Y" if the
PAD_EIM_D18 is high.  Add a nor-gpios property to the nor node in the
SabreAuto device-tree and add a function to the imx-weim probe to set
GPIO5 to drive the pad.

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |  1 +
 drivers/bus/imx-weim.c                   | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 8263fc1..530b4d6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -625,5 +625,6 @@
 		bank-width = <2>;
 		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
 				0x0000c000 0x1404a38e 0x00000000>;
+		nor-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index e98d15e..7b841d4 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -14,6 +14,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
 
 struct imx_weim_devtype {
 	unsigned int	cs_count;
@@ -108,6 +110,40 @@ err:
 	return -EINVAL;
 }
 
+/* set the GPIO to control PAD_EIM_D18 so cfi_qry_present() works properly */
+static int __init nor_gpio_setup(struct device_node *np, struct device *parent)
+{
+	unsigned nor_gpio, level;
+	enum of_gpio_flags of_flags;
+	int ret;
+
+	nor_gpio = of_get_named_gpio_flags(np, "nor-gpios", 0, &of_flags);
+
+	/* this child is not a NOR chip */
+	if (!nor_gpio)
+		return 0;
+
+	if (gpio_is_valid(nor_gpio)) {
+		ret = devm_gpio_request_one(parent, nor_gpio,
+					GPIOF_DIR_OUT, "nor-gpio");
+	} else {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (ret < 0)
+		goto out;
+
+	level = ((of_flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1);
+
+	gpio_set_value(nor_gpio, level);
+
+	return 0;
+out:
+	dev_err(parent, "Unable to request EIM_D18 GPIO for NOR.\n");
+	return ret;
+}
+
 /* Parse and set the timing for this device. */
 static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
@@ -154,6 +190,15 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 		if (!child->name)
 			continue;
 
+		if (of_device_is_compatible(child, "cfi-flash")) {
+			ret = nor_gpio_setup(child, &pdev->dev);
+			if (ret) {
+				dev_err(&pdev->dev, "%s gpios setup failed.\n",
+					child->full_name);
+				return ret;
+			}
+		}
+
 		ret = weim_timing_setup(child, base, devtype);
 		if (ret)
 			dev_warn(&pdev->dev, "%s set timing failed.\n",
-- 
2.6.2
