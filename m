From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 6 Aug 2018 10:18:33 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
 <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikulas Patocka
> Sent: 05 August 2018 15:36
> To: David Laight
...
> There's an instruction movntdqa (and vmovntdqa) that can actually do
> prefetch on write-combining memory type. It's the only instruction that
> can do it.
> 
> It this instruction is used on non-write-combining memory type, it behaves
> like movdqa.
> 
...
> I benchmarked it on a processor with ERMS - for writes to the framebuffer,
> there's no difference between memcpy, 8-byte writes, rep stosb, rep stosq,
> mmx, sse, avx - all this method achieve 16-17 GB/s

The combination of write-combining, posted writes and a fast PCIe slave
are probably why there is little difference.

> For reading from the framebuffer:
>  323 MB/s - memcpy (using avx2)
>   91 MB/s - explicit 8-byte reads
>  249 MB/s - rep movsq
>  307 MB/s - rep movsb

You must be getting the ERMS hardware optimised 'rep movsb'.

>   90 MB/s - mmx
>  176 MB/s - sse
> 4750 MB/s - sse movntdqa
>  330 MB/s - avx

avx512 is probably faster still.

> 5369 MB/s - avx vmovntdqa
> 
> So - it may make sense to introduce a function memcpy_from_framebuffer()
> that uses movntdqa or vmovntdqa on CPUs that support it.

For kernel space it ought to be just memcpy_fromio().

Can you easily repeat the tests using a non-write-combining map of the
same PCIe slave?

I can probably run the same measurements against our rather leisurely
FPGA based PCIe slave.
IIRC PCIe reads happen every 128 clocks of the cards 62.5MHz clock,
increasing the size of the registers makes a significant different.
I've not tried mapping write-combining and using (v)movntdaq.
I'm not sure what effect write-combining would have if the whole BAR
were mapped that way - so I'll either have to map the physical addresses
twice or add in another BAR.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
