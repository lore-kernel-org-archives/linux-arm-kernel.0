From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 23:18:32 +0000
Subject: [PATCH 3/5] gic: Add set_type callback
In-Reply-To: <1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100127231832.GF29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:32:27AM -0800, adharmap at codeaurora.org wrote:
> +	if (flow_type & (IRQ_TYPE_EDGE_RISING|IRQ_TYPE_EDGE_FALLING)) {
> +		reg_value |= (2<<bit_index);
> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
> +							+ register_index);
> +		__set_irq_handler_unlocked(irq, handle_edge_irq);
> +	}
> +
> +	if (flow_type & (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW)) {

This is actually where things start to get rather sticky - because
there may well be on-chip inverters between the GIC and external
peripherals.

Since the GIC can only sense one edge or one level depending on the
hardware setup, it seems wrong to allow the configuration of both
high and low levels, and both edges.
