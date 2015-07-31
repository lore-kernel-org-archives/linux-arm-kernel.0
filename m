From: mishal@softerra.com (mishal)
Date: Fri, 31 Jul 2015 18:12:42 +0300
Subject: [PATCH v4] ARM: dts: add bcm2835-pwm bindings
In-Reply-To: <20150225145017.GB5132@x1>
References: <1421325190-7648-1-git-send-email-bart.tanghe@thomasmore.be>
 <20150225145017.GB5132@x1>
Message-ID: <55BB906A.9000105@softerra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tried with latest rpi kernel from github, branch rpi-4.0.y on RaspberryPi A+
on pins 18 and 19
     pwm_pins: pwm {
         brcm,pins = <18 19>;
         brcm,function = <2 2>; /* alt5*/
     };

and pins 12, 13

     pwm_pins: pwm {
         brcm,pins = <12 13>;
         brcm,function = <4 4>; /* alt0*/
     };

different combinations for period/duty_cycle without any output.

(WiringPi library works on pins 18 and 12.)
Did something changed in recent kernels?
Thank you.


On 25.02.15 16:50, Lee Jones wrote:
> On Thu, 15 Jan 2015, Bart Tanghe wrote:
>
>> To probe the bcm2835-pwm driver properly, this dts bindings has to be added
>> to the bcm2835 dtsi file.
>> In expectation of a bcm2835 clock driver, I've added fixed-clock clock binding.
>> ---
>> Changes in v4:
>>   - node added by reg value
>>
>> Signed-off-by: Bart Tanghe <bart.tanghe@thomasmore.be>
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Applied, thanks.
>
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>> index 3342cb1..e8a0f13 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -122,6 +123,14 @@
>>   			status = "disabled";
>>   		};
>>   
>> +                pwm: pwm at 7e20c000 {
>> +                        compatible = "brcm,bcm2835-pwm";
>> +                        reg = <0x7e20c000 0x28>;
>> +                        clocks = <&clk_pwm>;
>> +                        #pwm-cells = <2>;
>> +                        status = "disabled";
>> +                };
>> +
>>   		sdhci: sdhci at 7e300000 {
>>   			compatible = "brcm,bcm2835-sdhci";
>>   			reg = <0x7e300000 0x100>;
>> @@ -179,5 +188,13 @@
>>   			clock-output-names = "spi";
>>   			clock-frequency = <250000000>;
>>   		};
>> +
>> +		clk_pwm: clock at 3 {
>> +			compatible = "fixed-clock";
>> +			reg = <3>;
>> +			#clock-cells = <0>;
>> +			clock-output-names = "pwm";
>> +			clock-frequency = <9200000>;
>> +		};
>>   	};
>>   };
