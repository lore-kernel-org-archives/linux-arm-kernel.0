From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 14:15:20 +0200
Subject: [PATCH V4 6/7] iommu/msm: Use writel_relaxed and add a barrier
In-Reply-To: <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
 <3070591.xyl7SB8DB7@wuerfel> <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
Message-ID: <2638968.1a16UdaY62@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2016 17:37:40 Sricharan wrote:
> >
> >These comments are completely useless. What is the specific race
> >that you are protecting against, and why are the implicit barriers
> >not sufficient here? Please find a better way to document what
> >is going on.
> >
> 
> The reason for doing this was, when the tlb maintenance ops are called
> by  io-pgtable functions, it expects that the tlb_range ops is complete
> only after the tlb_sync callback is called. Previously we were using
> writel and the sync in that case was dummy. Also previously every register
> configuration write was done using writel,  which was an overkill. So now
> we do all the writes with writel_relaxed  and a barrier in the end. I will
> change the documentation for this.

If you need the barrier after the write, it probably was already faulty
before, because writel only implies a barrier before the store, not
after. Of course all the barriers likely made the whole process so
slow that you never hit that race in the end.

	Arnd
