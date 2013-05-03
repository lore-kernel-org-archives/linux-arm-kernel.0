From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 May 2013 23:23:01 +0100
Subject: [RFC patch 7/8] genirq: generic chip: Add linear irq domain
 support
In-Reply-To: <20130503214629.810207749@linutronix.de>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.810207749@linutronix.de>
Message-ID: <20130503222300.GF18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 09:50:53PM -0000, Thomas Gleixner wrote:
> +	/* Init mask cache ? */
> +	if (dgc->gc_flags & IRQ_GC_INIT_MASK_CACHE) {
> +		raw_spin_lock_irqsave(&gc->lock, flags);
> +		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
> +		raw_spin_unlock_irqrestore(&gc->lock, flags);
> +	}

This looks a little weird to me - it seems that it'll re-read this
each time any irq is mapped in the domain, which is probably not
wanted.
