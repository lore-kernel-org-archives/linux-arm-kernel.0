From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 15 Apr 2011 12:17:55 -0700
Subject: [RFC PATCH] genirq: implement read_irq_line for interrupt lines
In-Reply-To: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
References: <1302892952-7090-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <4DA899E3.30409@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2011 11:42 AM, Abhijeet Dharmapurikar wrote:
[...]
>
> +/**
> + *	irq_read_line - read the value on an irq line
> + *	@irq: Interrupt number representing a hardware line
> + *
> + *	This function may be called from IRQ context only when
> + *	desc->chip->bus_lock and desc->chip->bus_sync_unlock are NULL !

What does it return?  I can see that -EINVAL is returned if it isn't 
applicable to this irq.  But what if chip->irq_read_line is implemented?




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
>   /*
>    * Internal function that tells the architecture code whether a
>    * particular irq has been exclusively allocated or is available
