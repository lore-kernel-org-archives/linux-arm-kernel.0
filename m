From: slash.tmp@free.fr (Mason)
Date: Mon, 5 Jun 2017 13:57:27 +0200
Subject: Design of interrupt controller driver
In-Reply-To: <alpine.DEB.2.20.1706051007050.3517@nanos>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
 <alpine.DEB.2.20.1706041551530.2813@nanos>
 <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
 <alpine.DEB.2.20.1706042208080.3517@nanos>
 <6e4da485-42cc-9b70-1b4a-9729f646e014@free.fr>
 <alpine.DEB.2.20.1706051007050.3517@nanos>
Message-ID: <77a6e423-5c6a-9e5a-d679-c2576074fe6d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2017 10:23, Thomas Gleixner wrote:
> On Mon, 5 Jun 2017, Mason wrote:
>> On 04/06/2017 22:13, Thomas Gleixner wrote:
>>> When you configure the interrupt as edge then you cannot share it. No
>>> matter whether it stays high or not.
>>
>> Could you explain why? (I must be missing something.)
> 
> Device A    Device B	 Combined Output  Edge detection
> Low    	    Low	   	 0	  	  N
> 
> Low -> High Low		 1	    	  Y  -> Interrupt handled
> 
> High   	    Low -> High	 1	    	  N
> 
> When the A line stays high, which it does, then the edge detector will not
> see a transition for B and you lose an interrupt.

Doh! It's totally obvious, now that you point it out.
I must be mis-remembering my previous setup.
I'll review everything before submitting a patch.

>>> The only way to share it is, to configure it as level interrupt. But that
>>> requires that you can disable the interrupt at the DMA device level once it
>>> triggered. Otherwise you get an interrupt storm.
>>
>> I'm not sure what you mean with "disable the interrupt at the
>> DMA device level". The interrupt can be masked at the system
>> interrupt controller (i.e. before sharing the interrupt
>> signal). The DMA engine just outputs 0 when busy, 1 when idle.
> 
> Sharing level interrupts requires a way to disable the device (in your case
> the DMA engine) interrupt output in order to prevent irq storms.
> 
> Pseudo code (locking etc. omitted):
> 
> irq_handler_devA()
> {
> 	if (!interrupt_active(devA))
> 		return IRQ_NONE;
> 
> 	handle_device_irq();
> 
> 	if (no_more_outstanding_requests(devA)) {
> 		reg = readl(devA->irq_control_reg);
> 		reg &= ~DEV_IRQ_ENABLE;
> 		writel(devA->irq_control_reg, reg);
> 	}
> 	return IRQ_HANDLED;
> }
> 
> queue_request_devA()
> {
> 	if (no_more_outstanding_requests(devA)) {
> 		queue_request();
> 		
> 		start_engine();
> 
> 		/* Reenable interrupt at device level */
> 		reg = readl(devA->irq_control_reg);
> 		reg |= DEV_IRQ_ENABLE;
> 		writel(devA->irq_control_reg, reg);
> 	} else {
> 	       queue_request();
> 	}
> }
> 
> You get the idea.

I'll take a closer look at the DMA engine driver.

Is it possible to call the interrupt controller's mask callback
from the DMA engine driver ISR, or is that reserved for the IRQ
framework? Because that's what the HW designers had in mind,
thus they didn't provide a way to mask the interrupt in the
device. It just outputs the signal to the interrupt router.

So their proposed setup is as follows:

Start the system with the DMA interrupt masked in the intc.
When SW needs to perform a DMA op, the DMA driver starts
the op (thus the interrupt signal goes low), then unmasks
the interrupt in the intc. Interrupt triggers when signal
goes high (level high). Driver masks interrupt in ISR,
until next op is available.

Is that possible in the Linux framework?

Regards.
