From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Mar 2014 11:34:13 +0100 (CET)
Subject: [PATCH V3 1/5] genirq: define flag IRQ_SRC_DST_INVERTED, and
 accessors
In-Reply-To: <alpine.DEB.2.02.1403041018370.18573@ionos.tec.linutronix.de>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
 <alpine.DEB.2.02.1403041018370.18573@ionos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.02.1403041130280.18573@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Mar 2014, Thomas Gleixner wrote:

> On Mon, 3 Mar 2014, Stephen Warren wrote:
> 
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Some devices have configurable IRQ output polarities. Software might
> > use IRQ_TYPE_* to determine how to configure such a device's IRQ
> > output polarity in order to match how the IRQ controller input is
> > configured. If the board or SoC inverts the signal between the
> > device's IRQ output and controller's IRQ output, software must be
> > aware of this fact, in order to program the IRQ output to the correct
> > (i.e. opposite) polarity. This flag provides that information.
> 
> So what you're saying is:
> 
> Device IRQ output --> [Optional Inverter Logic] --> IRQ controller input.
> 
> And you're storing the information about the presence of the inverter
> logic in the irq itself, but the core does not make any use of it and
> you let the device driver deal with the outcome.
> 
> This sucks as all affected drivers have to implement the same sanity
> logic for this.
> 
> Why don't you implement a core function which tells the driver which
> polarity to select? That requires a few more changes, but I think it's
> worth it for other reasons.
> 
> Right now the set_type logic requires the irq chip drivers to
> implement sanity checking and default selections for TYPE_NONE. We can
> be more clever about that and add this information to the irq chip
> flags.
> 
> enum {
>      IRQ_CHIP_TYPES_MASK	= 0x0f,
>      IRQ_CHIP_DEFAULT_MASK	= 0xf0,
>      IRQ_CHIP_EXISTING_FLAGS	....
> }

We need to extend the mask to indicate whether the chip supports
BOTH_EDGES. A chip can support FALLING and RISING, but not both at the
same time. For the set_type side the current BOTH = FALLING | RISING
is fine, but for checking the supported type it's not sufficient.

Thanks,

	tglx
