From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 31 Jul 2015 15:30:23 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <20150731132238.GP407@e104818-lin.cambridge.arm.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-G9Vpmt_c84OsG0JNRKopJ44uneJaAEpY3AMq6oS-Qdg@mail.gmail.com>
 <20150731125303.GO407@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_KL6F=9DpV=ZqYUgY9wjBF+FBodnLMBw=ZOFo6xK7-2w@mail.gmail.com>
 <20150731132238.GP407@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu88g7o8+BzK9TtZVmq9+n8uK7GzbMJUygTbgZ9Pf1_1cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2015 at 15:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Jul 31, 2015 at 03:10:39PM +0200, Ard Biesheuvel wrote:
>> On 31 July 2015 at 14:53, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Thu, Jul 30, 2015 at 09:27:03PM +0200, Ard Biesheuvel wrote:
>> >> On 30 July 2015 at 12:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> > On Wed, Jul 29, 2015 at 08:49:57PM +0000, Stuart Yoder wrote:
>> >> >> > From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
>> >> [...]
>> >> >> > To be honest, I think this is poorly designed, and I am not sure we
>> >> >> > should cater for such configurations in the defconfig.
>> >> >>
>> >> >> Agree, if this is a one-off weird platform then we shouldn't.
>> >> >>
>> >> >> But, the 'Principles of ARM Memory Maps' doc proposes this:
>> >> >> 2 GB at 0x8000_0000
>> >> >> 30 GB at 0x8_8000_0000
>> >> >> 480 GB at 0x88_0000_0000
>> >> >
>> >> > I'm not particularly recommending this layout, at least not without some
>> >> > clarifications on DRAM aliases (I'll ping people internally about it
>> >> > again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
>> >> > and all the memory beyond 32-bit was highmem anyway. It was later
>> >> > updated for AArch64 but only to allow 44/48-bit PA (a few sections
>> >> > added).
>> >>
>> >> As an aside, is there any reason why the direct mapping *must* be a
>> >> linear mapping?
>> >> Other than the performance concerns regarding
>> >> phys_to_virt/virt_to_phys, I mean?
>> >
>> > Mostly performance concerns. You could compact the physical range into a
>> > smaller virtual one but the conversion will be costly, especially if you
>> > want to make it multi-platform (having to look-up memory ranges,
>> > memblock offsets). This would affect page table entry setup, code that
>> > requires a page structure (like virt_to_page) and anything else doing
>> > the virt/phys conversion.
>> >
>> > I tried something like that for RealView PBX in the past but it was
>> > hard-coded (no multi-platform at the time). See
>> > arch/arm/mach-realview/include/mach/memory.h.
>>
>> Yes, that looks vaguely like what I had in mind.
>>
>> IOW, we could partition the direct mapping just like the ARM
>> recommendation, i.e.,
>>
>> 0 - 2 GB
>> 2 - 32 GB
>> 32 - 512 GB
>>
>> but default to 1:1 correspondence, so that
>>
>> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
>> PHYS_OFFSET1 = memstart_addr + 2 GB
>> PHYS_OFFSET2 = memstart_addr + 32 GB
>>
>> and only if the ARM recommended physical memory map is detected (with
>> memstart_addr @ 0x8000_0000), switch to
>>
>> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
>> PHYS_OFFSET1 = memstart_addr + 30 GB
>> PHYS_OFFSET2 = memstart_addr + 480 GB
>
> I don't really like such complexity when all you need on arm64 is to
> enable 48-bit VA (though it would be interesting to benchmark it).
>
>> I guess such a special case would be out of the question for one-off
>> crazy designs like Freescale, but since this is the layout recommended
>> by ARM itself, I suppose we could try and support it a bit better.
>
> I'm trying to get the layout fixed before it spreads any further ;).

Yes, that would be even better.

> Interestingly, SBSA doesn't mention this document at all.
>

No, and the document itself never claims that its recommendations
apply universally, i.e., from the introduction

"""
This document describes the address maps used by ARM for A-class
systems, from models and emulators to development boards and complex
SoCs.
"""

where 'used by ARM' should probably be clarified to mean 'used by ARM
Ltd. for its own designs' rather than 'recommended by ARM Ltd. for all
designs by licensees'
