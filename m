From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Oct 2014 12:41:31 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <2195665.D7cJPYcoOh@wuerfel>
References: <cover.1413136383.git.stefan@agner.ch>
 <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
 <2195665.D7cJPYcoOh@wuerfel>
Message-ID: <806cb97553e446d52761bd66306036a9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-12 20:56, schrieb Arnd Bergmann:
> On Sunday 12 October 2014 20:13:58 Stefan Agner wrote:
>> This adds an initial device tree to run Linux on the Cortex-M4 on
>> Vybrid.
>>
>> HACK: Because we include armv7-m.dtsi, the soc node happens to
>> be before the clock node. This is a problem for vf610-clk.c, which
>> tries to optain the fixed clocks defined in the clock nodes. But
>> because clock drivers are initialized sequencially, and we do not
>> have support for deferred probing, the clock initialization fails
>> horrible.
> 
> I thought that was fixed recently.

Unless it was very recently, it didn't solve my case.

Both, clk-fixed-rate as well as clk-vf610 are initialized using
CLK_OF_DECLARE. So I guess its the dt order. Or is it compile time
order? But I think driver code is linked before arch code. 

> 
>> Move the armv7-m.dtsi include to the bottom to temporarily work
>> work around this...
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
>> hack as well. Is it common acceptable that the kernel depends
>> on DTS order?
> 
> Generally speaking, the kernel should not rely on the order of
> nodes in the dtb.
> 
>> diff --git a/arch/arm/boot/dts/vf610m4.dts b/arch/arm/boot/dts/vf610m4.dts
>> new file mode 100644
>> index 0000000..61488fe
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/vf610m4.dts
>> @@ -0,0 +1,144 @@
>> +/*
>> + * Device tree for VF610 Cortex-M4 support
>> + */
>> +
>> +/dts-v1/;
>> +#include "skeleton.dtsi"
>> +#include "vf610-pinfunc.h"
>> +#include <dt-bindings/clock/vf610-clock.h>
>> +
>> +/ {
>> +	model = "VF610 Cortex-M4";
>> +	compatible = "fsl,vf610m4";
>> +
>> +	chosen {
>> +		bootargs = "console=ttyLP0,115200 ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc root=/dev/mmcblk0p2 rootwait";
>> +	};
>> +
>> +	memory {
>> +		reg = <0x88000000 0x2000000>;
>> +	};
>> +
>> +	aliases {
>> +		serial0 = &uart2;
>> +	};
> 
> All of these are board specific, the common way to handle this is to make
> a vf610m4.dtsi file and include that from a v6610m4-myboard.dts file
> which sets the properties.
> 
> The command line should actually be set by the boot loader.

Hm, this would then be a feature needed in the small boot loader I plan
to integrate with m4boot.


> Also, it would be good to make the UART driver handle the early console
> setup through the stdout-path property.

Ok, having a look at that. Do I see things right that this is somewhat
like a default "console=" argument? But probably not picked up by
user-space (systemd) later on...

> 
>> +
>> +	soc {
>> +		aips0: aips-bus at 40000000 {
>> +			compatible = "fsl,aips-bus", "simple-bus";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			reg = <0x40000000 0x70000>;
>> +			ranges;
>> +
>> +/*
>> +			uart0: serial at 40027000 {
>> +				compatible = "fsl,vf610-lpuart";
>> +				reg = <0x40027000 0x1000>;
>> +				interrupts = <61>;
>> +				clocks = <&clks VF610_CLK_UART0>;
>> +				clock-names = "ipg";
>> +				status = "okay";
>> +			};
>> +
>> +			uart1: serial at 40028000 {
>> +				compatible = "fsl,vf610-lpuart";
>> +				reg = <0x40028000 0x1000>;
>> +				interrupts = <62>;
>> +				clocks = <&clks VF610_CLK_UART1>;
>> +				clock-names = "ipg";
>> +				status = "okay";
>> +			};
>> +*/
> 
> Don't comment out nodes, just make them as 'status="disabled"'.
> 
> For any peripherals that are accessible to both the m4 and the a5
> core, it might be nice to put them into a shared .dtsi file.

Hm, actually all peripherals are accessible from both core. However,
since we do have different interrupt controllers, the interrupt property
looks different. But I guess it's perfectly ok to add this property in
the m4 and a5 specific dtsi.

We already discussed the shared dtsi issue for Vybird in a different
thread (VF500 support). Considering we want to create a shared dtsi for
both cores and all variants, I guess it would something look like that:

vfxxx.dtsi => vf500.dtsi (Cortex-A5, single core)
           => vf600m4.dtsi (Cortex-M4)
           => vf600.dtsi (Cortex-A5)
           => vf610.dtsi (Cortex-A5 with L2 Cache)

Or do we want the core included on all dtsi?

vfxxx.dtsi => vf500a5.dtsi (Cortex-A5, single core)
           => vf600m4.dtsi (Cortex-M4)
           => vf600a5.dtsi (Cortex-A5)
           => vf610a5.dtsi (Cortex-A5 with L2 Cache)

--
Stefan
