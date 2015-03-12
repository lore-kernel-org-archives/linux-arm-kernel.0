From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Mar 2015 12:33:22 -0500
Subject: [PATCH v3 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <20150312170541.GE30145@leverpostej>
References: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
 <1426107080-29079-2-git-send-email-galak@codeaurora.org>
 <20150312170541.GE30145@leverpostej>
Message-ID: <E114AF0E-5DA9-412A-B3E2-DDD95D224C66@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 12, 2015, at 12:05 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Kumar,
> 
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
>> +	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
>> +			"qcom,msm8916", "qcom,mtp";
>> +};
> 
> No /chosen/stdout-path?

Nope ;).

> 
> Does your UART driver support earlycon?

It does.

> 
> [...]
> 
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0>;
>> +		};
>> +
>> +		CPU1: cpu at 1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x1>;
>> +		};
>> +
>> +		CPU2: cpu at 2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x2>;
>> +		};
>> +
>> +		CPU3: cpu at 3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x3>;
>> +		};
>> +	};
> 
> The secondary CPUs need an enable-method. Are you using PSCI or
> spin-table?

This is on purpose.  We aren?t using either PSCI or spin-table.  Right now the dts is for booting on a single core.  I can drop CPU1..CPU3 if that helps.

> Which exception level do the CPUs enter the kernel?
> 
>> +	timer {
>> +		compatible = "arm,armv7-timer";
> 
> This should be "arm,armv8-timer?.

will change

> 
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
>> +	};
> 
> NAK. CNTFRQ should be programmed on all CPUs prior to entering the
> kernel, per the boot protocol. You should not need clock-frequency here.

Will drop clock-frequency.

> [...]
> 
>> +		intc: interrupt-controller at b000000 {
>> +			compatible = "qcom,msm-qgic2";
> 
> This string isn't documented (but seems to be supported by the GIC
> driver).

There?s a patch posted to add ?qcom,msm-qgic2? to the binding doc.

> How does this differ from other GIC implementations?

Not sure the exact details, just that its qcom?s on implementation of the GIC spec.

> 
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
>> +		};
> 
> No GICH, GICV, maintenance interrupt?

Nope.

> 
> Minor nit, but I'd prefer if the reg entries were on individual lines as
> happens in other dts.
> 
> Thanks,
> Mark.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
