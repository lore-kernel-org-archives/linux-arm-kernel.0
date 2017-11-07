From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue, 7 Nov 2017 18:55:22 +0100
Subject: [PATCH 1/1] add mali r6p2 dt node
In-Reply-To: <20171107110539.3wrm6uu6ohh6dnuy@flea>
References: <1510049010-5758-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20171107110539.3wrm6uu6ohh6dnuy@flea>
Message-ID: <49715d2b-97f5-7e21-7072-8e050d471a9f@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 07/11/2017 12:05, Maxime Ripard ha scritto:
> Hi,
> 
> On Tue, Nov 07, 2017 at 11:03:30AM +0100, Giulio Benetti wrote:
>> This patch adds device tree mali node compatible with r6p2 utgard kernel driver
>> provided by ARM and patched by maxime ripard on his github.
>>
>> It can be easily used in target.dts with:
>>
>> &mali {
>> 	status = "okay";
>> }
>>
>> then loading mali.ko in user space.
>>
>> Best regards
>> Giulio Benetti
>> Micronova srl
> 
> Again, you should have a proper commit log here.

As log could it be:
It seems there is not mali node in sun7i-a20.dtsi    << This is "Why"

Add mali node to sun7i-a20.dtsi                << This is "How"

Or can you point me to some example?
I've tried to check lot of other patches,
but really I can't understand which is the right way.

> 
> Moreover, the DT binding itself doesn't have a dependency on the mali
> driver version. This is just a description of the hardware so you
> shouldn't mention it.

Right

> 
> And there's no need for the status = "okay" in the board DTS, since
> you don't disable it in your patch.

Right

> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 228c368..e402596 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -1216,6 +1216,33 @@
>>   			#size-cells = <0>;
>>   		};
>>   
>> +		mali: gpu at 1c40000 {
>> +			compatible = "allwinner,sun8i-a23-mali",
> 
> This doesn't make any sense. The A23 went out later, and...
> 
>> +				     "allwinner,sun7i-a20-mali", "arm,mali-400";
> 
> You're actually using the proper compatible already.

So I will delete "allwinner,sun8i-a23-mali",

> 
>> +			reg = <0x01c40000 0x10000>;
>> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "gp",
>> +					  "gpmmu",
>> +					  "pp0",
>> +					  "ppmmu0",
>> +					  "pp1",
>> +					  "ppmmu1",
>> +					  "pmu";
>> +			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
>> +			clock-names = "bus", "core";
>> +			resets = <&ccu RST_GPU>;
>> +			#cooling-cells = <2>;
> 
> This isn't needed unless you're using thermal throttling, but in this
> case you would also need to add the OPPs.

Right,
but at this time OPPs are not ready,
so I can delete #cooling-cells = <2>;

> 
>> +
>> +			assigned-clocks = <&ccu CLK_GPU>;
>> +			assigned-clock-rates = <381000000>;
> 
> And this should be in the driver instead.

So it's useless and I will remove that

> 
> Maxime
> 

Now, to avoid any possible other mistake,
do I have to resubmit patch corrected answering to this thread,
when you give me the ok?

PS. Sorry for the mess with double patches,
but I did a mess with mailing lists
and I'm new to this.

Thank you

-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
