From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 20 Feb 2017 16:38:09 +0100
Subject: [PATCH 4/4] ARM: dts: da850-evm: add the UI expander node
In-Reply-To: <5f194c6d-0937-bac2-31cd-2f1658f68d0d@ti.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
 <1487268932-6469-5-git-send-email-bgolaszewski@baylibre.com>
 <5f194c6d-0937-bac2-31cd-2f1658f68d0d@ti.com>
Message-ID: <CAMpxmJX3p03YiPL5X9=pKud4A7bXh9bV=qk7qAEAnA3OF3Hgbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-20 10:36 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Thursday 16 February 2017 11:45 PM, Bartosz Golaszewski wrote:
>> If we're using the UI board and want vpif capture, we need to select
>> the video capture functionality by driving the sel_c pin low on the
>> tca6416 expander and sel_a & sel_b pins high. Do it statically by
>> hogging relevant GPIOs in the device tree.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---

[snip]

>>
>> +                             sel_a {
>> +                                     gpio-hog;
>> +                                     gpios = <7 GPIO_ACTIVE_HIGH>;
>> +                                     output-high;
>> +                                     line-name = "sel_a";
>> +                             };
>> +
>> +                             sel_b {
>> +                                     gpio-hog;
>> +                                     gpios = <6 GPIO_ACTIVE_HIGH>;
>> +                                     output-high;
>> +                                     line-name = "sel_b";
>> +                             };
>> +
>> +                             sel_c {
>> +                                     gpio-hog;
>> +                                     gpios = <5 GPIO_ACTIVE_HIGH>;
>> +                                     output-low;
>> +                                     line-name = "sel_c";
>
> I think this is better handled by using an enable-gpios property in vpif
> capture device-tree node. So in the vpif capture node you would have:
>
>         enable-gpios =  <&tca6416 7 GPIO_ACTIVE_HIGH
>                          &tca6416 6 GPIO_ACTIVE_HIGH
>                          &tca6416 5 GPIO_ACTIVE_LOW>;
>
> and in the vpif capture driver, you would request each of these gpios
> using: devm_gpiod_get_array_optional(.., .., GPIOD_OUT_HIGH);
>

I'm not sure about this one - the result is the same (function still
defined statically in the DT) while now it requires changes to the
vpif driver too.

Is there any other reason we'd prefer this approach?

Thanks,
Bartosz
