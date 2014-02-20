From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Feb 2014 18:34:23 +0100
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <201402201800.49425.arnd@arndb.de>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHy7YHDLCfUGA-ua4iLzK2PMotVZvC=51t-bMkVZVBQFaA@mail.gmail.com>
 <5306168F.1080400@samsung.com> <201402201800.49425.arnd@arndb.de>
Message-ID: <53063C9F.4060307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.02.2014 18:00, Arnd Bergmann wrote:
> On Thursday 20 February 2014, Tomasz Figa wrote:
>> On 20.02.2014 05:14, Sachin Kamat wrote:
>>> Hi Tomasz,
>>>
>>> On 19 February 2014 18:15, Tomasz Figa <t.figa@samsung.com> wrote:
>>>> Hi Sachin,
>>>>
>>>> [adding linux-arm-kernel ML to CC list]
>>>>
>>>>
>>>> On 19.02.2014 12:34, Sachin Kamat wrote:
>>>>>
>>>>> To avoid modifying the kernel every time a new SoC variant
>>>>> comes out.
>>> <snip>
>>>>
>>>> Since all Exynos chips can be easily recognized using dedicated chip ID
>>>> register, I wonder whether we really need to maintain two distinct board
>>>> files for Exynos 4 and 5 series, especially when both of them are doing
>>>> mostly the same set up, which can be simply generalized to cover all the
>>>> cases.
>>>>
>>>> Instead of adding just another level of artificially fine grained compatible
>>>> strings, I'd rather suggest merging both board files together and adding a
>>>> single compatible string identifying all SoCs that can be further
>>>> differentiated by using hardware chip ID register.
>>>>
>>>> What do you think?
>>>
>>> I agree with your idea of merging both the files as there is very little that is
>>> different for now. However I am not really sure if having a single compatible
>>> string for all SoCs would be good. What is achieved through compatible string
>>> can very well be done using chip ID too. But wouldn't we need to maintain some
>>> unique identity for the SoCs in human readable form at the DT level?
>>
>> Well, my understanding of Device Tree is that it should provide the
>> information that can't be automatically retrieved from the hardware, not
>> more.
>>
>> If you have a PCI or USB bus with enumerable devices, you don't list
>> them in DT, but instead limit the description to just the host
>> controller, if it can't be enumerated.
>>
>> Same goes for compatible string. My interpretation of it is that if you
>> can identify the hardware by some automatic means, e.g. querying some ID
>> register, then the compatible should be specific enough to identify the
>> class of devices with the same method of querying such register, with no
>> need for any additional redundant data in DT.
>
> There are some limitations to that, and you also have to apply common
> sense and taste. In theory you could argue that a compatible string can
> identify a board uniquely the same way that a board number did, and
> everything else is implied by that. Clearly that's not what we want.

I'd argue about relevance of this example. What I'm talking about is 
kind of data that can be retrieved directly from the hardware. Both 
compatible string and board number are just artificial identifiers that 
can be used by the kernel to decide (in a greatly simplified view) which 
set of static (i.e. hardcoded) data (and code) to use.

If it happens that a new piece of hardware requires just exactly the 
same set, because any possible differences can be obtained by reading 
some registers, then there is no need for the kernel to support any new 
compatible string and such hardware will work on older kernels as well.

> On the other end of the scale, you could eliminate a lot of compatible
> strings if you describe each register or each bit in some cases in
> DT properties, and that would be just as wrong.

I don't mind fine grained compatible strings. In fact, making them fine 
grained is most likely to be the best choice most of the time. Still, 
the simple fact is, though, that data which can be retrieved from the 
hardware automatically should not be repeated in DT. This is called 
redundancy and this is bad, from obvious reasons.

>> Of course nothing stops you from retaining more specific compatible
>> strings. In fact, this is probably the most appropriate solution,
>> because in future you might find out that certain SoCs need some special
>> differentiation, e.g. same ID value on two SoCs.
>>
>> So, to apply this to our case, our Exynos 5250 based Arndale board would
>> be changed from
>>
>> compatible = "insignal,arndale", "samsung,exynos5260";
>>
>> to
>>
>> compatible = "insignal,arndale", "samsung,exynos5260", "samsung,exynos";
>
> Right, this would make sense.
>
>> Now, the board file will be able to match simply by "samsung,exynos"
>> compatible string and SoC-specific code in mach-exynos (hopefully none
>> after it gets cleaned up fully) will use soc_is_exynos*() macros (what
>> AFAIK it is already doing at the moment).
>
> On principle, I would not take things out of the match list, if that
> would break booting with old DT file that don't list "samsung,exynos"
> as compatible. But for new SoCs that would work.

My proposal was about simply adding a fully generic string, without 
removing the specific ones. For already supported SoCs this is pretty 
obvious, as existing DTBs would not have this generic string listed. But 
the specific strings should be also present in DTSes of new SoCs, even 
if not recognized by the kernel, to make sure that in future any 
SoC-specific quirks could be easily handled.

> Using soc_is_exynos*() too much of course also isn't good. A lot of
> the things tested for should probably be checked from individual DT
> properties, but again we have to find the right balance. I wouldn't
> mind getting rid of the soc_is_exynos*() macros completely, because
> a) we can't use them in device drivers
> b) all platform code is supposed to be in drivers
> c) both rules are enforced for arm64

I fully agree. As I said, after cleaning up mach-exynos/ there should be 
no more code left using soc_is_*() macros. Ideally, the whole 
mach-exynos/ should collapse into a single, trivial file, with 
everything done in dedicated drivers.

>> Another benefit of this would be increased safety, because you are
>> reading SoC type from actual hardware, not from externally supplied
>> data. In conjunction with the more specific compatible string (e.g.
>> "samsung,exynos5260") some validation could be performed at boot-up time
>> to make sure that DT for correct SoC is used.
>
> I don't think that's necessary. If you get that part wrong, normally
> all your hopes are lost with the rest of the information in DT. ;-)

This would let you detect the problem earlier, though, without trying to 
probe incorrect devices and activating unsuitable configurations on 
devices that may happen to match on both SoCs. I agree, though, that 
this is not anything essential.

Best regards,
Tomasz
