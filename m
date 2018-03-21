From: davem@davemloft.net (David Miller)
Date: Wed, 21 Mar 2018 11:56:55 -0400 (EDT)
Subject: [PATCH v4 00/17] netdev: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180321.115655.108053425798020503.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 19 Mar 2018 22:42:15 -0400

> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing the
> register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> I did a regex search for wmb() followed by writel() in each drivers
> directory.
> I scrubbed the ones I care about in this series.
> 
> I considered "ease of change", "popular usage" and "performance critical
> path" as the determining criteria for my filtering.

I agree that for performance sensitive operations, specifically writing
doorbell registers in the hot paths or RX and TX packet processing, this
is a good change.

However, in configuration paths and whatnot, it is much less urgent and
useful.

Therefore I think it would work better if you concentrated solely on
hot code path cases.

You can, on a driver by driver basis, submit the other transformations
in the slow paths, and let the driver maintainers decide whether to
take those on or not.

Also, please stick exactly to the case where we have:

	wmb/mb/etc.
	writel()

Because I see some changes where we have:

	writel()

	barrier()

	writel()

for exmaple, and you are turning that second writel() into a relaxed
on as well.  The above is using a compile barrier, not a memory
barrier, so effectively it is two writel()'s in sequence which is
not what this patch set is about.

If anything, that compile barrier() is superfluous and could be
removed.  But that is also a separate change from what this patch
series is doing here.

Finally, it makes it that much easier if we can see the preceeding
memory barrier in the context of the patch that adjusts the writel
into a writel_relaxed.

In one case, a macro DOORBELL() is changed to use writel().  This
makes it so that the patch reviewer has to scan over the entire
driver in question to see exactly how DOORBELL() is used and whether
it fits the criteria for the writel_relaxed() transformation.

I would suggest that you adjust the name of the macro in a situation
like this, f.e. to DOORBELL_RELAXED().

Thank you.
