From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:51 +0900
Subject: [PATCH 21/34] ARM: shmobile: lager: enable USB3.0
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <37f7c1b0c1ed9465b2e2609ba57bba8a874ddd3c.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the PHY of USB3.0 and EHCI/OHCI ch2 are the same, the USB3.0
driver cannot use the phy driver when the EHCI/OHCI ch2 already used it:

phy phy-e6590100.usb-phy.3: phy init failed --> -16
xhci-hcd: probe of ee000000.usb failed with error -16

If so, we have to unbind the EHCI/OHCI ch2, and then we have to bind
the USB3.0 driver as the following:

  echo 0000:02:02.0 > /sys/bus/pci/drivers/ehci-pci/unbind
  echo 0000:02:01.0 > /sys/bus/pci/drivers/ohci-pci/unbind
  echo ee000000.usb > /sys/bus/platform/drivers/xhci-hcd/bind

Note that there will be pinctrl-related error messages if both
internal PCI and USB3.0 are enabled but they should be just ignored:

sh-pfc e6060000.pfc: pin GP_5_22 already requested by ee0d0000.pci; cannot claim for ee000000.usb
sh-pfc e6060000.pfc: pin-182 (ee000000.usb) status -22
ata1: SATA link down (SStatus 0 SControl 300)
sh-pfc e6060000.pfc: could not request pin 182 (GP_5_22) from group usb2  on device sh-pfc

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e96f952..d869f2a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -466,6 +466,12 @@
 	pinctrl-names = "default";
 };
 
+&xhci {
+	status = "okay";
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+};
+
 &pci2 {
 	status = "okay";
 	pinctrl-0 = <&usb2_pins>;
-- 
2.1.1
