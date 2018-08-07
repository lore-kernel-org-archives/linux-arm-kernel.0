From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 7 Aug 2018 14:33:58 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
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
Message-ID: <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikulas Patocka
> Sent: 07 August 2018 15:07
...
> Unaccelerated scrolling is still painfully slow
> even on modern computers because of slow framebuffer read.

I solved that many years ago on a strongarm system by mapping
the screen memory at two separate virtual addresses.
One uncached used for writes, the second cached using the
'minicache' for reads.
(and immediately fell foul of a memcpy() function that compared
the two virtual addresses and decided to copy backwards)

I suspect some modern cpus don't like you doing that and the
graphics 'drivers' won't use different mappings.

Even in glibc you want a more general copy_to/from_io_memory()
rather than just 'copy_from_framebuffer()'.
Best to define both - even if they end up identical.
Other drivers allow PCIe space be mmap()ed into user space.

While your tests show vmovntdqa being slightly slower than an
avx read for uncached mappings it is still much better than
all the other options.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
