From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 7 Oct 2015 16:07:19 +0000
Subject: when to use devm_request_irq and irq_set_chained_handler_and_data
In-Reply-To: <56153DBA.9070700@arm.com>
References: <loom.20151007T172212-792@post.gmane.org>
 <56153DBA.9070700@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719801690865@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, as mentioned in your review if have separate irq line which our driver consumes and we use devm_request_irq to setup irq line. Then can we use the same irq line number to setup chained irqchip but will there be two handlers for each of these or we can use the same handler.

> when to use devm_request_irq and when to use irq_set_chained_handler_and_data.
> I see that some drivers are not using devm_request_irq instead using 
> irq_set_chained_handler_and_data for setting up irq handling.

If you're writing code for a driver that is not consuming the interrupt itself, but demultiplexing and forwarding it to another subsystem by calling generic_handle_irq() (or something similar), then you must implement a chained irqchip (as I mentioned yesterday while reviewing your PCIe controler driver).

> If we use  irq_set_chained_handler_and_data will it show up in cat 
> /proc/interrupts

No. Because this intermediate irqchip doesn't handle the interrupt, the final handler is. Otherwise, you'd end up with twice the number of interrupts...

	M.
--
Jazz is not dead. It just smells funny...
