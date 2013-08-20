From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 22:08:39 +0100
Subject: [PATCH v2 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377017307-23201-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130820210839.GE17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 01:48:25PM -0300, Ezequiel Garcia wrote:
> Based on a similar approach suggested by Russel King:

Russell please.

We Russells get upset when our names are incorrectly spelt, just like
others get upset if they end up with extra letters in their names, or
you confuse Steven vs Stephen.  Or even dare call a Deborah "Debs"
(I did that once and the result was not particularly nice!)

> +void atomic_io_clear_set(u32 clear, u32 set, void __iomem *reg)
> +{
> +	spin_lock(&__io_lock);
> +	writel((readl(reg) & ~clear) | set, reg);
> +	/* ensure the write get done before unlocking */
> +	__iowmb();
> +	spin_unlock(&__io_lock);
> +}
> +EXPORT_SYMBOL(atomic_io_clear_set);

Some comments - neither of them you _have_ to act on:

1. writel((readl(reg) & ~mask) | (set & mask), reg) could be deemed
   to give better semantics - consider that if you don't look at the
   implementation, how do you know what the result of setting a bit
   in both the set & clear masks would be?

2. A historical note, that back in the 1980s with things like the BBC
   micro, this kind of operation was defined:

	new_value = (old_value & mask) ^ value

   which has the flexibility of being able to set, clear or toggle any
   bit.  I'm not saying that's a good interface, I'm merely pointing
   out that the problem of being able to set and clear bits is nothing
   new and other solutions are available. :)

3. Would it be better to separate these by having atomic_io_clear() and
   atomic_io_set() functions?

Just some things to think about; I have no overall preference here.
