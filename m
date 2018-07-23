From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:52:55 +0200
Subject: [RFT v2 03/10] pinctrl: samsung: Document hidden requirement about
 one external wakeup
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Message-ID: <20180723175302.22535-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware (S5Pv210 and all Exynos SoCs) provides only 32 external
interrupts which can wakeup device from deep sleep modes.  On S5Pv210
these are gph0-gph3.  On all Exynos designs these are gpx0-gpx3.
There is only one 32-bit register for controlling the external wakeup
interrupt mask (masking and unmasking waking capability of these
interrupts).

This lead to implementation in pinctrl driver and machine code which was
using static memory for storing the mask value and not caring about
multiple devices of pin controller... because only one pin controller
device will be handling this.

Since each pin controller node in Device Tree maps onto one device, this
corresponds to hidden assumption in parsing the Device Tree: external
wakeup interrupts can be defined only once.  Make this assumption an
explicit requirement.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 5e00a21de2bf..f7700c9e0d0b 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -145,8 +145,13 @@ A. External GPIO Interrupts: For supporting external gpio interrupts, the
 
 B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
    child node representing the external wakeup interrupt controller should be
-   included in the pin-controller device node. This child node should include
-   the following properties.
+   included in the pin-controller device node.
+
+   Only one pin-controller device node can include external wakeup interrupts
+   child node (in other words, only one External Wakeup Interrupts
+   pin-controller is supported).
+
+   This child node should include following properties:
 
    - compatible: identifies the type of the external wakeup interrupt controller
      The possible values are:
-- 
2.14.1
