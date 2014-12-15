From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 11:25:33 +0000
Subject: [PATCH 3/8] mfd: bindings: Provide ST bindings for ST's LPC device
In-Reply-To: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1418642738-17407-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On current ST platforms the LPC controls a number of functions including
Watchdog and Real Time Clock.  This patch provides the bindings used to
choose and configure the devices.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/st-lpc.txt | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st-lpc.txt

diff --git a/Documentation/devicetree/bindings/mfd/st-lpc.txt b/Documentation/devicetree/bindings/mfd/st-lpc.txt
new file mode 100644
index 0000000..b13f143
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st-lpc.txt
@@ -0,0 +1,36 @@
+STMicroelectronics Low Power Controller (LPC)
+=============================================
+
+Currently supports Watchdog OR Real Time Clock functionality.
+
+Required properties [common]
+
+- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
+				  "st,stih415-lpc" "st,stid127-lpc"
+- reg		: LPC registers base address + size
+- interrupts    : LPC interrupt line number and associated flags
+- clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
+- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
+		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
+		  selected.
+
+Required properties [watchdog mode]
+
+- st,syscfg	: Phandle to syscfg node used to enable watchdog and configure
+		  CPU reset type.
+- timeout-sec	: Watchdog timeout in seconds
+
+Optional properties [watchdog mode]
+
+- st,warm-reset	: If present reset type will be 'warm' - if not it will be cold
+
+Example:
+	lpc at fde05000 {
+		compatible	= "st,stih416-lpc-watchdog";
+		reg		= <0xfde05000 0x1000>;
+		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
+		st,syscfg	= <&syscfg_core>;
+		timeout-sec	= <600>;
+		st,lpc-mode	= <ST_LPC_MODE_WDT>;
+		st,warm-reset;
+	};
-- 
1.9.1
