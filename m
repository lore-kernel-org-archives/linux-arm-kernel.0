From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:29:59 +0800
Subject: [PATCH 02/15] dt-bindings: rtc: sun6i-rtc: Add compatible strings for
 pre-H6 variants
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While doing Bluetooth enablement for various boards based on various
Allwinner SoCs, minor differences in the RTC modules were found. These
include a lack of an external clock output (A31), different internal
oscillator frequencies (H3/H5/A64/V3/V3s), different regulator voltage
settings (H5/H6), and the presence of miscellaneous registers unrelated
to the RTC (A64/R40/H5/H6). The datasheet also describes different number
of registers for non-volatile storage, though based on actual experiments
the actual number is the same across the board.

This patch adds a list of all pre-H6 variants, grouped by the internal
oscillator's clock rate, regulator settings, and the presence of the
external clock output. Combinations are introduced for the variants that
have miscellaneous registers.

The RTC block in the H6 also handles the 24 MHz DCXO. This will require
more device tree binding changes and will be done later.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/rtc/sun6i-rtc.txt        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index d3e96459fc66..b1eaa443347d 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -3,7 +3,21 @@
 RTC controller for the Allwinner A31
 
 Required properties:
-- compatible	: Should be "allwinner,sun6i-a31-rtc"
+- compatible	: Should be one of the following combinations:
+		    - "allwinner,sun6i-a31-rtc"
+		    - "allwinner,sun8i-a23-rtc"
+		    - "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-r40-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun8i-v3-rtc"
+		    - "allwinner,sun50i-a64-rtc", "allwinner,sun8i-h3-rtc"
+		    - "allwinner,sun50i-h5-rtc"
+
+		  Where there are two or more compatible strings, this
+		  denotes the hardware covered by the most specific one
+		  is backward-compatible with the latter ones, and the
+		  implementation for the latter ones can be used, albeit
+		  with reduced functionality.
+
 - reg		: physical base address of the controller and length of
 		  memory mapped region.
 - interrupts	: IRQ lines for the RTC alarm 0 and alarm 1, in that order.
-- 
2.20.0.rc1
