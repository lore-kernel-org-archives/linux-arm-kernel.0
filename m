From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 16:49:07 +0000
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131210164907.GA11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:41:35AM -0300, Ezequiel Garcia wrote:

> +void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
> +{
> +	unsigned long flags;
> +	u32 value;
> +
> +	raw_spin_lock_irqsave(&__io_lock, flags);
> +	value = readl_relaxed(reg) & ~mask;
> +	value |= (set & mask);
> +	writel_relaxed(value, reg);
> +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> +}
> +EXPORT_SYMBOL(atomic_io_modify_relaxed);

This looks quite generic - why is it in architecture specific code?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/a9b3a487/attachment.sig>
