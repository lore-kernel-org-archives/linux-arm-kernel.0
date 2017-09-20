From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 12:43:09 +0530
Subject: [PATCH 2/2] gpio: tb10x: Handle return value of devm_kasprintf
In-Reply-To: <1505891589-6632-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505891589-6632-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1505891589-6632-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpio/gpio-tb10x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 091ffaa..ac6f2a9 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -193,6 +193,9 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 
 	tb10x_gpio->gc.label		=
 		devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOF", pdev->dev.of_node);
+	if (!tb10x_gpio->gc.label)
+		return -ENOMEM;
+
 	tb10x_gpio->gc.parent		= &pdev->dev;
 	tb10x_gpio->gc.owner		= THIS_MODULE;
 	tb10x_gpio->gc.direction_input	= tb10x_gpio_direction_in;
-- 
1.9.1
