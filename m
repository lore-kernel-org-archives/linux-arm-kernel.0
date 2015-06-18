From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 17 Jun 2015 18:00:40 -0700
Subject: [PATCH v3 1/4] gpio: brcmstb: fix null ptr dereference in driver
 remove
In-Reply-To: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1434589243-502-2-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a failure occurs during probe, brcmstb_gpio_remove() is called. In
remove, we call platform_get_drvdata(), but at the time of failure in
the probe the driver data hadn't yet been set which leads to a NULL
ptr dereference in the remove's list_for_each.  Call
platform_set_drvdata() and set up list head right after allocating the
priv struct to both avoid the null pointer dereference that could
occur today.  To guard against potential future changes, check for
null pointer in remove.

Reported-by: Tim Ross <tross@broadcom.com>
Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
New in v3.

 drivers/gpio/gpio-brcmstb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 7a3cb1f..4630a81 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -87,6 +87,15 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 	struct brcmstb_gpio_bank *bank;
 	int ret = 0;
 
+	if (!priv) {
+		dev_err(&pdev->dev, "called %s without drvdata!\n", __func__);
+		return -EFAULT;
+	}
+
+	/*
+	 * You can lose return values below, but we report all errors, and it's
+	 * more important to actually perform all of the steps.
+	 */
 	list_for_each(pos, &priv->bank_list) {
 		bank = list_entry(pos, struct brcmstb_gpio_bank, node);
 		ret = bgpio_remove(&bank->bgc);
@@ -143,6 +152,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+	INIT_LIST_HEAD(&priv->bank_list);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg_base = devm_ioremap_resource(dev, res);
@@ -153,7 +164,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
 
-	INIT_LIST_HEAD(&priv->bank_list);
 	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
 		return -EINVAL;
 
@@ -221,8 +231,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
 			priv->num_banks, priv->gpio_base, gpio_base - 1);
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 
 fail:
-- 
1.9.1
