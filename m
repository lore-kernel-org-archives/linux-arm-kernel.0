From: mpatocka@redhat.com (Mikulas Patocka)
Date: Sat, 4 Aug 2018 07:04:13 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Aug 2018, Andrew Pinski wrote:

> On Fri, Aug 3, 2018 at 5:58 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Fri, 3 Aug 2018, Richard Earnshaw (lists) wrote:
> >
> > > Whoa, hold on.
> > >
> > > Memcpy should never be used on device memory.  Period.  Memcpy doesn't
> > > know anything about what size of access is needed for accessing a device.
> > >
> > > But why is the buffer in device memory rather than some other form of
> > > uncached memory?
> > >
> > > If you change memcpy to deal with an aspect of the system hardware,
> > > you'll end up hosing performance EVERYWHERE.  DON'T DO IT!
> >
> > memcpy in glibc uses ifunc selection and it already has optimized variants
> > for Falkor and Thunder-X. You can add just another variant for Armada-8040
> > that works around this bug and you won't be harming anyone but users of
> > Armada-8040.
> 
> Except it is not a bug in the ARMADA at all.  It is a bug in thinking
> memcpy will work on non-DRAM memory.

There's plenty of memcpy's in the graphics stack. No one will be rewriting 
all the graphics drivers because of tiny market share that ARM has in 
desktop computers. So if you refuse to fix things and blame everyone else, 
you can as well announce that you don't want to have PCIe graphics on ARM 
at all.

> Can you run the test program on x86 using the similar framebuffer
> setup?  Does doing two writes (one aligned and one unaligned but
> overlapping with previous one) cause the same issue?  I suspect it
> does, then using memcpy for frame buffers is wrong.
>
> Thanks,
> Andrew

Overlapping unaligned writes work on x86 - they have to, because of 
backward compatibility.

8086, 80286 and 80386 didn't have any cache at all.

80486 and Pentium had cache, but when the CPU was reading some data from 
memory, the motherboard could disable cacheability for this data by a 
special pin. Software didn't have to do any explicit cache management - 
programs for 80386 that expected that there's no cache worked flawlessly 
on 80486 and Pentium.

Pentium Pro had memory type range registers that determine cacheability of 
various memory regions (so that it could allocate a cache line on write 
without having to query the motherboard if the particular region of memory 
is cacheable) - but the MTRRs were set by BIOS and the software didn't 
have to care about them at all - an 80386 operating system that had no 
idea of cacheability would still work on Pentium Pro.

MTRRs could also set a write-combining mode on a region of memory - but 
again, this is completely transparent to the software (the write combining 
buffers are flushed when accessing an I/O port or uncacheable memory) - so 
that an accelerated graphics driver written for Pentium that had no idea 
of write-combining would still work on Pentium Pro with write combining 
enabled.

Mikulas
