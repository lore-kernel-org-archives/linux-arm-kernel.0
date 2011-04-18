From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 18 Apr 2011 17:31:31 +0800
Subject: [RFC PATCH v2] Consolidate SRAM support
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimKvRbrrm7sxcYRpRe+FMH-kTNoiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 4:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This is the second revision of this patch. ?I've not moved it out of
> ARM yet as I haven't had a positive response from SH yet.
>
> It's now called pv_pool (for phys/virt pool) rather than sram_pool,
> and I've included MXC's iram support in this. ?Hopefully, if OMAP can
> remove the FB stuff from SRAM we can clean the OMAP bits up a little
> more. ?Neither have I sorted out the last reference to omap_sram_ceil.
> Some comments from OMAP people on what's going on there would be good.
>
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
>> This is work in progress.
>>
>> We have two SoCs using SRAM, both with their own allocation systems,
>> and both with their own ways of copying functions into the SRAM.
>>
>> Let's unify this before we have additional SoCs re-implementing this
>> obviously common functionality themselves.
>>
>> Unfortunately, we end up with code growth through doing this, but that
>> will become a win when we have another SoC using this (which I know
>> there's at least one in the pipeline).
>>
>> One of the considerations here is that we can easily convert sram-pool.c
>> to hook into device tree stuff, which can tell the sram allocator:
>> ? ? ? - physical address of sram
>> ? ? ? - size of sram
>> ? ? ? - allocation granularity
>> and then we just need to ensure that it is appropriately mapped.
>>
>> This uses the physical address, and unlike Davinci's dma address usage,
>> it always wants to have the physical address, and will always return
>> the corresponding physical address when passed that pointer.
>>
>> OMAP could probably do with some more work to make the omapfb and other
>> allocations use the sram allocator, rather than hooking in before the
>> sram allocator is initialized - and then further cleanups so that we
>> have an initialization function which just does
>>
>> sram_create(phys, size)
>> ? ? ? virt = map sram(phys, size)
>> ? ? ? create sram pool(virt, phys, size, min_alloc_order)
>>
>> Another question is whether we should allow multiple SRAM pools or not -
>> this code does allow multiple pools, but so far we only have one pool
>> per SoC. ?Overdesign? ?Maybe, but it prevents SoCs wanting to duplicate
>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
>>
Multiple SRAM pool does exist in Marvell MMP2 silicon. So it won't be
overdesign.

>> Lastly, uio_pruss should probably take the SRAM pool pointer via
>> platform data so that it doesn't have to include Davinci specific
>> includes.
>
