From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2015 20:38:22 +0100
Subject: [PATCH v3 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1442551054-2116-2-git-send-email-yamada.masahiro@socionext.com>
References: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
 <1442551054-2116-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150921193822.GV21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 01:37:32PM +0900, Masahiro Yamada wrote:
> +/**
> + * __uniphier_cache_maint_common - run a queue operation for a particular level
> + *
> + * @data: cache controller specific data
> + * @start: start address of range operation (don't care for "all" operation)
> + * @size: data size of range operation (don't care for "all" operation)
> + * @operation: flags to specify the desired cache operation
> + */
> +static void __uniphier_cache_maint_common(struct uniphier_cache_data *data,
> +					  unsigned long start,
> +					  unsigned long size,
> +					  u32 operation)
> +{
> +	unsigned long flags;
> +
> +	/*
> +	 * The IRQ must be disable during this sequence because the accessor
> +	 * holds the access right of the operation queue registers.  The IRQ
> +	 * should be restored after releasing the register access right.
> +	 */
> +	local_irq_save(flags);
> +
> +	/* clear the complete notification flag */
> +	writel_relaxed(UNIPHIER_SSCOLPQS_EF, data->op_base + UNIPHIER_SSCOLPQS);
> +
> +	/*
> +	 * We do not need a spin lock here because the hardware guarantees
> +	 * this sequence is atomic, i.e. the write access is arbitrated
> +	 * and only the winner's write accesses take effect.
> +	 * After register settings, we need to check the UNIPHIER_SSCOPPQSEF to
> +	 * see if we won the arbitration or not.
> +	 * If the command was not successfully set, just try again.
> +	 */
> +	do {
> +		/* set cache operation */
> +		writel_relaxed(UNIPHIER_SSCOQM_CE | operation,
> +			       data->op_base + UNIPHIER_SSCOQM);
> +
> +		/* set address range if needed */
> +		if (likely(UNIPHIER_SSCOQM_S_IS_RANGE(operation))) {
> +			writel_relaxed(start, data->op_base + UNIPHIER_SSCOQAD);
> +			writel_relaxed(size, data->op_base + UNIPHIER_SSCOQSZ);
> +		}
> +
> +		/* set target ways if needed */
> +		if (unlikely(UNIPHIER_SSCOQM_TID_IS_WAY(operation)))
> +			writel_relaxed(data->way_locked_mask,
> +				       data->op_base + UNIPHIER_SSCOQWN);
> +	} while (unlikely(readl_relaxed(data->op_base + UNIPHIER_SSCOPPQSEF) &
> +			  (UNIPHIER_SSCOPPQSEF_FE | UNIPHIER_SSCOPPQSEF_OE)));
> +
> +	/* wait until the operation is completed */
> +	while (likely(readl_relaxed(data->op_base + UNIPHIER_SSCOLPQS) !=
> +		      UNIPHIER_SSCOLPQS_EF))
> +		cpu_relax();
> +
> +	local_irq_restore(flags);

I'm concerned about this.  We've had caches like this (ARM L220) which
require only one operation to be performed at a time.  In a SMP system,
that requires a spinlock to prevent one CPU triggering a L2 maintanence
operation while another CPU tries to operate on the L2 cache.

>From the overall series diffstat, I see that you are adding SMP support
too.  So I have to ask the obvious question: if you need to disable
local IRQs around the L2 cache operations, what happens if two CPUs
both try to perform a L2 cache operation concurrently?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
