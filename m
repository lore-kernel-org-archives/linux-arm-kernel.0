From: mpatocka@redhat.com (Mikulas Patocka)
Date: Sun, 5 Aug 2018 10:36:01 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
 <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 03 August 2018 13:05
> ...
> > > Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
> > > isn't a good idea.
> > > In the kernel memcpy_to/fromio() ought to be a better choice but that
> > > is just an alternate name for memcpy().
> > >
> > > The problem on x86 is that memcpy() is likely to be implemented as
> > > 'rep movsb' on modern cpu - relying on the cpu hardware to perform
> > > cache-line sized transfers (etc).
> > > Unfortunately on uncached locations it has to revert to byte copies.
> > > So PCIe transfers (especially reads) are very slow.
> > >
> > > The transfers need to use the largest size register available.
> > >
> > > 	David
> > 
> > On x86, the framebuffer is mapped as write-combining memory type, so "rep
> > movsb" could merge the byte writes to larger chunks. I don't have a cpu
> > with the ERMS feature - could anyone try it if rep movsb works worse or
> > better than explicit writes to the framebuffer?
> 
> I don't think 'write combining' can help reads, and memcpy_to/fromio()

There's an instruction movntdqa (and vmovntdqa) that can actually do 
prefetch on write-combining memory type. It's the only instruction that 
can do it.

It this instruction is used on non-write-combining memory type, it behaves 
like movdqa.

> are likely to be used for normal memory mapped io areas.
> 
> 	David

I benchmarked it on a processor with ERMS - for writes to the framebuffer, 
there's no difference between memcpy, 8-byte writes, rep stosb, rep stosq, 
mmx, sse, avx - all this method achieve 16-17 GB/s

For reading from the framebuffer:
 323 MB/s - memcpy (using avx2)
  91 MB/s - explicit 8-byte reads
 249 MB/s - rep movsq
 307 MB/s - rep movsb
  90 MB/s - mmx
 176 MB/s - sse
4750 MB/s - sse movntdqa
 330 MB/s - avx
5369 MB/s - avx vmovntdqa

So - it may make sense to introduce a function memcpy_from_framebuffer() 
that uses movntdqa or vmovntdqa on CPUs that support it.

Mikulas
