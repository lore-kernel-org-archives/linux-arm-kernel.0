From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  5 May 2015 00:52:36 +0200
Subject: [PATCH v2 2/2] doc: dt: add documentation for lpc1850-rgu reset driver
In-Reply-To: <1430779956-12490-1-git-send-email-manabian@gmail.com>
References: <1430779956-12490-1-git-send-email-manabian@gmail.com>
Message-ID: <1430779956-12490-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt

diff --git a/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt b/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
new file mode 100644
index 000000000000..b4e96a278445
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
@@ -0,0 +1,84 @@
+NXP LPC1850  Reset Generation Unit (RGU)
+========================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-rgu"
+- reg: register base and length
+- clocks: phandle and clock specifier to RGU clocks
+- clock-names: should contain "delay" and "reg"
+- #reset-cells: should be 1
+
+See table below for valid peripheral reset numbers. Numbers not
+in the table below are either reserved or not applicable for
+normal operation.
+
+Reset	Peripheral
+  9	System control unit (SCU)
+ 12	ARM Cortex-M0 subsystem core (LPC43xx only)
+ 13	CPU core
+ 16	LCD controller
+ 17	USB0
+ 18	USB1
+ 19	DMA
+ 20	SDIO
+ 21	External memory controller (EMC)
+ 22	Ethernet
+ 25	Flash bank A
+ 27	EEPROM
+ 28	GPIO
+ 29	Flash bank B
+ 32	Timer0
+ 33	Timer1
+ 34	Timer2
+ 35	Timer3
+ 36	Repetitive Interrupt timer (RIT)
+ 37	State Configurable Timer (SCT)
+ 38	Motor control PWM (MCPWM)
+ 39	QEI
+ 40	ADC0
+ 41	ADC1
+ 42	DAC
+ 44	USART0
+ 45	UART1
+ 46	USART2
+ 47	USART3
+ 48	I2C0
+ 49	I2C1
+ 50	SSP0
+ 51	SSP1
+ 52	I2S0 and I2S1
+ 53	Serial Flash Interface (SPIFI)
+ 54	C_CAN1
+ 55	C_CAN0
+ 56	ARM Cortex-M0 application core (LPC4370 only)
+ 57	SGPIO (LPC43xx only)
+ 58	SPI (LPC43xx only)
+ 60	ADCHS (12-bit ADC) (LPC4370 only)
+
+Refer to NXP LPC18xx or LPC43xx user manual for more details about
+the reset signals and the connected block/peripheral.
+
+Reset provider example:
+rgu: reset-controller at 40053000 {
+	compatible = "nxp,lpc1850-rgu";
+	reg = <0x40053000 0x1000>;
+	clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_BUS>;
+	clock-names = "delay", "reg";
+	#reset-cells = <1>;
+};
+
+Reset consumer example:
+mac: ethernet at 40010000 {
+	compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
+	reg = <0x40010000 0x2000>;
+	interrupts = <5>;
+	interrupt-names = "macirq";
+	clocks = <&ccu1 CLK_CPU_ETHERNET>;
+	clock-names = "stmmaceth";
+	resets = <&rgu 22>;
+	reset-names = "stmmaceth";
+	status = "disabled";
+};
-- 
1.8.0
