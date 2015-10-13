From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 13 Oct 2015 20:04:29 +0100
Subject: [PATCH 4/4] arm64: dts: add .dts for GICv3 Foundation model
In-Reply-To: <561CE098.2030906@arm.com>
References: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
 <1444729069-27922-5-git-send-email-andre.przywara@arm.com>
 <561CE098.2030906@arm.com>
Message-ID: <561D55BD.5020200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 13/10/15 11:44, Marc Zyngier wrote:
> On 13/10/15 10:37, Andre Przywara wrote:
>> The ARMv8 Foundation model sports a command line parameter to use
>> a GICv3 emulation instead of the default GICv2 interrupt controller.
>> Add a new .dts file which reuses most of the definitions of the
>> existing model while just adding the required properties for the
>> GICv3 node.
>> This allows the public Foundation model to run with a GICv3.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/boot/dts/arm/Makefile                |  2 +-
>>  arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts | 30 +++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
>>
>> diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
>> index bb3c072..46d342d 100644
>> --- a/arch/arm64/boot/dts/arm/Makefile
>> +++ b/arch/arm64/boot/dts/arm/Makefile
>> @@ -1,4 +1,4 @@
>> -dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
>> +dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
>> diff --git a/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
>> new file mode 100644
>> index 0000000..ecdbe98
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts
>> @@ -0,0 +1,30 @@
>> +/*
>> + * ARM Ltd.
>> + *
>> + * ARMv8 Foundation model DTS (GICv3 configuration)
>> + */
>> +
>> +#include "foundation-v8.dtsi"
>> +
>> +/ {
>> +	gic: interrupt-controller at 2f000000 {
>> +		compatible = "arm,gic-v3";
>> +		#interrupt-cells = <3>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +		interrupt-controller;
>> +		reg =	<0x0 0x2f000000 0x0 0x10000>,
>> +			<0x0 0x2f100000 0x0 0x200000>,
>> +			<0x0 0x2c000000 0x0 0x2000>,
>> +			<0x0 0x2c010000 0x0 0x2000>,
>> +			<0x0 0x2c02f000 0x0 0x2000>;
>> +		interrupts = <1 9 0xf04>;
>> +
>> +		its: its at 2f020000 {
>> +			compatible = "arm,gic-v3-its";
>> +			msi-controller;
>> +			reg = <0x0 0x2f020000 0x0 0x20000>;
>> +		};
>> +	};
>> +};
>>
> 
> Do you know if the ITS has any modelled device connected to it? Not very
> useful on its own, but you may want to use it as a way to inject IPIs
> (just kidding, don't do that!).

Well, the ITS itself is there (the driver initializes and all ID
registers match the ARM description).
I tried to squeeze in the PCI node from some other model, but there does
not seem to be any PCI controller at this address, so this panics.

If I get this correctly, the only kind of hardware the model emulates is
the virtio-blk (which is virtio/mmio and thus wired IRQ only?) and the
SMC LAN, which also does not support MSIs.

So indeed there seems to be no user of the ITS so far, but I tend to
leave the ITS node in here anyway: and does not seem to hurt and we get
at least some testing coverage of the basic ITS initialization code.

Cheers,
Andre.
