From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 2 Aug 2015 08:19:07 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <1524396.PS7zpagrm1@wuerfel>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150731132238.GP407@e104818-lin.cambridge.arm.com>
 <CAKv+Gu88g7o8+BzK9TtZVmq9+n8uK7GzbMJUygTbgZ9Pf1_1cw@mail.gmail.com>
 <1524396.PS7zpagrm1@wuerfel>
Message-ID: <CAKv+Gu89UGzL9=0tYjQmv9dX7KOsfobpO4zG1E8X0g4W9u5Bkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2015 at 23:08, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 31 July 2015 15:30:23 Ard Biesheuvel wrote:
>> On 31 July 2015 at 15:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> > I tried something like that for RealView PBX in the past but it was
>> >> > hard-coded (no multi-platform at the time). See
>> >> > arch/arm/mach-realview/include/mach/memory.h.
>> >>
>> >> Yes, that looks vaguely like what I had in mind.
>> >>
>> >> IOW, we could partition the direct mapping just like the ARM
>> >> recommendation, i.e.,
>> >>
>> >> 0 - 2 GB
>> >> 2 - 32 GB
>> >> 32 - 512 GB
>> >>
>> >> but default to 1:1 correspondence, so that
>> >>
>> >> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
>> >> PHYS_OFFSET1 = memstart_addr + 2 GB
>> >> PHYS_OFFSET2 = memstart_addr + 32 GB
>> >>
>> >> and only if the ARM recommended physical memory map is detected (with
>> >> memstart_addr @ 0x8000_0000), switch to
>> >>
>> >> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
>> >> PHYS_OFFSET1 = memstart_addr + 30 GB
>> >> PHYS_OFFSET2 = memstart_addr + 480 GB
>> >
>> > I don't really like such complexity when all you need on arm64 is to
>> > enable 48-bit VA (though it would be interesting to benchmark it).
>
> More importantly, hardwiring this in virt_to_phys() would mean we can
> no longer run a kernel with this hack turned on with systems that have
> contiguous memory or any other layout besides the one from the document.
>

Well the hack, if enabled, would be turned on dynamically iff the
exact layout from the recommendation is detected, and the kernel is
loaded right at the base of DRAM.
Note that the first layout I presented is effectively the current
linear mapping, but with three steps.

> I also don't think it's a huge issue. On systems with lots of RAM,
> you want the 48-bit VA space anyway to run things like databases
> (which tend to mmap large files) efficiently, so all distros will
> use that anyway (except the crazy ones that use 64kb pages and
> also don't have the problem), and anyone with less than 32GB can
> live with 3-leval tables if they run a custom kernel.
>
>> >> I guess such a special case would be out of the question for one-off
>> >> crazy designs like Freescale, but since this is the layout recommended
>> >> by ARM itself, I suppose we could try and support it a bit better.
>> >
>> > I'm trying to get the layout fixed before it spreads any further ;).
>>
>> Yes, that would be even better.
>
> +1
>
>         Arnd
