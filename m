From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2012 20:14:58 +0100
Subject: Question about ION carveout heap support partial cache flush
In-Reply-To: <CAN1soZw4Qk5qSyuyMko9SZWu3u3_7OPA2yNVYz6C1WQWVimbvg@mail.gmail.com>
References: <CAMj5BkgffAW6azUjwz+iCF1tBLmBDRBvBjR-_fTr=4G=h+BLZw@mail.gmail.com>
 <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
 <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
 <20120827082914.GN18957@n2100.arm.linux.org.uk>
 <CAN1soZw4Qk5qSyuyMko9SZWu3u3_7OPA2yNVYz6C1WQWVimbvg@mail.gmail.com>
Message-ID: <20120827191458.GP18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 09:43:10PM +0800, Haojian Zhuang wrote:
> On Mon, Aug 27, 2012 at 4:29 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Aug 27, 2012 at 04:23:31PM +0800, zhangfei gao wrote:
> >> On Mon, Aug 27, 2012 at 1:46 PM, Haojian Zhuang
> >> <haojian.zhuang@gmail.com> wrote:
> >> > Let me summerize it. First, user space address is mapped. Then,
> >> > flushing user space
> >> > address is triggered. It's a workaround of fixing non-existed virtual
> >> > address without fixing
> >> > vmap() or any other solution. It's just a quick fix.
> >> >
> >> > Zhangfei,
> >> > I doubt that the issue may be caused by missing memory barrier.
> >> > Flushing is using
> >> > coprocessor instructions. It's a little different.
> >>
> >> Is there any limitation that dmac_map_area & dmac_flush_range
> >> supporting addr mapped from user space?
> >
> > They DEFINITELY DO NOT SUPPORT FLUSHING USER SPACE.
> 
> I agree that those API are defined to support kernel space address only.
> But the implementation is only flushing address by assembly code.

No.  Have you looked at what the dma_map_page() and scatterlist stuff
does?  It all wants to deal with a 'struct page'.  Have you looked at
how L2 caches are handled?  That wants to be able to use virt_to_phys
and similar to convert addresses, which only work on the linear mapped
region.

Have you thought about what happens when the user's page gets unmapped
or swapped out (or even just aged) ?  I don't think you've given any of
this any consideration what so ever.

There's more here than just "oh we can just pass random address X into
this function and hope that nothing goes wrong."  It's really not that
simple.
