From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 13 Mar 2017 10:18:45 +0800
Subject: [PATCH 5/5] usb: ehci: use bus->sysdev for DMA configuration
In-Reply-To: <1489371525-18928-1-git-send-email-peter.chen@nxp.com>
References: <1489371525-18928-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1489371525-18928-6-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the dma for ehci from sysdev. The sysdev is pointing to device that
is known to the system firmware or hardware.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 4de4301..9b7e639 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -138,7 +138,7 @@ static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 	ehci->sitd_pool = NULL;
 
 	if (ehci->periodic)
-		dma_free_coherent (ehci_to_hcd(ehci)->self.controller,
+		dma_free_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof (u32),
 			ehci->periodic, ehci->periodic_dma);
 	ehci->periodic = NULL;
@@ -155,7 +155,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* QTDs for control/bulk/intr transfers */
 	ehci->qtd_pool = dma_pool_create ("ehci_qtd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_qtd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -165,7 +165,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* QHs for control/bulk/intr transfers */
 	ehci->qh_pool = dma_pool_create ("ehci_qh",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof(struct ehci_qh_hw),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -179,7 +179,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* ITD for high speed ISO transfers */
 	ehci->itd_pool = dma_pool_create ("ehci_itd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_itd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -189,7 +189,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* SITD for full/low speed split ISO transfers */
 	ehci->sitd_pool = dma_pool_create ("ehci_sitd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_sitd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -199,7 +199,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* Hardware periodic table */
 	ehci->periodic = (__le32 *)
-		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
+		dma_alloc_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof(__le32),
 			&ehci->periodic_dma, flags);
 	if (ehci->periodic == NULL) {
-- 
2.7.4
