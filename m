From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 Jul 2016 17:03:50 +0200
Subject: [PATCH v2] dt: bindings: Make compatible optional for mmc function
 nodes
Message-ID: <1469891030-28838-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some boards (android tablets) different batches use different sdio
wifi modules. This is not a problem since mmc/sdio is an enumerable bus,
so we only need to describe and activate the mmc controller in dt and
then the kernel will automatically load the right driver.

Sometimes it is useful to specify certain ethernet properties for these
"unknown" sdio devices, specifically we want the boot-loader to be able
to set "local-mac-address" as some of these sdio wifi modules come without
an eeprom / without a factory programmed mac address.

Since the exact device is unknown (differs per batch) we cannot use
a wifi-chip specific compatible, thus sometimes it is desirable to have a
mmc function node, without having to make up an otherwise unused compatible
for the node, so make the compatible property optional.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Change the commit-msg to explain why it sometimes is desirable to have a
 mmc function node without a compatible
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index ed23b9b..a96c338 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -98,11 +98,13 @@ Required host node properties when using function subnodes:
 - #size-cells: should be zero.
 
 Required function subnode properties:
-- compatible: name of SDIO function following generic names recommended practice
 - reg: Must contain the SDIO function number of the function this subnode
        describes. A value of 0 denotes the memory SD function, values from
        1 to 7 denote the SDIO functions.
 
+Optional function subnode properties:
+- compatible: name of SDIO function following generic names recommended practice
+
 
 Examples
 --------
-- 
2.7.4
