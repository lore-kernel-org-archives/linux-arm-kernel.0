From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 15 Jul 2010 16:10:45 +0300
Subject: [PATCH 2/3] [ARM] usb/host/ohci-pxa27x: enable OHCI over U2DC
In-Reply-To: <1279199446-30526-1-git-send-email-grinberg@compulab.co.il>
References: <1279199446-30526-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1279199446-30526-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U2D Controller of pxa3xx is able to work in host mode.
Make pxa specific ohci implementation aware of it.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/usb/host/ohci-pxa27x.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index a18debd..7ca7f4c 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <mach/ohci.h>
+#include <mach/pxa3xx-u2d.h>
 
 /*
  * UHC: USB Host Controller (OHCI-like) register definitions
@@ -235,6 +236,9 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
 	if (retval < 0)
 		return retval;
 
+	if (cpu_is_pxa3xx())
+		pxa3xx_u2d_start_hc(&ohci_to_hcd(&ohci->ohci)->self);
+
 	uhchr = __raw_readl(ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
 	__raw_writel(uhchr, ohci->mmio_base + UHCHR);
 	__raw_writel(UHCHIE_UPRIE | UHCHIE_RWIE, ohci->mmio_base + UHCHIE);
@@ -251,6 +255,9 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
 
 	inf = dev->platform_data;
 
+	if (cpu_is_pxa3xx())
+		pxa3xx_u2d_stop_hc(&ohci_to_hcd(&ohci->ohci)->self);
+
 	if (inf->exit)
 		inf->exit(dev);
 
-- 
1.7.1
