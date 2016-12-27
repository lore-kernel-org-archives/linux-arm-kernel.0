From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 27 Dec 2016 16:06:10 +0900
Subject: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset doc
In-Reply-To: <20161227070611.14852-1-rogershimizu@gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
Message-ID: <20161227070611.14852-3-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add linkstation-reset doc to describe the newly added
POWER_RESET_LINKSTATION driver, which controls magic command
sending to UART1 to power-off Buffalo Linkstation / KuroBox
and their variants.

To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ryan Tandy <ryan@nardis.ca>
Cc: linux-pm at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 .../bindings/power/reset/linkstation-reset.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
new file mode 100644
index 000000000000..815e340318f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/linkstation-reset.txt
@@ -0,0 +1,26 @@
+* Buffalo Linkstation Reset Driver
+
+Power of some Buffalo Linkstation or KuroBox Pro is managed by
+micro-controller, which connects to UART1. After being fed from UART1
+by a few magic numbers, the so-called power-off command,
+the micro-controller will turn power off the device.
+
+This is very similar to QNAP or Synology NAS devices, which is
+described in qnap-poweroff.txt, however the command is much simpler,
+only 1-byte long and without checksums.
+
+This driver adds a handler to pm_power_off which is called to turn the
+power off.
+
+Required Properties:
+- compatible: Should be "linkstation,power-off"
+- reg: Address and length of the register set for UART1
+- clocks: tclk clock
+
+Example:
+
+	reset {
+		compatible = "linkstation,power-off";
+		reg = <0x12100 0x100>;
+		clocks = <&core_clk 0>;
+	};
-- 
2.11.0
