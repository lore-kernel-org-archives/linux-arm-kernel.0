From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2018 18:31:09 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
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
Message-ID: <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 6:22 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> On Wed, 8 Aug 2018, Catalin Marinas wrote:
>
> > On Wed, Aug 08, 2018 at 02:26:11PM +0000, David Laight wrote:
> > > From: Mikulas Patocka
> > > > Sent: 08 August 2018 14:47
> > > ...
> > > > The problem on ARM is that I see data corruption when the overlapping
> > > > unaligned writes are done just by a single core.
> > >
> > > Is this a sequence of unaligned writes (that shouldn't modify the
> > > same physical locations) or an aligned write followed by an
> > > unaligned one that updates part of the earlier write.
> > > (Or the opposite order?)
> >
> > In the memcpy() case, there can be a sequence of unaligned writes but
> > they would not modify the same byte (so no overlapping address at the
> > byte level).
>
> They do modify the same byte, but with the same value. Suppose that you
> want to copy a piece of data that is between 8 and 16 bytes long. You can
> do this:
>
> add src_end, src, len
> add dst_end, dst, len
> ldr x0, [src]
> ldr x1, [src_end - 8]
> str x0, [dst]
> str x1, [dst_end - 8]
>
> The ARM64 memcpy uses this trick heavily in order to reduce branching, and
> this is what makes the PCIe controller choke.

So when a single unaligned 'stp' gets translated into a PCIe with TLP
with length=5 (20 bytes) and LastBE = ~1stBE, write combining the
overlapping stores gives us a TLP with a longer length (5..8 for two
stores), and byte-enable bits that are not exactly a complement.

If the explanation is just that of the byte-enable settings of the merged
TLP are wrong, maybe the problem is that one of them is always
the complement of the other, which would work for power-of-two
length but not the odd length of the TLP post write-combining?

      Arnd
