From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 21 Dec 2015 13:42:48 +0100
Subject: [PATCH 4/4] ARM: bcm2835: Switch to using the new clock driver
 support.
In-Reply-To: <5677E7BF.3020404@martin.sperl.org>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-5-git-send-email-eric@anholt.net>
 <5677E7BF.3020404@martin.sperl.org>
Message-ID: <5677F3C8.5000600@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am 21.12.2015 um 12:51 schrieb Martin Sperl:
> On 06.09.2015 19:57, Eric Anholt wrote:
>> +        clocks: cprman at 7e101000 {
>> +            compatible = "brcm,bcm2835-cprman";
>> +            #clock-cells = <1>;
>> +            reg = <0x7e101000 0x2000>;
>> +
>> +            /* CPRMAN derives everything from the platform's
>> +             * oscillator.
>> +             */
>> +            clocks = <&clk_osc>;
>> +        };
>> +
>>
> This actually breaks i2s because of an overlap in registers:
> [   12.734352] bcm2835-i2s 20203000.i2s: can't request region for
> resource [mem 0x20101098-0x2010109f]
> [   12.826571] bcm2835-i2s: probe of 20203000.i2s failed with error -16
>
> here the corresponding section for i2s in /arch/arm/boot/dts/bcm2835.dtsi:
>                  i2s: i2s at 7e203000 {
>                          compatible = "brcm,bcm2835-i2s";
>                          reg = <0x7e203000 0x20>,
>                                <0x7e101098 0x02>;
>
>                          dmas = <&dma 2>,
>                                 <&dma 3>;
>                          dma-names = "tx", "rx";
>                          status = "disabled";
>                  };

unfortunately i don't have a i2s interface, but thanks for the remark.

It looks like the i2s driver programm the clock by itself instead of 
using the clock framework. So the second register entry should be 
removed from the i2s node.

>
> Note that actually the PCM/I2S reg-range should be (off by 4):
>      reg = <0x7e203000 0x24>;
> (see also: https://github.com/raspberrypi/linux/pull/1079)

Any chance that Robert (patch author) can send a proper patch to 
linux-rpi-kernel for the of by 4 issue?

Regards
Stefan

>
> Ciao,
>              Martin
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
>
