From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 16:43:54 +0100
Subject: when to use devm_request_irq and irq_set_chained_handler_and_data
In-Reply-To: <loom.20151007T172212-792@post.gmane.org>
References: <loom.20151007T172212-792@post.gmane.org>
Message-ID: <56153DBA.9070700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 16:29, bharat kumar gogada wrote:
> when to use devm_request_irq and when to use irq_set_chained_handler_and_data.
> I see that some drivers are not using devm_request_irq instead using
> irq_set_chained_handler_and_data for setting up irq handling.

If you're writing code for a driver that is not consuming the interrupt
itself, but demultiplexing and forwarding it to another subsystem by
calling generic_handle_irq() (or something similar), then you must
implement a chained irqchip (as I mentioned yesterday while reviewing
your PCIe controler driver).

> If we use  irq_set_chained_handler_and_data will it show up in cat
> /proc/interrupts

No. Because this intermediate irqchip doesn't handle the interrupt, the
final handler is. Otherwise, you'd end up with twice the number of
interrupts...

	M.
-- 
Jazz is not dead. It just smells funny...
