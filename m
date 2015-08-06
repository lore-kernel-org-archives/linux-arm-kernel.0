From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 6 Aug 2015 12:59:30 +0800
Subject: [PATCH v4 2/2] Documentation: dt: binding: atmel-sama5d4-wdt: for
 SAMA5D4 watchdog driver
In-Reply-To: <1438837170-4518-1-git-send-email-wenyou.yang@atmel.com>
References: <1438837170-4518-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1438837170-4518-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible "atmel,sama5d4-wdt" supports the SAMA5D4 watchdog driver
and the watchdog's WDT_MR register can be written more than once.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 .../bindings/watchdog/atmel-sama5d4-wdt.txt        |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
new file mode 100644
index 0000000..f7cc7c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
@@ -0,0 +1,35 @@
+* Atmel SAMA5D4 Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible: "atmel,sama5d4-wdt"
+- reg: base physical address and length of memory mapped region.
+
+Optional properties:
+- timeout-sec: watchdog timeout value (in seconds).
+- interrupts: interrupt number to the CPU.
+- atmel,watchdog-type: should be "hardware" or "software".
+	"hardware": enable watchdog fault reset. A watchdog fault triggers
+		    watchdog reset.
+	"software": enable watchdog fault interrupt. A watchdog fault asserts
+		    watchdog interrupt.
+- atmel,idle-halt: present if you want to stop the watchdog when the CPU is
+		   in idle state.
+	CAUTION: This property should be used with care, it actually makes the
+	watchdog not counting when the CPU is in idle state, therefore the
+	watchdog reset time depends on mean CPU usage and will not reset at all
+	if the CPU stop working while it is in idle state, which is probably
+	not what you want.
+- atmel,dbg-halt: present if you want to stop the watchdog when the CPU is
+		  in debug state.
+
+Example:
+	watchdog at fc068640 {
+		compatible = "atmel,sama5d4-wdt";
+		reg = <0xfc068640 0x10>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH 5>;
+		timeout-sec = <10>;
+		atmel,watchdog-type = "hardware";
+		atmel,dbg-halt;
+		atmel,idle-halt;
+		status = "okay";
+	};
-- 
1.7.9.5
