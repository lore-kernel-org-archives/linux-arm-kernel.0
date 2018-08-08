From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2018 16:14:45 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
Message-ID: <20180808151444.GF24736@iMac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> On 08/08/18 15:12, Mikulas Patocka wrote:
> > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> >>> 	while (1) {
> >>> 		start = (unsigned)random() % (LEN + 1);
> >>> 		end = (unsigned)random() % (LEN + 1);
> >>> 		if (start > end)
> >>> 			continue;
> >>> 		for (i = start; i < end; i++)
> >>> 			data[i] = val++;
> >>> 		memcpy(map + start, data + start, end - start);
> >>> 		if (memcmp(map, data, LEN)) {
> >>
> >> It may be worth trying to do a memcmp(map+start, data+start, end-start)
> >> here to see whether the hazard logic fails when the writes are unaligned
> >> but the reads are not.
> >>
> >> This problem may as well appear if you do byte writes and read longs
> >> back (and I consider this a hardware problem on this specific board).
> > 
> > I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> > same corruption occurs. So, it can't be read-after-write hazard. It is 
> > caused by the improper handling of hazard between the overlapping writes 
> > inside memcpy.
> 
> I don't think you've told us what form the corruption takes.  Does it
> lose some bytes?  Modify values beyond the copy range?  Write completely
> arbitrary values?

>From this message:

https://lore.kernel.org/lkml/alpine.LRH.2.02.1808060553130.30832 at file01.intranet.prod.int.rdu2.redhat.com/

- failing to write a few bytes
- writing a few bytes that were written 16 bytes before
- writing a few bytes that were written 16 bytes after

> The overlapping writes in memcpy never write different values to the
> same location, so I still feel this must be some sort of HW issue, not a
> SW one.

So do I (my interpretation is that it combines or rather skips some of
the writes to the same 16-byte address as it ignores the data strobes).

-- 
Catalin
