From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 13:37:24 +0100
Subject: [PATCH] clocksource/drivers/arm_global_timer: Always use
 {readl|writel}_relaxed
In-Reply-To: <20151113202001.5933ae54@xhacker>
References: <1447403678-7217-1-git-send-email-jszhang@marvell.com>
 <25602407.8sIohphlWH@wuerfel> <20151113202001.5933ae54@xhacker>
Message-ID: <53950580.slDxBxJnNC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 20:20:01 Jisheng Zhang wrote:
> 
> > for outer_cache.sync(). The Aurora outer cache sync has a different method
> > and also doesn't use l2x0_lock. Finally, tauros3 doesn't need a cache sync
> > at all.
> > 
> > Did you look at an older kernel version? We used to do a loop in the
> 
> oops, yes. The kernel version in product still needs the spinlock in sync.
> I didn't check the L2 cache code for about 1 year, sorry for that.
> If we upgrade to newer kernel version, yes, the bit performance bottleneck -- 
> spinlock contention won't exist anymore. Thanks for pointing out this.

If you still see lock contention on the l2x0 lock with your patch applied,
you might want to backport the optimizations to your product kernel, even
more so for the aurora controller in the Armada 370 that had some extra
optimizations.

> But I think we may still see trivial system performance improvement in 500-1000
> times/s of clockevent programming case due to the mb() in writel.

Yes, I think it's fine. Just try to put your best estimate of the
overhead in the patch description when you do the new version.

Unfortunately, it is not easy to measure what the actual overhead is
because low-level benchmarks of outer_cache.sync will show a much lower
overhead than doing it occasionally with an active cache.

	Arnd
