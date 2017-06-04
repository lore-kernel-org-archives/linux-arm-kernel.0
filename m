From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 4 Jun 2017 22:13:09 +0200 (CEST)
Subject: Design of interrupt controller driver
In-Reply-To: <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
 <alpine.DEB.2.20.1706041551530.2813@nanos>
 <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
Message-ID: <alpine.DEB.2.20.1706042208080.3517@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Jun 2017, Mason wrote:
> On 04/06/2017 15:55, Thomas Gleixner wrote:
> >> As for the DMA interrupt, the HW designers consider it
> >> a level interrupt. When the engine is busy processing
> >> a command, the interrupt signal is low; when the engine's
> >> command queue is empty, the interrupt signal is high.
> >> Thus, there is no risk of "missing a pulse". But maz
> >> has stated twice that the relevant *event* is the
> >> transition from "busy" to "idle", which makes this
> >> an edge (rising) interrupt. However, it doesn't have
> >> the problem described in 2)  The interrupt signal
> >> will remain high, so there is no risk of "missing"
> >> a pulse. So they can be grouped. Is that correct?
> > 
> > That depends on the DMA controller. If you can disable the interrupt line
> > at the DMA device level, then you can use that scheme. If not, you'll get
> > an interrupt storm as long as the DMA engine is idle.
> 
> I don't follow.

Sorry, hit send too early. Let me rephrase:

When you configure the interrupt as edge then you cannot share it. No
matter whether it stays high or not.

The only way to share it is, to configure it as level interrupt. But that
requires that you can disable the interrupt at the DMA device level once it
triggered. Otherwise you get an interrupt storm.

Thanks,

	tglx
