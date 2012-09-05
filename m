From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 10:34:52 +0900
Subject: [PATCH 2/3] ARM: shmobile: mackerel: fixup usb module order
In-Reply-To: <1346808893-14124-1-git-send-email-horms@verge.net.au>
References: <1346808893-14124-1-git-send-email-horms@verge.net.au>
Message-ID: <1346808893-14124-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

renesas_usbhs driver can play role as both Host and Gadget.
In case of Gadget, it requires not only renesas_usbhs
but also usb gadget module (like g_ether).
So, renesas_usbhs driver calls usb_add_gadget_udc() on probe time.

Because of this behavior,
Host port plays also Gadget role if kernel has both Host/Gadget support.

In mackerel case, from 0ada2da51800a4914887a9bcf22d563be80e50be
(ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd)
usb0 plays Gadget role, and usb1 plays Host role,
and current mackerel board probes as usb1 -> usb0.
Thus, 1st installed usb gadget module (like g_ether) will be
assigned to usb1 (= usb Host port), and 2nd module to usb0 (= usb Gadget port).
It is very confusable for user.
This patch fixup usb modes probing order as usb0 -> usb1.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7ea2b31..c129542 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -695,6 +695,7 @@ static struct platform_device usbhs0_device = {
  *  - J30 "open"
  *  - modify usbhs1_get_id() USBHS_HOST -> USBHS_GADGET
  *  - add .get_vbus = usbhs_get_vbus in usbhs1_private
+ *  - check usbhs0_device(pio)/usbhs1_device(irq) order in mackerel_devices.
  */
 #define IRQ8 evt2irq(0x0300)
 #define USB_PHY_MODE		(1 << 4)
@@ -1325,8 +1326,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
-	&usbhs1_device,
 	&usbhs0_device,
+	&usbhs1_device,
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
-- 
1.7.10.4
