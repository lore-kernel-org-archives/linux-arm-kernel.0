From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 25 Jan 2011 09:33:59 +0900
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <20110124175807.GA27427@n2100.arm.linux.org.uk>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
	<20110120180146.GH6335@n2100.arm.linux.org.uk>
	<1295547087.9039.694.camel@nimitz>
	<20110123180532.GA3509@n2100.arm.linux.org.uk>
	<1295887937.11047.119.camel@nimitz>
	<20110124175807.GA27427@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikK4oGx1dNTDfxketVr2kPdrg=WsrOXThVD6_U2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 2:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 08:52:17AM -0800, Dave Hansen wrote:
>> On Sun, 2011-01-23 at 18:05 +0000, Russell King - ARM Linux wrote:
>> > On Thu, Jan 20, 2011 at 10:11:27AM -0800, Dave Hansen wrote:
>> > > On Thu, 2011-01-20 at 18:01 +0000, Russell King - ARM Linux wrote:
>> > > > > The x86 version of show_mem() actually manages to do this without any
>> > > > > #ifdefs, and works for a ton of configuration options. ?It uses
>> > > > > pfn_valid() to tell whether it can touch a given pfn.
>> > > >
>> > > > x86 memory layout tends to be very simple as it expects memory to
>> > > > start at the beginning of every region described by a pgdat and extend
>> > > > in one contiguous block. ?I wish ARM was that simple.
>> > >
>> > > x86 memory layouts can be pretty funky and have been that way for a long
>> > > time. ?That's why we *have* to handle holes in x86's show_mem(). ?My
>> > > laptop even has a ~1GB hole in its ZONE_DMA32:
>> >
>> > If x86 is soo funky, I suggest you try the x86 version of show_mem()
>> > on an ARM platform with memory holes. ?Make sure you try it with
>> > sparsemem as well...
>>
>> x86 uses the generic lib/ show_mem(). ?It works for any holes, as long
>> as they're expressed in one of the memory models so that pfn_valid()
>> notices them.
>
> I think that's what I said.
>
>> ARM looks like its pfn_valid() is backed up by searching the (ASM
>> arch-specific) memblocks. ?That looks like it would be fairly slow
>> compared to the other pfn_valid() implementations and I can see why it's
>> being avoided in show_mem().
>
> Wrong. ?For flatmem, we have a pfn_valid() which is backed by doing a
> one, two or maybe rarely three compare search of the memblocks. ?Short
> of having a bitmap of every page in the 4GB memory space, you can't
> get more efficient than that.
>
> For sparsemem, sparsemem provides its own pfn_valid() which is _far_
> from what we require:
>
> static inline int pfn_valid(unsigned long pfn)
> {
> ? ? ? ?if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> ? ? ? ? ? ? ? ?return 0;
> ? ? ? ?return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> }
>
>> Maybe we should add either the MAX_ORDER or section_nr() trick to the
>> lib/ implementation. ?I bet that would use pfn_valid() rarely enough to
>> meet any performance concerns.
>
> No. ?I think it's entirely possible that on some platforms we have holes
> within sections. ?Like I said, ours is more funky than x86.
>
I don't think the improving performance can result the possibility of
misbehavior.

> The big problem we have on ARM is that the kernel sparsemem stuff doesn't
> *actually* support sparse memory. ?What it supports is fully populated
> blocks of memory of fixed size (known at compile time) where some blocks
> may be contiguous. ?Blocks are assumed to be populated from physical
> address zero.
>
> It doesn't actually support partially populated blocks.
>
> So, if your memory granule size is 4MB, and your memory starts at
> 0xc0000000 physical, you're stuck with 768 unused sparsemem blocks
> at the beginning of memory. ?If it's 1MB, then you have 3072 unused
> sparsemem blocks. ?Each mem_section structure is 8 bytes, so that
> could be 24K of zeros.
>
> What we actually need is infrastructure in the kernel which can properly
> handle sparse memory efficiently without causing such wastage. ?If your
> platform has four memory chunks, eg at 0xc0000000, 0xc4000000, 0xc8000000,
> and 0xcc000000, then you want to build the kernel to tell it "there may
> be four chunks with a 64MB offset, each chunk may be partially populated."
>
> It seems that Sparsemem can't do that efficiently.
>

If sparsemem is not the correct choice for ARM, why don't we go back
to the  flatmem? Still, the flatmem has problem on wastage of memory
because of memory holes. But it is more reliable for us, at least.
I think the idea of sparsemem is not bad for ARM, though. The
implementation is quite efficient. The problem is that we still
believe that sparsemem needs more verification to prove its
robustness.

Anyway, you told that we need to define NR_BANKS more that 8 to use
larger memory than 2gb without worry about misbehavior in mem_init()
and mem_show(). As i said before, I think that it is not reasonable to
create a number of memory chunks to avoid the problem. Nowhere in the
kernel code and descriptions informs that contiguous physical memory
chunks must not cross sparsemem section's boundaries.
