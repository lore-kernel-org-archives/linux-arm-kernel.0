From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 16 Dec 2017 11:38:40 +0800
Subject: [PATCH v3 1/2] ARM64: dts: meson-axg: add ethernet mac controller
In-Reply-To: <7ho9mz94dg.fsf@baylibre.com>
References: <20171215021014.231308-1-yixun.lan@amlogic.com>
 <20171215021014.231308-2-yixun.lan@amlogic.com> <7ho9mz94dg.fsf@baylibre.com>
Message-ID: <9bc81e9f-492c-a93f-9f50-67891a92a64a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin


On 12/16/2017 03:29 AM, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
>> Add DT info for the stmmac ethernet MAC which found in
>> the Amlogic's Meson-AXG SoC, also describe the ethernet
>> pinctrl & clock information here.
>>
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> This patch does not apply, and dependencies are not described.
> 
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 54 ++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index d356ce74ad89..94c4972222b7 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -7,6 +7,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/axg-clkc.h>
>>  
>>  / {
>>  	compatible = "amlogic,meson-axg";
>> @@ -148,6 +149,19 @@
>>  			#address-cells = <0>;
>>  		};
>>  
>> +		ethmac: ethernet at ff3f0000 {
>> +			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
>> +			reg = <0x0 0xff3f0000 0x0 0x10000
>> +				0x0 0xff634540 0x0 0x8>;
>> +			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "macirq";
>> +			clocks = <&clkc CLKID_ETH>,
>> +				 <&clkc CLKID_FCLK_DIV2>,
>> +				 <&clkc CLKID_MPLL2>;
>> +			clock-names = "stmmaceth", "clkin0", "clkin1";
>> +			status = "disabled";
>> +		};
>> +
>>  		hiubus: bus at ff63c000 {
>>  			compatible = "simple-bus";
>>  			reg = <0x0 0xff63c000 0x0 0x1c00>;
> 
> Based on the hiubus node, presumably this depends on the patch from the
> clock series.
> 
yes, it depend on clock, also the pinctrl patch

>> @@ -194,6 +208,46 @@
>>  					#gpio-cells = <2>;
>>  					gpio-ranges = <&pinctrl_periphs 0 0 86>;
>>  				};
> 
> I'm not sure where this part is coming from, but it causes the rest of
> it to not apply.
> 
> Please be sure to describe all dependencies.
> 
.
exactly, it depend on pinctrl

actually, once you apply the clock & pinctrl DT patch, this one should
go fine. I will send another v4 which base on your recent v4.16/dt64
branch for your convenience.

Yixun
