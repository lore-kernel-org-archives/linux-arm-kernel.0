From: davem@davemloft.net (David Miller)
Date: Sat, 17 Mar 2018 09:27:50 -0400 (EDT)
Subject: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
References: <740c7d45-450e-c9b3-ceed-7bc7fcefbc5a@codeaurora.org>
 <71e37a55-537b-d75a-cfde-f188b7cfce8e@codeaurora.org>
 <1f5e3b14-05a1-08d0-c0cb-00805526448d@codeaurora.org>
Message-ID: <20180317.092750.607418476271096975.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Sat, 17 Mar 2018 00:25:14 -0400

> I think I finally got what you mean.
> 
> Code seems to have
> 
> wmb()
> writel()/writeq()
> wmb()
> 
> this can be safely replaced with
> 
> wmb()
> __raw_writel()/__raw_writeq()
> wmb()
> 
> This will work on all arches. Below is the new version. Let me know if this is OK.

Unfortunately, I think this won't work.

At least on sparc, the __raw_*() variants also change the endianness to
native endianness.

PowerPC does this as well, even documented in a comment :-)

/*
 * Non ordered and non-swapping "raw" accessors
 */

Only the non-__raw_ variants do the endianness swap to/from
little-endian.
