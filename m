From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 1 Sep 2016 15:40:33 +0300
Subject: [PATCHv2 1/3] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <1472733635-22661-1-git-send-email-t-kristo@ti.com>
References: <1472733635-22661-1-git-send-email-t-kristo@ti.com>
Message-ID: <1472733635-22661-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a clock implementation, TI SCI clock, that will hook to the common
clock framework, and allow each clock to be controlled via TI SCI
protocol.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/clock/ti,sci-clk.txt       | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
new file mode 100644
index 0000000..231cb80
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
@@ -0,0 +1,51 @@
+Texas Instruments TI-SCI Clocks
+===============================
+
+All clocks on Texas Instruments' SoCs that contain a System Controller,
+are only controlled by this entity. Communication between a host processor
+running an OS and the System Controller happens through a protocol known
+as TI-SCI[1]. This clock implementation plugs into the common clock
+framework and makes use of the TI-SCI protocol on clock API requests.
+
+[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+Required properties:
+-------------------
+- compatible: Must be "ti,sci-clk"
+- #clock-cells: Shall be 2.
+  In clock consumers, this cell represents the device ID and clock ID
+  exposed by the PM firmware. The assignments can be found in the header
+  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
+  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where <soc>
+  is the SoC involved, for example 'k2g'.
+- ti,sci: Phandle to the TI SCI device to use for managing the clocks
+
+Optional properties:
+-------------------
+- ti,ssc-clocks: Array of phandle clocks that shall enable spread spectrum
+		 clocking while enabled
+- ti,allow-freq-change-clocks: Array of phandle clocks that shall allow
+			       dynamic clock frequency changes by firmware
+- ti,input-term-clocks: Array of phandle clocks that shall enable input
+			termination
+
+Examples:
+--------
+
+k2g_clks: k2g_clks {
+	compatible = "ti,sci-clk";
+	ti,sci = <&pmmc>;
+	#clock-cells = <2>;
+};
+
+dummy_node at 1234 {
+	clocks = <&k2g_clks K2G_DEV_DUMMY K2G_DEV_DUMMY_FCK>;
+};
+
+dummy_node2 at 2345 {
+	clocks = <&k2g_clks K2G_DEV_DUMMY2 K2G_DEV_DUMMY_X1_CLK>;
+};
+
+&k2g_clks {
+	ti,ssc-clocks = <&k2g_clks K2G_DEV_DUMMY K2G_DEV_DUMMY_FCK>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c5e3d1..ef88726 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11573,6 +11573,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	drivers/firmware/ti_sci*
 F:	include/linux/soc/ti/ti_sci_protocol.h
+F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
1.9.1
