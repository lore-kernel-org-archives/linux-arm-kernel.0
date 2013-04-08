From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 9 Apr 2013 01:21:22 +0400
Subject: [PATCH v2 3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
Message-ID: <201304090121.23296.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the EHCI internal buffer (before EHCI driver has a chance to touch the
registers) using the pre_setup() method in 'struct usb_ehci_pdata'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since the original posting:
- changed from init() platform device method to pre_setup() as per the previous
  patch.

 arch/arm/mach-shmobile/setup-r8a7779.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -446,10 +446,25 @@ static void usb_power_off(struct platfor
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
