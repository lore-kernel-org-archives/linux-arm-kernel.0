From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 27 Jan 2010 17:43:45 -0800
Subject: [PATCH 3/5] gic: Add set_type callback
In-Reply-To: <20100127231832.GF29665@n2100.arm.linux.org.uk>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-4-git-send-email-adharmap@codeaurora.org>
	<20100127231832.GF29665@n2100.arm.linux.org.uk>
Message-ID: <4B60EBD1.9020005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2010 at 11:32:27AM -0800, adharmap at codeaurora.org wrote:
>> +	if (flow_type & (IRQ_TYPE_EDGE_RISING|IRQ_TYPE_EDGE_FALLING)) {
>> +		reg_value |= (2<<bit_index);
>> +		writel(reg_value, gic_dist_base(irq) + GIC_DIST_CONFIG
>> +							+ register_index);
>> +		__set_irq_handler_unlocked(irq, handle_edge_irq);
>> +	}
>> +
>> +	if (flow_type & (IRQ_TYPE_LEVEL_HIGH|IRQ_TYPE_LEVEL_LOW)) {
> 
> This is actually where things start to get rather sticky - because
> there may well be on-chip inverters between the GIC and external
> peripherals.
Actually the comment in gic_dist_init mentions about configuring SPI's 
as level low when the GIC only supports level high. That suggests 
presence of an inverter.
> 
> Since the GIC can only sense one edge or one level depending on the
> hardware setup, it seems wrong to allow the configuration of both
> high and low levels, and both edges.
Agree, but this change at least lets us configure them as edge/level 
triggered.

One solution (a rather easy one) is we simply reject LEVEL_LOW and 
EDGE_FALLING and think as if the inverters belong to the peripherals 
rather than the GIC.

Please suggest alternative implementation ideas.
