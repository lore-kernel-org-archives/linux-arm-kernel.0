From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 17:53:10 +0200
Subject: [PATCH 1/5] ASoC: alc5623: Add device tree binding
In-Reply-To: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397749994-24983-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the ALC5623 codec be instantiated from DT. Add a simple binding
for the additional control register and the jack detect register.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
I followed the example of the WM8903 binding which allows register
values to be placed into DT.
---
 .../devicetree/bindings/sound/alc5623.txt          | 23 ++++++++++++++++++++++
 sound/soc/codecs/alc5623.c                         | 13 ++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
new file mode 100644
index 000000000000..f7f71346e338
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/alc5623.txt
@@ -0,0 +1,23 @@
+ALC5621/ALC5622/ALC5623 audio Codec
+
+Required properties:
+
+ - compatible:	"realtek,alc5623"
+ - reg:		the I2C address of the device.
+
+Optional properties:
+
+  - add-ctrl:	Default register value for Reg-40h, Additional Control Register.
+		If absent, the default is 0.
+
+  - jack-det-ctrl:	Default register value for Reg-5Ah, Jack Detect
+			Control Register. If absent, the default is 0.
+
+Example:
+
+			alc5621: alc5621 at 1a {
+				compatible = "alc5621";
+				reg = <0x1a>;
+				add-ctrl = <0x3700>;
+				jack-det-ctrl = <0x4810>;
+			};
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 2acf82f4a08a..1f9273d20b39 100644
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
+			if (ret >= 0)
+				alc5623->add_ctrl = val32;
+			ret = of_property_read_u32(np, "jack-det-ctrl", &val32);
+			if (ret >= 0)
+				alc5623->jack_det_ctrl = val32;
+		}
 	}
 
 	alc5623->id = vid2;
-- 
1.9.2
