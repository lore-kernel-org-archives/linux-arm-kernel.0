From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2018 12:39:28 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180808113927.GA24736@iMac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> 	while (1) {
> 		start = (unsigned)random() % (LEN + 1);
> 		end = (unsigned)random() % (LEN + 1);
> 		if (start > end)
> 			continue;
> 		for (i = start; i < end; i++)
> 			data[i] = val++;
> 		memcpy(map + start, data + start, end - start);
> 		if (memcmp(map, data, LEN)) {

It may be worth trying to do a memcmp(map+start, data+start, end-start)
here to see whether the hazard logic fails when the writes are unaligned
but the reads are not.

This problem may as well appear if you do byte writes and read longs
back (and I consider this a hardware problem on this specific board).

-- 
Catalin
