From: mpatocka@redhat.com (Mikulas Patocka)
Date: Wed, 8 Aug 2018 14:37:02 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808081435020.18198@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 8 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 08 August 2018 14:47
> ...
> > The problem on ARM is that I see data corruption when the overlapping
> > unaligned writes are done just by a single core.
> 
> Is this a sequence of unaligned writes (that shouldn't modify the
> same physical locations) or an aligned write followed by an
> unaligned one that updates part of the earlier write.
> (Or the opposite order?)
> 
> It might be that the unaligned writes are bypassing the write-combining
> buffer (without flushing it) - so overtake the aligned write.
> 
> Alternatively the unaligned writes go through the write-combining
> buffer but the byte-enables aren't handled in the expected way.
> 
> It ought to be possible to work out which sequence is actually broken.
> 
> 	David

All the unaligned/or aligned writes inside memcpy write the same value to 
the overlapping bytes. So, the corruption can't be explained just by 
reordering the writes or failing to detect hazard between them.

Mikulas
