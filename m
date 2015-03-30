From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 20:08:52 +0200
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <20150330150008.GD5964@e104818-lin.cambridge.arm.com>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150325145949.GE26903@localhost>
 <CAKv+Gu8LQGNVDw36B+Lv4xMQkcGN=M=uHxey-94cqrmE=AZDvg@mail.gmail.com>
 <CAKv+Gu_3PG7ffwn+TK7PdUPeovVoamb4XX1PSfor-3sNKW-0AQ@mail.gmail.com>
 <20150330123011.GB5964@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84YezZSQmyf4cV34TxMKRPytcFyrrTGO3RFx=_17i-Mg@mail.gmail.com>
 <20150330150008.GD5964@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-C5c0Ma+KEWkPWbxhcgvGfZXyDp4OXxG_BMyR7Hwtk1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 17:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 30, 2015 at 04:00:31PM +0200, Ard Biesheuvel wrote:
>> On 30 March 2015 at 15:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > Can we defer the setting of PHYS_OFFSET until we parse the DT memory
>> > nodes?
>>
>> I experimented a bit with that, but it is quite hairy. Any
>> manipulation of the page tables goes through __va/__pa, so you need a
>> valid PHYS_OFFSET there to ensure they point at the right physical
>> region.
>
> Yes, so we need set PHYS_OFFSET before we start using __va/__pa.
>
>> But PHYS_OFFSET also needs to be small enough for the DT
>> parsing code not to disregard regions that are below it.
>
> With PHYS_OFFSET as 0 initially, no regions would be dropped. But we
> could write a simplified early_init_dt_add_memory_arch() which avoids
> the PHYS_OFFSET check while setting the actual PHYS_OFFSET to the
> minimal address detected. I can see the generic function only uses
> __pa() to get the PHYS_OFFSET.
>

Excellent idea.

>> And then
>> there is the memblock limit to ensure that early dynamically allocated
>> page tables come from a region that is already mapped.
>
> By the time we start using memblock allocations, we have a PHYS_OFFSET
> set. The early DT parsing does not require any memory allocations AFAIK.
> We need to make sure that setup_machine_fdt creates a VA mapping of the
> DT and does not require the __va() macro (I thought I've seen some
> patches to use fixmap for DT).
>

Yes, so did I :-)

But using early_fixmap() implies using the ordinary page tables
manipulation code, which uses __pa/__va
So instead, I should refactor those patches to simply pick a VA offset
and map the FDT there from head.S

>> I think it may be doable, but it would require some significant
>> hacking, e.g., call early_init_scan_dt() at its physical address with
>> only the ID map loaded and the MMU and caches on, and only after that
>> start populating the virtual address space. Or at least only populate
>> the lower half, i.e., mappings below PAGE_OFFSET for the kernel and
>> the FDT
>
> With some form of your patches, we already decouple the PAGE_OFFSET from
> the kernel text mapping. We map the latter at some very high
> KERNEL_PAGE_OFFSET, the DT via fixmap (which is part of the kernel data
> section, so mapped at the high KERNEL_PAGE_OFFSET). Once we start
> calling early_init_dt_add_memory_arch(), we set the real PAGE_OFFSET and
> are free to use __pa/__va after setup_machine_fdt(). The actual linear
> mappings will be created later via paging_init().
>

OK, that sounds like it could work.

The only thing to note is (and this should answer Mark's question in
the other thread) is that the pgdir region should be mapped via the
linear mapping as well.
The alternative is to make __va() check whether the input physical
address falls within the pgdir region, and subtract the PAGE_OFFSET -
KERNEL_PAGE_OFFSET from the return value, but this is less trivial
than the __pa() counterpart which only needs to check a single bit.

So I propose we take defines KERNEL_PAGE_OFFSET as (PAGE_OFFSET -
SZ_64M) and FDT_PAGE_OFFSET (or whatever you want to call it) as
(PAGE_OFFSET - SZ_2M).
That way, the kernel, fdt and module space always share the same 128
MB window, which we can move around in the vmalloc space later if we
want to implement kASLR.
