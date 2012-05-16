From: marex@denx.de (Marek Vasut)
Date: Wed, 16 May 2012 03:14:45 +0200
Subject: [PATCH] usb: chipidea: improve the validation of endpoint count
In-Reply-To: <1337090303-16046-3-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337130885-32118-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The endpoint count is zero for host-only controller. On the other hand,
the endpoint count is non-zero for OTG capable controller.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Richard Zhao <richard.zhao@freescale.com>
Cc: alexander.shishkin at linux.intel.com
Cc: B20596 at freescale.com
Cc: B29397 at freescale.com
Cc: dong.aisheng at linaro.org
Cc: fabio.estevam at freescale.com
Cc: gregkh at linuxfoundation.org
Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: marex at denx.de
Cc: shawn.guo at linaro.org
To: linux-usb at vger.kernel.org
---
 drivers/usb/chipidea/core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f568b8e..b29a204 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -174,6 +174,7 @@ u8 hw_port_test_get(struct ci13xxx *ci)
 static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 {
 	u32 reg;
+	int dc;
 
 	/* bank is a module variable */
 	ci->hw_bank.abs = base;
@@ -195,7 +196,12 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 		ffs_nr(DCCPARAMS_DEN);
 	ci->hw_ep_max = reg * 2;   /* cache hw ENDPT_MAX */
 
-	if (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX)
+	dc = hw_read(ci, CAP_DCCPARAMS, DCCPARAMS_DC);
+
+	if (dc && (ci->hw_ep_max == 0 || ci->hw_ep_max > ENDPT_MAX))
+		return -ENODEV;
+
+	if (!dc && (ci->hw_ep_max != 0))
 		return -ENODEV;
 
 	dev_dbg(ci->dev, "ChipIdea HDRC found, lpm: %d; cap: %p op: %p\n",
-- 
1.7.10
