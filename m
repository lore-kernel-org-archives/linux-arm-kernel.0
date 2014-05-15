From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:26 +0200
Subject: [PATCH v6 01/17] usb: ehci-orion: use platform_get_irq() for DT
 probing
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Commit 77dae54ab385033e488d8b07045bc7f8d931740f ('ARM: Kirkwood:
ehci-orion: Add device tree binding') added the Device Tree binding
for the ehci-orion driver. To achieve that with the irq, it used the
irq_of_parse_and_map() function when probed in DT-mode, and
platform_get_irq() when probed in non-DT mode.

This is not necessary: platform_get_irq() works just as fine in
DT-mode, since the conversion from DT information to 'struct resource'
is done by the generic layers of the kernel.

Therefore, this commit switches back to use just platform_get_irq().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-orion.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 30d35e5e503a..7728e83007a7 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -154,10 +154,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 
 	pr_debug("Initializing Orion-SoC USB Host Controller\n");
 
-	if (pdev->dev.of_node)
-		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	else
-		irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(&pdev->dev,
 			"Found HC with no IRQ. Check %s setup!\n",
-- 
1.8.1.2
