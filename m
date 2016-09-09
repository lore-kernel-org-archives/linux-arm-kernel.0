From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Sep 2016 17:24:32 -0700
Subject: [RFC 00/17] clk: Add per-controller locks to fix deadlocks
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160909002432.GE13062@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16, Krzysztof Kozlowski wrote:
> Hi,
> 
> RFC, please, do not apply, maybe except patch #1 which is harmless.
> 
> 
> Introduction
> ============
> The patchset brings new entity: clock controller representing a hardware
> block.  The clock controller comes with its own prepare lock which
> is used then in many places.  The idea is to fix the deadlock mentioned
> in commit 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping
> I2C clock prepared") and commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock
> by keeping clock prepared").
> 
> 
> Disclaimer
> ==========
> Request for comments, so:
> 1. Only exynos_defconfig builds,
> 2. A lot of FIXME/TODO note still,
> 3. Checkpatch not run, lines not aligned,
> 4. Other (non-exynos) drivers not converted,
> 5. Probably not yet bisectable,
> 6. Locking became quite complex.
>    The previous one lock was simple.  Inefficient and dead-lock prone but
>    simple.  Because of clock hierarchy spanning through controllers, the
>    new locking became quite complicated.  I don't like it but...
> 
> 
> Details
> =======
> In Exynos-based boards case the deadlock occurs between clock's
> prepare_lock and regmap-i2c's lock:
> 
> CPU #0:                             CPU #1:
> lock(regmap)
>                                     s2mps11-clk: clk_prepare_lock()
> 
> i2c-exynos: clk_prepare_lock() - wait
>                                     lock(regmap) - wait
> 
> The clk_prepare_lock() on both CPUs come from different clock drivers
> and components:
> 1. I2C clock is part of SoC block and is required by i2c-s3c2410/i2c-exynos5
>    driver,
> 2. S2MPS11 clock is separate device, however driver uses I2C regmap.
> 
> The deadlock was reported by lockdep (always) and was happening
> in 20% of boots of Odroid XU3 with multi_v7 defconfig.  Workaround for
> deadlock was implemented by removing prepare/unprepare calls from I2C
> transfers.  However these are just workarounds... which after applying
> this patch can be reverted.
> 
> Additionally Marek Szyprowski's work on domains/clocks/pinctrl exposed
> the deadlock again in different configuration.
> 

Per-controller locks seems to be a misnomer. These patches look
more like per-clk_register() locks. The clk registrant can decide
how fine grained to make the prepare locking scheme. They can
decide to have one lock per clk, one lock for the entire tree, or
one lock per arbitrary subtree. I'd prefer to drop the controller
concept unless it's really done that way, by attaching to the OF
clk provider or device pointer.

Given that, it seems that conceptually these patches allow clk
registrants to carve out a set of clks that they want to be
treated as an atomic unit with regards to the prepare lock.
TL;DR trees of per-process recursive prepare mutex locks where
the locks cover one or more clks.

The locks are recursive per-process to simplify the problem where
we need to acquire the same lock multiple times while traversing
a tree that shares the same lock, right? Otherwise we would need
to track which locks we've already grabbed and refcount and we
wouldn't be able to re-enter the framework from within the clk
ops of the same atomic unit.

As long as we can guarantee that we always take the locks in the
same order we'll be fine. The burden to ensure that would be
placed on the clk registrants though, and verifying that will be
left up to humans? That seems fragile and error prone. We can
always say that we take the global lock and then traverse the
children up to the roots, but we can't be sure that during the
tree traversal we don't take locks in different order because of
how the clk registrant has structured things.

It would be great if the different clk APIs were listed, with the
order of how locks are taken BTW. And really overall just more
information about how the locking scheme works. I had to read
this patch series quite a few times to come to (hopefully the
right) conclusions.

So I'm not very fond of this design because the locking scheme is
pretty much out of the hands of the framework and can be easily
broken. I'm biased of course, because I'd prefer we go with my
wwmutex design of per-clk locks[1]. Taking locks in any order
works fine there, and we resolve quite a few long standing
locking problems that we have while improving scalability. The
problem there is that we don't get the recursive mutex design
(maybe that's a benefit!). Once a clk_op reenters the framework
with consumer APIs and tries to grab the same lock we deadlock.
This is why I've been slowly splitting consumers from providers
so we can easily identify these cases. If we had something like
coordinated clk rate switching, we could get rid of clk_ops
reentering the framework and avoid this problem (and we really do
need to do that).

The one thing I do like about this patch series though is the
gradual movement of providers to the new locking scheme. Maybe if
we combined that idea with per-clk wwmutex locks we could have
the best of both worlds and fix reentrancy later when we need it?
There's wwmutex_trylock() that we could use. Perhaps always pass
a NULL context if some clk flag isn't set (CLK_USE_PER_CLK_LOCK).
Plus we could assign the same wwmutex all over the place when
that flag isn't set and allocate a unique wwmutex at clk_register
time otherwise. I haven't thought about it deeply, so there may
be some glaring problem that I'm missing like when we have half
the clks in a tree with the flag set or something. This is where
driving home from the office for 45 minutes helps.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/251039.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
