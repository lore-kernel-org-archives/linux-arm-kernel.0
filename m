From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 21 Sep 2017 10:44:13 +0530
Subject: [PATCH v2 1/2] gpio: brcmstb: Handle return value of devm_kasprintf
Message-ID: <1cfed20c00d642a34d8f93c5e9591412d387fa2a.1505970542.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
		Set return 'err' to -ENOMEM.

 drivers/gpio/gpio-brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index dd0308c..27e92e5 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -485,6 +485,10 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		gc->of_node = np;
 		gc->owner = THIS_MODULE;
 		gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
+		if (!gc->label) {
+			err = -ENOMEM;
+			goto fail;
+		}
 		gc->base = gpio_base;
 		gc->of_gpio_n_cells = 2;
 		gc->of_xlate = brcmstb_gpio_of_xlate;
-- 
1.9.1
