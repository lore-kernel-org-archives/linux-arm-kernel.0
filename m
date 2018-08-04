From: pinskia@gmail.com (Andrew Pinski)
Date: Fri, 3 Aug 2018 18:13:05 -0700
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2018 at 5:58 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Fri, 3 Aug 2018, Richard Earnshaw (lists) wrote:
>
> > Whoa, hold on.
> >
> > Memcpy should never be used on device memory.  Period.  Memcpy doesn't
> > know anything about what size of access is needed for accessing a device.
> >
> > But why is the buffer in device memory rather than some other form of
> > uncached memory?
> >
> > If you change memcpy to deal with an aspect of the system hardware,
> > you'll end up hosing performance EVERYWHERE.  DON'T DO IT!
>
> memcpy in glibc uses ifunc selection and it already has optimized variants
> for Falkor and Thunder-X. You can add just another variant for Armada-8040
> that works around this bug and you won't be harming anyone but users of
> Armada-8040.

Except it is not a bug in the ARMADA at all.  It is a bug in thinking
memcpy will work on non-DRAM memory.
Can you run the test program on x86 using the similar framebuffer
setup?  Does doing two writes (one aligned and one unaligned but
overlapping with previous one) cause the same issue?  I suspect it
does, then using memcpy for frame buffers is wrong.

Thanks,
Andrew

>
> Furthermore, you can detect in the kernel that the PCI bus has some device
> with prefetchable BAR and activate the workaround only if there is
> videocard plugged in the PCIe slot.
>
> > If you must, create a new API with tighter semantics, but don't change
> > memcpy to accommodate this.
> >
> > Anyway, back to the original report.  What memory mapping is being used?
> >  In detail?
>
> It is PCI prefetchable BAR. It is mapped using pgprot_writecombine, which
> results in MT_NORMAL_NC page attributes. (the MT_DEVICE_nGnRE can't be
> used because it results in crashes due to unaligned accesses to videoram).
>
> > R.
>
> Mikulas
