From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 10 Sep 2018 22:12:49 +0200
Subject: [PATCH] usb: gadget: udc: atmel: handle at91sam9rl PMC
Message-ID: <20180910201249.23036-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9rl PMC is not quite the same as the at91sam9g45 one and now has
its own compatible string. Add support for that.

Fixes: 217bace8e548 ("ARM: dts: fix PMC compatible")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 17147b8c771e..8f267be1745d 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2017,6 +2017,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->errata = match->data;
 	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (IS_ERR(udc->pmc))
+		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9rl-pmc");
 	if (IS_ERR(udc->pmc))
 		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
 	if (udc->errata && IS_ERR(udc->pmc))
-- 
2.19.0.rc2
