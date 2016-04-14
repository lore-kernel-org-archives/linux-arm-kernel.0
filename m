From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 14 Apr 2016 17:33:15 +0200
Subject: [PATCH v2 9/9] mm: replace open coded page to virt conversion
 with page_to_virt()
In-Reply-To: <20160414152532.GD4584@arm.com>
References: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459349164-27175-10-git-send-email-ard.biesheuvel@linaro.org>
 <20160414152532.GD4584@arm.com>
Message-ID: <CAKv+Gu_EwTuJEgUs61GOdGeCnB4XWiqdaLL3hhbK-Uu3+-px8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 April 2016 at 17:25, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 30, 2016 at 04:46:04PM +0200, Ard Biesheuvel wrote:
>> The open coded conversion from struct page address to virtual address in
>> lowmem_page_address() involves an intermediate conversion step to pfn
>> number/physical address. Since the placement of the struct page array
>> relative to the linear mapping may be completely independent from the
>> placement of physical RAM (as is that case for arm64 after commit
>> dfd55ad85e 'arm64: vmemmap: use virtual projection of linear region'),
>> the conversion to physical address and back again should factor out of
>> the equation, but unfortunately, the shifting and pointer arithmetic
>> involved prevent this from happening, and the resulting calculation
>> essentially subtracts the address of the start of physical memory and
>> adds it back again, in a way that prevents the compiler from optimizing
>> it away.
>>
>> Since the start of physical memory is not a build time constant on arm64,
>> the resulting conversion involves an unnecessary memory access, which
>> we would like to get rid of. So replace the open coded conversion with
>> a call to page_to_virt(), and use the open coded conversion as its
>> default definition, to be overriden by the architecture, if desired.
>> The existing arch specific definitions of page_to_virt are all equivalent
>> to this default definition, so by itself this patch is a no-op.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> I assume you'll post this patch (and the nios2/openrisc) patches as
> individual patches targetting the relevant trees?
>

Sure, as they are completely independent from the rest of the series.
