From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 15:10:26 +0100
Subject: [PATCH 2/2] ehci-platform: Change compatible string from usb-ehci to
 ehci-platform
In-Reply-To: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
References: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392127826-31290-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial versions of the devicetree enablement patches for ehci-platform
used "ehci-platform" as compatible string. However this was disliked by various
reviewers because the platform bus is a Linux invention and devicetree is
supposed to be OS agnostic. After much discussion I gave up, added a:
"depends on !PPC_OF" to Kconfig to avoid a known conflict with PPC-OF platforms
and went with the generic usb-ehci as requested.

In retro-spect I should have stuck to my guns, because the dts files for many
existing boards already claim to be compatible with "usb-ehci", ie they have:

	compatible = "ti,ehci-omap", "usb-ehci";

In theory this should not be a problem since the "ti,ehci-omap" entry takes
presedence, but in practice using a conflicting compatible string is an issue,
because it makes which driver gets used depent on driver registration order.

This patch changes the compatible string claimed by ehci-platform (back) to
"ehci-platform", avoiding the driver registration / module loading ordering
problems, and removes the "depends on !PPC_OF" workaround.

Note that there already is a precedent for using ?hci-platform, in the form
of xhci-platform.c using "xhci-platfrom" as compatible string.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt | 4 ++--
 drivers/usb/host/Kconfig                           | 1 -
 drivers/usb/host/ehci-platform.c                   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 2c1aeeb..46f428a 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -1,7 +1,7 @@
 USB EHCI controllers
 
 Required properties:
-  - compatible : should be "usb-ehci".
+  - compatible : should be "ehci-platform".
   - reg : should contain at least address and length of the standard EHCI
     register set for the device. Optional platform-dependent registers
     (debug-port or other) can be also specified here, but only after
@@ -27,7 +27,7 @@ Example (Sequoia 440EPx):
 
 Example (Allwinner sun4i A10 SoC):
    ehci0: usb at 01c14000 {
-	   compatible = "allwinner,sun4i-a10-ehci", "usb-ehci";
+	   compatible = "allwinner,sun4i-a10-ehci", "ehci-platform";
 	   reg = <0x01c14000 0x100>;
 	   interrupts = <39>;
 	   clocks = <&ahb_gates 1>;
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index e28cbe0..a9707da 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -255,7 +255,6 @@ config USB_EHCI_ATH79
 
 config USB_EHCI_HCD_PLATFORM
 	tristate "Generic EHCI driver for a platform device"
-	depends on !PPC_OF
 	default n
 	---help---
 	  Adds an EHCI host driver for a generic platform device, which
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 8fde649..4f4d78f 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -333,7 +333,7 @@ static int ehci_platform_resume(struct device *dev)
 static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
-	{ .compatible = "usb-ehci", },
+	{ .compatible = "ehci-platform", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
1.8.5.3
