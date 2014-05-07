From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 May 2014 15:52:07 +0200
Subject: [PATCHv4 01/20] usb: ehci-orion: use platform_get_irq() for DT probing
In-Reply-To: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399470746-2948-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/usb/host/ehci-orion.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 30d35e5..7728e83 100644
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
1.9.2
