From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 6 Feb 2017 17:13:37 +0800
Subject: [PATCH v12 5/9] usb: ehci: fsl: use bus->sysdev for DMA configuration
In-Reply-To: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1486372421-29073-6-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

For the dual role ehci fsl driver, sysdev will handle the dma
config.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/ehci-fsl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 3733aab..4a08b70 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -96,8 +96,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 	}
 	irq = res->start;
 
-	hcd = usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev,
-				dev_name(&pdev->dev));
+	hcd = __usb_create_hcd(&fsl_ehci_hc_driver, pdev->dev.parent,
+			       &pdev->dev, dev_name(&pdev->dev), NULL);
 	if (!hcd) {
 		retval = -ENOMEM;
 		goto err1;
-- 
2.7.4
