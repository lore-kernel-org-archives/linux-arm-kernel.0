From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Sep 2013 10:54:46 +0100
Subject: [PATCH v3 5/6] ARM: atomics: prefetch the destination word for
 write prior to strex
In-Reply-To: <alpine.LFD.2.03.1309171407510.20709@syhkavp.arg>
References: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
 <1379424578-7477-6-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1309171407510.20709@syhkavp.arg>
Message-ID: <20130918095445.GC1783@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 07:09:35PM +0100, Nicolas Pitre wrote:
> On Tue, 17 Sep 2013, Will Deacon wrote:
> 
> > The cost of changing a cacheline from shared to exclusive state can be
> > significant, especially when this is triggered by an exclusive store,
> > since it may result in having to retry the transaction.
> > 
> > This patch prefixes our atomic access implementations with pldw
> > instructions (on CPUs which support them) to try and grab the line in
> > exclusive state from the start. Only the barrier-less functions are
> > updated, since memory barriers can limit the usefulness of prefetching
> > data.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks, Nicolas.

> By the way, did you measure significant performance improvements with 
> those patches?

Yep. Latest version shows around a 3% hackbench boost with -rc1 on my TC2.

Will
