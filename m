From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 2 Oct 2011 17:58:12 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <20110927181438.GM2138@amd.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
Message-ID: <CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry for the late response; we had a big holiday here and I was
forced away from my keyboard :)

On Tue, Sep 27, 2011 at 9:14 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> No. I suggest a simpler and shorter algorithm using the bit helpers.

Ok, fair enough. I've revised the patches and attached the main one
below; please tell me if it looks ok, and then I'll resubmit the
entire patch set.

The main changes I've done from your pseudo-code are:

1. removed the internal while loop, and used several bits
manipulations to replace it
2. removed the call to get_order(), and instead used the bytes order
we already have to deduct it
3. considered iova alignment requirements too
4. removed the BUG_ON()s, since we're checking for minimal
size/alignment conditions in the beginning of the map function

> And yes, overhead is important when we implement the generic dma-ops
> on-top of the iommu-api because this will make the iommu_map function a
> fast-path. So we really care about overhead here.

Don't get me wrong; I don't underestimate the importance of performance here.

I just think that as long as some code is reasonably efficient and not
badly designed (so it's not too hard to optimize later if needed),
then it's usually better to postpone optimizations until we benchmark
and know for certain that the effort in squeezing away several cpu
cycles is noticeable.

In this case, I'm not entirely convinced that it is, because every map
call anyway ends up flushing the caches, which might take hundreds of
cpu cycles. In addition, at least the ARM version of find_next_bit
doesn't look terribly bad.

YMMV though: I didn't find an optimized assembly implementation of
find_next_bit for x86, and the generic one does look complex. In
addition, the variable page size behavior of the x86 iommu drivers may
have caused much more iterations than any of the ARM drivers would
have had, so the penalty of running that generic find_next_bit
repeatedly could have accumulated into something noticeable.

Anyway, here comes the revised patch.

Thanks for your review!
Ohad.
