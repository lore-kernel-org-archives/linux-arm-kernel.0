From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:19 +0800
Subject: [next,
 PATCH 5/6] usb: mtu3: reset gadget when VBUS_FALL interrupt arises
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
Message-ID: <4def1d8ab49ab7733693c037c979ea89895856df.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When VBUS_FALL interrupt arises, it means U3 device is disconnected
with host, so need reset status of gadget

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 279f9cd..eecfd06 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -668,8 +668,10 @@ static irqreturn_t mtu3_u3_ltssm_isr(struct mtu3 *mtu)
 	if (ltssm & (HOT_RST_INTR | WARM_RST_INTR))
 		mtu3_gadget_reset(mtu);
 
-	if (ltssm & VBUS_FALL_INTR)
+	if (ltssm & VBUS_FALL_INTR) {
 		mtu3_ss_func_set(mtu, false);
+		mtu3_gadget_reset(mtu);
+	}
 
 	if (ltssm & VBUS_RISE_INTR)
 		mtu3_ss_func_set(mtu, true);
-- 
1.9.1
