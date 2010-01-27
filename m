From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 23:09:58 +0000
Subject: [PATCH 3/5] gic: Add set_type callback
In-Reply-To: <1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100127230958.GE29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:32:27AM -0800, adharmap at codeaurora.org wrote:
> +	if (irq > 1020)
> +		return -1;

*unprintable*.  Always use proper error codes.

> +
> +	/*
> +	* Two bits each, calc the register and bit, 16 per 32 bit register
> +	* accessible long word only
> +	* But the field is NxN 1xN and rising/falling
> +	*/
> +	register_index = (irq/16)<<2;
> +	bit_index = (irq & 0xF)<<1;
> +
> +	spin_lock(&irq_controller_lock);
> +	reg_value = readl(gic_dist_base(irq) + GIC_DIST_CONFIG +
> +						register_index);
> +	/*
> +	* keep the nxn and 1xn , mask the edge level
> +	* Edge is 1, level 0
> +	*/
> +	reg_value = (reg_value & ~(2<<bit_index));
> +	if (flow_type & (IRQ_TYPE_EDGE_RISING|IRQ_TYPE_EDGE_FALLING)) {
> +		reg_value |= (2<<bit_index);
> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
> +							+ register_index);
> +		__set_irq_handler_unlocked(irq, handle_edge_irq);
> +	}
> +
> +	if (flow_type & (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW)) {
> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
> +							+ register_index);
> +		__set_irq_handler_unlocked(irq, handle_level_irq);
> +	}

This needs to exclude the first 32 interrupts, where the interrupt
configuration is either read-only or banked between multiprocessor
CPUs.
