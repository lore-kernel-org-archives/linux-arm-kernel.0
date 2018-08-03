From: mpatocka@redhat.com (Mikulas Patocka)
Date: Fri, 3 Aug 2018 08:04:32 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Aug 2018, David Laight wrote:

> From: Ard Biesheuvel
> > Sent: 03 August 2018 10:30
> ...
> > The discussion about whether memcpy() should rely on unaligned
> > accesses, and whether you should use it on device memory is orthogonal
> > to that, and not the heart of the matter IMO
> 
> Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
> isn't a good idea.
> In the kernel memcpy_to/fromio() ought to be a better choice but that
> is just an alternate name for memcpy().
> 
> The problem on x86 is that memcpy() is likely to be implemented as
> 'rep movsb' on modern cpu - relying on the cpu hardware to perform
> cache-line sized transfers (etc).
> Unfortunately on uncached locations it has to revert to byte copies.
> So PCIe transfers (especially reads) are very slow.
> 
> The transfers need to use the largest size register available.
> 
> 	David

On x86, the framebuffer is mapped as write-combining memory type, so "rep 
movsb" could merge the byte writes to larger chunks. I don't have a cpu 
with the ERMS feature - could anyone try it if rep movsb works worse or 
better than explicit writes to the framebuffer?

Mikulas
