From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 11 Dec 2013 14:48:33 +0530
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <20131210170223.GE2854@darko.cambridge.arm.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <5295D1A5.5090403@arm.com>
 <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
 <5296330D.9010801@arm.com>
 <CAC8NTUVvLgNPdsSPY6Ms_D3JoyJR8AEFRH0=M7-kQEUegNVhKg@mail.gmail.com>
 <CAC8NTUUHiaB3m+zmoPPKXTzWq82veNhT4gCERSQiLvKhfMvRyQ@mail.gmail.com>
 <20131205173036.GE17165@arm.com>
 <CAC8NTUXVeSJMyG0H7PB_ms-vUpzk224XFmVq5JXQPzhJrgCdPw@mail.gmail.com>
 <20131210170223.GE2854@darko.cambridge.arm.com>
Message-ID: <CAC8NTUVtzdtxmdhVf3452LeAVUCjtF8DzdLy44K5rehUNoc0bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 10:32 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Dec 10, 2013 at 04:53:24PM +0000, Radha Mohan wrote:
>> On Thu, Dec 5, 2013 at 11:00 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Thu, Dec 05, 2013 at 02:35:52PM +0000, Radha Mohan wrote:
>> >> Before going for a next version of patch to fix breaking SMMU and KVM,
>> >> I would like to know  about the best possible implementation.
>> >> Should I go for a compile time option? I am not in favor of this. What
>> >> are options if in future there's 16KB page support in the kernel.
>> >
>> > As I said in the other email, separate the shifts definitions (primarily
>> > page size dependent) from the type definitions (dependent on the number
>> > of levels).
>> >
>> > Just to understand your requirements better. Does your platform have
>> > more than 256GB of RAM? With the current configuration, the VA space is
>> > 39-bit with 4K (which would allow 512GB minus some vmalloc and modules
>> > space) and 42-bit with 64K pages (2TB minus vmalloc/modules).
>>
>> Sorry for the delay in responding.
>> More than 256GB DRAM is a likely possibility. But I am unsure of the
>> exact page size that would be used. That is the reason for expanding
>> the VA bits to full and have flexibility for customers. As Marc
>> mentioned this is a rare requirement for now in ARMv8 processors, but
>> would be nice to have a plan for long term. I would prefer a runtime
>> support for this i.e reading the ID_AA64MMFR0_EL1.PARange value but I
>> think this would be a major rework.
>
> Don't confuse the physical address range (given by PARange) with the
> virtual address range. On arm64 we don't have to use highmem to access
> the RAM, so if you have lots of RAM (maximum architecture limit with
> 3-levels and 4K pages is 512GB) we need to expand the VA space to map
> it. But just having 48-bit PA space doesn't necessarily require the same
> VA space (unless for some weird reason all the RAM lives beyond bit 39
> which would require the idmap to have 4 levels, but even then we could
> do this just for a static idmap table).

OK. I will stick to 3-levels for now and redo the patch for 48-bit PA.

>
> --
> Catalin
