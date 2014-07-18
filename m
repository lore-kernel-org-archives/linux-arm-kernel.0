From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 19 Jul 2014 02:02:09 +0900
Subject: [PATCHv6 3/4] iio: devicetree: Add DT binding documentation for
 Exynos3250 ADC
In-Reply-To: <5835825.JtcDoyOP8b@wuerfel>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <6104032.PNRl85V92G@wuerfel>
 <CAGTfZH3cH-QFMbfTWJJfTPTRT-Bij2TW=6CH_Yy-GaZqZvn-Xg@mail.gmail.com>
 <5835825.JtcDoyOP8b@wuerfel>
Message-ID: <CAGTfZH3mnPJ72wi7aFYoChe_OeuRVsUVo3KGRRLTV5scwPbO4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 1:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 19 July 2014 01:23:15 Chanwoo Choi wrote:
>> If don't add new compatible including specific exynos version,
>> I would add new 'adc-needs-sclk' property with existing 'exynos-adc-v2'
>> compatible name.
>>
>>
>> Dear Naveen, Tomasz,
>>
>> If existing exynos-adc driver add just one property for 'sclk_adc'
>> as following, exynos-adc could not include the exynos version
>> in compatible name.
>>
>> I need your opinion about it.
>>
>>                 adc: adc at 126C0000 {
>>                         compatible = "samsung,exynos-adc-v2";
>>                         reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>>                         interrupts = <0 137 0>;
>>                         clock-names = "adc", "sclk_adc";
>>                         clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>> +                        adc-needs-sclk;
>>                         #io-channel-cells = <1>;
>>                         io-channel-ranges;
>>                 }
>
> How about just making it an optional clock? That would be much
> easier because then you can simply see if the clock itself is
> there and use it, or otherwise ignore it.

The v1 of this patchset[1] got the clock of 'sclk_adc'  but if the dt node
of ADC in dtsi file didn't include 'sclk_adc', print just warning message
without stopping probe as following:

 [1] https://lkml.org/lkml/2014/4/10/710

+       info->sclk = devm_clk_get(&pdev->dev, "sclk_adc");
+       if (IS_ERR(info->sclk)) {
+               dev_warn(&pdev->dev, "failed getting sclk clock, err = %ld\n",
+                                                       PTR_ERR(info->sclk));
+               info->sclk = NULL;
+       }

But, Tomasz Figa suggested the method[2] of this patchset(v6).
 [2] https://lkml.org/lkml/2014/4/11/189

Thanks,
Chanwoo Choi
