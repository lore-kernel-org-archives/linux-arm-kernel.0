From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Mar 2016 18:41:35 +0100
Subject: [PATCH v2 0/3] fix memremap on ARM
In-Reply-To: <CAPcyv4j-Pz8uMTnz+OJZGguQqS1jOG4U+JkpsO7cBRFvs=-Ehg@mail.gmail.com>
References: <1456508053-15015-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_8Fggh+hnVnj6pM6PbOysWFTNt=ot6nudLur9nzs2FVg@mail.gmail.com>
 <20160303171347.GY19428@n2100.arm.linux.org.uk>
 <CAKv+Gu_5vmxsigsCfsvcjFa-hhOP6vxnMavsQ45oKgMeYzgUSg@mail.gmail.com>
 <CAPcyv4ijokZMTNPsxVOafMUCT_CHyScTkCGbR94mcYOhQOKNqA@mail.gmail.com>
 <CAKv+Gu80AJ+UDGLWpr=1sYT57J+6X8-KZ5HCYSEz9JpgWaTQxA@mail.gmail.com>
 <CAPcyv4j-Pz8uMTnz+OJZGguQqS1jOG4U+JkpsO7cBRFvs=-Ehg@mail.gmail.com>
Message-ID: <CAKv+Gu_z0B9rK4NJgrZFXLXWhgi+LVj6E9555vx60LSEoRy9tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2016 at 18:33, Dan Williams <dan.j.williams@intel.com> wrote:
> On Thu, Mar 3, 2016 at 9:30 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 3 March 2016 at 18:27, Dan Williams <dan.j.williams@intel.com> wrote:
>>> On Thu, Mar 3, 2016 at 9:16 AM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 3 March 2016 at 18:13, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>>> On Thu, Mar 03, 2016 at 05:24:41PM +0100, Ard Biesheuvel wrote:
>>>>>> If there are no remaining objections, may I suggest that Dan takes
>>>>>> patch #1 and #2, and that I put the third patch into Russell's patch
>>>>>> system? The only strict ordering requirement is that #1 is merged
>>>>>> before #2 and #3 both hit mainline, and that is solved by taking #1
>>>>>> and #2 in order.
>>>>>
>>>>> How does the dependency between 1 and 3 get satisfied?  Your comment
>>>>> makes no sense to me.
>>>>>
>>>>
>>>> Patch #3 introduces a function arch_memremap_wb() on the ARM side
>>>> which will never get called unless patch #2 is also merged. Once both
>>>> #2 and #3 are in, the memremap() call that #1 reverts will use
>>>> MT_MEMORY_RW attributes rather than MT_DEVICE_CACHED, so #1 needs to
>>>> go first, but #2 and #3 can go in in either order.
>>>>
>>>> In other words, there are no build dependencies between the patches,
>>>> but to prevent pxa2xx-flash from using MT_MEMORY_RW attributes, it
>>>> needs to go in before #2
>>>
>>> Can we add a new MEMREMAP_ type for this case so that we don't need to
>>> keep carrying the confusing ioremap_cache() which means different
>>> things to different archs and silently falls back to uncached on some
>>> archs.
>>
>> Actually, I don't think so. Unifying ioremap_cache() between
>> architectures was a mistake to begin with, since I/O mapping
>> attributes vary so wildly between architectures, and there are very
>> few drivers that depend on such specific behavior that actually need
>> to be built for multiple architectures.
>>
>> So I think your memremap() is a fantastic idea, considering the
>> widespread abuse of ioremap_cache(), also in common code. But removing
>> it altogether to replace it with something that looks generic but
>> never is, is just repeating the same mistake imo.
>
> I'm not suggesting it be a generic flag.  I.e. something like
> MEMREMAP_ARM_ that explicitly documents that this driver has arch
> specific mapping dependencies.  That request type will fail on any
> arch that does not implement MEMREMAP_ARM_ support.

I don't see the point of adding this to a generic API. ioremap_cache()
is used to perform I/O, even if it has memory semantics on read.
Getting rid of the abuse, where ioremap_cache() is used to map system
RAM to access ACPI tables etc is something that we should fix, yes,
but arch specific I/O needs to stay out of the picture imo, simply
because there is no problem to fix here.
