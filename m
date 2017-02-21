From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 21 Feb 2017 10:22:59 +0100
Subject: [PATCH 4/4] ARM: dts: da850-evm: add the UI expander node
In-Reply-To: <2d708416-401a-d2df-5694-9896df47a673@ti.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
 <1487268932-6469-5-git-send-email-bgolaszewski@baylibre.com>
 <5f194c6d-0937-bac2-31cd-2f1658f68d0d@ti.com>
 <CAMpxmJX3p03YiPL5X9=pKud4A7bXh9bV=qk7qAEAnA3OF3Hgbw@mail.gmail.com>
 <2d708416-401a-d2df-5694-9896df47a673@ti.com>
Message-ID: <CAMpxmJWtJ=NJJvY13mmdGc3+nRB+-KSfjfNMCRJeOz=+Op-NQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-21 6:03 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 20 February 2017 09:08 PM, Bartosz Golaszewski wrote:
>> 2017-02-20 10:36 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>>> On Thursday 16 February 2017 11:45 PM, Bartosz Golaszewski wrote:
>>>> If we're using the UI board and want vpif capture, we need to select
>>>> the video capture functionality by driving the sel_c pin low on the
>>>> tca6416 expander and sel_a & sel_b pins high. Do it statically by
>>>> hogging relevant GPIOs in the device tree.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>> ---
>>
>> [snip]
>>
>>>>
>>>> +                             sel_a {
>>>> +                                     gpio-hog;
>>>> +                                     gpios = <7 GPIO_ACTIVE_HIGH>;
>>>> +                                     output-high;
>>>> +                                     line-name = "sel_a";
>>>> +                             };
>>>> +
>>>> +                             sel_b {
>>>> +                                     gpio-hog;
>>>> +                                     gpios = <6 GPIO_ACTIVE_HIGH>;
>>>> +                                     output-high;
>>>> +                                     line-name = "sel_b";
>>>> +                             };
>>>> +
>>>> +                             sel_c {
>>>> +                                     gpio-hog;
>>>> +                                     gpios = <5 GPIO_ACTIVE_HIGH>;
>>>> +                                     output-low;
>>>> +                                     line-name = "sel_c";
>>>
>>> I think this is better handled by using an enable-gpios property in vpif
>>> capture device-tree node. So in the vpif capture node you would have:
>>>
>>>         enable-gpios =  <&tca6416 7 GPIO_ACTIVE_HIGH
>>>                          &tca6416 6 GPIO_ACTIVE_HIGH
>>>                          &tca6416 5 GPIO_ACTIVE_LOW>;
>>>
>>> and in the vpif capture driver, you would request each of these gpios
>>> using: devm_gpiod_get_array_optional(.., .., GPIOD_OUT_HIGH);
>>>
>>
>> I'm not sure about this one - the result is the same (function still
>> defined statically in the DT) while now it requires changes to the
>> vpif driver too.
>>
>> Is there any other reason we'd prefer this approach?
>
> The GPIO hog functionality can race with driver probe. Based on probe
> order, you may have a situation where VPIF probes before tca6416 so we
> have an erroneous situation where probe is successful, but hardware is
> not really available.
>
> Using enable-gpios lets you handle probe deferral so VPIF capture probe
> completes only when hardware is ready. So if for some reason tca6416
> driver or hardware is misbehaving, VPIF will know about it through some
> error value rather than just assuming that everything went well.
>
> So, yes, in the "all goes well" scenario, there is not much difference
> in the two approaches. But the difference will be apparent when
> something goes wrong.
>
> Probe order will also influence the shutdown and suspend order. So
> kernel will automatically make sure that shutdown happens in reverse
> probe order. This may or may not matter in this case. But in  general,
> it will be nice to make sure VPIF shuts down before tca6416 does so that
> hardware is available for VPIF to cleanly shutdown (and not disconnected
> behind its back because tca6416 decided to put all its lines to off as
> part of its shutdown).
>
> I think GPIO hog should only be used for pins which are really "system
> level". IOW, not related to any driver functionality.
>
> Thanks,
> Sekhar

Ok, I'll extend the driver then.

Thanks,
Bartosz
