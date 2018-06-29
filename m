From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 29 Jun 2018 17:27:51 +0200
Subject: [PATCH v3 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <ebdd4cb8-7cc8-3efa-d4be-f5d8860e848d@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-7-miquel.raynal@bootlin.com>
 <ebdd4cb8-7cc8-3efa-d4be-f5d8860e848d@arm.com>
Message-ID: <20180629172751.7404a531@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 13:05:05
+0100:

> On 22/06/18 16:14, Miquel Raynal wrote:
> > Before splitting the code to support multiple platform devices to
> > be probed (one for the ICU, one per interrupt group), let's switch to
> > regmap first by creating one in the ->probe().  
> 
> What's the benefit of doing so? I assume that has to do with supporting
> multiple devices that share an MMIO range?

Yes, the ICU subnodes will share the same MMIO range.

> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/irqchip/irq-mvebu-icu.c | 45 +++++++++++++++++++++++++++--------------
> >  1 file changed, 30 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > index 0f2655d7f19e..3694c0d73c0d 100644
> > --- a/drivers/irqchip/irq-mvebu-icu.c
> > +++ b/drivers/irqchip/irq-mvebu-icu.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/syscon.h>
> >  
> >  #include <dt-bindings/interrupt-controller/mvebu-icu.h>
> >  
> > @@ -38,7 +40,7 @@
> >  
> >  struct mvebu_icu {
> >  	struct irq_chip irq_chip;
> > -	void __iomem *base;
> > +	struct regmap *regmap;
> >  	struct irq_domain *domain;
> >  	struct device *dev;
> >  	atomic_t initialized;
> > @@ -56,10 +58,10 @@ static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
> >  		return;
> >  
> >  	/* Set Clear/Set ICU SPI message address in AP */
> > -	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
> > -	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
> > -	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
> > -	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
> > +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, msg[0].address_hi);
> > +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, msg[0].address_lo);
> > +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, msg[1].address_hi);
> > +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, msg[1].address_lo);  
> 
> Isn't this a change in the way we write things to the MMIO registers?
> You're now trading a writel_relaxed for a writel, plus some locking...

Is the "writel_relaxed" -> "writel" thing really an issue?

> 
> Talking about which: Are you always in a context where you can take that
> lock? The bit of documentation I've just read seems to imply that the
> default lock is a mutex. Is that always safe? My guess is that it isn't,
> and any callback that can end-up here after having taken something like
> the desc lock is going to blow in your face.
> 
> Have you tried lockdep?

Just did -- thanks for pointing it, it failed once the overheat
interrupt fired. I'm not sure if it is because of the regmap-locking
mechanism. There is definitely something to fix there, but I don't know
what for now; I'll come back on it.

[for reference: logs below]

Thanks,
Miqu?l

---
[   91.128615] 
[   91.130120] ================================
[   91.134408] WARNING: inconsistent lock state
[   91.138698] 4.18.0-rc1-00047-g7f7c805c2b69-dirty #1580 Not tainted
[   91.144905] --------------------------------
[   91.149193] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[   91.155227] swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   91.160388] (____ptrval____) (&tz->lock){?.+.}, at: thermal_zone_get_temp+0x60/0x158
[   91.168186] {HARDIRQ-ON-W} state was registered at:
[   91.173089]   lock_acquire+0x44/0x60
[   91.176683]   __mutex_lock+0x74/0x880
[   91.180362]   mutex_lock_nested+0x1c/0x28
[   91.184390]   thermal_zone_of_sensor_register+0x198/0x250
[   91.189812]   devm_thermal_zone_of_sensor_register+0x5c/0xc0
[   91.195498]   armada_thermal_probe+0x220/0x5f0
[   91.199963]   platform_drv_probe+0x50/0xb0
[   91.204078]   driver_probe_device+0x224/0x308
[   91.208454]   __driver_attach+0xe8/0xf0
[   91.212309]   bus_for_each_dev+0x68/0xc8
[   91.216248]   driver_attach+0x20/0x28
[   91.219926]   bus_add_driver+0x108/0x228
[   91.223866]   driver_register+0x60/0x110
[   91.227806]   __platform_driver_register+0x44/0x50
[   91.232622]   armada_thermal_driver_init+0x18/0x20
[   91.237436]   do_one_initcall+0x58/0x170
[   91.241378]   kernel_init_freeable+0x1d4/0x27c
[   91.245843]   kernel_init+0x10/0x108
[   91.249434]   ret_from_fork+0x10/0x18
[   91.253111] irq event stamp: 61312
[   91.256530] hardirqs last  enabled at (61309): [<ffff000008086ab0>] arch_cpu_idle+0x10/0x20
[   91.264918] hardirqs last disabled at (61310): [<ffff000008083134>] el1_irq+0x74/0x130
[   91.272871] softirqs last  enabled at (61312): [<ffff0000080b7fa0>] _local_bh_enable+0x20/0x40
[   91.281520] softirqs last disabled at (61311): [<ffff0000080b8398>] irq_enter+0x58/0x78
[   91.289559] 
[   91.289559] other info that might help us debug this:
[   91.296114]  Possible unsafe locking scenario:
[   91.296114] 
[   91.302058]        CPU0
[   91.304514]        ----
[   91.306970]   lock(&tz->lock);
[   91.310041]   <Interrupt>
[   91.312670]     lock(&tz->lock);
[   91.315916] 
[   91.315916]  *** DEADLOCK ***
[   91.315916] 
[   91.321863] no locks held by swapper/0/0.
[   91.325890] 
[   91.325890] stack backtrace:
[   91.330269] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc1-00047-g7f7c805c2b69-dirty #1580
[   91.339091] Hardware name: Marvell Armada 7040 DB board (DT)
[   91.344775] Call trace:
[   91.347234]  dump_backtrace+0x0/0x1a0
[   91.350913]  show_stack+0x14/0x20
[   91.354244]  dump_stack+0xb8/0xf4
[   91.357574]  print_usage_bug.part.24+0x264/0x27c
[   91.362211]  mark_lock+0x150/0x6b0
[   91.365628]  __lock_acquire+0x6d0/0x18f8
[   91.369568]  lock_acquire+0x44/0x60
[   91.373073]  __mutex_lock+0x74/0x880
[   91.376666]  mutex_lock_nested+0x1c/0x28
[   91.380606]  thermal_zone_get_temp+0x60/0x158
[   91.384982]  thermal_zone_device_update.part.4+0x34/0xe0
[   91.390318]  thermal_zone_device_update+0x28/0x38
[   91.395043]  armada_overheat_isr+0xb0/0xb8
[   91.399159]  __handle_irq_event_percpu+0x9c/0x128
[   91.403883]  handle_irq_event_percpu+0x34/0x88
[   91.408346]  handle_irq_event+0x48/0x78
[   91.412201]  handle_fasteoi_irq+0xa0/0x180
[   91.416316]  generic_handle_irq+0x24/0x38
[   91.420346]  mvebu_sei_handle_cascade_irq+0xc8/0x180
[   91.425332]  generic_handle_irq+0x24/0x38
[   91.429360]  __handle_domain_irq+0x5c/0xb8
[   91.433473]  gic_handle_irq+0x58/0xb0
[   91.437151]  el1_irq+0xb4/0x130
[   91.440306]  arch_cpu_idle+0x14/0x20
[   91.443898]  default_idle_call+0x18/0x30
[   91.447840]  do_idle+0x1c4/0x278
[   91.451082]  cpu_startup_entry+0x24/0x28
[   91.455023]  rest_init+0x254/0x268
[   91.458440]  start_kernel+0x3f0/0x41c
[   91.462126] thermal thermal_zone5: critical temperature reached (54 C), shutting down
