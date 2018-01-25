From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 25 Jan 2018 01:16:38 +0100
Subject: [RFC/RFT usb-next v1 5/6] usb: chipidea: do not set the "phy" field
 in struct usb_hcd
In-Reply-To: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
References: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180125001639.14681-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that usb_add_hcd parses all generic PHYs anyways the code which
skips initialization of a single PHY will go away.
Remove the code which sets struct usb_hcd's phy field from the chipidea
driver as this field will go away soon.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/chipidea/host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 19d60ed7e41f..fc324767cb0f 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -124,9 +124,7 @@ static int host_start(struct ci_hdrc *ci)
 
 	hcd->power_budget = ci->platdata->power_budget;
 	hcd->tpl_support = ci->platdata->tpl_support;
-	if (ci->phy)
-		hcd->phy = ci->phy;
-	else
+	if (!ci->phy)
 		hcd->usb_phy = ci->usb_phy;
 
 	ehci = hcd_to_ehci(hcd);
-- 
2.16.1
