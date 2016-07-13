From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 13 Jul 2016 12:20:04 +0200
Subject: [PATCH] dt: bindings: Add a generic ethernet device binding
Message-ID: <1468405204-5845-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards (android tablets) different batches use different sdio
wifi modules. This is not a problem since sdio is a discoverable bus,
so we only need to describe and activate the mmc controller in dt and
then the kernel will automatically load the right driver.

But sometimes it is useful to specify certain ethernet properties for
these "unknown" sdio devices, specifically we want the boot-loader
to be able to set "local-mac-address" as some of these sdio wifi
modules come without an eeprom / without a factory programmed mac
address.

Since the exact device is unknown (differs per batch) we cannot use
a wifi-chip specific compatible. This commit adds a new
"generic,ethernet" binding for use in dt-nodes describing such an
unknown ethernet device.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/net/generic.txt | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/generic.txt

diff --git a/Documentation/devicetree/bindings/net/generic.txt b/Documentation/devicetree/bindings/net/generic.txt
new file mode 100644
index 0000000..2325709
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/generic.txt
@@ -0,0 +1,30 @@
+* Generic ethernet controller
+
+This binding is for ethernet devices which need a dt node so that certain
+standard properties, e.g. a mac-address can be specified via dt, but
+otherwise can be detected automatically as they are on a discoverable bus.
+
+Required properties:
+- compatible: should be "generic,ethernet"
+
+Optional properties:
+- See bindings/ethernet.txt
+
+Example:
+
+/ {
+	aliases {
+		/* Make u-boot set mac-address for the sdio-wifi (no eeprom) */
+		ethernet0 = &sdio_wifi;
+	};
+};
+
+&mmc1 {
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: sdio_wifi at 1 {
+		compatible = "generic,ethernet"
+		reg = <1>;
+	};
+};
-- 
2.7.4
