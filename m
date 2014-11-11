From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 10 Nov 2014 18:20:01 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <545C4E1F.4060401@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <545C4E1F.4060401@gmail.com>
Message-ID: <54617251.10306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sonymobile.com>

v2, changes from v1:
  - The patch this documents was updated to make the serialN alias
    optional instead of required.

Update devicetree binding for msm_serial to reflect msm_serial_probe()
getting line id from the serial alias.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
---
 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt |   15 +++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
===================================================================
--- linux.orig/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
+++ linux/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
@@ -27,11 +27,21 @@ Optional properties:
 - dmas: Should contain dma specifiers for transmit and receive channels
 - dma-names: Should contain "tx" for transmit and "rx" for receive channels
 
+Note: Each UART port should have an alias correctly numbered in the
+"aliases" node, according to serialN format, where N is the port number
+(non-negative decimal integer).  If the aliases are not present then
+the port numbers will be 0..(number of UARTS - 1), assigned in the driver
+probe order.
+
 Examples:
 
 A uartdm v1.4 device with dma capabilities.
 
-serial at f991e000 {
+aliases {
+	serial0 = &serial0;
+};
+
+serial0: serial at f991e000 {
 	compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 	reg = <0xf991e000 0x1000>;
 	interrupts = <0 108 0x0>;
@@ -43,7 +53,11 @@ serial at f991e000 {
 
 A uartdm v1.3 device without dma capabilities and part of a GSBI complex.
 
-serial at 19c40000 {
+aliases {
+	serial0 = &serial0;
+};
+
+serial0: serial at 19c40000 {
 	compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 	reg = <0x19c40000 0x1000>,
 	      <0x19c00000 0x1000>;
