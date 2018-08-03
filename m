From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 3 Aug 2018 13:04:22 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikulas Patocka
> Sent: 03 August 2018 13:05
...
> > Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
> > isn't a good idea.
> > In the kernel memcpy_to/fromio() ought to be a better choice but that
> > is just an alternate name for memcpy().
> >
> > The problem on x86 is that memcpy() is likely to be implemented as
> > 'rep movsb' on modern cpu - relying on the cpu hardware to perform
> > cache-line sized transfers (etc).
> > Unfortunately on uncached locations it has to revert to byte copies.
> > So PCIe transfers (especially reads) are very slow.
> >
> > The transfers need to use the largest size register available.
> >
> > 	David
> 
> On x86, the framebuffer is mapped as write-combining memory type, so "rep
> movsb" could merge the byte writes to larger chunks. I don't have a cpu
> with the ERMS feature - could anyone try it if rep movsb works worse or
> better than explicit writes to the framebuffer?

I don't think 'write combining' can help reads, and memcpy_to/fromio()
are likely to be used for normal memory mapped io areas.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
