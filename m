From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Jan 2018 20:19:30 +0000
Subject: [PATCH 2/3] ARM: dts: mvebu: add sdram controller node to
 Armada-38x
References: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
 <20180108223158.21930-3-chris.packham@alliedtelesis.co.nz>
 <87tvvu6ro6.fsf@free-electrons.com>
Message-ID: <5aa9a523e86e4607a14265790d105168@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 21:31, Gregory CLEMENT wrote:
> Hi Chris,
>   
>   On mar., janv. 09 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
>> The Armada-38x uses an SDRAM controller that is compatible with the
>> Armada-XP. The key difference is the width of the bus (XP is 64/32, 38x
>> is 32/16). The SDRAM controller registers are the same between the two
>> SoCs.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index 00ff549d4e39..6d34c5ec178f 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -138,6 +138,11 @@
>>   			#size-cells = <1>;
>>   			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
>>   
>> +			sdramc at 1400 {
> 
> Could you add a label? Thanks to this it would be possible to
> enable/disable it at board level in a esay way.
> 

Sure. Any suggestions for a name better than "sdramc:"?

It's probably worth adding the same label to armada-xp.dtsi and 
armada-xp-98dx3236.dtsi.

>> +				compatible = "marvell,armada-xp-sdram-controller";
>> +				reg = <0x1400 0x500>;
> 
> What about adding status = "disabled" ?
> 
> Thanks to this we can enable it at board level only if we really want
> it, it would avoid nasty regression on boards that don't need it, if an
> issue occurs. Unless you are sure that it is completely safe to enable
> it for everyone.

The EDAC driver (which is default n) will not probe the device if ECC 
has not been enabled so that should be safe.

Other than the EDAC driver the only other code that looks at this is in 
arch/arm/mach-mvebu/pm.c and it almost seems like an omission that this 
code is not active on armada-38x. The armada-38x platforms I have access 
to don't use suspend/resume so I can't verify this.
