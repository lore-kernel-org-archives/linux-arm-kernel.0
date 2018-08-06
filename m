From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 6 Aug 2018 10:30:15 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180805215150.GB1862@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <20180805215150.GB1862@amd>
Message-ID: <alpine.LRH.2.02.1808061003320.9697@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sun, 5 Aug 2018, Pavel Machek wrote:

> Hi!
> 
> > > Can you run the test program on x86 using the similar framebuffer
> > > setup?  Does doing two writes (one aligned and one unaligned but
> > > overlapping with previous one) cause the same issue?  I suspect it
> > > does, then using memcpy for frame buffers is wrong.
> 
> I'm pretty sure it will work ok on x86.
> 
> > Overlapping unaligned writes work on x86 - they have to, because of 
> > backward compatibility.
> 
> It is not that easy. 8086s (and similar) did not have MTRRs and PATs
> either. Overlapping unaligned writes _on main memory_, _with normal
> MTRR settings_ certainly work ok on x86.

It works even with write-combining. Write-combining specifies, that the 
writes may hit the framebuffer in unspecified order. But if the writes are 
overlapping, the CPU can't just reorder them and write the wrong result to 
the framebuffer.

> Chances is memory type can be configured to work similar way on your
> ARM/PCIe case?

ARM has memory types GRE, nGRE, nGnRE, nGnRnE - that allow or not allow 
gathering, reordering, early write acknowledgement. Unfortunatelly, all 
these memory types will trigger a fault on unaligned accesses.

It has also Non-Cached memory type (some people on this thread believe 
that it can't be used for GPUs, some believe that it can) - this memory 
type supports unaligned accesses, so it is actually used for framebuffers 
on ARM.

If we had a memory type that didn't do early write acknowledgement and 
supported unaligned accesses, it would solve this problem.

Mikulas
