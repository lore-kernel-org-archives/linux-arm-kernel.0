From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 10 May 2018 13:47:07 +0800
Subject: [PATCH v2 2/7] usb: mtu3: remove repeated setting of gadget state
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
Message-ID: <affcd9dfe86a0dceda1151cf7d39ce880fae14fb.1525930818.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb_add_gadget_udc() will set the gadget state as
USB_STATE_NOTATTACHED, so we needn't set it again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index f05f10f..de0de01 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -660,14 +660,10 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 	mtu3_gadget_init_eps(mtu);
 
 	ret = usb_add_gadget_udc(mtu->dev, &mtu->g);
-	if (ret) {
+	if (ret)
 		dev_err(mtu->dev, "failed to register udc\n");
-		return ret;
-	}
 
-	usb_gadget_set_state(&mtu->g, USB_STATE_NOTATTACHED);
-
-	return 0;
+	return ret;
 }
 
 void mtu3_gadget_cleanup(struct mtu3 *mtu)
-- 
1.9.1
