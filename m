From: 21cnbao@gmail.com (21cnbao at gmail.com)
Date: Tue,  4 Jun 2013 20:17:57 +0800
Subject: [PATCH] usb: chipidea: udc: fix potential kernel panic
In-Reply-To: <y>
References: <y>
Message-ID: <1370348277-24709-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rong Wang <Rong.Wang@csr.com>

If global_phy is used when CONFIG_USB_PHY is not defined,
usb_get_phy() returns ERR_PTR(-ENXIO). If we only check
ci->transceiver is NULL or not in vbus_draw callback, it
will return true and continue to dereference ERR_PTR(-ENXIO)
which will cause a kernel panic.

Tested on CSR SiRFatlasVI SoC platform which licensed chipidea.

Signed-off-by: Rong Wang <Rong.Wang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/usb/chipidea/udc.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 519ead2..822194b 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1392,7 +1392,7 @@ static int ci13xxx_vbus_draw(struct usb_gadget *_gadget, unsigned mA)
 {
 	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);
 
-	if (ci->transceiver)
+	if (!IS_ERR_OR_NULL(ci->transceiver))
 		return usb_phy_set_power(ci->transceiver, mA);
 	return -ENOTSUPP;
 }
@@ -1682,8 +1682,9 @@ static int udc_start(struct ci13xxx *ci)
 		ci->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
 
 	if (ci->platdata->flags & CI13XXX_REQUIRE_TRANSCEIVER) {
-		if (ci->transceiver == NULL) {
-			retval = -ENODEV;
+		if (IS_ERR_OR_NULL(ci->transceiver)) {
+			retval = ci->transceiver ?
+				PTR_ERR(ci->transceiver) : -ENODEV;
 			goto destroy_eps;
 		}
 	}
-- 
1.7.5.4
