From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 19:29:42 +0100
Subject: [PATCH 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <1376138582-7550-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376138582-7550-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130812182942.GA28695@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 01:43:00PM +0100, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API
> with clear-set semantics.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

[...]

> +void atomic_io_clear_set(void __iomem *reg, u32 clear, u32 set)
> +{
> +	spin_lock(&__io_lock);
> +	writel((readl(reg) & ~clear) | set, reg);
> +	spin_unlock(&__io_lock);
> +}

I appreciate that you've lifted this code from a previous driver, but this
doesn't really make any sense to me. The spin_unlock operation is
essentially a store to normal, cacheable memory, whilst the writel is an
__iowmb followed by a store to device memory.

This means that you don't have ordering guarantees between the two accesses
outside of the CPU, potentially giving you:

	spin_lock(&__io_lock);
	spin_unlock(&__io_lock);
	writel((readl(reg) & ~clear) | set, reg);

which is probably not what you want.

I suggest adding an iowmb after the writel if you really need this ordering
to be enforced (but this may have a significant performance impact,
depending on your SoC).

Will
