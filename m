From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 27 Aug 2010 10:37:40 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100827171639.83c8642c.kamezawa.hiroyu@jp.fujitsu.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
	<20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
	<20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTi=T1y+sQuqVTYgOkYvqrxdYB1bZmCpKafN5jPqi@mail.gmail.com>
	<20100826133028.39d731da.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTimB+s0tO=wrODAU4qCaZnCBoLZ2A9pGjR_jheOj@mail.gmail.com>
	<20100827171639.83c8642c.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <1282898260.1975.1844.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-27 at 17:16 +0900, KAMEZAWA Hiroyuki wrote:
> > How about changing following this?
> > The thing is MAX_ORDER is static. But we want to avoid too big
> > MAX_ORDER of whole zones to support devices which requires big
> > allocation chunk.
> > So let's add MAX_ORDER into each zone and then, each zone can have
> > different max order.
> > For example, while DMA[32], NORMAL, HIGHMEM can have normal size 11,
> > MOVABLE zone could have a 15.
> > 
> > This approach has a big side effect?

The side effect of increasing MAX_ORDER is that page allocations get
more expensive since the buddy tree gets larger, yielding more
splits/merges.

> Hm...need to check hard coded MAX_ORDER usages...I don't think
> side-effect is big. Hmm. But I think enlarging MAX_ORDER isn't an
> important thing. A code which strips contiguous chunks of pages from
> buddy allocator is a necessaty thing, as..

Right, once we can explicitly free the pages we want, crossing MAX_ORDER
isn't too hard like you say, we can simply continue with freeing the
next in order page.
