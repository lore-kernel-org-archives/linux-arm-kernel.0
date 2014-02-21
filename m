From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 21 Feb 2014 14:18:49 +0100
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <CAK9yfHyWG1ac6isTRSB3VWfxER9cSuDJHwY3b7svyEk9EozpWQ@mail.gmail.com>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
 <201402201800.49425.arnd@arndb.de> <53063C9F.4060307@samsung.com>
 <16785833.BhsvfRuRRo@wuerfel>
 <CAK9yfHyWG1ac6isTRSB3VWfxER9cSuDJHwY3b7svyEk9EozpWQ@mail.gmail.com>
Message-ID: <53075239.4010603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.02.2014 07:08, Sachin Kamat wrote:
> On 20 February 2014 23:18, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 20 February 2014 18:34:23 Tomasz Figa wrote:
>>> On 20.02.2014 18:00, Arnd Bergmann wrote:
>>>>> Of course nothing stops you from retaining more specific compatible
>>>>> strings. In fact, this is probably the most appropriate solution,
>>>>> because in future you might find out that certain SoCs need some special
>>>>> differentiation, e.g. same ID value on two SoCs.
>>>>>
>>>>> So, to apply this to our case, our Exynos 5250 based Arndale board would
>>>>> be changed from
>>>>>
>>>>> compatible = "insignal,arndale", "samsung,exynos5260";
>>>>>
>>>>> to
>>>>>
>>>>> compatible = "insignal,arndale", "samsung,exynos5260", "samsung,exynos";
>>>>
>>>> Right, this would make sense.
>>>>
>>>>> Now, the board file will be able to match simply by "samsung,exynos"
>>>>> compatible string and SoC-specific code in mach-exynos (hopefully none
>>>>> after it gets cleaned up fully) will use soc_is_exynos*() macros (what
>>>>> AFAIK it is already doing at the moment).
>>>>
>>>> On principle, I would not take things out of the match list, if that
>>>> would break booting with old DT file that don't list "samsung,exynos"
>>>> as compatible. But for new SoCs that would work.
>>>
>>> My proposal was about simply adding a fully generic string, without
>>> removing the specific ones. For already supported SoCs this is pretty
>>> obvious, as existing DTBs would not have this generic string listed. But
>>> the specific strings should be also present in DTSes of new SoCs, even
>>> if not recognized by the kernel, to make sure that in future any
>>> SoC-specific quirks could be easily handled.
>>
>> Yes, that's ideal.
>>
>>>> Using soc_is_exynos*() too much of course also isn't good. A lot of
>>>> the things tested for should probably be checked from individual DT
>>>> properties, but again we have to find the right balance. I wouldn't
>>>> mind getting rid of the soc_is_exynos*() macros completely, because
>>>> a) we can't use them in device drivers
>>>> b) all platform code is supposed to be in drivers
>>>> c) both rules are enforced for arm64
>>>
>>> I fully agree. As I said, after cleaning up mach-exynos/ there should be
>>> no more code left using soc_is_*() macros. Ideally, the whole
>>> mach-exynos/ should collapse into a single, trivial file, with
>>> everything done in dedicated drivers.
>>
>> Right.
>
> Now that we have a broader agreement on this, I think we can go ahead with the
> following steps as an initial approach:
> 1. Have a common machine file for both exynos4 and 5 files, mach-exynos-dt.c.
> 2. Introduce a generic compatible string "samsung,exynos".
> 3. Append this to the compatible property list for existing boards.
>
> If this plan looks OK, I can send across patches doing this.
>

Looks good. I would also merge common.c with this resulting 
mach-exynos-dt.c, as it would be the only user of the code there.

Best regards,
Tomasz
