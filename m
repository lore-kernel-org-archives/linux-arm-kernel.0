From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 26 Jul 2013 17:18:24 +0800
Subject: [PATCH v13 08/14] usb: chipidea: disable all interrupts and clear all
 interrupts status
In-Reply-To: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1374830310-21765-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the initialization, it needs to disable all interrupts
enable bit as well as clear all interrupts status bits to avoid
exceptional interrupt.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 28983c3..8884af6 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -198,6 +198,12 @@ static int hw_device_init(struct ci_hdrc *ci, void __iomem *base)
 	if (ci->hw_ep_max > ENDPT_MAX)
 		return -ENODEV;
 
+	/* Disable all interrupts bits */
+	hw_write(ci, OP_USBINTR, 0xffffffff, 0);
+
+	/* Clear all interrupts status bits*/
+	hw_write(ci, OP_USBSTS, 0xffffffff, 0xffffffff);
+
 	dev_dbg(ci->dev, "ChipIdea HDRC found, lpm: %d; cap: %p op: %p\n",
 		ci->hw_bank.lpm, ci->hw_bank.cap, ci->hw_bank.op);
 
@@ -413,8 +419,11 @@ static void ci_get_otg_capable(struct ci_hdrc *ci)
 		ci->is_otg = (hw_read(ci, CAP_DCCPARAMS,
 				DCCPARAMS_DC | DCCPARAMS_HC)
 					== (DCCPARAMS_DC | DCCPARAMS_HC));
-	if (ci->is_otg)
+	if (ci->is_otg) {
 		dev_dbg(ci->dev, "It is OTG capable controller\n");
+		ci_disable_otg_interrupt(ci, OTGSC_INT_EN_BITS);
+		ci_clear_otg_interrupt(ci, OTGSC_INT_STATUS_BITS);
+	}
 }
 
 static int ci_hdrc_probe(struct platform_device *pdev)
-- 
1.7.0.4
