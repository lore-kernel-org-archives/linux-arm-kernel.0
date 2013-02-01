From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 12:54:17 +0000
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130201121137.GC23869@e102568-lin.cambridge.arm.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com>
 <20130201121137.GC23869@e102568-lin.cambridge.arm.com>
Message-ID: <20130201125417.GL23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 12:11:38PM +0000, Lorenzo Pieralisi wrote:
> Well, on latest processors (A15, A7) caches are invalidated on reset unless
> the chip is programmed to skip that on reset (ie L2 retained).
> 
> But it makes sense, for sure it should not be called v7_invalidate_l1,
> but invalidate_louis, and instead of forcing level 0 we should be
> reading LoUIS and invalidate up to that level as we do in the clean and
> invalidate function.

No.  Think about it.  c7, c6, 2 _invalidates_ the cache.  That means any
data contained within the cache is discarded.  Data is not written back.

If you do this down to the LoUIS, that includes all cache levels in the
inner sharable domain.  The inner sharable domain includes the other CPUs
in the system which may already be running (certainly the boot CPU will
be running).

Are you _really_ sure you want to be invalidating _valid_ data held in
caches in the inner sharable domain by other CPUs, rather than just the
cache associated with the CPU which is being brought online?
