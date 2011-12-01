From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 18:28:52 +0000
Subject: does non-continuous RAM means I need to select the sparse
 memory model?
In-Reply-To: <20111129203010.GA26618@pengutronix.de>
References: <20111129203010.GA26618@pengutronix.de>
Message-ID: <20111201182852.GC9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 09:30:10PM +0100, Uwe Kleine-K?nig wrote:
> I'm currently working on a new arch port and my current machine has RAM
> at 0x10000000 and 0x80000000. So there is a big hole between the two
> banks. When selecting the sparse memory model it works, but when
> selecting flat the machine runs into a BUG in mark_bootmem() called by
> free_unused_memmap() to free the space between the two banks.

Well, it looks like you have the answer in your latest email:

> Apart from that it seems I cannot use flatmem as is on my machine. It
> has only 128kiB at 0x10000000 + 1MiB at 0x80000000 and needs 14MiB to hold the
> table of "struct page"s.

Which shows that there's no possible way to use flatmem in this platform.

Now, to use sparsemem with this, sparsemem people will tell you that
each sparsemem section must be fully populated.  So, as your minimum
memory size is 128kiB, your sparsemem section size must be 128kiB.
This makes SECTION_SIZE_BITS be 17.

You need to span to 0x80000000+, which means you need MAX_PHYSMEM_BITS
to be 32.

These two together means you're in for having an array of 2^(32 - 17) =
32768 pointers to struct section for starters.  That takes 128kiB.
Now add in the struct page structures, which for 128kiB of memory will
be 1kiB.  Now add 9 struct section's as well...

What I'm pointing out is that in the scenario you appear to have, trying
to use the small pool of memory which is soo dislocated from the rest of
memory is a waste of effort.  Adding it to the pool means that you require
more memory for the management data structures than you gain from adding
it to the system.  The net benefit from trying to use it is actually
negative.

So, forget that the 128kiB chunk of memory exists - at that size and
distance from the rest of memory its really not worth bothering with.
