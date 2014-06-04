From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 3 Jun 2014 17:53:25 -0700
Subject: XADC
Message-ID: <e2cd1349-5cfb-4456-a1f5-74e7affff085@BN1AFFO11FD006.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

I recently found that you developed a driver for XADC and I thought I
enable it (see patch below). But it seems something is not working
correctly. The values I tested don't seem to be right and also fixed.
I.e. they don't change over time or across boards:

  # cat in_temp0_scale 
  123.040771484
  # cat in_voltage0_vccint_scale 
  0.732421875
  # cat in_voltage0_vccint_raw 
  1384
  # cat in_voltage1_vccaux_s[ 1203.660637] random: nonblocking pool is initialized
  # cat in_voltage1_vccaux_scale 
  0.732421875
  # cat in_voltage3_vccpint_scale 
  0.732421875

Do you have an idea what I'm missing?

	Thanks,
	S?ren

----------------8<-----------------8<-----------------8<--------------8<--------
Date: Tue, 3 Jun 2014 15:11:26 -0700
Subject: [PATCH] ARM: zynq: DT: Add XADC node

Add node for the Xilinx A/D Converter.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 760bbc463c5b..c5854286a95a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -65,6 +65,14 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		adc at f8007100 {
+			compatible = "xlnx,zynq-xadc-1.00.a";
+			reg = <0xf8007100 0x20>;
+			interrupts = <0 7 4>;
+			interrupt-parent = <&intc>;
+			clocks = <&clkc 12>;
+		};
+
 		i2c0: i2c at e0004000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
-- 
2.0.0
