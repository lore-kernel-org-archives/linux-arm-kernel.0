From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 3 Jan 2012 14:33:04 +1100
Subject: linux-next: manual merge of the input tree with the arm-soc tree
Message-ID: <20120103143304.eeeaf5e11021721fd02dbce8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

Today's linux-next merge of the input tree got a conflict in
drivers/input/keyboard/samsung-keypad.c between commit b3d6ac3e5f93
("input: samsung-keypad: Add device tree support") from the arm-soc tree
and commit 48c98b1bb85a ("Input: samsung-keypad - implement runtime power
management support") from the input tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/input/keyboard/samsung-keypad.c
index 8a0060c,b746fce..0000000
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@@ -20,11 -20,11 +20,13 @@@
  #include <linux/io.h>
  #include <linux/module.h>
  #include <linux/platform_device.h>
+ #include <linux/pm.h>
+ #include <linux/pm_runtime.h>
  #include <linux/slab.h>
 +#include <linux/of.h>
 +#include <linux/of_gpio.h>
  #include <linux/sched.h>
- #include <plat/keypad.h>
+ #include <linux/input/samsung-keypad.h>
  
  #define SAMSUNG_KEYIFCON			0x00
  #define SAMSUNG_KEYIFSTSCLR			0x04
@@@ -69,8 -70,8 +72,9 @@@ struct samsung_keypad 
  	void __iomem *base;
  	wait_queue_head_t wait;
  	bool stopped;
+ 	bool wake_enabled;
  	int irq;
 +	enum samsung_keypad_type type;
  	unsigned int row_shift;
  	unsigned int rows;
  	unsigned int cols;
@@@ -421,18 -318,9 +438,19 @@@ static int __devinit samsung_keypad_pro
  	keypad->row_shift = row_shift;
  	keypad->rows = pdata->rows;
  	keypad->cols = pdata->cols;
+ 	keypad->stopped = true;
  	init_waitqueue_head(&keypad->wait);
  
 +	if (pdev->dev.of_node) {
 +#ifdef CONFIG_OF
 +		samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
 +		keypad->type = of_device_is_compatible(pdev->dev.of_node,
 +					"samsung,s5pv210-keypad");
 +#endif
 +	} else {
 +		keypad->type = platform_get_device_id(pdev)->driver_data;
 +	}
 +
  	input_dev->name = pdev->name;
  	input_dev->id.bustype = BUS_HOST;
  	input_dev->dev.parent = &pdev->dev;
@@@ -471,21 -363,15 +493,21 @@@
  	if (error)
  		goto err_free_irq;
  
- 	device_init_wakeup(&pdev->dev, pdata->wakeup);
- 	platform_set_drvdata(pdev, keypad);
- 
 +	if (pdev->dev.of_node) {
 +		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
 +		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
 +		devm_kfree(&pdev->dev, (void *)pdata);
 +	}
  	return 0;
  
  err_free_irq:
  	free_irq(keypad->irq, keypad);
+ 	pm_runtime_disable(&pdev->dev);
+ 	device_init_wakeup(&pdev->dev, 0);
+ 	platform_set_drvdata(pdev, NULL);
  err_put_clk:
  	clk_put(keypad->clk);
 +	samsung_keypad_dt_gpio_free(keypad);
  err_unmap_base:
  	iounmap(keypad->base);
  err_free_mem:
@@@ -578,24 -510,14 +647,25 @@@ static int samsung_keypad_resume(struc
  
  	return 0;
  }
+ #endif
  
  static const struct dev_pm_ops samsung_keypad_pm_ops = {
- 	.suspend	= samsung_keypad_suspend,
- 	.resume		= samsung_keypad_resume,
+ 	SET_SYSTEM_SLEEP_PM_OPS(samsung_keypad_suspend, samsung_keypad_resume)
+ 	SET_RUNTIME_PM_OPS(samsung_keypad_runtime_suspend,
+ 			   samsung_keypad_runtime_resume, NULL)
  };
- #endif
  
 +#ifdef CONFIG_OF
 +static const struct of_device_id samsung_keypad_dt_match[] = {
 +	{ .compatible = "samsung,s3c6410-keypad" },
 +	{ .compatible = "samsung,s5pv210-keypad" },
 +	{},
 +};
 +MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
 +#else
 +#define samsung_keypad_dt_match NULL
 +#endif
 +
  static struct platform_device_id samsung_keypad_driver_ids[] = {
  	{
  		.name		= "samsung-keypad",
@@@ -614,10 -536,7 +684,8 @@@ static struct platform_driver samsung_k
  	.driver		= {
  		.name	= "samsung-keypad",
  		.owner	= THIS_MODULE,
 +		.of_match_table = samsung_keypad_dt_match,
- #ifdef CONFIG_PM
  		.pm	= &samsung_keypad_pm_ops,
- #endif
  	},
  	.id_table	= samsung_keypad_driver_ids,
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120103/fe937ff0/attachment.sig>
