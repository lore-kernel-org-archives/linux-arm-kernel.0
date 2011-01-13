From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 13 Jan 2011 10:06:15 +0100
Subject: [PATCH] unbreak ehci-mxc on otg port of i.MX27
Message-ID: <1294909575-32709-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 711669e5b80b6f2d88f61ed8a9681f83d8cbd201 fixed port 0 support
for i.MX51 but broke it for (at least) i.MX27 which doesn't have
a usb_phy1 clock but has a pdev->id 0.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/host/ehci-mxc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index fa59b26..18eb597 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -178,7 +178,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* "dr" device has its own clock */
-	if (pdev->id == 0) {
+	if ((cpu_is_mx51()) & (pdev->id == 0)) {
 		priv->phy1clk = clk_get(dev, "usb_phy1");
 		if (IS_ERR(priv->phy1clk)) {
 			ret = PTR_ERR(priv->phy1clk);
-- 
1.7.3.4
