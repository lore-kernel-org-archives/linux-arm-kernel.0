From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Mon, 23 Jan 2017 17:32:21 +0100
Subject: [PATCH 3/7] IIO: add bindings for STM32 DFSDM ADC driver
In-Reply-To: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1485189145-29576-4-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the
STM32 DFSDM ADC.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt  b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
new file mode 100644
index 0000000..c156bcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 	
@@ -0,0 +1,60 @@
+STMicroelectronics STM32 DFSDM ADC device driver
+
+STM32 DFSDM ADC is a sigma delta analog-to-digital converter.
+It has to be declared in device-tree as a subnode of the DFSDM mfd node.
+
+It has several multiplexed input channels. Conversions can be performed
+in single, scan or discontinuous mode. Conversions can be launched in software
+or using hardware triggers.
+Each instance of the driver uses one filter instance handle by the DFSDM mfd
+driver.
+
+DFSDM also offers extra features:
+-The analog watchdog feature allows the application to detect if the
+ input voltage goes beyond the user-defined, higher or lower thresholds.
+-The short circuit detection allows allows the application to detect if the
+ input is in CC.
+-The clock absence detection allows application to detect if SPI input is clocked.
+
+Required properties:
+- compatible:	Must be "st,stm32-dfsdm-adc".
+- reg:		Specifies the DFSDM filter instance.
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+- st,adc-channels:	List of single-ended channels muxed for this ADC.
+- st,adc-channel-names:	List of single-ended channels Name.
+
+Optional properties:
+- st,adc-channel-types:	Single-ended channel input type. Default value is 0.
+			- 0: SPI with data on rising edge (default)
+			- 1: SPI with data on falling edge
+			- 2: manchester codec, rising edage = logic 0
+			- 3: manchester codec, rising edage = logic 1
+- st,adc-channel-clk-src: Conversion clock source. default value is 1.
+			  - 0: External SPI clocl (CLKIN x)
+			  - 1: internal SPI clock (CLKOUT) (default)
+			  - 2: internal SPI clock divided by 2 (falling edge).
+			  - 2: internal SPI clock divided by 2 (rising edge).
+- st,adc-alt-channel: 	  must be defined if Two ADCs are connected on same SPI
+			  input.
+			  If not set channel n is connected to SPI input n.
+			  If set channel n is connected to SPI input n + 1.
+
+Example:
+	dfsdm: dfsdm at 4400D000 {
+		iio_dfsdm0: iio-dfsdm at 0 {
+			compatible = "st,stm32-dfsdm-adc";
+			#io-channel-cells = <1>;
+			reg = <0>;
+			st,adc-channels = <1>;
+			st,adc-channel-names = "in0";
+		};
+		iio_dfsdm1: iio-dfsdm at 1 {
+			compatible = "st,stm32-dfsdm-adc";
+			#io-channel-cells = <1>;
+			reg = <1>;
+			st,adc-channels = <1>;
+			st,adc-channel-names = "in1";
+			st,adc-channel-types = <1>;
+			st,adc-alt-channel = <1>;
+		};
+	};
-- 
1.9.1
