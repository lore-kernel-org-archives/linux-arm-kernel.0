From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 3 Aug 2018 11:24:28 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Message-ID: <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel
> Sent: 03 August 2018 10:30
...
> The discussion about whether memcpy() should rely on unaligned
> accesses, and whether you should use it on device memory is orthogonal
> to that, and not the heart of the matter IMO

Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
isn't a good idea.
In the kernel memcpy_to/fromio() ought to be a better choice but that
is just an alternate name for memcpy().

The problem on x86 is that memcpy() is likely to be implemented as
'rep movsb' on modern cpu - relying on the cpu hardware to perform
cache-line sized transfers (etc).
Unfortunately on uncached locations it has to revert to byte copies.
So PCIe transfers (especially reads) are very slow.

The transfers need to use the largest size register available.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
