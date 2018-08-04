From: mpatocka@redhat.com (Mikulas Patocka)
Date: Fri, 3 Aug 2018 20:58:18 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
Message-ID: <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Aug 2018, Richard Earnshaw (lists) wrote:

> Whoa, hold on.
> 
> Memcpy should never be used on device memory.  Period.  Memcpy doesn't
> know anything about what size of access is needed for accessing a device.
> 
> But why is the buffer in device memory rather than some other form of
> uncached memory?
> 
> If you change memcpy to deal with an aspect of the system hardware,
> you'll end up hosing performance EVERYWHERE.  DON'T DO IT!

memcpy in glibc uses ifunc selection and it already has optimized variants 
for Falkor and Thunder-X. You can add just another variant for Armada-8040 
that works around this bug and you won't be harming anyone but users of 
Armada-8040.

Furthermore, you can detect in the kernel that the PCI bus has some device 
with prefetchable BAR and activate the workaround only if there is 
videocard plugged in the PCIe slot.

> If you must, create a new API with tighter semantics, but don't change
> memcpy to accommodate this.
> 
> Anyway, back to the original report.  What memory mapping is being used?
>  In detail?

It is PCI prefetchable BAR. It is mapped using pgprot_writecombine, which 
results in MT_NORMAL_NC page attributes. (the MT_DEVICE_nGnRE can't be 
used because it results in crashes due to unaligned accesses to videoram).

> R.

Mikulas
