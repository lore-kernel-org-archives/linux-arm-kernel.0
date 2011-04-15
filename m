From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Fri, 15 Apr 2011 15:03:19 -0400
Subject: [RFC PATCH] genirq: implement read_irq_line for interrupt lines
In-Reply-To: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
References: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <20110415190319.GA24111@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Abhijeet Dharmapurikar (adharmap at codeaurora.org) wrote:
> Some drivers need to know what the status of the interrupt line is.
> This is especially true for drivers that register a handler with
> IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING and in the handler they
> need to know which edge transition it was invoked for.
> 
> The irq_read_line callback in the chip allows the controller to provide
> the real time status of this line. Controllers that can read the status
> of an interrupt line should implement this by doing necessary
> hardware reads and return the logical state of the line.
> 
> Interrupt controllers based on the slow bus architecture should conduct
> the transaction in this callback. The genirq code will call the chip's
> bus lock prior to calling irq_read_line. Obviously since the transaction
> would be completed before returning from irq_read_line it need not do
> any transactions in the bus unlock call.
> 
> Drivers need to be aware whether the interrupt controller is a slow bus
> and call read_irq_line in proper context.

Hrm, this strikes me as odd. Is there any way this generic API could
handle the corner-cases without needed the caller to know this ?

[...]

> +/**
> + *	irq_read_line - read the value on an irq line
> + *	@irq: Interrupt number representing a hardware line
> + *
> + *	This function may be called from IRQ context only when
> + *	desc->chip->bus_lock and desc->chip->bus_sync_unlock are NULL !

The comment here seems to imply "be careful when using this extremely
fragile interface", which does not give me the warm safety feeling I
would come to expect from a generic kernel API.

Any ideas on how to improve that ?

Thanks,

Mathieu

> + */
> +int irq_read_line(unsigned int irq)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	unsigned long flags;
> +	int val;
> +
> +	if (!desc || !desc->irq_data.chip->irq_read_line)
> +		return -EINVAL;
> +
> +	chip_bus_lock(desc);
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	val = desc->irq_data.chip->irq_read_line(&desc->irq_data);
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +	chip_bus_sync_unlock(desc);
> +	return val;
> +}
> +EXPORT_SYMBOL(irq_read_line);
> +
>  /*
>   * Internal function that tells the architecture code whether a
>   * particular irq has been exclusively allocated or is available
> -- 
> 1.7.1
> 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
