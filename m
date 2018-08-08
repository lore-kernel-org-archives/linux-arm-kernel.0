From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 8 Aug 2018 13:02:54 +0000
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180808121641.GB24736@iMac.local>
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
Message-ID: <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas
> Sent: 08 August 2018 13:17
...
> I think hazarding is what goes wrong here, especially since with
> overlapping unaligned addresses. However, I disagree that it is
> impossible to implement this properly on a platform with PCIe so that
> Normal NC mappings can be used.

I've been trying to follow this discussion...

Is the problem just that reads don't snoop/flush the write-combining buffer?
Aligned writes that end on an appropriate boundary will leave the write
combining buffer empty.
But if the buffer isn't emptied the PCIe read gets ahead of the PCIe write.

ISTR even x86 requires a fence instruction in some sequence associated
with write-combining writes.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
