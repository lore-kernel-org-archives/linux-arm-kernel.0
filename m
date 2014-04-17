From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Apr 2014 14:40:43 -0000
Subject: [patch 0/6] dma: edma: Provide granular residue accounting
Message-ID: <20140417133737.892475126@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The residue reporting in edma_tx_status() is broken and the
implementation is beyond silly. See patch 1/n and 2/n

The following series addresses this and adds on top granular
accounting to the driver.

The motivation behind this is that I tried to get the DMA mode of the
DCAN peripheral in beaglebone working. The DCAN device driver
implements a network device via the net/can infrastructure.

So the obvious choice would have been scatter gather lists. But that
has the same issue as the stupid "FIFO" implementation of the CAN IP.

Once the last SG element is processed, the EDMA interrupt needs to
establish the next SG list. In fastest mode the CAN packets come with
less than 50us over the wire and there is no buffering in the CAN
IP. So if the interrupt gets delayed a bit we can lose packets. With
enough load on the bus its observable.

The next obstacle was the missing per SG element reporting. We really
can't wait for a full SG list for notification.

I couldn't be bothered to fix this, as this would defeat the whole
idea of NAPI: disable interrupts and poll the device until all pending
packets are done.

So we'd trade the CAN interrupt per packet against the EDMA interrupt
per packet. And the notification which is done via a tasklet is not
really helpful either.

Interrupt
     schedule tasklet

  softirq
     run tasklet
     	 napi_schedule()
	    raise RX softirq

     run rx-action 
  	 poll one packet
	 napi_complete()

So even if another interrupt comes in before we leave the NAPI poll
there is no way that we can see it as it merily schedules the
tasklet. Not what you really want.

The same applies to cyclic buffers where the period is one CAN
frame. That actually works without the packet loss due to SG reload.

But the interrupt load is amazing and with only max 20 periods an
overrun is to observe when the softirq goes into the ksoftirq
thread. It just takes 1ms away from the CPU to happen, which is less
than a full timeslot with HZ=250.

Next idea was to utilize a single larger cyclic buffer and avoid the
EDMA interrupt alltogether as the CAN chip can signal the state change
via its own interrupt which is then handled simply via the normal NAPI
mechanisms. Now the CAN IP has no packet counter so I decided to use
dma_tx_status to track the DMA progress.

That failed to work because the residue reporting was only descriptor
granular and returned even the wrong size for the circular buffer.

So I digged into the details and found a rather simple solution to
make granular accounting useable for both circular and SG style work.

With that the DCAN DMA works reliably and the system load decreases
significantly as the main contributor to that (the slow read from the
DCAN interface) is gone.

As a side note:

The DCAN readout is 4 consecutive 32bit registers. The only way I got
that working is by configuring the engine with:

       cfg.direction = DMA_DEV_TO_MEM;
       cfg.src_addr_width = 16;
       cfg.src_maxburst = 1;

With
       cfg.src_addr_width = 4;
       cfg.src_maxburst = 4;

it reads just 4 times the first register.

I have my doubts that this is correct API wise, so it'd be nice if
someone could enlighten me on that.

Thanks,

	tglx
