From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 24 Aug 2015 13:20:02 +0900
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DA8486.1000803@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <CAJKOXPeEm8exg_UG0tDnaEGO40ejBKZ-ok=bKbVrwYvXnDaMdg@mail.gmail.com>
 <55DA8486.1000803@rock-chips.com>
Message-ID: <55DA9B72.1030804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.08.2015 11:42, Yakir Yang wrote:
> Hi Krzysztof,
> 
> ? 08/23/2015 07:43 PM, Krzysztof Kozlowski ??:
>> 2015-08-24 8:23 GMT+09:00 Rob Herring <robherring2@gmail.com>:
>>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>>>> Analogix dp driver is split from exynos dp driver, so we just
>>>> make an copy of exynos_dp.txt, and then simplify exynos_dp.txt
>>>>
>>>> Beside update some exynos dtsi file with the latest change
>>>> according to the devicetree binding documents.
>>> You can't just change the exynos bindings and break compatibility. Is
>>> there some agreement with exynos folks to do this?
>> No, there is no agreement. This wasn't even sent to Exynos maintainers.
> 
> Sorry about this one, actually I have add Exynos maintainers in version
> 1 & version 2,
> but lose some maintainers in version 3, I would fix it in bellow versions.
> 
>> Additionally the patchset did not look interesting to me because of
>> misleading subject - Documentation instead of "ARM: dts:".
>>
>> Yakir, please:
>> 1. Provide backward compatibility. Mark old properties as deprecated
>> but still support them.
> 
> Do you mean that I should keep the old properties declare in exynos-dp.txt,
> but just mark them as deprecated flag.

That is one of ways how to do this. However more important is that
driver should still support old bindings so such code:

-       if (of_property_read_u32(dp_node, "samsung,color-space",
+       if (of_property_read_u32(dp_node, "analogix,color-space",

is probably wrong. Will the driver support old DTB in the same way as it
was supporting before the change?

> Let me show same examples, make
> me understand your suggest rightly.

exynos-dp already contains deprecated properties. Other ways of doing
this would be:
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
Documentation/devicetree/bindings/rtc/s3c-rtc.txt

It depends up to you. The "touchscreen" looks good because it organizes
old properties in a common section. In case of exynos-dp.txt you can add
at beginning of file information about new bindings and mark everything
deprecated.

> 
> 1. "samsung,ycbcr-coeff" is abandoned in latest analogix-dp driver,
> absolutely
>     I should not carry this to analogix-dp.txt document. But I should
> keep this in
>     exynos-dp.txt document, and mark them with an little "deprecated" flag.
> 
> [Documentation/devicetree/bindings/video/exynos_dp.txt]
> Required properties for dp-controller:
>    [...]
>     -samsung,ycbcr-coeff (DEPRECATED):
>         YCbCr co-efficients for input video.
>             COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> 
> Is it right ?

Yes, this is right.

> 
>> 2. Separate all DTS changes to a separate patch, unless bisectability
>> would be hurt. Anyway you should prepare it in a such way that
>> separation would be possible without breaking bisectability.
> 
> So I should separate this patch into two parts, one is name "Document:",
> the other is "ARM: dts: ".

Yes.

> 
> Honestly, I don't understand what the "bisectability" means in this case.

I was referring to bisectability in general. The patchset should be
fully bisectable which means that it does not introduce any issues
during "git bisect". This effectively means that at each intermediate
step (after applying each patch, one by one) every existing stuff works
the same as previously without any regression. Including booting with
old DTB.

> 
>> 3. Use proper subject for the patch changing DTS. This is not
>> documentation change!
> 
> Hmm... when I separate this patch into two parts, I though I can keep
> "Documentation" proper subject in this patch, and the other is the "ARM:
> dts"
> proper subject. Am I right ?

Yes, you're right.

> 
>> 4. Please use script get_maintainers to obtain list of valid
>> maintainers and CC-them with at least cover letter and patches
>> requiring their attention.
> 
> Yeah, thanks.

Sure. Now I found older versions of the patchset but previously there
were no changes to the bindings. Again the prefix in subject is
important to easily filter out and find necessary emails.

BTW, I like the patchset because I like in general works which merge
code and reduce duplicate stuff.

Best regards,
Krzysztof
