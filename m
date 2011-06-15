From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2011 10:02:57 +0100
Subject: [PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0
In-Reply-To: <20110614173013.GA9234@e102568-lin.cambridge.arm.com>
References: <1307926019-28958-1-git-send-email-ccross@android.com>
	<20110613101942.GA7924@e102568-lin.cambridge.arm.com>
	<BANLkTingENSjDaE7O+Lb6P=ED4JtuJY1jkV25b3SW6RhsOQQkw@mail.gmail.com>
	<20110614173013.GA9234@e102568-lin.cambridge.arm.com>
Message-ID: <20110615090257.GC31110@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Tue, Jun 14, 2011 at 06:30:19PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jun 13, 2011 at 07:20:34PM +0100, Colin Cross wrote:
>
> According to the PL310 TRM (r3p2 3-9) on disable the PL310 syncs, which means
> it flushes internal buffers, but it is not supposed to clean dirty lines.
> It seems unsafe to me to use the stack and other cacheable data right before
> disabling.
> 
> > Otherwise, wouldn't a flush_cache_all() and l2x0_flush_all() in
> > l2x0_disable() ensure the stack lines were flushed out?  Probably
> > needs a readl_releaxed as well, to ensure the disable has taken
> > effect.
> > 
> 
> I reckon the safest option is to clean and disable in one C
> function. Moreover at that point in time spinlocks might not be an option
> anymore (CPU out of coherency), which makes those functions unusable.

I was planning to add this functionality as part of my kexec patches since
otherwise the l2x0_lock gets blown away on disable. I initially attributed
this to loss of coherency, but that's clearly not the case as I still had L1
running.

Colin - I'll add you to CC for v3 of that series.

Will
