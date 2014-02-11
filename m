From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 17:35:28 +0100
Subject: [PATCH v2 1/2] ohci-platform: Change compatible string from usb-ohci
 to generic-ohci
In-Reply-To: <1392136529-5060-1-git-send-email-hdegoede@redhat.com>
References: <1392136529-5060-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392136529-5060-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial versions of the devicetree enablement patches for ohci-platform
used "ohci-platform" as compatible string. However this was disliked by various
reviewers because the platform bus is a Linux invention and devicetree is
supposed to be OS agnostic. After much discussion I gave up and went with
the generic usb-ohci as requested.

In retro-spect I should have chosen something different, the dts files for many
existing boards already claim to be compatible with "usb-ohci", ie they have:

	compatible = "ti,ohci-omap3", "usb-ohci";

In theory this should not be a problem since the "ti,ohci-omap3" entry takes
presedence, but in practice using a conflicting compatible string is an issue,
because it makes which driver gets used depend on driver registration order.

This patch changes the compatible string claimed by ohci-platform to
"generic-ohci", avoiding the driver registration / module loading ordering
problems.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/usb/usb-ohci.txt | 4 ++--
 drivers/usb/host/ohci-platform.c                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
index 6933b0c..45f67d9 100644
--- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
@@ -1,7 +1,7 @@
 USB OHCI controllers
 
 Required properties:
-- compatible : "usb-ohci"
+- compatible : "generic-ohci"
 - reg : ohci controller register range (address and length)
 - interrupts : ohci controller interrupt
 
@@ -16,7 +16,7 @@ Optional properties:
 Example:
 
 	ohci0: usb at 01c14400 {
-		compatible = "allwinner,sun4i-a10-ohci", "usb-ohci";
+		compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 		reg = <0x01c14400 0x100>;
 		interrupts = <64>;
 		clocks = <&usb_clk 6>, <&ahb_gates 2>;
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index e2c28fd..b6ca0b2 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -319,7 +319,7 @@ static int ohci_platform_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct of_device_id ohci_platform_ids[] = {
-	{ .compatible = "usb-ohci", },
+	{ .compatible = "generic-ohci", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ohci_platform_ids);
-- 
1.8.5.3
