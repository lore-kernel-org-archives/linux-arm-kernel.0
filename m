From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 22 Apr 2014 12:41:01 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140422104043.GT24070@n2100.arm.linux.org.uk>
References: <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
 <20140417213502.GX24070@n2100.arm.linux.org.uk>
 <CAL_JsqKCGg25wrTq8SyXK3zebo+uJG61083K6--mJ9Fxek03XQ@mail.gmail.com>
 <alpine.LFD.2.11.1404180019410.980@knanqh.ubzr> <535643ED.8030406@linaro.org>
 <20140422104043.GT24070@n2100.arm.linux.org.uk>
Message-ID: <5356554D.6030207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/14 11:40, Russell King - ARM Linux wrote:
> On Tue, Apr 22, 2014 at 11:26:53AM +0100, Daniel Thompson wrote:
>> On 18/04/14 05:34, Nicolas Pitre wrote:
>>>> I'm not suggesting to break anything or changing existing platforms,
>>>>> but how do we improve the Image format in a compatible way. If
>>>>> bootloaders want to support booting Image files or vmlinux directly,
>>>>> then we should support that including any compatible changes to make
>>>>> things work better.
>>> And why would bootloaders want that?  Just to create confusion with 
>>> the established boot protocol?
>>
>> I'd say that they don't. My original concern was how the different
>> architectures negotiate if more than one arch wants a special text
>> offset, not how to write a correct bootloader.
>>
>> The existing uImage files already provide sufficient information to load
>> the kernel regardless of the TEXT_OFFSET chosen by negotiation among the
>> enabled architectures.
> 
> No.  uImage merely specifies the address at which to load/execute the
> zImage, and more often than not this is a step which has to be done
> after kernel build as the kernel build does not have the information
> to be able to generate a uImage on its own.  Also, a uImage generated
> for one platform will not necessarily boot on a different platform
> even though the contents of the uImage may be 100% identical apart
> from the header.

You were right about the typo but I'm afraid the location was much
earlier. Sorry! Replace uImage with the vmlinux ELF image and my last
post is not quite such nonsense.


>> The entry point is PAGE_OFFSET + TEXT_OFFSET and, although only
>> implicitly defined, the entry point cannot be set to any other value
>> without making a backward incompatible to arm/Booting:
>>     "The boot loader is expected to call the kernel image by jumping
>>     directly to the first instruction of the kernel image."

Although for this bit probably will always be nonsense.


>> Therefore providing PAGE_OFFSET remains 1G aligned and the hardware
>> meets the not-unreasonably-stupid test (i.e. TEXT_OFFSET < 1G) then
>> deriving the right value for TEXT_OFFSET is a trivial mask operation on
>> the entry point.
> 
> PAGE_OFFSET doesn't have to be 1G aligned.  As I've already pointed out
> in previous replies, PAGE_OFFSET is totally irrelevant in this discussion.
> PAGE_OFFSET is the *virtual* address of the RAM, and has no bearing what
> so ever on where you load the kernel image.

When trying to directly load an ELF image, where by default vaddr ==
paddr, its actually PAGE_OFFSET we're looking for. Combining that with
some platform specific knowledge about RAM (i.e. typical PHYS_OFFSET for
the platform) and we can derive sensible paddr values.

At the start of last week the loader I used assumed TEXT_OFFSET would be
0x8000 and used it to calculate PAGE_OFFSET from the ELF entry point.

So I guess what I have now is still broken just, not quite as obviously...
