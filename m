From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 25 Aug 2015 09:33:53 +0800
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DBAD90.3040901@samsung.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <CAJKOXPeEm8exg_UG0tDnaEGO40ejBKZ-ok=bKbVrwYvXnDaMdg@mail.gmail.com>
 <55DA8486.1000803@rock-chips.com> <55DA9B72.1030804@samsung.com>
 <55DB1281.9070502@rock-chips.com> <55DBAD90.3040901@samsung.com>
Message-ID: <55DBC601.5090107@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

? 2015/8/25 7:49, Krzysztof Kozlowski ??:
> On 24.08.2015 21:48, Yakir Yang wrote:
>> Hi Krzysztof,
>>
>> ? 08/24/2015 12:20 PM, Krzysztof Kozlowski ??:
>>> On 24.08.2015 11:42, Yakir Yang wrote:
>>>> Hi Krzysztof,
>>>>
>>>> ? 08/23/2015 07:43 PM, Krzysztof Kozlowski ??:
>>>>> 2015-08-24 8:23 GMT+09:00 Rob Herring <robherring2@gmail.com>:
>>>>>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com>
>>>>>> wrote:
>>>>>>> Analogix dp driver is split from exynos dp driver, so we just
>>>>>>> make an copy of exynos_dp.txt, and then simplify exynos_dp.txt
>>>>>>>
>>>>>>> Beside update some exynos dtsi file with the latest change
>>>>>>> according to the devicetree binding documents.
>>>>>> You can't just change the exynos bindings and break compatibility. Is
>>>>>> there some agreement with exynos folks to do this?
>>>>> No, there is no agreement. This wasn't even sent to Exynos maintainers.
>>>> Sorry about this one, actually I have add Exynos maintainers in version
>>>> 1 & version 2,
>>>> but lose some maintainers in version 3, I would fix it in bellow
>>>> versions.
>>>>
>>>>> Additionally the patchset did not look interesting to me because of
>>>>> misleading subject - Documentation instead of "ARM: dts:".
>>>>>
>>>>> Yakir, please:
>>>>> 1. Provide backward compatibility. Mark old properties as deprecated
>>>>> but still support them.
>>>> Do you mean that I should keep the old properties declare in
>>>> exynos-dp.txt,
>>>> but just mark them as deprecated flag.
>>> That is one of ways how to do this. However more important is that
>>> driver should still support old bindings so such code:
>>> -       if (of_property_read_u32(dp_node, "samsung,color-space",
>>> +       if (of_property_read_u32(dp_node, "analogix,color-space",
>>>
>>> is probably wrong. Will the driver support old DTB in the same way as it
>>> was supporting before the change?
>> Okay, I got your means. So document is not the focus, the most important
>> is that
>> driver should support the old dts prop.
> Right, the focus is on the driver.
>
>> If so the new analogix dp driver
>> should keep
>> the "samsung,color-space", rather then just mark it with [DEPRECATED] flag.
> If you are replacing a binding/property then it should be marked
> deprecated. This means that the old property is still working but new
> users of it should not be added.

Okay, so just quote Heiko's reply, such code would be need in analogix 
dp driver.

        if (of_property_read_u32(dp_node, "analogix,color-space",
                                  &dp_video_config->color_space))
	       if (of_property_read_u32(dp_node, "samsung,color-space",
                 	                 &dp_video_config->color_space)) {

                 	dev_err(dev, "failed to get color-space\n");
                 	return ERR_PTR(-EINVAL);
         	}


>> But from your follow suggest, I think you agree to update driver code,
>> and just mark
>> old prop with deprecated flag. If so I think such code would not be wrong
>>
>> -       if (of_property_read_u32(dp_node, "samsung,color-space",
>> +      if (of_property_read_u32(dp_node, "analogix,color-space",
> It looks wrong because it breaks backward compatibility with existing
> DTB. As I said before:
>>>> 1. Provide backward compatibility. Mark old properties
>>>> as deprecated but still support them.
>
>> And actually @Rob have suggest me to remove the prefix, just use
>> "color-space" here.
> For new bindings I don't mind. But please remember about existing users,
> existing DTB and bisectability.
>
>>>> Let me show same examples, make
>>>> me understand your suggest rightly.
>>> exynos-dp already contains deprecated properties. Other ways of doing
>>> this would be:
>>> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>> Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>>>
>>> It depends up to you. The "touchscreen" looks good because it organizes
>>> old properties in a common section. In case of exynos-dp.txt you can add
>>> at beginning of file information about new bindings and mark everything
>>> deprecated.
>> Whoops, thanks for your remind, I prefer the "touchscreen" style.
>>
>>>> 1. "samsung,ycbcr-coeff" is abandoned in latest analogix-dp driver,
>>>> absolutely
>>>>       I should not carry this to analogix-dp.txt document. But I should
>>>> keep this in
>>>>       exynos-dp.txt document, and mark them with an little
>>>> "deprecated" flag.
>>>>
>>>> [Documentation/devicetree/bindings/video/exynos_dp.txt]
>>>> Required properties for dp-controller:
>>>>      [...]
>>>>       -samsung,ycbcr-coeff (DEPRECATED):
>>>>           YCbCr co-efficients for input video.
>>>>               COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
>>>>
>>>> Is it right ?
>>> Yes, this is right.
>>>
>>>>> 2. Separate all DTS changes to a separate patch, unless bisectability
>>>>> would be hurt. Anyway you should prepare it in a such way that
>>>>> separation would be possible without breaking bisectability.
>>>> So I should separate this patch into two parts, one is name "Document:",
>>>> the other is "ARM: dts: ".
>>> Yes.
>>>
>>>> Honestly, I don't understand what the "bisectability" means in this
>>>> case.
>>> I was referring to bisectability in general. The patchset should be
>>> fully bisectable which means that it does not introduce any issues
>>> during "git bisect". This effectively means that at each intermediate
>>> step (after applying each patch, one by one) every existing stuff works
>>> the same as previously without any regression. Including booting with
>>> old DTB.
>> Oh, thanks for your careful explain, so I guess your first comment is
>> talking about
>> the "bisectability" that if I only apply the 01 - 05 patches, kernel
>> could not bootup
>> normally, cause driver need "analogix,color-space" but DTB only have
>> "samsung,color-space".
> Right. In the same time please remember that kernel may be booted with
> old DTB.

Okay, thanks a lot  ;)

- Yakir

> Best regards,
> Krzysztof
>
>
>
