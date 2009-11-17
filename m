From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Nov 2009 17:05:19 +0000
Subject: [PATCH] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <20091117120018.583b6374@life-in-the-fast-lane>
References: <1258444074-20679-1-git-send-email-m.szyprowski@samsung.com>
	<20091117091024.187d7cda@hina.wild-wind.fr.eu.org>
	<000701ca6766$90fbb2e0$b2f318a0$%szyprowski@samsung.com>
	<20091117120018.583b6374@life-in-the-fast-lane>
Message-ID: <20091117170519.GA1494@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 12:00:18PM +0100, Marc Zyngier wrote:
> Then what about introducing a CORTEX_A8 symbol, selected by ARCH_OMAP3,
> ARCH_S5PC1XX and others to come, and that would select the right cache
> line value? We really want to avoid those ever growing dependency lines
> that lead to conflicts when applying patches from multiple sources.
> 
> Unless we can have a Cortex-A8 implementation with a cache line that is
> not 64 bytes?

CPUs of the same family can have different cache line sizes.  The only
way to be sure is if you read the cache type registers and work it out.

However, L1_CACHE_SHIFT must be a compile time constant - it can't be
run-time calculated.  So, we chose to set L1_CACHE_SHIFT to be the
largest size found for the SoC concerned.

So, setting it to 64 for CPU_V7 makes no sense, since such CPUs can have
larger or smaller cache line sizes - and that's about the same as trying
to select the cache line size according to a CORTEX_A8 symbol...

The original patch seems to be the only sensible solution to this.
