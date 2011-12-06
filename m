From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Tue,  6 Dec 2011 16:37:46 +0530
Subject: [PATCH] USB: pxa168: Fix compilation error
In-Reply-To: <no>
References: <no>
Message-ID: <1323169667-10671-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit c430131a02d677aa708f56342c1565edfdacb3c0,
HC_LENGTH takes two arguments. This patch fixes following
compilation error:

In file included from drivers/usb/host/ehci-hcd.c:1323:
drivers/usb/host/ehci-pxa168.c:302:54: error: macro "HC_LENGTH" requires 2 arguments, but only 1 given
In file included from drivers/usb/host/ehci-hcd.c:1323:
drivers/usb/host/ehci-pxa168.c: In function 'ehci_pxa168_drv_probe':
drivers/usb/host/ehci-pxa168.c:302: error: 'HC_LENGTH' undeclared (first use in this function)
drivers/usb/host/ehci-pxa168.c:302: error: (Each undeclared identifier is reported only once
drivers/usb/host/ehci-pxa168.c:302: error: for each function it appears in.)

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/usb/host/ehci-pxa168.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-pxa168.c b/drivers/usb/host/ehci-pxa168.c
index ac0c16e..8d0e7a2 100644
--- a/drivers/usb/host/ehci-pxa168.c
+++ b/drivers/usb/host/ehci-pxa168.c
@@ -299,7 +299,7 @@ static int __devinit ehci_pxa168_drv_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs + 0x100;
 	ehci->regs = hcd->regs + 0x100 +
-		HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
 	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
 	hcd->has_tt = 1;
 	ehci->sbrn = 0x20;
-- 
1.7.0.4
