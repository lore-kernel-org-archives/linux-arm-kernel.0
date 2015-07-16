From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 16 Jul 2015 17:27:51 +0200
Subject: [PATCH 4/7] Documentation: mtd: add a DT property to set the latency
 code of Spansion memory
In-Reply-To: <cover.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <398ca9f17bda638e05e97f258fb4e6d27ac828db.1437059658.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the SPI controller and the NOR flash memory need to agree on the
number of dummy cycles to use for Fast Read commands. For Spansion
memories, this number of dummy cycles is not given directly but through a
so called "latency code".
The latency code can be found into the memory datasheet and depends on the
SPI clock frequency, the Fast Read op code and the Single/Dual Data Rate
mode.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 .../devicetree/bindings/mtd/spansion-nor.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/spansion-nor.txt

diff --git a/Documentation/devicetree/bindings/mtd/spansion-nor.txt b/Documentation/devicetree/bindings/mtd/spansion-nor.txt
new file mode 100644
index 000000000000..a55c62db0e6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spansion-nor.txt
@@ -0,0 +1,22 @@
+* Spansion NOR flash
+
+Optional properties:
+- spansion,latency-code : Only used when the "m25p,num-dummy-cycles" property is
+                          set. The Spansion latency code tells the NOR flash
+                          memory the number of dummy cycles to expect for each
+                          Fast Read command. The value to be used is provided by
+                          tables in the memory datasheet and depends on the SPI
+                          clock frequency and on the Single/Dual Data Rate mode.
+                          Then the value of "m25p,num-dummy-cycles" property
+                          should match the (Fast) Read command to be used for
+                          the chosen latency code.
+
+Example:
+
+	m25p80 at 0 {
+		compatible = "spansion,s25fl512s";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		m25p,num-dummy-cycles = <8>;
+		spansion,latency-code = <2>;
+	};
-- 
1.8.2.2
