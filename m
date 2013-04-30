From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 May 2013 02:51:27 +0400
Subject: [PATCH v7 3/9] ARM: shmobile: r8a7779: setup EHCI internal buffer
In-Reply-To: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
References: <201305010242.37483.sergei.shtylyov@cogentembedded.com>
Message-ID: <201305010251.28029.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the EHCI internal buffer (before EHCI driver has a chance to touch the
registers) using the pre_setup() method in 'struct usb_ehci_pdata'.

The patch has been tested on the Marzen board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 4:
- refreshed the patch.

Changes since version 3:
- lowercased the SoC name in the subject.

Changes since version 2:
- added #include <linux/usb/hcd.h>;
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- changed from init() platform device method to pre_setup() as per the previous
  patch.

 arch/arm/mach-shmobile/setup-r8a7779.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -33,6 +33,7 @@
 #include <linux/sh_timer.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/hcd.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
@@ -435,10 +436,25 @@ static void usb_power_off(struct platfor
 	pm_runtime_disable(&pdev->dev);
 }
 
+static int ehci_init_internal_buffer(struct usb_hcd *hcd)
+{
+	/*
+	 * Below are recommended values from the datasheet;
+	 * see [USB :: Setting of EHCI Internal Buffer].
+	 */
+	/* EHCI IP internal buffer setting */
+	iowrite32(0x00ff0040, hcd->regs + 0x0094);
+	/* EHCI IP internal buffer enable */
+	iowrite32(0x00000001, hcd->regs + 0x009C);
+
+	return 0;
+}
+
 static struct usb_ehci_pdata ehcix_pdata = {
 	.power_on	= usb_power_on,
 	.power_off	= usb_power_off,
 	.power_suspend	= usb_power_off,
+	.pre_setup	= ehci_init_internal_buffer,
 };
 
 static struct resource ehci0_resources[] = {
