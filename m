From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 17:27:08 +0100
Subject: when to use devm_request_irq and irq_set_chained_handler_and_data
In-Reply-To: <8520D5D51A55D047800579B09414719801690865@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <loom.20151007T172212-792@post.gmane.org>
 <56153DBA.9070700@arm.com>
 <8520D5D51A55D047800579B09414719801690865@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <561547DC.2030409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 17:07, Bharat Kumar Gogada wrote:
> Thanks, as mentioned in your review if have separate irq line which
> our driver consumes and we use devm_request_irq to setup irq line.
> Then can we use the same irq line number to setup chained irqchip but
> will there be two handlers for each of these or we can use the same
> handler.

I'm not sure I understand what you mean here, but let me be clear about
what I want to see in your particular driver:

- if you handle MSIs, you need an MSI domain
- if you call generic_handle_irq(), your need a chained irqchip with its
own irq domain

None of the above cases can be implemented using devm_request_irq, or
request_irq, or setup_irq.

If you have interrupts that are directly consumed by your driver
(because they are interrupts that are unrelated to devices that are on
the PCIe bus), then you can possibly use devm_request_irq.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
