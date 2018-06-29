From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 29 Jun 2018 20:20:46 +0200
Subject: [PATCH v3 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <868t6xzf4u.wl-marc.zyngier@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-7-miquel.raynal@bootlin.com>
 <ebdd4cb8-7cc8-3efa-d4be-f5d8860e848d@arm.com>
 <20180629172751.7404a531@xps13>
 <868t6xzf4u.wl-marc.zyngier@arm.com>
Message-ID: <20180629202046.53c7b874@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Fri, 29 Jun 2018 18:17:21
+0100:

> On Fri, 29 Jun 2018 16:27:51 +0100,
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > 
> > Hi Marc,
> > 
> > Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 13:05:05
> > +0100:
> >   
> > > On 22/06/18 16:14, Miquel Raynal wrote:  
> > > > Before splitting the code to support multiple platform devices to
> > > > be probed (one for the ICU, one per interrupt group), let's switch to
> > > > regmap first by creating one in the ->probe().    
> > > 
> > > What's the benefit of doing so? I assume that has to do with supporting
> > > multiple devices that share an MMIO range?  
> > 
> > Yes, the ICU subnodes will share the same MMIO range.  
> 
> So, one MMIO range, shared by multiple devices managed by the same
> driver. Why the complexity?

Mmmmh... one point :)

> 
> >   
> > >   
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/irqchip/irq-mvebu-icu.c | 45 +++++++++++++++++++++++++++--------------
> > > >  1 file changed, 30 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > > > index 0f2655d7f19e..3694c0d73c0d 100644
> > > > --- a/drivers/irqchip/irq-mvebu-icu.c
> > > > +++ b/drivers/irqchip/irq-mvebu-icu.c
> > > > @@ -18,6 +18,8 @@
> > > >  #include <linux/of_irq.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/mfd/syscon.h>
> > > >  
> > > >  #include <dt-bindings/interrupt-controller/mvebu-icu.h>
> > > >  
> > > > @@ -38,7 +40,7 @@
> > > >  
> > > >  struct mvebu_icu {
> > > >  	struct irq_chip irq_chip;
> > > > -	void __iomem *base;
> > > > +	struct regmap *regmap;
> > > >  	struct irq_domain *domain;
> > > >  	struct device *dev;
> > > >  	atomic_t initialized;
> > > > @@ -56,10 +58,10 @@ static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
> > > >  		return;
> > > >  
> > > >  	/* Set Clear/Set ICU SPI message address in AP */
> > > > -	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
> > > > -	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
> > > > -	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
> > > > -	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
> > > > +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, msg[0].address_hi);
> > > > +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, msg[0].address_lo);
> > > > +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, msg[1].address_hi);
> > > > +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, msg[1].address_lo);    
> > > 
> > > Isn't this a change in the way we write things to the MMIO registers?
> > > You're now trading a writel_relaxed for a writel, plus some locking...  
> > 
> > Is the "writel_relaxed" -> "writel" thing really an issue?  
> 
> If you're happy with system-wide barriers (dsb sy) being issued,
> synchronising unrelated accesses, and generally slowing down the whole
> system in a completely unnecessary way, then there is absolutely no
> issue whatsoever. Performance is completely overrated anyway, let's
> embrace slow computing.

8-D

> 
> >   
> > > 
> > > Talking about which: Are you always in a context where you can take that
> > > lock? The bit of documentation I've just read seems to imply that the
> > > default lock is a mutex. Is that always safe? My guess is that it isn't,
> > > and any callback that can end-up here after having taken something like
> > > the desc lock is going to blow in your face.
> > > 
> > > Have you tried lockdep?  
> > 
> > Just did -- thanks for pointing it, it failed once the overheat
> > interrupt fired. I'm not sure if it is because of the regmap-locking
> > mechanism. There is definitely something to fix there, but I don't know
> > what for now; I'll come back on it.  
> 
> Well, that's interesting:
> 
> > [   91.376666]  mutex_lock_nested+0x1c/0x28
> > [   91.380606]  thermal_zone_get_temp+0x60/0x158
> > [   91.384982]  thermal_zone_device_update.part.4+0x34/0xe0
> > [   91.390318]  thermal_zone_device_update+0x28/0x38
> > [   91.395043]  armada_overheat_isr+0xb0/0xb8
> > [   91.399159]  __handle_irq_event_percpu+0x9c/0x128
> > [   91.403883]  handle_irq_event_percpu+0x34/0x88
> > [   91.408346]  handle_irq_event+0x48/0x78
> > [   91.412201]  handle_fasteoi_irq+0xa0/0x180
> > [   91.416316]  generic_handle_irq+0x24/0x38
> > [   91.420346]  mvebu_sei_handle_cascade_irq+0xc8/0x180
> > [   91.425332]  generic_handle_irq+0x24/0x38
> > [   91.429360]  __handle_domain_irq+0x5c/0xb8
> > [   91.433473]  gic_handle_irq+0x58/0xb0
> > [   91.437151]  el1_irq+0xb4/0x130  
> 
> Taking a mutex in an interrupt handler is... great! On the other hand,
> that armada_overheat_isr function doesn't seem to exist in 4.18-rc2,
> so that's absolutely fine.

I had no troubles with NSRs so I wanted to check with SEIs too.

The only device using SEIs for now is this thermal driver which I just
contributed, it is still under review. The ISR is making a thermal-core
call to update on an overheat situation. This call is synchronous and
the core checks for the current temperature, but first locks its
tz->lock mutex, which is kind of bad in interrupt context. I just
realized it. Sad.

> 
> Nonetheless, regmap usage in this context is still suspect, and my gut
> feeling is that you really don't need it at all.

You are right on this and I probably over-looked at the initial
problem. I'm pretty sure I can get rid of it as long as only one driver
touches this MMIO region.

Thanks for all your thoughts, I'll resend a version next week.

Thank you very much,
Miqu?l
