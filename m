From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2018 13:11:24 +0100
Subject: [PATCH] arm64: kprobe: make page to RO mode when allocate it
In-Reply-To: <20181029120434.GA15446@arm.com>
References: <20181015111600.5479-1-anders.roxell@linaro.org>
 <20181029120434.GA15446@arm.com>
Message-ID: <CAK8P3a0oSn8Z6wJT1X2si8+A2wttkh7EjqD_MZYt4+L5a_XKLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/18, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 15, 2018 at 01:16:00PM +0200, Anders Roxell wrote:

>> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +void *alloc_insn_page(void)
>>  {
>> -	void *addrs[1];
>> -	u32 insns[1];
>> +	void *page;
>>
>> -	addrs[0] = (void *)addr;
>> -	insns[0] = (u32)opcode;
>> +	page = vmalloc_exec(PAGE_SIZE);
>> +	if (page)
>> +		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
>
> This looks a bit strange to me -- you're allocating PAGE_SIZE bytes so
> that we can adjust the permissions, yet we can't guarantee that page is
> actually page-aligned and therefore end up explicitly masking down.
>
> In which case allocating an entire page isn't actually helping us, and
> we could end up racing with somebody else changing permission on the
> same page afaict.
>
> I think we need to ensure we really have an entire page, perhaps using
> vmap() instead? Or have I missed some subtle detail here?

I'm fairly sure that vmalloc() and vmalloc_exec() is guaranteed to be page
aligned everywhere. The documentation is a bit vague here, but I'm
still confident enough that we can make that assumption based on

/**
 *      vmalloc_exec  -  allocate virtually contiguous, executable memory
 *      @size:          allocation size
 *
 *      Kernel-internal function to allocate enough pages to cover @size
 *      the page level allocator and map them into contiguous and
 *      executable kernel virtual space.
 *
 *      For tight control over page level allocator and protection flags
 *      use __vmalloc() instead.
 */
void *vmalloc_exec(unsigned long size)


       Arnd
