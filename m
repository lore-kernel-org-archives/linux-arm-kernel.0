From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 21 May 2014 12:56:19 +0200
Subject: + arm-move-arm_dma_limit-to-setup_dma_zone.patch added to -mm tree
In-Reply-To: <CABV+yWt8vJK-ahGFhtoVbGLhkOOxy3-SLZQdaE5V1Oy+oQsh4w@mail.gmail.com>
References: <CAKv+Gu_QCJn5UGyM4zEPLvkTPMnfwTM2qKYnBU42vEPwwt6-Dg@mail.gmail.com>
 <CABV+yWt8vJK-ahGFhtoVbGLhkOOxy3-SLZQdaE5V1Oy+oQsh4w@mail.gmail.com>
Message-ID: <CAKv+Gu9-h+cEPtHcYwdH5OVUFYAnqDtXgQYFA+Liy-+A4=mAdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 08:50, Vladimir Murzin <murzin.v@gmail.com> wrote:
> Hi Ard
>
> On 5/19/14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Gents,
>>
>> I noticed this patch turning up in -next:
>> http://ozlabs.org/~akpm/mmots/broken-out/arm-move-arm_dma_limit-to-setup_dma_zone.patch
>>
>> which I think is incorrect. More specifically, it replaces a reference
>> to arm_dma_limit, which is defined as either
>>
>> arch/arm/mm/init.c:177:         arm_dma_limit = PHYS_OFFSET +
>> arm_dma_zone_size - 1;
>>
>> or
>>
>> arch/arm/mm/init.c:179:         arm_dma_limit = 0xffffffff;
>>
>> with 'arm_dma_pfn_limit << PAGE_SHIFT', which means the bottom
>> PAGE_SHIFT '1' bytes are lost.
>>
>
> Do not we lost even more with
> dma_contiguous_reserve
>      dma_contiguous_reserve_area
> ...
>         /* Sanitise input arguments */
>         alignment = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
>         base = ALIGN(base, alignment);
>         size = ALIGN(size, alignment);
>         limit &= ~(alignment - 1);
>

That's interesting. It looks like there may be a mismatch here: we
pass an inclusive limit where the callee expects it to be exclusive,
resulting in the top 4 megabytes of the DMA zone to be lost (for
pageblock_order == MAX_ORDER-1). I.e., if arm_dma_zone == SZ_64M, we
will end up calling __memblock_alloc_base() with a limit of 60 megs.

@Russell: care to share your thought on this?

-- 
Ard.
