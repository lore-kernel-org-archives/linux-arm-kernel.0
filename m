From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jul 2015 13:58:07 +0200
Subject: bug in identity map for 4KB pages?
In-Reply-To: <CAKv+Gu-0NO5QnK34iXEK2_ATgsSYLMUwiq7u_=iPv5UrNba4kQ@mail.gmail.com>
References: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
 <20150729114258.GK15213@leverpostej>
 <CAKv+Gu-0NO5QnK34iXEK2_ATgsSYLMUwiq7u_=iPv5UrNba4kQ@mail.gmail.com>
Message-ID: <CAKv+Gu8uOO52xt+VX7YR5YHCN-Tan7mBRpR-xCJD33eE=vJcSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 13:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 29 July 2015 at 13:42, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Wed, Jul 29, 2015 at 08:47:10AM +0100, Ard Biesheuvel wrote:
>>> On 29 July 2015 at 04:37, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>>> > Our system has RAM at a high address, and previously required using 48-bit VA
>>> > in order to have an idmap that covered all of RAM.
>>> >
>>> > In testing on 4.2-rc4, which now contains support for the increased VA range
>>> > of the idmap without using 48-bit VA, I'm finding that things work for
>>> > 64KB pages, but do not for 4KB pages.
>>> >
>>> > Is there any known limitation here with 4KB pages?  Any ideas?
>>> >
>>>
>>> You probably have memory at 0x8000_0000 and at 0x80_8000_0000, right?
>>> So the physical arrangement still requires more than the 39 bits of
>>> virtual address space you get with 3 levels, even if the ID map can
>>> cope now. That is why you get the 0x40_0000_0000 virtual address:
>>> __phys_to_virt() just wraps to a positive number.
>>
>> Ah, I see. So it's the linear mapping rather than the idmap which is the
>> problem.
>>
>> We cut memory which would fall below the start of the linear map in
>> early_init_dt_add_memory_arch, by cutting memory below phys_offset.
>>
>> It looks like we already have the logic for cutting memory beyond the
>> end of the linear map, so we should just need to override the limit.
>>
>> Stuart, does the below patch prevent the panic you see?
>>
>
> Wouldn't something like this make more sense?
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 597831bdddf3..64480b65ef17 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -158,6 +158,15 @@ early_param("mem", early_mem);
>
>  void __init arm64_memblock_init(void)
>  {
> +       /*
> +        * Remove the memory that we will not be able to cover
> +        * with the linear mapping.
> +        */
> +       const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +
> +       memblock_remove(0, memstart_addr);
> +       memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
> +
>         memblock_enforce_memory_limit(memory_limit);
>
>         /*
> """
>
> (taken from my patch 'arm64: override early_init_dt_add_memory_arch()'
> sent to the list a while ago as part of the linear mapping decoupling
> series)
>

(replying to self) but actually, either solution still means that, of
the ~16 GB this platform seems to have installed, only 2 GB is made
available.

I suppose there is little we can do about it, since we cannot ignore
the lower 2GB if the kernel resides there ...

-- 
Ard.
