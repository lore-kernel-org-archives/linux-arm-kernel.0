From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 11:49:32 +0000
Subject: [PATCH V12 2/7] dma: hidma: Add Device Tree support
In-Reply-To: <5699232E.60809@codeaurora.org>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-3-git-send-email-okaya@codeaurora.org>
 <20160115151637.GJ3262@leverpostej> <5699232E.60809@codeaurora.org>
Message-ID: <20160118114931.GJ21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +Main node required properties:
> >> +- compatible: "qcom,hidma-mgmt-1.0";
> >> +- reg: Address range for DMA device
> >> +- dma-channels: Number of channels supported by this DMA controller.
> >> +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
> >> +  fragmented to multiples of this amount.
> >> +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
> >> +  fragmented to multiples of this amount.
> >> +- max-write-transactions: Maximum write transactions to perform in a burst
> >> +- max-read-transactions: Maximum read transactions to perform in a burst
> > 
> > Just to check, where do these max-* values come from?
> These are HW bus parameters like the burst count and 
> size of each burst. These values change based on the SoC this IP is in use.
> 
> > 
> > Are they some correctness requirement of the bus this is attached to?
> You can starve other peripherals if you use incorrect values as the bus is 
> shared with other peripherals. Yes, correctness is required.

Is that a property of the system known statically, or one determined by
testing the system under particular workloads? It feels like the latter
(though I appreciate that not starving other masters is certainly a
correctness property regardless of how this is derived).

I'd have expected the bus this is plugged into to have appropriate QoS
settings pre-configured so as to avoid starvation, though it sounds like
that's not possible here?

> > Are they tuning values?
> Correct value is necessary for functioning. I'd consider weight and priority
> as the only tuning parameters. 
> 
> > 
> > The latter doesn't really belong in the DT. Given they're writeable from
> > the driver, it seems like that's what they are...
> 
> Good catch. Those should have been read-only. I wanted to be able to export these
> information to the userspace app. I'll fix the sysfs to make them read-only.
> 
> > 
> >> +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
> > 
> > I'm not sure what this means. Could you elaborate on this is?
> After each reset command, HW starts a timer. This is the time HW waits before it declares
> reset failed.

Is that a reset command sent to the HIDMA by the OS, or a reset command
from the HIDMA to something else?

What does it do when it declares a reset as failed?

How can the OS make use of this information? It has no idea of the
clocks input to the HIDMA, so it has no idea how long a cycle is.

Is this programmed by the OS?

Is the particular duration in cycles a requirement of some other agent?

Thanks,
Mark.
