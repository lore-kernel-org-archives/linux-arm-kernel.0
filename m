From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:11 +0200
Subject: [PATCH v2 1/9] ASoC: alc5623: Add device tree binding
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the ALC5623 codec be instantiated from DT. Add a simple binding
for the additional control register and the jack detect register.

Also, add a prompt to the Kconfig entry for this CODEC, so that it can
be selected. Since kirkwood-t5325.c will no longer be used, we need to
be able to enable the CODEC in the mvebu_v5_defconfig etc.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
I followed the example of the WM8903 binding which allows register
values to be placed into DT.

v1->v2:

Add redundant OF ID table.
Fix binding documentation.
Fix check of return code from of_property_read_u32().
Add Kconfig prompt
---
 .../devicetree/bindings/sound/alc5623.txt          | 25 ++++++++++++++++++++++
 sound/soc/codecs/Kconfig                           |  2 +-
 sound/soc/codecs/alc5623.c                         | 20 +++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
new file mode 100644
index 000000000000..26c86c98d671
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/alc5623.txt
@@ -0,0 +1,25 @@
+ALC5621/ALC5622/ALC5623 audio Codec
+
+Required properties:
+
+ - compatible:	"realtek,alc5623"
+ - reg:		the I2C address of the device.
+
+Optional properties:
+
+ - add-ctrl:	  Default register value for Reg-40h, Additional Control
+		  Register. If absent or has the value of 0, the
+		  register is untouched.
+
+ - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
+		  Control Register. If absent or has value 0, the
+		  register is untouched.
+
+Example:
+
+	alc5621: alc5621 at 1a {
+		compatible = "alc5621";
+		reg = <0x1a>;
+		add-ctrl = <0x3700>;
+		jack-det-ctrl = <0x4810>;
+	};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f0e840137887..5fefaa8c50ef 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -269,7 +269,7 @@ config SND_SOC_AK5386
 	tristate "AKM AK5638 CODEC"
 
 config SND_SOC_ALC5623
-       tristate
+       tristate "Realtek ALC5623 CODEC"
 
 config SND_SOC_ALC5632
 	tristate
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 2acf82f4a08a..9d0755aa1d16 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -998,8 +999,10 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 {
 	struct alc5623_platform_data *pdata;
 	struct alc5623_priv *alc5623;
+	struct device_node *np;
 	unsigned int vid1, vid2;
 	int ret;
+	u32 val32;
 
 	alc5623 = devm_kzalloc(&client->dev, sizeof(struct alc5623_priv),
 			       GFP_KERNEL);
@@ -1040,6 +1043,16 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	if (pdata) {
 		alc5623->add_ctrl = pdata->add_ctrl;
 		alc5623->jack_det_ctrl = pdata->jack_det_ctrl;
+	} else {
+		if (client->dev.of_node) {
+			np = client->dev.of_node;
+			ret = of_property_read_u32(np, "add-ctrl", &val32);
+			if (!ret)
+				alc5623->add_ctrl = val32;
+			ret = of_property_read_u32(np, "jack-det-ctrl", &val32);
+			if (!ret)
+				alc5623->jack_det_ctrl = val32;
+		}
 	}
 
 	alc5623->id = vid2;
@@ -1081,11 +1094,18 @@ static const struct i2c_device_id alc5623_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);
 
+static const struct of_device_id alc5623_of_match[] = {
+	{ .compatible = "realtek,alc5623", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, alc5623_of_match);
+
 /*  i2c codec control layer */
 static struct i2c_driver alc5623_i2c_driver = {
 	.driver = {
 		.name = "alc562x-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(alc5623_of_match),
 	},
 	.probe = alc5623_i2c_probe,
 	.remove =  alc5623_i2c_remove,
-- 
2.0.0.rc0
