From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 8 Aug 2018 16:43:46 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
 <20180808145017.GE24736@iMac.local>
 <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
Message-ID: <a804913d98ae4598a725cb40a6d19b4e@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann
> Sent: 08 August 2018 17:31
..
> > They do modify the same byte, but with the same value. Suppose that you
> > want to copy a piece of data that is between 8 and 16 bytes long. You can
> > do this:
> >
> > add src_end, src, len
> > add dst_end, dst, len
> > ldr x0, [src]
> > ldr x1, [src_end - 8]
> > str x0, [dst]
> > str x1, [dst_end - 8]

I've done that myself (on x86) copied the last 'word' first then
everything else in increasing address order.

> > The ARM64 memcpy uses this trick heavily in order to reduce branching, and
> > this is what makes the PCIe controller choke.

More likely the write combining buffer?

> So when a single unaligned 'stp' gets translated into a PCIe with TLP
> with length=5 (20 bytes) and LastBE = ~1stBE, write combining the
> overlapping stores gives us a TLP with a longer length (5..8 for two
> stores), and byte-enable bits that are not exactly a complement.

Write combining should generate a much longer TLP.
Depending on the size of the write combining buffer.

But in the above case I'd have thought that the second write
would fail to 'combine' - because it isn't contiguous with the
stored data.

So something more complex will be going on.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
