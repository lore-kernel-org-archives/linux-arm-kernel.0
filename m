From: rabin@rab.in (Rabin Vincent)
Date: Wed, 23 Jun 2010 01:06:38 +0530
Subject: [PATCH v4 2/4] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100621144632.26309.63314.stgit@e102109-lin.cambridge.arm.com>
References: <20100621144409.26309.87173.stgit@e102109-lin.cambridge.arm.com>
	<20100621144632.26309.63314.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100622193638.GA9780@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 03:46:32PM +0100, Catalin Marinas wrote:
> There are places in Linux where writes to newly allocated page cache
> pages happen without a subsequent call to flush_dcache_page() (several
> PIO drivers including USB HCD). This patch changes the meaning of
> PG_arch_1 to be PG_dcache_clean and always flush the D-cache for a newly
> mapped page in update_mmu_cache().

Correct me if I'm misreading the code, but don't this patch and the next
one make the assumption that CONFIG_SMP == VIPT non-aliasing (or PIPT)
caches?  This patch does not add flushing on SMP systems, and the next
one handles the I$-D$ coherency issues there (ignoring the set_pte race
fix for a moment).   Won't the flushing added in this patch be
unnecessary on non-SMP PIPT systems, since they too only need the
exec-related flushing?

Rabin
