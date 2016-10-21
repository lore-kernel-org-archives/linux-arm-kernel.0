From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 21 Oct 2016 15:45:59 +0300
Subject: [PATCH 1/3] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
References: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
Message-ID: <1477053961-27128-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a clock implementation, TI SCI clock, that will hook to the common
clock framework, and allow each clock to be controlled via TI SCI
protocol.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti,sci-clk.txt       | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
new file mode 100644
index 0000000..bfc3ca4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
@@ -0,0 +1,37 @@
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
+- compatible: Must be "ti,k2g-sci-clk"
+- #clock-cells: Shall be 2.
+  In clock consumers, this cell represents the device ID and clock ID
+  exposed by the PM firmware. The assignments can be found in the header
+  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
+  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where <soc>
+  is the SoC involved, for example 'k2g'.
+
+Examples:
+--------
+
+pmmc: pmmc {
+	compatible = "ti,k2g-sci";
+
+	k2g_clks: k2g_clks {
+		compatible = "ti,k2g-sci-clk";
+		#clock-cells = <2>;
+	};
+};
+
+uart0: serial at 2530c00 {
+	compatible = "ns16550a";
+	clocks = <&k2g_clks K2G_DEV_UART0 0>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3eaac5ed..3ee7c7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11895,6 +11895,7 @@ F:	include/linux/soc/ti/ti_sci_protocol.h
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
+F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
1.9.1
