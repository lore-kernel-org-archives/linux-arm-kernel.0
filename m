From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:18:30 +0200
Subject: [PATCH 2/2] usb: fsl_mxc_udc.c: fix mxc_ahb_clk disable for i.MX25
In-Reply-To: <1336461510-30190-1-git-send-email-eric@eukrea.com>
References: <1336461510-30190-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461510-30190-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as i.MX35, i.MX25 doesn't have this clock so don't try to disable/put it.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 drivers/usb/gadget/fsl_mxc_udc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 8bbf673..4e30fb6 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -78,10 +78,10 @@ eclkrate:
 	clk_put(mxc_usb_clk);
 	mxc_usb_clk = NULL;
 egusb:
-	if (!cpu_is_mx35())
+	if (!cpu_is_mx35() && !cpu_is_mx25())
 		clk_disable(mxc_ahb_clk);
 eenahb:
-	if (!cpu_is_mx35())
+	if (!cpu_is_mx35() && !cpu_is_mx25())
 		clk_put(mxc_ahb_clk);
 	return ret;
 }
@@ -120,7 +120,7 @@ void fsl_udc_clk_release(void)
 		clk_disable(mxc_usb_clk);
 		clk_put(mxc_usb_clk);
 	}
-	if (!cpu_is_mx35()) {
+	if (!cpu_is_mx35() && !cpu_is_mx25()) {
 		clk_disable(mxc_ahb_clk);
 		clk_put(mxc_ahb_clk);
 	}
-- 
1.7.7.6
