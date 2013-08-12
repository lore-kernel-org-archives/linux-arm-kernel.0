From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:53 +0800
Subject: [PATCH v15 07/13] usb: chipidea: disable all interrupts and clear all
 interrupts status
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-8-git-send-email-peter.chen@freescale.com>
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
index 56294e0..8ce0c45 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -199,6 +199,12 @@ static int hw_device_init(struct ci_hdrc *ci, void __iomem *base)
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
 
@@ -434,8 +440,11 @@ static void ci_get_otg_capable(struct ci_hdrc *ci)
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
1.7.1
