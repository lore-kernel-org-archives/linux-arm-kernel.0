From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Thu, 23 Jan 2014 13:38:37 +0000
Subject: [PATCH v2] dma: Add Xilinx AXI Video Direct Memory Access
 Engine driver support
In-Reply-To: <52E0FC22.8060903@metafoo.de>
References: <1390409565-4200-1-git-send-email-sthokal@xilinx.com>
 <1390409565-4200-2-git-send-email-sthokal@xilinx.com>
 <52E0FC22.8060903@metafoo.de>
Message-ID: <1390484317.7619.81.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-23 at 12:25 +0100, Lars-Peter Clausen wrote:
> On 01/22/2014 05:52 PM, Srikanth Thokala wrote:

[...]

> > +	/* Request the interrupt */
> > +	chan->irq = irq_of_parse_and_map(node, 0);
> > +	err = devm_request_irq(xdev->dev, chan->irq, xilinx_vdma_irq_handler,
> > +			       IRQF_SHARED, "xilinx-vdma-controller", chan);
> 
> This is a clasic example of where to not use devm_request_irq. 'chan' is
> accessed in the interrupt handler, but if you use devm_request_irq 'chan'
> will be freed before the interrupt handler has been released, which means
> there is now a race condition where the interrupt handler can access already
> freed memory.

Could you elaborate this case? As far as I understood managed resources
are a kind of stack pile. In this case you have no such condition. Where
am I wrong?


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
