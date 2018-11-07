From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:12:54 +0800
Subject: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Bluetooth controllers can take up to two external clocks:
an external frequency reference, substituting the main crystal, and a
LPO clock at 32.768 kHz substituting the internal LPO clock.

In particular, the external LPO clock must be used when the controller
does not have NVRAM connected, and the main reference frequency is not
the default 20 MHz. This is described in detail in the datasheet.

The original "extclk" clock name is ambiguous as to which of these it
refers to, and some designs might even require both.

This patch deprecates the existing name, and adds "txco" and "lpo".

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e6ee6..2535e54219af 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -18,7 +18,10 @@ Optional properties:
  - shutdown-gpios: GPIO specifier, used to enable the BT module
  - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
  - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
- - clocks: clock specifier if external clock provided to the controller
+ - clocks and clock-names: clock specifier if external clocks are provided
+   - "txco": external reference clock
+   - "extclk": deprecated, replaced by "txco"
+   - "lpo": external low power 32.768 kHz clock
  - clock-names: should be "extclk"
 
 
-- 
2.19.1
