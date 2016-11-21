From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Nov 2016 22:03:00 +0530
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <a309a738-7fa7-3aab-4457-f7d693e6b37f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 October 2016 08:15 PM, Bartosz Golaszewski wrote:
> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
> +{
> +	const struct da8xx_ddrctl_config_knob *knob;
> +	const struct da8xx_ddrctl_setting *setting;
> +	struct device_node *node;
> +	struct resource *res;
> +	void __iomem *ddrctl;
> +	struct device *dev;
> +	u32 reg;
> +
> +	dev = &pdev->dev;
> +	node = dev->of_node;
> +
> +	setting = da8xx_ddrctl_get_board_settings();
> +	if (!setting) {
> +		dev_err(dev, "no settings for board '%s'\n",
> +			of_flat_dt_get_machine_name());
> +		return -EINVAL;
> +	}

This causes a section mismatch because of_flat_dt_get_machine_name() 
has an __init annotation. I did not notice that before, sorry.

It can be fixed with a patch like below:

---8<---
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index a20e7bbbcbe0..9ca5aab3ac54 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -102,6 +102,18 @@ static const struct da8xx_ddrctl_setting *da8xx_ddrctl_get_board_settings(void)
 	return NULL;
 }
 
+static const char* da8xx_ddrctl_get_machine_name(void)
+{
+	const char *str;
+	int ret;
+
+	ret = of_property_read_string(of_root, "model", &str);
+	if (ret)
+		ret = of_property_read_string(of_root, "compatible", &str);
+
+	return str;
+}
+
 static int da8xx_ddrctl_probe(struct platform_device *pdev)
 {
 	const struct da8xx_ddrctl_config_knob *knob;
@@ -118,7 +130,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
 	setting = da8xx_ddrctl_get_board_settings();
 	if (!setting) {
 		dev_err(dev, "no settings for board '%s'\n",
-			of_flat_dt_get_machine_name());
+			da8xx_ddrctl_get_machine_name());
 		return -EINVAL;
 	}
---8<--- 

A similar fix is required for the other driver in this series (patch 
2/5). I need some advise on whether I should introduce a common 
function to get the machine name post kernel boot-up (I cannot see an 
existing one). If yes, any advise on which file it should go into?

Thanks,
Sekhar
