From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Nov 2012 16:03:09 +1100
Subject: linux-next: manual merge of the arm-soc tree with the driver-core tree
Message-ID: <20121129160309.7dc352f433d39f1bde0018a8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/leds/leds-ns2.c between commit 98ea1ea20cb7 ("leds: remove use of
__devinit") from the driver-core tree and commit 72052fcc1026 ("leds:
leds-ns2: add device tree binding") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/leds/leds-ns2.c
index bc6a0db,d64cc22..0000000
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@@ -247,9 -260,67 +248,65 @@@ static void delete_ns2_led(struct ns2_l
  {
  	device_remove_file(led_dat->cdev.dev, &dev_attr_sata);
  	led_classdev_unregister(&led_dat->cdev);
 -	gpio_free(led_dat->cmd);
 -	gpio_free(led_dat->slow);
  }
  
+ #ifdef CONFIG_OF_GPIO
+ /*
+  * Translate OpenFirmware node properties into platform_data.
+  */
 -static int __devinit
++static int
+ ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
+ {
+ 	struct device_node *np = dev->of_node;
+ 	struct device_node *child;
+ 	struct ns2_led *leds;
+ 	int num_leds = 0;
+ 	int i = 0;
+ 
+ 	num_leds = of_get_child_count(np);
+ 	if (!num_leds)
+ 		return -ENODEV;
+ 
+ 	leds = devm_kzalloc(dev, num_leds * sizeof(struct ns2_led),
+ 			    GFP_KERNEL);
+ 	if (!leds)
+ 		return -ENOMEM;
+ 
+ 	for_each_child_of_node(np, child) {
+ 		const char *string;
+ 		int ret;
+ 
+ 		ret = of_get_named_gpio(child, "cmd-gpio", 0);
+ 		if (ret < 0)
+ 			return ret;
+ 		leds[i].cmd = ret;
+ 		ret = of_get_named_gpio(child, "slow-gpio", 0);
+ 		if (ret < 0)
+ 			return ret;
+ 		leds[i].slow = ret;
+ 		ret = of_property_read_string(child, "label", &string);
+ 		leds[i].name = (ret == 0) ? string : child->name;
+ 		ret = of_property_read_string(child, "linux,default-trigger",
+ 					      &string);
+ 		if (ret == 0)
+ 			leds[i].default_trigger = string;
+ 
+ 		i++;
+ 	}
+ 
+ 	pdata->leds = leds;
+ 	pdata->num_leds = num_leds;
+ 
+ 	return 0;
+ }
+ 
+ static const struct of_device_id of_ns2_leds_match[] = {
+ 	{ .compatible = "lacie,ns2-leds", },
+ 	{},
+ };
+ #endif /* CONFIG_OF_GPIO */
+ 
 -static int __devinit ns2_led_probe(struct platform_device *pdev)
 +static int ns2_led_probe(struct platform_device *pdev)
  {
  	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
  	struct ns2_led_data *leds_data;
@@@ -296,10 -381,11 +367,11 @@@ static int ns2_led_remove(struct platfo
  
  static struct platform_driver ns2_led_driver = {
  	.probe		= ns2_led_probe,
 -	.remove		= __devexit_p(ns2_led_remove),
 +	.remove		= ns2_led_remove,
  	.driver		= {
- 		.name	= "leds-ns2",
- 		.owner	= THIS_MODULE,
+ 		.name		= "leds-ns2",
+ 		.owner		= THIS_MODULE,
+ 		.of_match_table	= of_match_ptr(of_ns2_leds_match),
  	},
  };
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/3d6430ed/attachment.sig>
