From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Aug 2016 17:51:19 -0700
Subject: [PATCH v2 1/2] ARM: dts: Add MDM9615 dtsi
In-Reply-To: <884c47cb-6629-fab6-fba0-d189ea835adb@baylibre.com>
References: <1471525661-2563-1-git-send-email-narmstrong@baylibre.com>
 <1471525661-2563-2-git-send-email-narmstrong@baylibre.com>
 <20160818180840.GE361@codeaurora.org>
 <884c47cb-6629-fab6-fba0-d189ea835adb@baylibre.com>
Message-ID: <20160823005119.GO6502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20, Neil Armstrong wrote:
> On 08/18/2016 08:08 PM, Stephen Boyd wrote:
> > On 08/18, Neil Armstrong wrote:
> > 
> > 
> >> +
> >> +		gsbi2: gsbi at 16100000 {
> >> +			compatible = "qcom,gsbi-v1.0.0";
> >> +			cell-index = <2>;
> >> +			reg = <0x16100000 0x100>;
> >> +			clocks = <&gcc GSBI2_H_CLK>;
> >> +			clock-names = "iface";
> >> +			status = "disabled";
> >> +			#address-cells = <1>;
> >> +			#size-cells = <1>;
> >> +			ranges;
> >> +
> >> +			gsbi2_i2c: i2c at 16180000 {
> >> +				compatible = "qcom,i2c-qup-v1.1.1";
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> >> +				reg = <0x16180000 0x1000>;
> >> +				interrupts = <GIC_SPI 149 IRQ_TYPE_NONE>;
> > 
> > There should be a trigger type... high perhaps?
> 
> Well, I do not know, and other qcom dtsi has 0x0 or NONE here...

We should fix those. The driver uses IRQF_TRIGGER_HIGH so it
seems like we should put that here as well.

> 
> > 
> >> +
> >> +				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
> >> +				clock-names = "core", "iface";
> >> +				status = "disabled";
> >> +			};
> >> +		};
> >> +
> >> +
> >> +		qcom,ssbi at 500000 {
> >> +			compatible = "qcom,ssbi";
> >> +			reg = <0x500000 0x1000>;
> >> +			qcom,controller-type = "pmic-arbiter";
> >> +
> >> +			pmicintc: pmic at 0 {
> >> +				compatible = "qcom,pm8018", "qcom,pm8921";
> > 
> > I know that DT specifies most specific compatible first, but when
> > the generic compatible is part number specific as well it never
> > feels right to me. I guess I'll have to get over this.
> > 
> >> +				interrupts = <GIC_PPI 226 IRQ_TYPE_NONE>;
> >> +				#interrupt-cells = <2>;
> >> +				interrupt-controller;
> >> +				#address-cells = <1>;
> >> +				#size-cells = <0>;
> > 
> > Can we have interrupt-parent = <&pmicintc> here instead of in
> > every node?
> 
> No since the pmic node interrupt parent is the GIC.

Ah ok. Silly me.

> > 
> >> +			compatible = "qcom,bam-v1.3.0";
> >> +			reg = <0x12142000 0x8000>;
> >> +			interrupts = <GIC_SPI 97 IRQ_TYPE_NONE>;
> > 
> > There should really be some flags.
> 
> Same as for the qup and uartdm, other qcom dtsi left 0x0 or NONE here...

The driver uses IRQF_TRIGGER_HIGH here, so use that in dtsi?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
