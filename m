From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jan 2016 18:14:01 +0100
Subject: [PATCH 0/4] Update cpu feature extraction
In-Reply-To: <20160128170141.GM10826@n2100.arm.linux.org.uk>
References: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
 <56A9F7C6.2060109@arm.com>
 <20160128170141.GM10826@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-vnVq6S+EqCNS=P+_Mu-eY0vNG8S9RTAwM7xggQXUjSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2016 at 18:01, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 28, 2016 at 11:13:10AM +0000, Vladimir Murzin wrote:
>> On 26/01/16 09:23, Vladimir Murzin wrote:
>> > Hi,
>> >
>> > This has been started as a fix in cpu feature extractor, but Suzuki suggested
>> > syncing-up the whole cpu feature handling with the recent updates on arm64
>> > side [1,2].
>> >
>> > I've kept fixes separately, so they can go as the are in case there is concern
>> > on updating cpu feature handling.
>> >
>> > [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/455568
>> > [2] https://lkml.org/lkml/2015/11/18/570
>> >
>>
>> Russell, is it OK for patch tracker?
>
> I'd really like to hear that someone has validated these changes or at
> least someone in ARM Ltd such as Will or Catalin has reviewed them; I
> remember the subject of whether certain fields are signed or unsigned
> being almost a personal opinion - we used to treat all fields as
> unsigned, but that was declared to be wrong, so we then went to treating
> them all as signed fields... See:
>
> commit b8c9592b4a6c93211c8163888a97880d608503b5
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Thu Mar 19 19:03:25 2015 +0100
>
>     ARM: 8318/1: treat CPU feature register fields as signed quantities
>
>     The various CPU feature registers consist of 4-bit blocks that
>     represent signed quantities, whose positive values represent
>     incremental features, and whose negative values are reserved.
>
>     To improve forward compatibility, update the feature detection
>     code to take possible future higher values into account, but
>     ignore negative values.
>
>     Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> For instance:
>
> -       sync_prim = ((read_cpuid_ext(CPUID_EXT_ISAR3) >> 8) & 0xf0) |
> -                   ((read_cpuid_ext(CPUID_EXT_ISAR4) >> 20) & 0x0f);
> -       if (sync_prim >= 0x13)
> +       if (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) > 1 ||
> +           (cpuid_feature_extract(CPUID_EXT_ISAR3, 12) == 1 &&
> +            cpuid_feature_extract(CPUID_EXT_ISAR3, 20) >= 3))
>                 elf_hwcap &= ~HWCAP_SWP;
>
> (let's ignore the ISAR4 vs ISAR3 problem).  What if ISAR4 20:23 have
> bit 23 set?  In the original code, that would be treated as being ">= 3"
> but in the new code, that's less than zero, so would fail the test.
>
> I think we had much the same questions back in March 2015 when this was
> last discussed, when I raised the issue of there being a documentation
> bug in that the documentation doesn't make it clear how reserved 4-bit
> CPU ID fields should be intepreted.
>
> What I'd like to see is some kind of positive concensus on this (and
> a doc update); what I don't want to do is to apply these patches and
> then get another round of patches converting some of them back to
> signed tests, and then later another set of patches doing the reverse,
> because that seems to be what's now happening.
>

Indeed. As I commented to one of the other patches, having any kind of
less-than/greater-than relation does not make any sense if the ARM ARM
defines '0 means A, 1 means B, all other values reserved' since the
whole point of the comparisons is to infer A or B (or both) from other
values than 0 or 1. My understanding at the time was that these fields
are signed 4-bit quantities, and so each positive value n implies all
of [0, n-1] as well.

If this turns out not to be the case, we should simply not infer the
presence of features based on
reserved-yet-greater-than-some-documented values, and back out my
changes to that effect as well.

-- 
Ard.
