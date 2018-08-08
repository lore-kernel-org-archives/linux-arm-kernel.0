From: mpatocka@redhat.com (Mikulas Patocka)
Date: Wed, 8 Aug 2018 10:21:46 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
 <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
 <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
 <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808081017210.9997@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 7 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 07 August 2018 15:07
> ...
> > Unaccelerated scrolling is still painfully slow
> > even on modern computers because of slow framebuffer read.
> 
> I solved that many years ago on a strongarm system by mapping
> the screen memory at two separate virtual addresses.
> One uncached used for writes, the second cached using the
> 'minicache' for reads.
> (and immediately fell foul of a memcpy() function that compared
> the two virtual addresses and decided to copy backwards)
> 
> I suspect some modern cpus don't like you doing that and the
> graphics 'drivers' won't use different mappings.

Intel says that you can't mix PAT memory attributes - but the non-temporal 
store instructions use write-combining semantics on a memory that is 
normally cacheable - and it is allowed to mix non-temporal stores with 
other cacheable memory accesses - so I believe that the CPU will snoop the 
cache for wc accesses and handle the conflict.

> Even in glibc you want a more general copy_to/from_io_memory()
> rather than just 'copy_from_framebuffer()'.
> Best to define both - even if they end up identical.
> Other drivers allow PCIe space be mmap()ed into user space.
> 
> While your tests show vmovntdqa being slightly slower than an
> avx read for uncached mappings it is still much better than
> all the other options.

Tihs was a measuring glitch - movntdqa is as fast as movdqa on non-cached
mappings.

Mikulas

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
