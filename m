From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Feb 2014 11:58:57 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf tree
Message-ID: <20140221115857.3ea3d7277d03c5b6b4d26488@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/qcom-msm8960-cdp.dts between commit a1d711938959 ("ARM:
dts: msm: Add krait-pmu to platforms with Krait CPUs") from the arm-perf
tree and commit cc60a1a4d47a ("ARM: dts: msm: split out msm8660 and
msm8960 soc into dts include") from the arm-soc tree.

I fixed it up (probably not the best way ... see below) and can carry the
fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 66c59a6a722c,a58fb88315f6..000000000000
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@@ -7,70 -3,4 +3,10 @@@
  / {
  	model = "Qualcomm MSM8960 CDP";
  	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
- 	interrupt-parent = <&intc>;
 +
 +	cpu-pmu {
 +		compatible = "qcom,krait-pmu";
 +		interrupts = <1 10 0x304>;
 +		qcom,no-pc-write;
 +	};
- 
- 	intc: interrupt-controller at 2000000 {
- 		compatible = "qcom,msm-qgic2";
- 		interrupt-controller;
- 		#interrupt-cells = <3>;
- 		reg = < 0x02000000 0x1000 >,
- 		      < 0x02002000 0x1000 >;
- 	};
- 
- 	timer at 200a000 {
- 		compatible = "qcom,kpss-timer", "qcom,msm-timer";
- 		interrupts = <1 1 0x301>,
- 			     <1 2 0x301>,
- 			     <1 3 0x301>;
- 		reg = <0x0200a000 0x100>;
- 		clock-frequency = <27000000>,
- 				  <32768>;
- 		cpu-offset = <0x80000>;
- 	};
- 
- 	msmgpio: gpio at 800000 {
- 		compatible = "qcom,msm-gpio";
- 		gpio-controller;
- 		#gpio-cells = <2>;
- 		ngpio = <150>;
- 		interrupts = <0 16 0x4>;
- 		interrupt-controller;
- 		#interrupt-cells = <2>;
- 		reg = <0x800000 0x4000>;
- 	};
- 
- 	gcc: clock-controller at 900000 {
- 		compatible = "qcom,gcc-msm8960";
- 		#clock-cells = <1>;
- 		#reset-cells = <1>;
- 		reg = <0x900000 0x4000>;
- 	};
- 
- 	clock-controller at 4000000 {
- 		compatible = "qcom,mmcc-msm8960";
- 		reg = <0x4000000 0x1000>;
- 		#clock-cells = <1>;
- 		#reset-cells = <1>;
- 	};
- 
- 	serial at 16440000 {
- 		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
- 		reg = <0x16440000 0x1000>,
- 		      <0x16400000 0x1000>;
- 		interrupts = <0 154 0x0>;
- 		clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
- 		clock-names = "core", "iface";
- 	};
- 
- 	qcom,ssbi at 500000 {
- 		compatible = "qcom,ssbi";
- 		reg = <0x500000 0x1000>;
- 		qcom,controller-type = "pmic-arbiter";
- 	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/423f7933/attachment.sig>
