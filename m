From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 10 Sep 2014 10:49:05 +0800
Subject: [PATCH v4 3/4] ARM: dts: add main Thermal info to rk3288
In-Reply-To: <3426113.Zcq8V2S7cg@diego>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1409710239-19941-4-git-send-email-caesar.wang@rock-chips.com>
 <3426113.Zcq8V2S7cg@diego>
Message-ID: <540FBC21.2090504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2014?09?09? 19:37, Heiko St?bner ??:
> Am Mittwoch, 3. September 2014, 10:10:38 schrieb Caesar Wang:
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
>> index 36be7bb..3d672e3 100644
>> --- a/arch/arm/boot/dts/rk3288.dtsi
>> +++ b/arch/arm/boot/dts/rk3288.dtsi
>> @@ -224,6 +224,17 @@
>>   		status = "disabled";
>>   	};
>>
>> +	tsadc: tsadc at ff280000 {
> please keep the list of nodes sorted by register address. So when looking at
> my v3.18-next/dts branch, it should be after uart4: serial at ff1c0000 and before
> usb_host0_ehci: usb at ff500000 .
>

oh...,I will fix it.
>> +		compatible = "rockchip,rk3288-tsadc";
>> +		reg = <0xff280000 0x100>;
>> +		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
>> +		clock-names = "tsadc", "apb_pclk";
>> +		pinctrl-names = "default";
>> +		pinctrl-1 = <&tsadc_int>;
>> +		status = "disabled";
>> +	};
>> +
>>   	/* NOTE: ohci at ff520000 doesn't actually work on hardware */
>>
>>   	usb_hsic: usb at ff5c0000 {
>> @@ -611,5 +622,12 @@
>>   				rockchip,pins = <5 15 3 &pcfg_pull_none>;
>>   			};
>>   		};
>> +
>> +		tsadc {
>> +			tsadc_int: tsadc-int {
>> +				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
>> +			};
>> +		};
> After looking this up in the schematics I see that this is the
> overtemperature-protection output pin ... labeled OTP_OUT.
> So I'd think the pinconfig should reflect this pin-name, especially as tsadc-int
> suggests, that this would be an interrupt leading into the tsadc, while in
> fact it is an output to a separate circuit.
>
Maybe,I guess  your mean as the follows .
Please correct it and  Laugh out if I got it wrong.

tsadc {
             otp_out: otp-out {
                 rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
             };

             tsadc_int: tsadc-int {
                 rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
             };
         };
Then,I deal with the otp_out in thermal driver.
I believe The "otp_out" will restart board if it's a high active.

tsadc_int: tsadc-int {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
+			};

But,I think the about will be implemented in thermal driver.
> Heiko
>
>
>

-- 
Best regards,
Caesar
