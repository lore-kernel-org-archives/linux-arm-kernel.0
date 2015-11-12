From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Nov 2015 17:30:47 +0100
Subject: [PATCH 0/3] remove UEFI reserved regions from the linear mapping
In-Reply-To: <20151112161309.GF26564@leverpostej>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151112155523.GD26564@leverpostej>
 <CAKv+Gu8Rd3T_2mjMkx0VZQ052mFjxufGB-U7_EuivvR+5M64cw@mail.gmail.com>
 <20151112161309.GF26564@leverpostej>
Message-ID: <CAKv+Gu-p9F79xA3F==-2K8n29QfdSk=2Q1cq=cs_EAMF4sT+Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 17:13, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Nov 12, 2015 at 05:01:19PM +0100, Ard Biesheuvel wrote:
>> On 12 November 2015 at 16:55, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Oct 29, 2015 at 02:40:56PM +0100, Ard Biesheuvel wrote:
[...]
>> >> Patch #1 slightly reorders the UEFI runtime services initialization routines
>> >> so that the EFI_MEMMAP flag is only set if the permanent mapping of the UEFI
>> >> memory map is in place.
>> >
>> > This also means that the memory map is mapped even with EFI runtime
>> > support disabled, but I guess that's not a big problem.
>> >
>>
>> Yes. You need that anyway if you are going to rely on it even when the
>> runtime services are disabled.
>
> Not with the MEMBLOCK_NOMAP approach.
>

No, you're right. And actually, it also avoids the whole page_is_ram()
problem, since all regions (including the NOMAP ones) are registered
as 'System RAM' ranges, so in that respect, nothing changes from the
ACPI/page_is_ram() pov

> I don't have a strong case for caring about that; I only imagine that
> being a problem if you're trying to track down extremely nasty memory
> corruption / bad pointer bugs and want the bare minimum VA space mapped.
> Even then the impact is minimal.
>

Indeed. And in general, I am in favour of not relying on the UEFI
memory map at all if we can avoid it, but use memblock as an
intermediate memory map that is equally available on !UEFI boots.

>> > As a side thought, it would be nice if we could memremap_ro the system
>> > table and memory map in future to prevent potential corruption, given
>> > they have fixed VAs and are always mapped.
>> >
>>
>> I agree, and I already have some local patches using
>> early_memremap_ro() for the EFI init code.
>
> Ah, nice!
>
>> memremap_ro() does not actually exist yet, but I intend to propose
>> MEMREMAP_RO and MEMREMAP_NX flags to Dan Williams's memremap() work
>> once I get around to it.
>
> That sounds good; I would certainly be in favour of that.
>
> For some reason I thought the memremap arch changes had gone in for
> v4.3, but I see that's not the case. I'll take a look around.
>

There are some complications, I think. On ARM, ioremap_cache()
disallows remapping of pfn_valid() pages, whereas arm64 short circuits
those to return the linear mapping directly (which, again for highmem
reasons, is not feasible on ARM)

Anyway, I am trying not to make changes on the arm64 side that are
difficult to port to ARM. MEMBLOCK_NOMAP works fine on both sides, so
perhaps I should just revert to using that instead of opening the
page_is_ram() can of worms.

-- 
Ard.
