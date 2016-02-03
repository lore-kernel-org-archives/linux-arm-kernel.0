From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu,  4 Feb 2016 01:18:39 +0800
Subject: [PATCH v10 1/5] Documentation: add sbsa-gwdt driver documentation
In-Reply-To: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1454519923-25230-2-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT.

Also add sbsa-gwdt introduction in watchdog-parameters.txt

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 35 ++++++++++++++++++++++
 Documentation/watchdog/watchdog-parameters.txt     |  5 ++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..73a5d0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
@@ -0,0 +1,35 @@
+* SBSA (Server Base System Architecture) Generic Watchdog
+
+The SBSA Generic Watchdog Timer is used to force a reset of the system
+after two stages of timeout have elapsed.  A detailed definition of the
+watchdog timer can be found in the ARM document: ARM-DEN-0029 - Server
+Base System Architecture (SBSA)
+
+Required properties:
+- compatible: Should at least contain "arm,sbsa-gwdt".
+
+- reg: Each entry specifies the base physical address of a register frame
+  and the length of that frame; currently, two frames must be defined,
+  in this order:
+  1: Watchdog control frame;
+  2: Refresh frame.
+
+- interrupts: Should contain the Watchdog Signal 0 (WS0) SPI (Shared
+  Peripheral Interrupt) number of SBSA Generic Watchdog.
+
+Optional properties
+- timeout-sec: Watchdog timeout values (in seconds).
+
+- status: Indicates the device is not available for use. Should be "okay"
+  or "disabled" for available/unavailable. Default is "okay".
+
+Example for FVP Foundation Model v8:
+
+watchdog at 2a440000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a440000 0 0x1000>,
+	      <0x0 0x2a450000 0 0x1000>;
+	interrupts = <0 27 4>;
+	timeout-sec = <30>;
+	status = "okay";
+};
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..300eb4d 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -284,6 +284,11 @@ sbc_fitpc2_wdt:
 margin: Watchdog margin in seconds (default 60s)
 nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
+sbsa_gwdt:
+timeout: Watchdog timeout in seconds. (default 20s)
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
+-------------------------------------------------
 sc1200wdt:
 isapnp: When set to 0 driver ISA PnP support will be disabled (default=1)
 io: io port
-- 
2.5.0
