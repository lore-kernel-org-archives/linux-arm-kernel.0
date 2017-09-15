From: rocky.hao@rock-chips.com (rocky.hao)
Date: Fri, 15 Sep 2017 11:52:37 +0800
Subject: [PATCH 3/5] arm: dts: rockchip: add tsadc node for RV1108 SoC
In-Reply-To: <89384e20-94d8-c698-135e-f48924c20493@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
 <89384e20-94d8-c698-135e-f48924c20493@rock-chips.com>
Message-ID: <8ae300de-b1a0-c399-fcd1-cdbaf408ab1b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Thanks for the reply.

? 2017/9/15 10:25, Caesar Wang ??:
> Rocky,
> 
> ? 2017?08?24? 18:27, Rocky Hao ??:
>> Add tsadc needed main information for RV1108 SoC.
>> 750000Hz is the max clock rate supported by tsadc module.
>>
>> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rv1108.dtsi | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rv1108.dtsi 
>> b/arch/arm/boot/dts/rv1108.dtsi
>> index 25fab0b80f53..dbdd8c2180e7 100644
>> --- a/arch/arm/boot/dts/rv1108.dtsi
>> +++ b/arch/arm/boot/dts/rv1108.dtsi
>> @@ -275,6 +275,25 @@
>>           status = "disabled";
>>       };
>> +    tsadc: tsadc at 10370000 {
>> +        compatible = "rockchip,rv1108-tsadc";
>> +        reg = <0x10370000 0x100>;
>> +        interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>> +        assigned-clocks = <&cru SCLK_TSADC>;
>> +        assigned-clock-rates = <750000>;
>> +        clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +        clock-names = "tsadc", "apb_pclk";
>> +        pinctrl-names = "init", "default", "sleep";
>> +        pinctrl-0 = <&otp_gpio>;
>> +        pinctrl-1 = <&otp_out>;
>> +        pinctrl-2 = <&otp_gpio>;
>> +        resets = <&cru SRST_TSADC>;
>> +        reset-names = "tsadc-apb";
>> +        rockchip,hw-tshut-temp = <120000>;
> 
>  From the Patch[4/5], you set the critial temperature is 95 degree. I 
> will suggest the Tshut temperature is 100 degree.
Setting rockchip,hw-tshut-temp = <120000>; is not a problem.
Maybe we should change the critial temperature (soc_crit: soc-crit) to 
115 degree. I will explain more in another thread Patch[4/5] arm: dts: 
rockchip: add thermal nodes for RV1108 SoC @ 
https://patchwork.kernel.org/patch/9919757/
> Think about the the peripherial devices,  the 120 degree will damage 
> some chips.
> 
>> +        #thermal-sensor-cells = <1>;
>> +        status = "disabled";
>> +    };
>> +
>>       adc: adc at 1038c000 {
>>           compatible = "rockchip,rv1108-saradc", 
>> "rockchip,rk3399-saradc";
>>           reg = <0x1038c000 0x100>;
>> @@ -642,6 +661,16 @@
>>               };
>>           };
>> +        tsadc {
>> +            otp_out: otp-out {
>> +                rockchip,pins = <0 RK_PB7 RK_FUNC_1 &pcfg_pull_none>;
>> +            };
>> +
>> +            otp_gpio: otp-gpio {
>> +                rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
>> +            };
>> +        };
>> +
>>           uart0 {
>>               uart0_xfer: uart0-xfer {
>>                   rockchip,pins = <3 RK_PA6 RK_FUNC_1 &pcfg_pull_up>,
> 
> 
> 
> 
