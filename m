From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 13 Jun 2016 10:47:30 +0200
Subject: [PATCH] usb: gadget: udc: atmel: Also get regmap for at91sam9x5-pmc
Message-ID: <1465807650-27316-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "atmel,at91sam9g45-udc" compatible UDC is also used on at91sam9x5 so it
is also necessary to try to get the syscon for at91sam9x5-pmc.

Fixes: 4747639f01c9 ("usb: gadget: atmel: access the PMC using regmap")
Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 18569de06b04..bb1f6c8f0f01 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1920,6 +1920,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->errata = match->data;
 	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
+	if (IS_ERR(udc->pmc))
+		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
 	if (udc->errata && IS_ERR(udc->pmc))
 		return ERR_CAST(udc->pmc);
 
-- 
2.8.1
