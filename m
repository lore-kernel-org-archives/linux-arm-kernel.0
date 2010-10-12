From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 12 Oct 2010 18:00:28 +0200
Subject: [PATCH] mmci: corrected calculation of clock div for ux500
Message-ID: <mailman.40.1291322372.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 variant of this block has a different divider.
The value used right now is too big and which means a loss
in performance. This fix corrects it. Also expand the math
comments a bit so it's clear what's happening.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7567872..0a95377 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,7 @@ static unsigned int fmax =3D 515633;
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware wh=
en
  *             using DMA.
  * @sdio: variant supports SDIO
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
 struct variant_data {
        unsigned int            clkreg;
@@ -61,6 +62,7 @@ struct variant_data {
        bool                    broken_blockend;
        bool                    broken_blockend_dma;
        bool                    sdio;
+       bool                    st_clkdiv;
 };

 static struct variant_data variant_arm =3D {
@@ -86,7 +88,9 @@ static struct variant_data variant_ux500 =3D {
        .datalength_bits        =3D 24,
        .broken_blockend        =3D true,
        .sdio                   =3D true,
+       .st_clkdiv              =3D true,
 };
+
 /*
  * This must be called with host->lock held
  */
@@ -99,7 +103,22 @@ static void mmci_set_clkreg(struct mmci_host
*host, unsigned int desired)
                if (desired >=3D host->mclk) {
                        clk =3D MCI_CLK_BYPASS;
                        host->cclk =3D host->mclk;
+               } else if (variant->st_clkdiv) {
+                       /*
+                        * DB8500 TRM says f =3D mclk / (clkdiv + 2)
+                        * =3D> clkdiv =3D (mclk / f) - 2
+                        * Round the divider up so we don't exceed the max
+                        * frequency
+                        */
+                       clk =3D DIV_ROUND_UP(host->mclk, desired) - 2;
+                       if (clk >=3D 256)
+                               clk =3D 255;
+                       host->cclk =3D host->mclk / (clk + 2);
                } else {
+                       /*
+                        * PL180 TRM says f =3D mclk / (2 * (clkdiv + 1))
+                        * =3D> clkdiv =3D mclk / (2 * f) - 1
+                        */
                        clk =3D host->mclk / (2 * desired) - 1;
                        if (clk >=3D 256)
                                clk =3D 255;
--=20
1.7.3.2


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.42.1291737903.1530.linux-arm-kernel@lists.infradead.org>

Hello Andrew,

mach-at91 makes use of interrupt priority and nesting, which can be
set via a call to at91samXXXX_init_interrupts(). This utilises the
processor's internal IRQ priority mechanism.
This worked fine up to kernel 2.6.34.x, but not since kernel 2.6.35
Kernel 2.6.35 introduced a patch
(http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.35.y.git;a=3D=
commit;h=3De58aa3d2d0cc01ad8d6f7f640a0670433f794922)
(the diff: http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.35.=
y.git;a=3Dblobdiff;f=3Dkernel/irq/handle.c;h=3D27e5c69112235c2f0cebe18981bb=
1f5504ed6807;hp=3D76d5a671bfe1a3db5fd7bb0d2cb4f8b992a3c485;hb=3De58aa3d2d0c=
c01ad8d6f7f640a0670433f794922;hpb=3Dae731f8d0785ccd3380f511bae888933b6562e4=
5)
that disables all IRQs while handling interrupts. This is done by
removing the lines that re-enabled them. As a result, no other
interrupt can nest into the current interrupt. This makes all ARM
interrupt priorities (related to nesting) completely ineffective.
I can add at this point, that as far as I checked, mach-at91 is the
only ARM mach that uses the processor's interrupt priorities (others
like OMAP or IXP do not).

There is a discussion of this patch here:
http://kerneltrap.org/mailarchive/linux-kernel/2010/3/26/4551986/thread

I can think of some ways to deal with this problem:

Give up interrupt priorities as others do + remove the priority code
from arm/mach-at91/...
As Ingo Molnar suggests, re-enable interrupts inside the all the at91
IRQ handlers (drivers etc.), thus preserving the old behaviour. But
now we have to remember to do this for every new driver...
Use threaded-interrupts (handler run as thread) and make use of thread
priorities. Again - change all existing at91 drivers (also, setting
interrupt-thread priority is not supported yet).
Convince the commiters to re-enable the interrupts as before 2.6.35

What do you think?
Maybe you can forward this mail to others. I don't know who should be
addressed in this matter.

Thank's a lot,
Itai.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.43.1291742817.1530.linux-arm-kernel@lists.infradead.org>

The Manzano External Arch Spec says that bits 13:5 and 1:0 are read
unpredictable, not to mention the defined bits, so they must be masked. 
If they are non-zero, this would cause pxa3xx_resume_after_mmu to
"restore" the modified mapping to the wrong place.

Do you agree this is a problem?

I'm using the patch below as a fix for now, but it's hard to know what
registers are available.  Might be better to just mask it off the lower
bits in r1 again.

        @ Let us ensure we jump to resume_after_mmu only when the mcr above
        @ actually took effect.  They call it the "cpwait" operation.
-       mrc     p15, 0, r1, c2, c0, 0           @ queue a dependency on CP15
-       sub     pc, r2, r1, lsr #32             @ jump to virtual addr
+       mrc     p15, 0, r0, c2, c0, 0           @ queue a dependency on CP15
+       sub     pc, r2, r0, lsr #32             @ jump to virtual addr



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.61.1292350726.1530.linux-arm-kernel@lists.infradead.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

We could even go a step further and avoid any find_vma() call in
do_cache_op() (I actually tried this in the past but the optimisation
wasn't significant, at least for a small app with few VMAs and we may
need some other limitations). The reason I tried that was that some
app was trying to flush some memory range that ended up across two
VMAs (I don't recall the details).

> -#define flush_cache_user_range(vma,start,end) \
> +#define flush_cache_user_range(start,end) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuc_coherent_user_range((start) & PAGE_MASK=
, PAGE_ALIGN(end))

BTW (for a different patch), why do we still need the page alignment
here? I've heard JIT people complaining that performance is affected
when they only need to flush a small range and the kernel does a full
page. I recall something to do with COW in the past but we handle the
flushing in a different place already for this (at least starting with
ARMv6).

--=20
Catalin


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.63.1292504842.1530.linux-arm-kernel@lists.infradead.org>

I think an interesting exercise would be to allow platforms to only
have local timers without any global timer.  I'm not currently sure
what that would involve, or even if it's possible, but I think for
MSM's sake it's something that needs looking into to remove some of
the complexity from their code.

It also means that if we do have local timers configured, we don't need
to support a global timer (unless we need it for sleep wakeup.)


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.64.1292585468.1530.linux-arm-kernel@lists.infradead.org>

that accesses the RAM directly. It's not a physically separate device
indeed but from a direct memory access perspective it can be treated
as any other device.

In the DMA API we can fall back to the non-coherent ops when a NULL
struct device is passed. I assume in your code you already pass a NULL
device to dma_alloc_coherent().

-- 
Catalin


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.65.1292872195.1530.linux-arm-kernel@lists.infradead.org>

   clock_gettime( CLOCK_MONOTONIC, &now );

leads me to believe that kernel function ks8695_gettimeoffset() is not worth anything.


I suspect that there really is no "count down" read support on the KS8695 timer register.

The time delta (when it jumps) that I see from clock_gettime() corresponds to the 2 msec system
interrupt HZ tick that I compiled into the kernel.


I think this is a hardware limitation, but wanted another opinion, kernel code for said function has
not changed in years, shown below.


Thank you,

Dick


/*
 * Returns number of ms since last clock interrupt.  Note that interrupts
 * will have been disabled by do_gettimeoffset()
 */
static unsigned long ks8695_gettimeoffset (void)
{
    unsigned long elapsed, tick2, intpending;

    /*
     * Get the current number of ticks.  Note that there is a race
     * condition between us reading the timer and checking for an
     * interrupt.  We solve this by ensuring that the counter has not
     * reloaded between our two reads.
     */
    elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
    do {
        tick2 = elapsed;
        intpending = __raw_readl(KS8695_IRQ_VA + KS8695_INTST) & (1 << KS8695_IRQ_TIMER1);
        elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
    } while (elapsed > tick2);

    /* Convert to number of ticks expired (not remaining) */
    elapsed = (CLOCK_TICK_RATE / HZ) - elapsed;

    /* Is interrupt pending?  If so, then timer has been reloaded already. */
    if (intpending)
        elapsed += (CLOCK_TICK_RATE / HZ);

    /* Convert ticks to usecs */
    return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
}



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.66.1292873528.1530.linux-arm-kernel@lists.infradead.org>

   clock_gettime( CLOCK_MONOTONIC, &now );

leads me to believe that kernel function ks8695_gettimeoffset() is not worth anything.


I suspect that there really is no "count down" read support on the KS8695 timer register.

The time delta (when it jumps) that I see from clock_gettime() corresponds to the 2 msec system
interrupt HZ tick that I compiled into the kernel.


I think this is a hardware limitation, but wanted another opinion, kernel code for said function has
not changed in years, shown below.


Thank you,

Dick


/*
 * Returns number of ms since last clock interrupt.  Note that interrupts
 * will have been disabled by do_gettimeoffset()
 */
static unsigned long ks8695_gettimeoffset (void)
{
    unsigned long elapsed, tick2, intpending;

    /*
     * Get the current number of ticks.  Note that there is a race
     * condition between us reading the timer and checking for an
     * interrupt.  We solve this by ensuring that the counter has not
     * reloaded between our two reads.
     */
    elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
    do {
        tick2 = elapsed;
        intpending = __raw_readl(KS8695_IRQ_VA + KS8695_INTST) & (1 << KS8695_IRQ_TIMER1);
        elapsed = __raw_readl(KS8695_TMR_VA + KS8695_T1TC) + __raw_readl(KS8695_TMR_VA + KS8695_T1PD);
    } while (elapsed > tick2);

    /* Convert to number of ticks expired (not remaining) */
    elapsed = (CLOCK_TICK_RATE / HZ) - elapsed;

    /* Is interrupt pending?  If so, then timer has been reloaded already. */
    if (intpending)
        elapsed += (CLOCK_TICK_RATE / HZ);

    /* Convert ticks to usecs */
    return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
}



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.67.1292929198.1530.linux-arm-kernel@lists.infradead.org>

physical address and (sometimes) CPU virtual address that an IOMMU
mapping is created for.  If they did add support for their IOMMUs to
the DMA API, the DMA API will be buried beneath their IOMMU layer.

The OMAP devices with IOMMUs are hardly generic drivers in any case -
they tend to be there for their on-board DSP stuff.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.97.1293190159.1530.linux-arm-kernel@lists.infradead.org>

added entries for ID 2000 to their mach-types file, which have long
since been taken by other people.

(Why people do this is beyond me - the allocation of them is soo trivial
it's untrue, and actually it doesn't require accurate information.  As
one company once did, they allocated an ID using an uninteresting and
ficticious name in the database, and when they were ready for release,
they requested it be changed to their product.)

Anyway, the answer is that if there isn't a way to configure it in the
boot loader, then the above is the only way around it.  (uboot has been
modified to allow the ID to be changed via its command line.)


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.100.1293776186.1530.linux-arm-kernel@lists.infradead.org>

appropriate prefix here.

Otherwise this patch looks okay.

g.


> +{
> +	struct ti_ssp_gpio_chip *gpio = to_ssp_gpio_chip(chip);
> +	int error;
> +
> +	spin_lock(&gpio->lock);
> +
> +	gpio->iosel &= ~SSP_PIN_MASK(gpio_num);
> +	gpio->iosel |=  SSP_PIN_SEL(gpio_num, SSP_OUT);
> +
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +
> +	if (error < 0)
> +		goto error;
> +
> +	if (val)
> +		gpio->out |= BIT(gpio_num);
> +	else
> +		gpio->out &= ~BIT(gpio_num);
> +
> +	error = ti_ssp_raw_write(gpio->dev, gpio->out);
> +
> +error:
> +	spin_unlock(&gpio->lock);
> +	return error;
> +}
> +
> +static int value_get(struct gpio_chip *chip, unsigned gpio_num)
> +{
> +	struct ti_ssp_gpio_chip *gpio = to_ssp_gpio_chip(chip);
> +	int ret;
> +
> +	spin_lock(&gpio->lock);
> +
> +	ret = ti_ssp_raw_read(gpio->dev);
> +	if (ret >= 0)
> +		ret = !!(ret & BIT(gpio_num));
> +
> +	spin_unlock(&gpio->lock);
> +	return ret;
> +}
> +
> +static void value_set(struct gpio_chip *chip, unsigned gpio_num, int val)
> +{
> +	struct ti_ssp_gpio_chip *gpio = to_ssp_gpio_chip(chip);
> +
> +	spin_lock(&gpio->lock);
> +
> +	if (val)
> +		gpio->out |= BIT(gpio_num);
> +	else
> +		gpio->out &= ~BIT(gpio_num);
> +
> +	ti_ssp_raw_write(gpio->dev, gpio->out);
> +
> +	spin_unlock(&gpio->lock);
> +}
> +
> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
> +{
> +	const struct ti_ssp_gpio_data *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct ti_ssp_gpio_chip *gpio;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(dev, "platform data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
> +	if (!gpio) {
> +		dev_err(dev, "cannot allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	gpio->dev = dev;
> +	gpio->iosel = SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN) |
> +		      SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_SEL(3, SSP_IN);
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +	if (error < 0) {
> +		dev_err(dev, "gpio io setup failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	spin_lock_init(&gpio->lock);
> +	platform_set_drvdata(pdev, gpio);
> +
> +	gpio->chip.base  = pdata->start;
> +	gpio->chip.ngpio = 4;
> +	gpio->chip.dev   = &pdev->dev;
> +	gpio->chip.label = "ti_ssp_gpio";
> +	gpio->chip.owner = THIS_MODULE;
> +	gpio->chip.get   = value_get;
> +	gpio->chip.set   = value_set;
> +	gpio->chip.direction_input  = direction_in;
> +	gpio->chip.direction_output = direction_out;
> +
> +	error = gpiochip_add(&gpio->chip);
> +	if (error < 0) {
> +		dev_err(dev, "gpio chip registration failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	dev_info(dev, "ssp gpio interface registered\n");
> +	return 0;
> +
> +error:
> +	kfree(gpio);
> +	return error;
> +}
> +
> +static int __devexit ti_ssp_gpio_remove(struct platform_device *pdev)
> +{
> +	struct ti_ssp_gpio_chip *gpio = platform_get_drvdata(pdev);
> +	int error;
> +
> +	error = gpiochip_remove(&gpio->chip);
> +	if (error < 0)
> +		return error;
> +	kfree(gpio);
> +	return 0;
> +}
> +
> +static struct platform_driver ti_ssp_gpio_driver = {
> +	.probe		= ti_ssp_gpio_probe,
> +	.remove		= __devexit_p(ti_ssp_gpio_remove),
> +	.driver		= {
> +		.name	= "ti-ssp-gpio",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init ti_ssp_gpio_init(void)
> +{
> +	return platform_driver_register(&ti_ssp_gpio_driver);
> +}
> +module_init(ti_ssp_gpio_init);
> +
> +static void __exit ti_ssp_gpio_exit(void)
> +{
> +	platform_driver_unregister(&ti_ssp_gpio_driver);
> +}
> +module_exit(ti_ssp_gpio_exit);
> +
> +MODULE_DESCRIPTION("GPIO interface for TI-SSP");
> +MODULE_AUTHOR("Cyril Chemparathy <cyril@ti.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ti-ssp-gpio");
> diff --git a/include/linux/mfd/ti_ssp.h b/include/linux/mfd/ti_ssp.h
> index dbb4b43..10c65bb 100644
> --- a/include/linux/mfd/ti_ssp.h
> +++ b/include/linux/mfd/ti_ssp.h
> @@ -38,6 +38,10 @@ struct ti_ssp_spi_data {
>  	void		(*select)(int cs);
>  };
>  
> +struct ti_ssp_gpio_data {
> +	int		start;
> +};
> +
>  /*
>   * Sequencer port IO pin configuration bits.  These do not correlate 1-1 with
>   * the hardware.  The iosel field in the port data combines iosel1 and iosel2,
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.102.1294012788.1530.linux-arm-kernel@lists.infradead.org>

Auto-merging arch/arm/Kconfig
Removing arch/arm/mach-ux500/devices-db5500.c
Removing drivers/gpio/tc35892-gpio.c
Auto-merging drivers/input/keyboard/Kconfig
Auto-merging drivers/input/keyboard/Makefile
Removing drivers/mfd/tc35892.c
Auto-merging drivers/net/caif/caif_shm_u5500.c
Removing include/linux/mfd/tc35892.h
Merge made by recursive.
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-ux500/Makefile                       |   14 +-
 arch/arm/mach-ux500/board-mop500-keypads.c         |  229 ++++++++++
 arch/arm/mach-ux500/board-mop500-sdi.c             |   79 +++-
 arch/arm/mach-ux500/board-mop500.c                 |  228 +++-------
 arch/arm/mach-ux500/board-mop500.h                 |    9 +
 arch/arm/mach-ux500/board-u5500-sdi.c              |   49 ++
 arch/arm/mach-ux500/board-u5500.c                  |   19 +-
 arch/arm/mach-ux500/clock.c                        |  365 +++++++++++-----
 arch/arm/mach-ux500/clock.h                        |    4 +
 arch/arm/mach-ux500/cpu-db5500.c                   |   38 ++-
 arch/arm/mach-ux500/cpu-db8500.c                   |   58 ++-
 arch/arm/mach-ux500/cpu.c                          |   13 +-
 arch/arm/mach-ux500/cpufreq.c                      |  211 +++++++++
 arch/arm/mach-ux500/devices-common.c               |  145 ++++++
 arch/arm/mach-ux500/devices-common.h               |   82 ++++
 arch/arm/mach-ux500/devices-db5500.c               |   46 --
 arch/arm/mach-ux500/devices-db5500.h               |   66 +++
 arch/arm/mach-ux500/devices-db8500.c               |  169 +-------
 arch/arm/mach-ux500/devices-db8500.h               |   98 ++++
 arch/arm/mach-ux500/devices.c                      |   63 ---
 arch/arm/mach-ux500/dma-db5500.c                   |  120 +++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h     |    4 +
 arch/arm/mach-ux500/include/mach/db8500-regs.h     |    3 +-
 arch/arm/mach-ux500/include/mach/devices.h         |   17 -
 arch/arm/mach-ux500/include/mach/gpio.h            |   38 --
 arch/arm/mach-ux500/include/mach/hardware.h        |    2 +
 .../mach-ux500/include/mach/irqs-board-mop500.h    |   28 ++-
 arch/arm/mach-ux500/include/mach/irqs.h            |   44 --
 .../include/mach/{mbox.h => mbox-db5500.h}         |    0
 arch/arm/mach-ux500/include/mach/prcmu-defs.h      |   30 ++
 arch/arm/mach-ux500/include/mach/prcmu-regs.h      |   15 +-
 arch/arm/mach-ux500/include/mach/prcmu.h           |   15 +-
 arch/arm/mach-ux500/include/mach/setup.h           |    7 +-
 arch/arm/mach-ux500/include/mach/uncompress.h      |   23 +-
 arch/arm/mach-ux500/{mbox.c => mbox-db5500.c}      |    2 +-
 .../mach-ux500/{modem_irq.c => modem-irq-db5500.c} |    0
 arch/arm/mach-ux500/platsmp.c                      |    2 +-
 arch/arm/mach-ux500/prcmu.c                        |  179 +++++++-
 arch/arm/plat-nomadik/gpio.c                       |   52 ++-
 arch/arm/plat-nomadik/include/plat/pincfg.h        |   70 +++-
 drivers/gpio/Kconfig                               |    8 +-
 drivers/gpio/Makefile                              |    2 +-
 drivers/gpio/tc35892-gpio.c                        |  389 ----------------
 drivers/gpio/tc3589x-gpio.c                        |  389 ++++++++++++++++
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tc3589x-keypad.c            |  472 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |    6 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/tc35892.c                              |  345 --------------
 drivers/mfd/tc3589x.c                              |  422 +++++++++++++++++
 drivers/net/caif/caif_shm_u5500.c                  |    2 +-
 include/linux/mfd/tc35892.h                        |  136 ------
 include/linux/mfd/tc3589x.h                        |  195 ++++++++
 55 files changed, 3387 insertions(+), 1629 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-keypads.c
 create mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c
 create mode 100644 arch/arm/mach-ux500/cpufreq.c
 create mode 100644 arch/arm/mach-ux500/devices-common.c
 create mode 100644 arch/arm/mach-ux500/devices-common.h
 delete mode 100644 arch/arm/mach-ux500/devices-db5500.c
 create mode 100644 arch/arm/mach-ux500/devices-db5500.h
 create mode 100644 arch/arm/mach-ux500/devices-db8500.h
 create mode 100644 arch/arm/mach-ux500/dma-db5500.c
 rename arch/arm/mach-ux500/include/mach/{mbox.h => mbox-db5500.h} (100%)
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-defs.h
 rename arch/arm/mach-ux500/{mbox.c => mbox-db5500.c} (99%)
 rename arch/arm/mach-ux500/{modem_irq.c => modem-irq-db5500.c} (100%)
 delete mode 100644 drivers/gpio/tc35892-gpio.c
 create mode 100644 drivers/gpio/tc3589x-gpio.c
 create mode 100644 drivers/input/keyboard/tc3589x-keypad.c
 delete mode 100644 drivers/mfd/tc35892.c
 create mode 100644 drivers/mfd/tc3589x.c
 delete mode 100644 include/linux/mfd/tc35892.h
 create mode 100644 include/linux/mfd/tc3589x.h



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.106.1294272045.1530.linux-arm-kernel@lists.infradead.org>

from the efficient implementation perspective it does matter.

Take for example the read-ahead done on block devices.  We don't want to
flush all those pages that were read in when we don't know that they're
ever going to end up in a user mapping.  So what's commonly done (as
suggested by DaveM) is that flush_dcache_page() detects that it's a
dcache page, ensures that there's no user mappings, and sets a 'dirty'
flag.  This flag is guaranteed to be clear when new, clean, unread
pages enter the page cache.

When the page eventually ends up in a user mapping, that dirty flag is
checked and the necessary cache flushing done at that point.

Note that when there are user mappings, flush_dcache_page() has to flush
those mappings too, otherwise mmap() <-> read()/write() coherency breaks.
I believe this was what flush_dcache_page() was created to resolve.

flush_kernel_dcache_page() was to solve the problem of PIO drivers
writing to dcache pages, so that data written into the kernel mapping
would be visible to subsequent user mappings.

We chose a different overall approach - which had already been adopted by
PPC - where we invert the meaning of this 'dirty' bit to mean that it's
clean.  So every new page cache page starts out life as being marked
dirty and so nothing needs to be done at flush_kernel_dcache_page().
We continue to use davem's optimization but with the changed meaning of
the bit, but as we now support SMP we do the flushing at set_pte_at()
time.

This also means that we don't have to rely on the (endlessly) buggy PIO
drivers remembering to add flush_kernel_dcache_page() calls - something
which has been a source of constant never-ending pain for us.

The final piece of the jigsaw is flush_anon_page() which deals with
kernel<->user coherency for anonymous pages by flushing both the user
and kernel sides of the mapping.  This was to solve direct-io coherency
problems.

As the users of flush_anon_page() always do:

	flush_anon_page(vma, page, addr);
	flush_dcache_page(page);

and documentation doesn't appear to imply that this will always be the
case, we restrict flush_dcache_page() to only work on page cache pages,
otherwise we end up flushing the kernel-side mapping multiple time in
succession.

Maybe we should make flush_anon_page() only flush the user mapping,
stipulate that it shall always be followed by flush_dcache_page(),
which shall flush the kernel side mapping even for anonymous pages?
That sounds to me like a recipe for missing flush_dcache_page() calls
causing bugs.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.107.1294295380.1530.linux-arm-kernel@lists.infradead.org>

be marked as an irq, at the bank level. But its corresponding pad will
have its wakeup bit disabled. Would that work? I think yes, in most cases.

Now let's take the WFI instruction as a divisor for 2 situations:

A - common / working case: an interrupt on that gpio still happens after the WFI instruction.
Since the system is in sleep mode and the pad for that gpio is not wakeup
capable, then nothing would happen and the system won't wakeup. Then, I think
everyone is happy here.

B - corner case: an interrupt on that gpio happens before the WFI instruction.
Since the system is active, the gpio bank can still report this interrupt
and will do it. The suspend won't happen due to a irq which has been
explicitly marked as disabled and wakeup incapable.

Then, would that be the expected behavior? Assuming that the driver
has explicitly said to the system, you should not bother about this at all.

> 
> Kevin
> 

-- 
Eduardo Valentin


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.112.1294657272.1530.linux-arm-kernel@lists.infradead.org>

lock to use in the clock - mutex or spinlock.

I don't see that having some clocks be one and others another is really
acceptable - think about the resulting mess if you end up with some
parent mux'd clocks which are a mutex and others which are a spinlock.
Can a driver use an atomic call for that?  Sometimes depending on the
mux, sometimes depending on whether a parent clock is already enabled.

What if your clock was enabled while the mux selected another spinlock-
locked clk, but then you switched to a different operating point and the
mux then selected the mutex-locked clock.

We could say that this is illegal - but then we need to have the code
explicitly check this otherwise such situations will be created.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.114.1294749761.1530.linux-arm-kernel@lists.infradead.org>

flags structure for disabling MS interrupts.

Driver Tweak patch (not accepted):
https://patchwork.kernel.org/patch/450771/


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.115.1294749761.1530.linux-arm-kernel@lists.infradead.org>

the problem back in the platform code (this patch).

All three proposed patches work for me.  I'd gladly submit a fourth if
suggested -- this problem pretty much kills a couple of platform
configurations we are working on...

> Thanks,
> Prakash
> 






>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.123.1295362998.1530.linux-arm-kernel@lists.infradead.org>

"this CPU has K extensions" as it appears possible from the ARM ARM to
have a CPU which is ARMv6K (eg, the CPU in Dove) which does not support
SMP.  Whether that identifies itself as ARMv6 in the architecture field
of the main ID register, or uses the new CPUID scheme is not clear.
If it identifies itself as ARMv6, then there's no CPUID registers to
detect what it supports.

If it's the new CPUID scheme, while we can tell that a CPU has CLREX
support, that doesn't necessary mean that it has the access fault stuff.
That just means that a greater range of exclusive operations are
supported.

Also:

| An implementation that provides hardware management of the access flag:
| ??? does not generate Access Flag faults when the access flag is enabled
| ...

So, if we don't enable the access flag support, then we shouldn't see
them (we don't enable them.)

What's more:

| Memory Model Feature Register 2 (ID_MMFR2)
| HW access flag, bits [31:28]
| Indicates support for a Hardware access flag, as part of the VMSAv7 implementation.
| Permitted values are:
| 0b0000 Not supported.
| 0b0001 Support for VMSAv7 access flag, updated in hardware.

That doesn't suggest that it's valid to assume that this will be '1' on
ARMv6K - and istr there's some subtle differences between the various
CPUID registers for different architectures as well - to make the CPUID
scheme just that little more complicated to use, so these bits may not
even be defined that way for ARMv6K.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.125.1295528596.1530.linux-arm-kernel@lists.infradead.org>

in arch/arm/mach-msm/dma.c, so there should be no problem with ARMv6 CPUs.

So, can we get a more detailed explaination as to the exact problem being
seen?


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.126.1295904167.1530.linux-arm-kernel@lists.infradead.org>

For SREQ:
	For receive: Asserted if data counter is
	zero and receive FIFO contains more than
	one and fewer than eight words.
	For transmit: Asserted if fewer than eight
	and more than one word remain for
	transfer to FIFO.

For BREQ:
	For receive: Asserted if FIFO contains
	eight words and data counter is not zero,
	or if FIFO contains more than eight words.
	For transmit: Asserted if more than eight
	words remain for transfer to FIFO.

For LSREQ:
	For receive: Asserted if data counter is
	zero and FIFO contains only one word.
	For transmit: Asserted if only one word
	remains for transfer to FIFO.

For LBREQ:
	For receive: Asserted if data counter is
	zero and FIFO contains eight words.
	For transmit: Asserted if only eight words
	remain for transfer to FIFO.

So, for small transfers (less than half the FIFO depth), SREQ will be
asserted to transfer a single word at a time, and LSREQ for the last
word.  There shouldn't be any bursts from the DMA controller.

The second argument is that if you have a burst size of, say, 8 words
and you program the DMA to transfer 4 words, it should _not_ transfer
8 words to the peripheral.

> What it does is to emulate single requests below a certain
> threshold by requesting one-word bursts. I think this is
> primarily for SDIO, not card transfers.

This should be handled in hardware, if not it's DMA controller specific
as it shouldn't burst past the remainder of the transfer.  If your DMA
controller does burst past the number of bytes in the transfer, surely
that's something that your DMA controller code needs to work around?

> > + ? ? ? /* Check for weird stuff in the sg list */
> > + ? ? ? /* shouldn't this be in the DMA engine driver? */
> > + ? ? ? for_each_sg(data->sg, sg, data->sg_len, i) {
> > + ? ? ? ? ? ? ? dev_vdbg(mmc_dev(host->mmc), "MMCI SGlist %d dir %d: length: %08
> > + ? ? ? ? ? ? ? ? ? ? ? ?i, conf.direction, sg->length);
> > + ? ? ? ? ? ? ? if (sg->offset & 3 || sg->length & 3)
> > + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> > + ? ? ? }
> 
> This one is just overcautious and for SDIO we don't even want to do
> such things, so it should be dropped altogether.
> 
> The original intent was to avoid writing anything than 32bit words
> into the register, and with the SDIO-modified versions you can
> actually do that.

Surely that's to do with the DMA controller though?

> So I'll drop it for the next iteration.

Given that I've already heavily modified the code, it's probably better if
you just let me know the answer... ;)


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.127.1295905947.1530.linux-arm-kernel@lists.infradead.org>

it seemed to be using ioremap() - which with its initialization moved
before memory allocators were up and running causes an oops.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.128.1295953973.1530.linux-arm-kernel@lists.infradead.org>

a "detailed" error instead of just returning NULL.

just my 2 cents,
re,
 wh


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.129.1295957832.1530.linux-arm-kernel@lists.infradead.org>

until the CPU enters WFI mode - which means that provided we can
guarantee no one issues a WFI instruction between setting the power mode,
and executing that instruction, being woken up (or failing) and resetting
the power mode back... that shouldn't require the power mode to be
programmed from assembly code.

In any case, we actually need the help of spinlocks to deal with
concurrent access to the SCU power control register - something you
can't do in assembly code.

On the way down to a WFI low power mode, we can call scu_power_mode(),
do the rest of the cleanup (which must not schedule) and issue WFI.  On
the way back up, do whatever needs to be done and call scu_power_mode()
to reset back to 'normal' mode.

> Also note that this register can be blocked using trust-zone which
> again makes it platform dependent because direct write won't be
> allowed in that case.

Yes, I did notice.  What's the OMAP SMC interface for that?

> I would prefer the header export if there is no major
> objection since there is already a possibility of custom
> implementation with trust zone.
> 
> On OMAP4, on ES1.0 we need to use a secure API to achieve
> this where as on ES2.0, it can be directly accessed.

As I say, I'd rather not have each SoC implementing access to this as
someone's bound to forget the spinlock if they're dealing with more than
one CPU, which'll make stuff unreliable (just like I did on my initial
version.)

We could have a callback to SoC code which does the appropriate SMC call,
but first I'll need to know what's required for the SMC call.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.134.1296667312.1530.linux-arm-kernel@lists.infradead.org>

Pin Name   #  Pin Description
--------  --  ----------------------------------------------------------
AD0/nCS   13  Address Bit 0 (I2S)/Control Port Chip Select (SPI) (Input)
              - AD0 is a chip address pin in I2C mode; nCS is the chip
              signal select for SPI format.

The other pin in question:

Pin Name   #  Pin Description
--------  --  ----------------------------------------------------------
nRST      14  Reset (Input) - The device enters a low power mode when
              this pin is driven low.

Regards,
Hartley=


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.135.1296720960.1530.linux-arm-kernel@lists.infradead.org>

For SREQ:<br>
 =A0 =A0 =A0 =A0For receive: Asserted if data counter is<br>
 =A0 =A0 =A0 =A0zero and receive FIFO contains more than<br>
 =A0 =A0 =A0 =A0one and fewer than eight words.<br>
 =A0 =A0 =A0 =A0For transmit: Asserted if fewer than eight<br>
 =A0 =A0 =A0 =A0and more than one word remain for<br>
 =A0 =A0 =A0 =A0transfer to FIFO.<br>
<br>
For BREQ:<br>
 =A0 =A0 =A0 =A0For receive: Asserted if FIFO contains<br>
 =A0 =A0 =A0 =A0eight words and data counter is not zero,<br>
 =A0 =A0 =A0 =A0or if FIFO contains more than eight words.<br>
 =A0 =A0 =A0 =A0For transmit: Asserted if more than eight<br>
 =A0 =A0 =A0 =A0words remain for transfer to FIFO.<br>
<br>
For LSREQ:<br>
 =A0 =A0 =A0 =A0For receive: Asserted if data counter is<br>
 =A0 =A0 =A0 =A0zero and FIFO contains only one word.<br>
 =A0 =A0 =A0 =A0For transmit: Asserted if only one word<br>
 =A0 =A0 =A0 =A0remains for transfer to FIFO.<br>
<br>
For LBREQ:<br>
 =A0 =A0 =A0 =A0For receive: Asserted if data counter is<br>
 =A0 =A0 =A0 =A0zero and FIFO contains eight words.<br>
 =A0 =A0 =A0 =A0For transmit: Asserted if only eight words<br>
 =A0 =A0 =A0 =A0remain for transfer to FIFO.<br>
<br>
So, for small transfers (less than half the FIFO depth), SREQ will be<br>
asserted to transfer a single word at a time, and LSREQ for the last<br>
word. =A0There shouldn&#39;t be any bursts from the DMA controller.<br>
<br>
The second argument is that if you have a burst size of, say, 8 words<br>
and you program the DMA to transfer 4 words, it should _not_ transfer<br>
8 words to the peripheral.<br>
<br>
&gt; What it does is to emulate single requests below a certain<br>
&gt; threshold by requesting one-word bursts. I think this is<br>
&gt; primarily for SDIO, not card transfers.<br>
<br>
This should be handled in hardware, if not it&#39;s DMA controller specific=
<br>
as it shouldn&#39;t burst past the remainder of the transfer. =A0If your DM=
A<br>
controller does burst past the number of bytes in the transfer, surely<br>
that&#39;s something that your DMA controller code needs to work around?<br=
></blockquote><div><br>Yes that indeed seems resonable. With the COH901318 =
DMA engine<br>it worked just fine without the burst threshold. Just want to=
 give my<br>
colleagues a chance to have a second opinion on this.<br>=A0<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
&gt; &gt; + =A0 =A0 =A0 /* Check for weird stuff in the sg list */<br>
&gt; &gt; + =A0 =A0 =A0 /* shouldn&#39;t this be in the DMA engine driver? =
*/<br>
&gt; &gt; + =A0 =A0 =A0 for_each_sg(data-&gt;sg, sg, data-&gt;sg_len, i) {<=
br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_vdbg(mmc_dev(host-&gt;mmc), &qu=
ot;MMCI SGlist %d dir %d: length: %08<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i, conf.directio=
n, sg-&gt;length);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sg-&gt;offset &amp; 3 || sg-&gt=
;length &amp; 3)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; &gt; + =A0 =A0 =A0 }<br>
&gt;<br>
&gt; This one is just overcautious and for SDIO we don&#39;t even want to d=
o<br>
&gt; such things, so it should be dropped altogether.<br>
&gt;<br>
&gt; The original intent was to avoid writing anything than 32bit words<br>
&gt; into the register, and with the SDIO-modified versions you can<br>
&gt; actually do that.<br>
<br>
Surely that&#39;s to do with the DMA controller though?<br></blockquote><di=
v><br>Absolutely.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding=
-left: 1ex;">

&gt; So I&#39;ll drop it for the next iteration.<br>
<br>
Given that I&#39;ve already heavily modified the code, it&#39;s probably be=
tter if<br>
you just let me know the answer... ;)<br>
</blockquote></div><br>In any case I&#39;m happy if you post/commit the MMC=
I support<br>you have, if there are problems we can certainly sort it out l=
ater<br>in any case.<br><br>Hm, does this mean you got it working with one =
of the<br>
reference boards eventually?<br><br>Yours,<br>Linus Walleij<br>

--0016e649c71adca677049aa790e5--


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.139.1297175725.1530.linux-arm-kernel@lists.infradead.org>

> +#define TTC0_BASE              (PERIPH_BASE + 0x1000)

So, PERIPH_BASE is also an iomem cookie, not a physical address, so it
too should be void __iomem *.

Hence:

> +#define PERIPH_BASE            0xF8000000

should be:

#define PERIPH_BASE            IOMEM(0xF8000000)

But then in a different patch you do:
+               .virtual        = TTC0_BASE,
+               .pfn            = __phys_to_pfn(TTC0_BASE),

So it's also used as a physical address.  Yuck.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.140.1297343456.1530.linux-arm-kernel@lists.infradead.org>

configuration bahaves. It looks like a uart tx loopback in the iomuxer.
Is this correct?

Sascha

On Wed, Feb 09, 2011 at 10:54:01AM +0100, julien.boibessot at free.fr wrote:
> From: Julien Boibessot <julien.boibessot@armadeus.com>
>
> 
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index b6767f9..df531aa 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -473,7 +473,7 @@
>  #define _MX51_PAD_UART2_RXD__UART2_RXD		IOMUX_PAD(0x628, 0x238, 0, 0x09ec, 2, 0)
>  #define _MX51_PAD_UART2_TXD__FIRI_RXD		IOMUX_PAD(0x62c, 0x23c, 1, 0x0000, 0, 0)
>  #define _MX51_PAD_UART2_TXD__GPIO1_21		IOMUX_PAD(0x62c, 0x23c, 3, 0x0000, 0, 0)
> -#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x09ec, 3, 0)
> +#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__CSI1_D0		IOMUX_PAD(0x630, 0x240, 2, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__GPIO1_22		IOMUX_PAD(0x630, 0x240, 3, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__UART1_DTR		IOMUX_PAD(0x630, 0x240, 0, 0x0000, 0, 0)
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.147.1297934872.1530.linux-arm-kernel@lists.infradead.org>

Beagle or Panda boards

http://www.beagleboard.org/
http://www.pandaboard.org/

But there are also many other variants, including boards made by
third-party companies such as IGEPv2

Are you targeting a specifc platform?


There's a config file here, which should build a kernel which works on
the Beagle or Panda board:
http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config

Note that you may hit a section discard problem when the final link is
done to create vmlinux.  The top patch from this branch should work
around it, but hopefully it should be fixed upstream soon:

git://git.linaro.org/people/dmart/linux-2.6-arm.git
arm/smpup-section-discard-fix

Cheers
---Dave

>
> TIA,
> cheers,
> Vadim
>
>
>
>>>
>>> If you're trying to support a specific board I'm unlikely to be able
>>> to debug it for you, but feel free to ping me with questions.
>>>
>>> Cheers
>>> ---Dave
>>>
>>
>


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.150.1298305604.1530.linux-arm-kernel@lists.infradead.org>

find what is the interrupt line of CortexA9 performance monitor
in omap4. Seems without this information, we can't use perf on
omap4.

Any suggestions or ideas about it?

-- 
Lei Ming


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.151.1298305836.1530.linux-arm-kernel@lists.infradead.org>

Hungarian notation) is brain damaged"

Also, all your exported routines severely lack any sort of locking. An IO
mutex or spinlock is mandatory here. 

> +static int pruss_mfd_add_devices(struct platform_device *pdev)
> +{
> +	struct da8xx_pruss_devices *dev_data = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct mfd_cell cell;
> +	u32 err, count;
> +
> +	for (count = 0; (dev_data + count)->dev_name != NULL; count++) {
> +		memset(&cell, 0, sizeof(struct mfd_cell));
> +		cell.id			= count;
> +		cell.name		= (dev_data + count)->dev_name;
> +		cell.platform_data	= (dev_data + count)->pdata;
> +		cell.data_size		= (dev_data + count)->pdata_size;
> +
> +		err = mfd_add_devices(dev, 0, &cell, 1, NULL, 0);
> +		if (err) {
> +			dev_err(dev, "cannot add mfd cells\n");
> +			return err;
> +		}
> +	}
> +	return err;
> +}
So, what are the potential subdevices for this driver ? If it's a really
dynamic setup, I'm fine with passing those as platform data but then do it so
that you pass a NULL terminated da8xx_pruss_devices array. That will avoid
most of the ugly casts you're doing here.

> diff --git a/include/linux/mfd/pruss/da8xx_pru.h b/include/linux/mfd/pruss/da8xx_pru.h
> new file mode 100644
> index 0000000..68d8421
> --- /dev/null
> +++ b/include/linux/mfd/pruss/da8xx_pru.h
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (C) 2010 Texas Instruments Incorporated
> + * Author: Jitendra Kumar <jitendra@mistralsolutions.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#ifndef _PRUSS_H_
> +#define _PRUSS_H_
> +
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include "da8xx_prucore.h"
> +
> +#define PRUSS_NUM0			DA8XX_PRUCORE_0
> +#define PRUSS_NUM1			DA8XX_PRUCORE_1
Those are unused.

> diff --git a/include/linux/mfd/pruss/da8xx_prucore.h b/include/linux/mfd/pruss/da8xx_prucore.h
> new file mode 100644
> index 0000000..81f2ff9
> --- /dev/null
> +++ b/include/linux/mfd/pruss/da8xx_prucore.h
Please rename your mfd include directory to include/linux/mfd/da8xx/, so that
one can match it with the drivers/mfd/da8xx driver code.


> +typedef struct {
> +	u32 CONTROL;
> +	u32 STATUS;
> +	u32 WAKEUP;
> +	u32 CYCLECNT;
> +	u32 STALLCNT;
> +	u8  RSVD0[12];
> +	u32 CONTABBLKIDX0;
> +	u32 CONTABBLKIDX1;
> +	u32 CONTABPROPTR0;
> +	u32 CONTABPROPTR1;
> +	u8  RSVD1[976];
> +	u32 INTGPR[32];
> +	u32 INTCTER[32];
> +} *da8xx_prusscore_regs;
Again, we don't need that structure.

Cheers,
Samuel.


-- 
Intel Open Source Technology Centre
http://oss.intel.com/


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.155.1298638975.1530.linux-arm-kernel@lists.infradead.org>

OMAP-L1x8/C674m/AM18xx devices (where m is an even number)."

http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem

Thanks,
Hans



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.156.1298722292.1530.linux-arm-kernel@lists.infradead.org>

--------------------------------------------------
From: "Nori, Sekhar" <nsekhar@ti.com>
Sent: Thursday, February 24, 2011 4:57 PM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>; 
<davinci-linux-open-source@linux.davincidsp.com>
Cc: <linux-arm-kernel@lists.infradead.org>; "Watkins, Melissa" 
<m-watkins@ti.com>; <sachi@mistralsolutions.com>; "Kevin Hilman" 
<khilman@deeprootsystems.com>; "Russell King" <linux@arm.linux.org.uk>; 
"Michael Williamson" <michael.williamson@criticallink.com>; "Chemparathy, 
Cyril" <cyril@ti.com>; "Sergei Shtylyov" <sshtylyov@ru.mvista.com>; "open 
list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] davinci: changed SRAM allocator to shared ram.

> Hi Subhasish,
>
> On Thu, Feb 24, 2011 at 15:54:56, Subhasish Ghosh wrote:
>> --------------------------------------------------
>> From: "Nori, Sekhar" <nsekhar@ti.com>
>> Sent: Wednesday, February 23, 2011 9:00 PM
>> To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>;
>> <davinci-linux-open-source@linux.davincidsp.com>
>> Cc: <linux-arm-kernel@lists.infradead.org>; "Watkins, Melissa"
>> <m-watkins@ti.com>; <sachi@mistralsolutions.com>; "Kevin Hilman"
>> <khilman@deeprootsystems.com>; "Russell King" <linux@arm.linux.org.uk>;
>> "Michael Williamson" <michael.williamson@criticallink.com>; "Chemparathy,
>> Cyril" <cyril@ti.com>; "Sergei Shtylyov" <sshtylyov@ru.mvista.com>; "open
>> list" <linux-kernel@vger.kernel.org>
>> Subject: RE: [PATCH 1/1] davinci: changed SRAM allocator to shared ram.
>>
>> > Hi Subhasish,
>> >
>> > On Fri, Feb 11, 2011 at 19:51:28, Subhasish Ghosh wrote:
>> >> This patch modifies the sram allocator to allocate memory
>> >> from the DA8XX shared RAM.
>> >
>> > It will be nice to know if you tried suspend-to-RAM
>> > after this change and found it to be working.
>> >
>>
>> SG -- My file system is currently mounted from MMC.
>>           Suspend to RAM seems to have bug with MMC.
>> 
>> (http://processors.wiki.ti.com/index.php/OMAP-L1_Linux_Drivers_Usage#Suspend-to-RAM)
>
> You can try Kevin's suggestion here:
>
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-January/021807.html
>
>>           I had tried NFS earlier, but I think there is some problem with
>> NFS boot and udev with this kernel.
>
> Anyway there are some problems reported with Ethernet
> driver and suspend on the latest kernel. Folks inside
> TI are working on it.
>
>>            So, currently I will not be able to do it, but will try if I 
>> get
>> a chance.
>
> How about using ramdisk?
>
> Thanks,
> Sekhar
>
>> > Thanks,
>> > Sekhar
>> >
>> >>
>> >> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
>> >> ---
>> >>  arch/arm/mach-davinci/da850.c              |    6 +++---
>> >>  arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
>> >>  2 files changed, 4 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-davinci/da850.c
>> >> b/arch/arm/mach-davinci/da850.c
>> >> index 3443d97..8a4de97 100644
>> >> --- a/arch/arm/mach-davinci/da850.c
>> >> +++ b/arch/arm/mach-davinci/da850.c
>> >> @@ -711,7 +711,7 @@ static struct map_desc da850_io_desc[] = {
>> >>  },
>> >>  {
>> >>  .virtual = SRAM_VIRT,
>> >> - .pfn = __phys_to_pfn(DA8XX_ARM_RAM_BASE),
>> >> + .pfn = __phys_to_pfn(DA8XX_SHARED_RAM_BASE),
>> >>  .length = SZ_8K,
>> >>  .type = MT_DEVICE
>> >>  },
>> >> @@ -1083,8 +1083,8 @@ static struct davinci_soc_info
>> >> davinci_soc_info_da850 = {
>> >>  .gpio_irq = IRQ_DA8XX_GPIO0,
>> >>  .serial_dev = &da8xx_serial_device,
>> >>  .emac_pdata = &da8xx_emac_pdata,
>> >> - .sram_dma = DA8XX_ARM_RAM_BASE,
>> >> - .sram_len = SZ_8K,
>> >> + .sram_dma = DA8XX_SHARED_RAM_BASE,
>> >> + .sram_len = SZ_128K,
>> >>  .reset_device = &da8xx_wdt_device,
>> >>  };
>> >>
>> >> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h
>> >> b/arch/arm/mach-davinci/include/mach/da8xx.h
>> >> index cfcb223..c3c3339 100644
>> >> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
>> >> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
>> >> @@ -70,6 +70,7 @@ extern unsigned int da850_max_speed;
>> >>  #define DA8XX_AEMIF_CTL_BASE 0x68000000
>> >>  #define DA8XX_DDR2_CTL_BASE 0xb0000000
>> >>  #define DA8XX_ARM_RAM_BASE 0xffff0000
>> >> +#define DA8XX_SHARED_RAM_BASE 0x80000000
>> >>
>> >>  void __init da830_init(void);
>> >>  void __init da850_init(void);
>> >> -- 
>> >> 1.7.2.3
>> >>
>> >>
>> >
>>
> 


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.161.1299282893.1530.linux-arm-kernel@lists.infradead.org>

checking for the wakeup event.  I also think it should be clear that
this is checking for IO-ring wakeups, not module wakeups.

Also, in PATCH 5/7, you're calling this hwmod API directly from a
driver.  Drivers should not know anything about hwmods.  Any
OMAP-specific hooks must be called through pdata function pointers.
Also, they should go through omap_device, which would then call
omap_hwmod.

Thinking more about this (and how you use it in PATCH 5/7), what is
needed is an omap_device level API to check if a wakeup occured for that
device.  That function would check for either module-level wakeup or IO
pad wakeup.  The driver should not need to care about how the wakeup
occurred.

> +{
> +	if (oh->mux)
> +		return omap_hwmod_mux_wakeup(oh->mux);
> +	return -EINVAL;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index fedd829..4100be0 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -588,6 +588,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh);
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
>   * to use initcalls once the initial boot ordering is straightened out

Kevin


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.170.1299852607.1530.linux-arm-kernel@lists.infradead.org>

Now it makes me wonder if this thing would make sense. Maybe it's
better to create a node under platform and then add attributes to it, as suggested
in V1 thread. I don't know, this could still be done by the socinfo code.
I mean, location is still an issue it seams :-)

Another thing, what could be done is, instead of creating new data structures to hold
the attributes, a struct  attribute_group could be pass instead during registration time.
What do you think??

> +
> +static struct attribute *soc_attrs[] = {
> +	NULL,
> +};
> +
> +static struct attribute_group soc_attr_group = {
> +	.attrs = soc_attrs,
> +};


What is the point of the above two ?

> +
> +int __init register_sysfs_soc(struct sysfs_soc_info *info, size_t num)
> +{
> +	int ret;
> +
> +	soc_object = kobject_create_and_add("socinfo", NULL);
> +	if (!soc_object) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	ret = sysfs_create_group(soc_object, &soc_attr_group);
> +	if (ret)
> +		goto kset_exit;

You add an empty group here.

> +
> +	ret = register_sysfs_soc_info(info, num);
> +	if (ret)
> +		goto group_exit;

But the real thing happens here.

> +
> +	return 0;
> +
> +group_exit:
> +	sysfs_remove_group(soc_object, &soc_attr_group);
> +kset_exit:
> +	kobject_put(soc_object);
> +exit:
> +	return ret;
> +}
> +
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..05e5529
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +#ifndef __SYS_SOC_H
> +#define __SYS_SOC_H
> +
> +#include <linux/kobject.h>
> +
> +/**
> + * struct sys_soc_info - SoC exports related informations
> + * @name: name of the export
> + * @info: pointer on the key to export
> + * @get_info: callback to retrieve key if info field is NULL
> + * @attr: export's sysdev class attribute
> + */
> +struct sysfs_soc_info {
> +	const char *info;
> +	ssize_t (*get_info)(char *buf, struct sysfs_soc_info *);
> +	struct kobj_attribute attr;
> +};
> +
> +ssize_t show_soc_info(struct kobject *, struct kobj_attribute *, char *);
> +
> +#define SYSFS_SOC_ATTR_VALUE(_name, _value) {		\
> +	.attr.attr.name = _name,			\
> +	.attr.attr.mode = S_IRUGO,			\
> +	.attr.show	= show_soc_info,		\
> +	.info           = _value,			\
> +}
> +
> +#define SYSFS_SOC_ATTR_CALLBACK(_name, _callback) {	\
> +	.attr.attr.name = _name,			\
> +	.attr.attr.mode = S_IRUGO,			\
> +	.attr.show	= show_soc_info,		\
> +	.get_info       = _callback,			\
> +}
> +
> +/**
> + * register_sys_soc - register the soc information
> + * @name: name of the machine
> + * @info: pointer on the info table to export
> + * @num: number of info to export
> + *
> + * NOTE: This function must only be called once
> + */
> +int register_sysfs_soc(struct sysfs_soc_info *info, size_t num);
> +
> +#endif /* __SYS_SOC_H */
> -- 
> 1.7.1

-- 
Eduardo Valentin


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.173.1300197670.1530.linux-arm-kernel@lists.infradead.org>

Already up-to-date.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.177.1300791825.1530.linux-arm-kernel@lists.infradead.org>

On Mar 15, 2011 9:55 PM, "Kukjin Kim" <kgene.kim@samsung.com> wrote:
> Marek Szyprowski wrote:
>>
>> This patch adds a placeholder for board specific interrupts on S5PC210
>> platform.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> arch/arm/mach-exynos4/include/mach/irqs.h | 6 +++++-
>> 1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
>> exynos4/include/mach/irqs.h
>> index 5d03730..cc2186d 100644
>> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
>> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
>> @@ -154,7 +154,11 @@
>> #define IRQ_GPIO2_NR_GROUPS 9
>> #define IRQ_GPIO_END (S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
>>
>> +/* optional board specific irqs */
>> +#define IRQ_BOARD_START IRQ_GPIO_END
>> +#define IRQ_NR_BOARD 16
>> +
>> /* Set the default NR_IRQS */
>> -#define NR_IRQS (IRQ_GPIO_END)
>> +#define NR_IRQS (IRQ_GPIO_END + IRQ_NR_BOARD)
>>
>> #endif /* __ASM_ARCH_IRQS_H */
>> --
>> 1.7.1.569.g6f426
>
> I have no idea that we need specific interrupt on EXYNOS4 now.
> As you know, this can affect all machines of EXYNOS4 SoC even though there
> is EXYNOS4210 now.
>
> If required, we need something like SAMSUNG_GPIO_EXTRA for compatibility.
> Anyway need more discussion on this :)
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

--0016e6de1501990ff9049e851a4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Now pmic8998, 8997 requires extra interrupts.</p>
<p>If you don&#39;t want to extends irqs, the sparse irq can be used at eac=
h board.</p>
<p>Of course, in case of exynos4210, need some patch for sparse irq support=
.</p>
<p>Kyungmin Park</p>
<p>From Android </p>
<div class=3D"gmail_quote">On Mar 15, 2011 9:55 PM, &quot;Kukjin Kim&quot; =
&lt;<a href=3D"mailto:kgene.kim@samsung.com">kgene.kim at samsung.com</a>&gt; =
wrote:<br type=3D"attribution">&gt; Marek Szyprowski wrote:<br>&gt;&gt; <br=
>
&gt;&gt; This patch adds a placeholder for board specific interrupts on S5P=
C210<br>&gt;&gt; platform.<br>&gt;&gt; <br>&gt;&gt; Signed-off-by: Marek Sz=
yprowski &lt;<a href=3D"mailto:m.szyprowski@samsung.com">m.szyprowski at samsu=
ng.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Kyungmin Park &lt;<a href=3D"mailto:kyungmin.park@s=
amsung.com">kyungmin.park at samsung.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt;  =
arch/arm/mach-exynos4/include/mach/irqs.h |    6 +++++-<br>&gt;&gt;  1 file=
s changed, 5 insertions(+), 1 deletions(-)<br>
&gt;&gt; <br>&gt;&gt; diff --git a/arch/arm/mach-exynos4/include/mach/irqs.=
h b/arch/arm/mach-<br>&gt;&gt; exynos4/include/mach/irqs.h<br>&gt;&gt; inde=
x 5d03730..cc2186d 100644<br>&gt;&gt; --- a/arch/arm/mach-exynos4/include/m=
ach/irqs.h<br>
&gt;&gt; +++ b/arch/arm/mach-exynos4/include/mach/irqs.h<br>&gt;&gt; @@ -15=
4,7 +154,11 @@<br>&gt;&gt;  #define IRQ_GPIO2_NR_GROUPS	9<br>&gt;&gt;  #def=
ine IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)<br>&gt;&gt; <br>
&gt;&gt; +/* optional board specific irqs */<br>&gt;&gt; +#define IRQ_BOARD=
_START		IRQ_GPIO_END<br>&gt;&gt; +#define IRQ_NR_BOARD		16<br>&gt;&gt; +<br=
>&gt;&gt;  /* Set the default NR_IRQS */<br>&gt;&gt; -#define NR_IRQS			(IR=
Q_GPIO_END)<br>
&gt;&gt; +#define NR_IRQS			(IRQ_GPIO_END + IRQ_NR_BOARD)<br>&gt;&gt; <br>&=
gt;&gt;  #endif /* __ASM_ARCH_IRQS_H */<br>&gt;&gt; --<br>&gt;&gt; 1.7.1.56=
9.g6f426<br>&gt; <br>&gt; I have no idea that we need specific interrupt on=
 EXYNOS4 now.<br>
&gt; As you know, this can affect all machines of EXYNOS4 SoC even though t=
here<br>&gt; is EXYNOS4210 now.<br>&gt; <br>&gt; If required, we need somet=
hing like SAMSUNG_GPIO_EXTRA for compatibility.<br>&gt; Anyway need more di=
scussion on this :)<br>
&gt; <br>&gt; Thanks.<br>&gt; <br>&gt; Best regards,<br>&gt; Kgene.<br>&gt;=
 --<br>&gt; Kukjin Kim &lt;<a href=3D"mailto:kgene.kim@samsung.com">kgene.k=
im at samsung.com</a>&gt;, Senior Engineer,<br>&gt; SW Solution Development Te=
am, Samsung Electronics Co., Ltd.<br>
&gt; <br>&gt; --<br>&gt; To unsubscribe from this list: send the line &quot=
;unsubscribe linux-samsung-soc&quot; in<br>&gt; the body of a message to <a=
 href=3D"mailto:majordomo@vger.kernel.org">majordomo at vger.kernel.org</a><br=
>
&gt; More majordomo info at  <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html">http://vger.kernel.org/majordomo-info.html</a><br></div>

--0016e6de1501990ff9049e851a4b--


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.179.1300978648.1530.linux-arm-kernel@lists.infradead.org>

there are precedents for this on other platforms (e.g. PowerPC),
and there is existing GDB/BFD infrastructure to check for presence/
absence of such notes.

However, we also need to be able to distinguish the various cases:
VFPv2 vs. VFPv3-D16 vs. VFPv3-D32 vs. VFPv32-D32+NEON
These cause GDB to display/interact with the register set in
different ways ...

To distinguish 16 vs. 32 registers, we can of course simply look
at the size of the note.  But how to detect support for NEON as
opposed to plain VFPv32-D32?  I could think of two ways:

1) Have *two* new note types, one for VFP, and one for NEON
2) Have GDB look into the AT_HWCAP setting in the NT_AUXV note

Option 2) seems preferable to me, since NT_AUXV is already there,
and it can also be used to detect the integer-only NEON case.

Thoughts?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch=E4ftsf=FChrung:=
 Dirk
Wittkopp
  Sitz der Gesellschaft: B=F6blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294=




>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.183.1301471587.1530.linux-arm-kernel@lists.infradead.org>

driver for the AMD z160 gpu found on theses imx SoCs. iirc, this driver by
itself is GPL but relies on closed-source userspace stuff, that's imho why
you didn't see a driver for it. I think you can find it in fsl tree
inside drivers/mxc/ directory.

Arnaud


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.188.1301921409.1530.linux-arm-kernel@lists.infradead.org>

only, and so people are hearing about it 3rd, 4th or more hand - which
really isn't the way to go about giving this news.

So, I'm not going to pass on the details which I've heard, instead
I'd suggest people wait for (or try to find) an official announcement.



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.190.1302123452.1530.linux-arm-kernel@lists.infradead.org>

be atomic.

For SSB it's not always 100% atomic, but we're always safe
due to some assumptions being made. But this is an SSB implementation
detail that is different from AXI. So don't look too closely
at the SSB implementation of the I/O functions. You certainly want
to implement them slightly differently in AXI. SSB currently doesn't
make use of the additional sliding windows, because they are not
available in the majority of SSB devices.

The AXI bus subsystem will manage the sliding windows and the driver
doesn't know about the details.

-- 
Greetings Michael.



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.191.1302196643.1530.linux-arm-kernel@lists.infradead.org>

arch/arm/plat-samsung/gpio.c registers gpios with the kernel.  Each
platform seems to have its own static table of gpio banks which are
registered without any regard to the Linux device model.  It works,
but it isn't really the way things should be done.

The design of gpiolib right now is such that the of_node pointer
should be known *before* of_gpiochip_add() gets called.  This is very
important because the code that registers the gpio is the only place
that can truly know which node is actually associated with the gpio.

To solve your problem, the best solution would be to rework
arch/arm/plat-samsung-gpio.c to properly use the driver model and
register platform_devices which can be attached to dt nodes.  This
change should probably be done anyway, even ignoring the dt needs, but
I'm not going to force you to make this change to get dt support added
for samsung gpios.

Alternately, what you should do is make sure that the chip->of_node
pointer is correctly populated before calling gpiochip_add(), possibly
in s3c_gpiolib_add().

Also, be careful about the way that 'compatible' is being used.
Remember that compatible describes the /interface/ to a device, but
not the /instance/.  Many systems have multiple instances of the same
device, and compatible doesn't provide any help for differentiating
between them.  Typically, when trying to find a specific instance of a
device, it should be resolved with a property in the /aliases node, or
it should be matched up against the resolved base address of the
device.

Cheers,
g.

>  	if ((!chip->of_node) && (chip->dev))
>  		chip->of_node = chip->dev->of_node;
>  
> Index: b/include/asm-generic/gpio.h
> ===================================================================
> --- a/include/asm-generic/gpio.h	2011-04-07 18:19:20.000000000 +0200
> +++ b/include/asm-generic/gpio.h	2011-04-07 18:19:30.000000000 +0200
> @@ -129,6 +129,7 @@
>  	int of_gpio_n_cells;
>  	int (*of_xlate)(struct gpio_chip *gc, struct device_node *np,
>  		        const void *gpio_spec, u32 *flags);
> +	const char *dt_compat;
>  #endif
>  };
>  
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.194.1302257004.1530.linux-arm-kernel@lists.infradead.org>

`naked'
     Use this attribute on the ARM, AVR, IP2K and SPU ports to indicate
     that the specified function does not need prologue/epilogue
     sequences generated by the compiler.  It is up to the programmer
     to provide these sequences. The only statements that can be safely
     included in naked functions are `asm' statements that do not have
     operands.  All other statements, including declarations of local
     variables, `if' statements, and so forth, should be avoided.
     Naked functions should be used to implement the body of an
     assembly function, while allowing the compiler to construct the
     requisite function declaration for the assembler.

... but we don't have an asm statement with no operands and no
accompanying declarations in this case.  Logically the code ought to
work if the compiler doesn't spill anything to the stack, and explicit
register variables ought to avoid this provided we don't have too
many.

But I doubt whether this behaviour is well tested by the compiler guys.

Cheers
---Dave


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.195.1302267614.1530.linux-arm-kernel@lists.infradead.org>

enum {
        PER_LINUX =             0x0000,
        PER_LINUX_32BIT =       0x0000 | ADDR_LIMIT_32BIT,
        PER_LINUX_FDPIC =       0x0000 | FDPIC_FUNCPTRS,
        PER_SVR4 =              0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
        [...]

So this is a combination of a personality ID and flag bits.  And the 
only difference between PER_LINUX and PER_LINUX_32BIT is one of those 
flag bits.


Nicolas


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.200.1303129187.1530.linux-arm-kernel@lists.infradead.org>

specific, they are present... but there is totally no point in doing
that. Everything we use is Broadcom specific.


> I think it would be fine to extend the AMBA bus slightly if there are
> just minor differences.

As I said, Broadcom specific driver use nothing from AMBA common
things. Plus we implement routines that are Broadcom specific and no
other platform will use them.

--=20
Rafa=C5=82


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.203.1303203322.1530.linux-arm-kernel@lists.infradead.org>

channel enable bit could cause data to be lost.  I think you need to set 
the CH_SUSP bit and wait for the FIFO_EMPTY flag to go high then disable 
the channel.

Jamie


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.206.1303317968.1530.linux-arm-kernel@lists.infradead.org>

!RXFIFOEMPTY in your case. Did you try to change the former to the
latter to see how it works?

Thanks,
   Vitaly


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.209.1303594388.1530.linux-arm-kernel@lists.infradead.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.214.1304079197.1530.linux-arm-kernel@lists.infradead.org>

selector, divisor and gates are a single entity or different IP
blocks. It does not matter whether they share registers or not.

The framework can always look at them as separate entities from the
abstraction level.

So if you enable Gate , then the framework goes down the tree and
enables Divisor (which is a NOP) then enables Selector (again a NOP)
and then the current selected Root clock.

So if you set the rate for the gate 1 clock, then the framework can go
down the tree and figure out whether the divisor can be set to that
rate or even figure out that the selector needs to be changed to root
B.

Not lets add more outgoing gates to the divisor:

[Root clock A]-                         |- [ Gate 1 ] - consumer1 (drivers/*)
      	      |                         |
      	      - [Selector] -- [Divisor] -- [ Gate 2 ] - consumer2 (drivers/*)
              |                         |
[Root clock B]-                         |- [ Gate 3 ] - consumer3 (drivers/*)

The enable/disable mechanism will be the same. If you look at rate
changes, then you can decide at the framework level whether it's
possible to change the divisor if there is more than one active child
(Gate). In the above scenario it's not possible as you would violate
the settings of consumer2 and consumer3 if you change the rate on
behalf of consumer1.

[Root clock A]-                         |- [ Gate 1 ] - consumer1 (drivers/*)
      	      |                         |
      	      - [Selector] -- [Divisor] -- [ Gate 2 ] -- [divisor] - consumer2 (drivers/*)
              |                         |
[Root clock B]-                         |- [ Gate 3 ] -- [divisor] - consumer3 (drivers/*)

Now in this scenario the core can figure out whether it can satisfy
the request of consumer1 by adjusting the divisors behind Gate 2 and 3
accordingly.

This are all well defined semantical problems and should be solved in
common code rather than having different buggy implementations in each
SoC clock "framework".

Thanks,

	tglx
--8323328-256550738-1304079187=:3005--


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.216.1304491229.1530.linux-arm-kernel@lists.infradead.org>

the actual rate does not matter, only enabling/disabling the clock for
register accesses is important. When a driver sets a rate on a clock it
does it on purpose and if this clock is not even present on other SoCs
it looks like a bug or at least a very special case for me. So I think
clk_set_rate for a NULL clock should fail.
Other than that it's not a good behaviour when clk_get_rate() returns
0 for clock which rate has been successfully set to another rate using
clk_set_rate().

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.217.1304558255.1530.linux-arm-kernel@lists.infradead.org>

kernel-parameters.txt where we limit the number of present cpus to the
maxcpus cmdline but still show the possible cpus in sysfs although we
only allow hotplugging of the present cpus. So a maxcpus=1 on a system
with possibly 2 cpus will have a cpu1 in /sys/devices/system/cpu/ but
error out when you do

# echo 1 > /sys/devices/system/cpu/cpu1/online

because the cpu isn't present (to use the cpumask notation).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.218.1304614171.1530.linux-arm-kernel@lists.infradead.org>

Note that requesting a GPIO does NOT cause it to be configured in any
way; it just marks that GPIO as in use.  Separate code must handle any
pin setup (e.g. controlling which pin the GPIO uses, pullup/pulldown).


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.219.1304619521.1530.linux-arm-kernel@lists.infradead.org>

Note that requesting a GPIO does NOT cause it to be configured in any
way; it just marks that GPIO as in use.  Separate code must handle any
pin setup (e.g. controlling which pin the GPIO uses, pullup/pulldown).


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.220.1304678000.1530.linux-arm-kernel@lists.infradead.org>

- Fix crash while hotpluging a CPU
- Use handle_percpu_irq() instead of handle_fasteoi_irq()
- MSM fixes courtesy of Stephen Boyd
- MSM switched to percpu_timer_handler()
- Remove local timer interrupt accounting
- Restructure patches #1 and #2

Marc Zyngier (12):
  ARM: gic: add per-cpu interrupt multiplexer
  ARM: smp_twd: add support for remapped PPI interrupts
  ARM: omap4: use remapped PPI interrupts for local timer
  ARM: versatile: use remapped PPI interrupts for local timer
  ARM: shmobile: use remapped PPI interrupts for local timer
  ARM: ux500: use remapped PPI interrupts for local timer
  ARM: tegra: use remapped PPI interrupts for local timer
  ARM: msm: use remapped PPI interrupts for local timer
  ARM: exynos4: use remapped PPI interrupts for local timer
  ARM: gic: remove previous local timer interrupt handling
  ARM: gic: add compute_irqnr macro for exynos4
  ARM: SMP: automatically select ARM_GIC_VPPI

 arch/arm/Kconfig                                  |    1 +
 arch/arm/common/Kconfig                           |    5 +
 arch/arm/common/gic.c                             |  143 +++++++++++++++++=
++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   31 ++---
 arch/arm/include/asm/hardware/gic.h               |   12 ++-
 arch/arm/include/asm/localtimer.h                 |    7 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/kernel/irq.c                             |   11 +-
 arch/arm/kernel/smp.c                             |   27 +---
 arch/arm/kernel/smp_twd.c                         |   17 ++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +----------
 arch/arm/mach-exynos4/localtimer.c                |    3 +-
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-----------
 arch/arm/mach-msm/timer.c                         |   62 ++++-----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 arch/arm/mach-shmobile/localtimer.c               |    3 +-
 arch/arm/mach-tegra/localtimer.c                  |    3 +-
 arch/arm/mach-ux500/localtimer.c                  |    3 +-
 arch/arm/plat-versatile/localtimer.c              |    3 +-
 25 files changed, 235 insertions(+), 288 deletions(-)




>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.222.1305006349.1530.linux-arm-kernel@lists.infradead.org>

Ignoring RAM at 60000000-63ffffff (vmalloc region overlap).

Could you or someone else please give me a hint how to deal with this?

Thanks a lot.

BR


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.224.1305070414.1530.linux-arm-kernel@lists.infradead.org>

Are you thinking that the i2c controller should be in the
harmony_devices array and initialized with the other devices? If so i2c
is different in the kernel. An i2c controller isn't registered with
platform_device_register().

I may not be understanding your question.

> 
> So, all this already works without putting the board-specific platform
> data definitions into board-dt.c as an temporary measure.
> 



>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.225.1305142273.1530.linux-arm-kernel@lists.infradead.org>

the RX.
So, I disabled the complete TX section in the driver, but even when the 
complete TX was disabled
I observed the same errors in RX.


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.226.1305142273.1530.linux-arm-kernel@lists.infradead.org>

routine was getting called.
I traced it down to the below function, this is a sub-system specific 
function in the file serial-core.c

static int uart_carrier_raised(struct tty_port *port)
{
        struct uart_state *state = container_of(port, struct uart_state, 
port);
        struct uart_port *uport = state->uart_port;
        int mctrl;

        spin_lock_irq(&uport->lock);
        uport->ops->enable_ms(uport);
        mctrl = uport->ops->get_mctrl(uport);
        spin_unlock_irq(&uport->lock);
        if (mctrl & TIOCM_CAR) {
                return 1;
        }
        return 0;
}

In this function I moved the "return 1" to the beginning of the function, 
this solved the bug that we are having. There was no data loss.

I think, the two spin locks used in this function is somehow effecting the 
RX.

I then modified this function to as follows and the error is not observed 
anymore.

static int uart_carrier_raised(struct tty_port *port)
{
        struct uart_state *state = container_of(port, struct uart_state, 
port);
        struct uart_port *uport = state->uart_port;
        int mctrl;
        unsigned long flags = 0;

        spin_lock_irqsave(&uport->lock, flags);
        uport->ops->enable_ms(uport);
        mctrl = uport->ops->get_mctrl(uport);
        spin_unlock_irqrestore(&uport->lock, flags);
        if (mctrl & TIOCM_CAR) {
                return 1;
        }
        return 0;
}

Is this a BUG in the TTY sub-system or am I doing something wrong in my 
driver.

I also changed one driver function to as follows:

static u32 pruss_suart_get_mctrl(struct uart_port *port)
{
        return TIOCM_CAR;
}

Best Regards,
Subhasish Ghosh
--------------------------------------------------
From: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Sent: Friday, April 22, 2011 5:38 PM
To: <davinci-linux-open-source@linux.davincidsp.com>
Cc: <linux-arm-kernel@lists.infradead.org>; <m-watkins@ti.com>; 
<nsekhar@ti.com>; <sachi@mistralsolutions.com>; "Subhasish Ghosh" 
<subhasish@mistralsolutions.com>; "Greg Kroah-Hartman (maintainer:TTY 
LAYER,commit_signer:2/4=50%,commit_signer:1/2=50%)" <gregkh@suse.de>; 
"Andrew Morton (commit_signer:1/4=25%)" <akpm@linux-foundation.org>; "Randy 
Dunlap (commit_signer:1/4=25%)" <randy.dunlap@oracle.com>; "open list" 
<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] tty: add pruss SUART driver

> This patch adds support for the TTY compliant
> Soft-UART device emulated on PRUSS.
>
> This patch depends on:
> davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS.
>            https://patchwork.kernel.org/patch/615681/
> davinci: changed SRAM allocator to shared ram.
>            https://patchwork.kernel.org/patch/549351/
>
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> ---
> drivers/tty/serial/Kconfig             |   18 +
> drivers/tty/serial/Makefile            |    6 +
> drivers/tty/serial/pruss_suart.c       | 1061 ++++++++++++++++++++
> drivers/tty/serial/pruss_suart.h       | 1038 +++++++++++++++++++
> drivers/tty/serial/pruss_suart_api.c   | 1710 
> ++++++++++++++++++++++++++++++++
> drivers/tty/serial/pruss_suart_utils.c |  393 ++++++++
> include/linux/serial_core.h            |    2 +
> 7 files changed, 4228 insertions(+), 0 deletions(-)
> create mode 100644 drivers/tty/serial/pruss_suart.c
> create mode 100644 drivers/tty/serial/pruss_suart.h
> create mode 100644 drivers/tty/serial/pruss_suart_api.c
> create mode 100644 drivers/tty/serial/pruss_suart_utils.c
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 2b83346..6c26ebf 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1596,4 +1596,22 @@ config SERIAL_PCH_UART
>    This driver is for PCH(Platform controller Hub) UART of Intel EG20T
>    which is an IOH(Input/Output Hub) for x86 embedded processor.
>    Enabling PCH_DMA, this PCH UART works as DMA mode.
> +
> +config SERIAL_PRUSS_SUART
> + depends on ARCH_DAVINCI && ARCH_DAVINCI_DA850
> + select SERIAL_CORE
> + tristate "PRUSS based SoftUART emulation on DA8XX"
> + ---help---
> + This driver emulates up to eight different UARTs on the PRUSS.
> + You may modify the NR_SUARTS macro in the driver to emulate
> + less number of UARTS as per your requirement.
> + If not sure, mark No
> +
> +config PRUSS_SUART_MCASP
> + depends on ARCH_DAVINCI_DA830 && SERIAL_PRUSS_SUART
> + default "0"
> + int "McASP number"
> + ---help---
> + Enter the McASP number to use with SUART (0, 1 or 2).
> + You will need to recompile the kernel if this is changed.
> endmenu
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 8ea92e9..e1eaaf3 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -92,3 +92,9 @@ obj-$(CONFIG_SERIAL_MRST_MAX3110) += mrst_max3110.o
> obj-$(CONFIG_SERIAL_MFD_HSU) += mfd.o
> obj-$(CONFIG_SERIAL_IFX6X60)  += ifx6x60.o
> obj-$(CONFIG_SERIAL_PCH_UART) += pch_uart.o
> +
> +pruss_uart-objs := pruss_suart.o \
> + pruss_suart_api.o \
> + pruss_suart_utils.o
> +
> +obj-$(CONFIG_SERIAL_PRUSS_SUART) += pruss_uart.o
> diff --git a/drivers/tty/serial/pruss_suart.c 
> b/drivers/tty/serial/pruss_suart.c
> new file mode 100644
> index 0000000..37c3c21
> --- /dev/null
> +++ b/drivers/tty/serial/pruss_suart.c
> @@ -0,0 +1,1061 @@
> +/*
> + * PRUSS SUART Emulation device driver
> + * Author: subhasish at mistralsolutions.com
> + *
> + * This driver supports TI's PRU SUART Emulation and the
> + * specs for the same is available at <http://www.ti.com>
> + *
> + * Copyright (C) 2010, 2011 Texas Instruments Incorporated 
> <http://www.ti.com/>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed as is WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/firmware.h>
> +#include <linux/clk.h>
> +#include <linux/serial_reg.h>
> +#include <linux/delay.h>
> +#include <linux/bitops.h>
> +#include <mach/sram.h>
> +#include "pruss_suart.h"
> +
> +#define NR_SUART 8
> +#define DRV_NAME "da8xx_pruss_uart"
> +#define DRV_DESC "PRUSS SUART Driver v1.0"
> +#define MAX_SUART_RETRIES 100
> +#define SUART_CNTX_SZ 512
> +#define SUART_FIFO_TIMEOUT_DFLT 5
> +#define SUART_FIFO_TIMEOUT_MIN 4
> +#define SUART_FIFO_TIMEOUT_MAX 500
> +
> +/* Default timeout set to 5ms */
> +static s16 suart_timeout = SUART_FIFO_TIMEOUT_DFLT;
> +module_param(suart_timeout, short, S_IRUGO);
> +MODULE_PARM_DESC(suart_timeout,
> + "fifo timeout in milli seconds (min: 4; max: 500)");
> +
> +struct suart_fifo {
> + void *fifo_vaddr_buff_tx;
> + void *fifo_vaddr_buff_rx;
> + void *fifo_phys_addr_tx;
> + void *fifo_phys_addr_rx;
> +};
> +
> +struct omapl_pru_suart {
> + struct uart_port port[NR_SUART];
> + struct device *dev;
> + unsigned long tx_empty[NR_SUART];
> + struct clk *clk_mcasp;
> + struct suart_fifo suart_fifo_addr[NR_SUART];
> + struct suart_handle suart_hdl[NR_SUART];
> + struct pruss_suart_iomap suart_iomap;
> + struct tasklet_struct tx_task[NR_SUART];
> + u32 clk_freq_pru;
> + u32 clk_freq_mcasp;
> + u32 tx_loadsz;
> +};
> +
> +static u32 suart_get_duplex(struct omapl_pru_suart *soft_uart, u32 
> uart_no)
> +{
> + return soft_uart->suart_hdl[uart_no].uart_type;
> +}
> +
> +static inline void __stop_tx(struct omapl_pru_suart *soft_uart, u32 
> uart_no)
> +{
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> + struct uart_port *port = &soft_uart->port[uart_no];
> + u16 txready;
> + u32 i;
> +
> + /* Check if any TX in progress */
> + for (i = 0, txready = 1; (i < 10000) && txready; i++) {
> + txready = (pru_softuart_get_tx_status
> + (dev, &soft_uart->suart_hdl[uart_no]) &
> + CHN_TXRX_STATUS_RDY);
> + }
> + /* To stop tx, disable the TX interrupt */
> + spin_lock_irqsave(&port->lock, flags);
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[uart_no].uart_num,
> + PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
> + pru_softuart_clr_tx_status(dev, &soft_uart->suart_hdl[uart_no]);
> + spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void pruss_suart_stop_tx(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> +
> + __stop_tx(soft_uart, port->line);
> +}
> +
> +static void omapl_pru_tx_chars(struct omapl_pru_suart *soft_uart, u32 
> uart_no)
> +{
> + struct circ_buf *xmit = &soft_uart->port[uart_no].state->xmit;
> + struct device *dev = soft_uart->dev;
> + s32 count = 0;
> +
> + if (!(suart_get_duplex(soft_uart, uart_no) & ePRU_SUART_HALF_TX))
> + return;
> +
> + if (uart_circ_empty(xmit) ||
> + uart_tx_stopped(&soft_uart->port[uart_no])) {
> + pruss_suart_stop_tx(&soft_uart->port[uart_no]);
> + set_bit(0, &soft_uart->tx_empty[uart_no]);
> + return;
> + }
> +
> + for (count = 0; count <= soft_uart->tx_loadsz; count++) {
> + *((s8 *)soft_uart->suart_fifo_addr[uart_no].fifo_vaddr_buff_tx
> + + count) = xmit->buf[xmit->tail];
> + xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> + soft_uart->port[uart_no].icount.tx++;
> + if (uart_circ_empty(xmit)) {
> + uart_circ_clear(xmit);
> + break;
> + }
> + }
> +
> + if (count == (SUART_FIFO_LEN + 1))
> + count = SUART_FIFO_LEN;
> +
> + /* Write the character to the data port */
> + if (pru_softuart_write(dev,
> + &soft_uart->suart_hdl[uart_no],
> + (u32 *)&soft_uart->suart_fifo_addr
> + [uart_no].fifo_phys_addr_tx, count) != 0) {
> + dev_err(dev, "failed to tx data\n");
> + }
> +
> + if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> + uart_write_wakeup(&soft_uart->port[uart_no]);
> +
> +#if 0
> + if (uart_circ_empty(xmit))
> + __stop_tx(soft_uart, uart_no);
> +#endif
> +}
> +
> +static void suart_tx_task(unsigned long data)
> +{
> + struct uart_port *port = (struct uart_port *)data;
> + struct omapl_pru_suart *soft_uart =
> + container_of(port, struct omapl_pru_suart, port[port->line]);
> +
> + omapl_pru_tx_chars(soft_uart, port->line);
> +}
> +
> +static void omapl_pru_rx_chars(struct omapl_pru_suart *soft_uart, u32 
> uart_no)
> +{
> + struct tty_struct *tty = NULL;
> + struct device *dev = soft_uart->dev;
> + s8 flags = TTY_NORMAL;
> + u16 rx_status, data_len = SUART_FIFO_LEN;
> + u32 data_len_read;
> + u8 suart_data[SUART_FIFO_LEN + 1];
> + s32 i = 0;
> +
> + if (!(suart_get_duplex(soft_uart, uart_no) & ePRU_SUART_HALF_RX))
> + return;
> +
> + /* read the status */
> + rx_status = pru_softuart_get_rx_status(dev,
> + &soft_uart->suart_hdl[uart_no]);
> +
> + pru_softuart_read_data(dev, &soft_uart->suart_hdl[uart_no],
> + suart_data, data_len + 1, &data_len_read);
> +
> + tty = tty_port_tty_get(&soft_uart->port[uart_no].state->port);
> +
> + if (!tty)
> + return;
> +
> + /* check for errors */
> + if (rx_status & CHN_TXRX_STATUS_ERR) {
> + if (rx_status & CHN_TXRX_STATUS_FE)
> + soft_uart->port[uart_no].icount.frame++;
> + if (rx_status & CHN_TXRX_STATUS_OVRNERR)
> + soft_uart->port[uart_no].icount.overrun++;
> + if (rx_status & CHN_TXRX_STATUS_BI)
> + soft_uart->port[uart_no].icount.brk++;
> + rx_status &= soft_uart->port[uart_no].
> + read_status_mask;
> + if (rx_status & CHN_TXRX_STATUS_FE)
> + flags = TTY_FRAME;
> + if (rx_status & CHN_TXRX_STATUS_OVRNERR)
> + flags = TTY_OVERRUN;
> + if (rx_status & CHN_TXRX_STATUS_BI)
> + flags = TTY_BREAK;
> +
> +#ifdef SUPPORT_SYSRQ
> + soft_uart->port[uart_no].sysrq = 0;
> +#endif
> + } else {
> + for (i = 0; i <= data_len_read; i++) {
> + soft_uart->port[uart_no].icount.rx++;
> + /* check for sys rq */
> + if (uart_handle_sysrq_char
> +     (&soft_uart->port[uart_no], suart_data))
> + continue;
> + }
> + tty_insert_flip_string(tty, suart_data, data_len_read);
> + }
> +
> + /* push data into tty */
> + pru_softuart_clr_rx_status(dev, &soft_uart->suart_hdl[uart_no]);
> + tty_flip_buffer_push(tty);
> + tty_kref_put(tty);
> +}
> +
> +static irqreturn_t pruss_suart_interrupt(s32 irq, void *dev_id)
> +{
> + struct uart_port *port = dev_id;
> + struct omapl_pru_suart *soft_uart =
> + container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + u16 txrx_flag;
> + u32 ret;
> + unsigned long flags = 0;
> + u16 uart_num = port->line + 1;
> +
> + spin_lock_irqsave(&port->lock, flags);
> +
> + do {
> + ret = pru_softuart_get_isrstatus(dev, uart_num, &txrx_flag);
> + if (ret != 0) {
> + dev_err(dev, "suart%d: failed to get interrupt, ret:"
> + " 0x%X txrx_flag 0x%X\n",
> + port->line, ret, txrx_flag);
> + spin_unlock_irqrestore(&port->lock, flags);
> + return IRQ_NONE;
> + }
> + if ((PRU_RX_INTR & txrx_flag) == PRU_RX_INTR) {
> + pru_intr_clr_isrstatus(dev, uart_num, PRU_RX_INTR);
> + if ((soft_uart->port[port->line].ignore_status_mask &
> + CHN_TXRX_STATUS_RDY) == CHN_TXRX_STATUS_RDY) {
> + pru_softuart_clr_rx_status(dev,
> + &soft_uart->suart_hdl
> + [port->line]);
> + } else {
> + omapl_pru_rx_chars(soft_uart, port->line);
> + }
> + }
> +
> + if ((PRU_TX_INTR & txrx_flag) == PRU_TX_INTR) {
> + pru_intr_clr_isrstatus(dev, uart_num, PRU_TX_INTR);
> + pru_softuart_clr_tx_status(dev, &soft_uart->suart_hdl
> + [port->line]);
> + tasklet_schedule(&soft_uart->tx_task[port->line]);
> + }
> + } while (txrx_flag & (PRU_RX_INTR | PRU_TX_INTR));
> +
> + spin_unlock_irqrestore(&port->lock, flags);
> + return IRQ_HANDLED;
> +}
> +
> +static void pruss_suart_stop_rx(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> +
> + spin_lock_irqsave(&port->lock, flags);
> + /* disable rx interrupt */
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, CHN_TXRX_IE_MASK_BI
> +    | CHN_TXRX_IE_MASK_FE | CHN_TXRX_IE_MASK_CMPLT
> +    | CHN_TXRX_IE_MASK_TIMEOUT);
> + spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void pruss_suart_enable_ms(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + dev_err(dev, "modem control timer not supported\n");
> +}
> +
> +static void pruss_suart_start_tx(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> +
> + /* unmask the tx interrupts */
> + spin_lock_irqsave(&port->lock, flags);
> + suart_intr_setmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
> + spin_unlock_irqrestore(&port->lock, flags);
> +
> + if (test_and_clear_bit(0, &soft_uart->tx_empty[port->line]))
> + omapl_pru_tx_chars(soft_uart, port->line);
> +}
> +
> +static u32 pruss_suart_tx_empty(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> +
> + return (pru_softuart_get_tx_status(dev,
> + &soft_uart->suart_hdl[port->line])
> + & CHN_TXRX_STATUS_RDY) ? 0 : TIOCSER_TEMT;
> +}
> +
> +static u32 pruss_suart_get_mctrl(struct uart_port *port)
> +{
> + return -ENOTSUPP;
> +}
> +
> +static void pruss_suart_set_mctrl(struct uart_port *port, u32 mctrl)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + dev_dbg(dev, "modem control not supported\n");
> +}
> +
> +static void pruss_suart_break_ctl(struct uart_port *port, s32 
> break_state)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> +
> + spin_lock_irqsave(&port->lock, flags);
> +
> + if (break_state == -1)
> + suart_intr_clrmask(dev,
> + soft_uart->suart_hdl[port->line].uart_num,
> + PRU_RX_INTR, CHN_TXRX_IE_MASK_BI);
> + else
> + suart_intr_setmask(dev,
> + soft_uart->suart_hdl[port->line].uart_num,
> + PRU_RX_INTR, CHN_TXRX_IE_MASK_BI);
> +
> + spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void pruss_suart_set_termios(struct uart_port *port,
> +   struct ktermios *termios,
> +   struct ktermios *old)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + u8 cval = 0;
> + unsigned long flags = 0;
> + u32 baud = 0;
> + u32 old_csize = old ? old->c_cflag & CSIZE : CS8;
> +
> +/*
> + * Do not allow unsupported configurations to be set
> + */
> + if (1) {
> + termios->c_cflag &= ~(CRTSCTS | CMSPAR | CSTOPB
> +       | PARENB | PARODD | CMSPAR);
> + }
> +
> + switch (termios->c_cflag & CSIZE) {
> + case CS6:
> + cval = ePRU_SUART_DATA_BITS6;
> + break;
> + case CS7:
> + cval = ePRU_SUART_DATA_BITS7;
> + break;
> + default:
> + case CS8:
> + cval = ePRU_SUART_DATA_BITS8;
> + break;
> + }
> + /*
> + * We do not support CS5.
> + */
> + if ((termios->c_cflag & CSIZE) == CS5) {
> + termios->c_cflag &= ~CSIZE;
> + termios->c_cflag |= old_csize;
> + }
> + if (pru_softuart_setdatabits
> + (dev, &soft_uart->suart_hdl[port->line], cval, cval) != 0)
> + dev_err(dev, "failed to set data bits to: %d\n", cval);
> +
> +/*
> + * Ask the core to calculate the divisor for us.
> + */
> + baud = uart_get_baud_rate(port, termios, old,
> +   port->uartclk / 16 / 0xffff,
> +   port->uartclk / 16);
> +
> +/*
> + * Ok, we're now changing the port state.  Do it with
> + * interrupts disabled.
> + */
> + spin_lock_irqsave(&port->lock, flags);
> +
> + /* Set the baud */
> + if (pru_softuart_setbaud(dev, &soft_uart->suart_hdl[port->line],
> + SUART_DEFAULT_BAUD / baud,
> + SUART_DEFAULT_BAUD / baud) != 0)
> + dev_err(dev, "failed to set baud to: %d\n", baud);
> +
> +/*
> + * update port->read_config_mask and port->ignore_config_mask
> + * to indicate the events we are interested in receiving
> + */
> + suart_intr_setmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, SUART_GBL_INTR_ERR_MASK);
> + port->read_status_mask = 0;
> + if (termios->c_iflag & INPCK) { /* Input parity check not supported,
> + just enabled FE */
> + port->read_status_mask |= CHN_TXRX_STATUS_FE;
> + suart_intr_setmask(dev,
> + soft_uart->suart_hdl[port->line].uart_num,
> + PRU_RX_INTR, CHN_TXRX_IE_MASK_FE);
> + }
> + if (termios->c_iflag & (BRKINT | PARMRK)) {
> + port->read_status_mask |= CHN_TXRX_STATUS_BI;
> + suart_intr_setmask(dev,
> + soft_uart->suart_hdl[port->line].uart_num,
> + PRU_RX_INTR, CHN_TXRX_IE_MASK_BI);
> + }
> +/*
> + * Characters to ignore
> + */
> + port->ignore_status_mask = 0;
> + if (termios->c_iflag & IGNBRK) {
> + port->ignore_status_mask |= CHN_TXRX_STATUS_BI;
> + /*
> + * If we're ignoring break indicators,
> + * ignore overruns too (for real raw support).
> + */
> + if (termios->c_iflag & IGNPAR) {
> + port->ignore_status_mask |=
> +     (CHN_TXRX_STATUS_OVRNERR | CHN_TXRX_STATUS_FE);
> + /*
> + * Overrun in case of RX
> + * Underrun in case of TX
> + */
> + suart_intr_clrmask(dev, soft_uart->
> +    suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, CHN_TXRX_IE_MASK_FE);
> + }
> + suart_intr_clrmask(dev,
> + soft_uart->suart_hdl[port->line].uart_num,
> + PRU_RX_INTR, CHN_TXRX_IE_MASK_BI);
> + }
> +/*
> + * ignore all characters if CREAD is not set
> + */
> + if ((termios->c_cflag & CREAD) == 0) {
> + port->ignore_status_mask |= CHN_TXRX_STATUS_RDY;
> + pruss_suart_stop_rx(port);
> + }
> + /*
> + * update the per port timeout
> + */
> + uart_update_timeout(port, termios->c_cflag, baud);
> +
> + spin_unlock_irqrestore(&port->lock, flags);
> +
> + /* Don't rewrite B0 */
> + if (tty_termios_baud_rate(termios))
> + tty_termios_encode_baud_rate(termios, baud, baud);
> +}
> +
> +/*
> + * Grab any interrupt resources and initialise any low level driver
> + * state.  Enable the port for reception.  It should not activate
> + * RTS nor DTR; this will be done via a separate call to set_mctrl.
> + *
> + * This method will only be called when the port is initially opened.
> + *
> + * Locking: port_sem taken.
> + * Interrupts: globally disabled.
> + */
> +static s32 pruss_suart_startup(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> + s32 retval;
> +
> + /*
> + * Disable interrupts from this port
> + */
> + spin_lock_irqsave(&port->lock, flags);
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, CHN_TXRX_IE_MASK_BI
> +    | CHN_TXRX_IE_MASK_FE | CHN_TXRX_IE_MASK_CMPLT
> +    | CHN_TXRX_IE_MASK_TIMEOUT);
> + spin_unlock_irqrestore(&port->lock, flags);
> +
> + retval = request_irq(port->irq, pruss_suart_interrupt,
> +      port->irqflags, "suart_irq", port);
> + if (retval) {
> + free_irq(port->irq, port); /* should we free this if err */
> + goto out;
> + }
> + /*
> + * enable interrupts from this port
> + */
> + spin_lock_irqsave(&port->lock, flags);
> + suart_intr_setmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, SUART_GBL_INTR_ERR_MASK);
> +
> + suart_intr_setmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, CHN_TXRX_IE_MASK_BI
> +    | CHN_TXRX_IE_MASK_FE | CHN_TXRX_IE_MASK_CMPLT
> +    | CHN_TXRX_IE_MASK_TIMEOUT);
> +
> + suart_intr_setmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
> + spin_unlock_irqrestore(&port->lock, flags);
> +
> + if ((suart_get_duplex(soft_uart, port->line) & ePRU_SUART_HALF_TX)
> +     == ePRU_SUART_HALF_TX) {
> + suart_pru_to_host_intr_enable(dev, soft_uart->
> + suart_hdl[port->line].uart_num, PRU_TX_INTR, true);
> + }
> + /* Seed RX if port is half-rx or full-duplex */
> + if ((suart_get_duplex(soft_uart, port->line) & ePRU_SUART_HALF_RX)
> + == ePRU_SUART_HALF_RX) {
> + suart_pru_to_host_intr_enable(dev, soft_uart->
> + suart_hdl[port->line].uart_num, PRU_RX_INTR, true);
> + pru_softuart_read(dev, &soft_uart->suart_hdl[port->line],
> + (u32 *)&soft_uart->suart_fifo_addr[port->line].
> + fifo_phys_addr_rx, SUART_FIFO_LEN);
> + }
> +out:
> + return retval;
> +}
> +
> +/*
> + * Disable the port, disable any break condition that may be in
> + * effect, and free any interrupt resources.  It should not disable
> + * RTS nor DTR; this will have already been done via a separate
> + * call to set_mctrl.
> + *
> + * Drivers must not access port->info once this call has completed.
> + *
> + * This method will only be called when there are no more users of
> + * this port.
> + *
> + * Locking: port_sem taken.
> + * Interrupts: caller dependent.
> + */
> +
> +static void pruss_suart_shutdown(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct device *dev = soft_uart->dev;
> + unsigned long flags = 0;
> +
> + /*
> + * Disable interrupts from this port
> + */
> + /* Disable BI and FE intr */
> + spin_lock_irqsave(&port->lock, flags);
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
> + suart_intr_clrmask(dev, soft_uart->suart_hdl[port->line].uart_num,
> +    PRU_RX_INTR, CHN_TXRX_IE_MASK_BI
> +    | CHN_TXRX_IE_MASK_FE | CHN_TXRX_IE_MASK_CMPLT
> +    | CHN_TXRX_IE_MASK_TIMEOUT);
> + spin_unlock_irqrestore(&port->lock, flags);
> +
> + /* free interrupts */
> + free_irq(port->irq, port);
> +}
> +
> +/*
> + * Return a pointer to a string constant describing the specified
> + * port, or return NULL, in which case the string 'unknown' is
> + * substituted.
> + *
> + * Locking: none.
> + * Interrupts: caller dependent.
> + */
> +
> +static const char *pruss_suart_type(struct uart_port *port)
> +{
> + return "suart_tty";
> +}
> +
> +/*
> + * Release any memory and IO region resources currently in use by
> + * the port.
> + *
> + * Locking: none.
> + * Interrupts: caller dependent.
> + */
> +
> +static void pruss_suart_release_port(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct platform_device *pdev = to_platform_device(port->dev);
> +
> + if (0 != pru_softuart_close(&soft_uart->suart_hdl[port->line]))
> + dev_err(&pdev->dev, "failed to close suart\n");
> +
> + return;
> +}
> +
> +/*
> + * Request any memory and IO region resources required by the port.
> + * If any fail, no resources should be registered when this function
> + * returns, and it should return -EBUSY on failure.
> + *
> + * Locking: none.
> + * Interrupts: caller dependent.
> + *
> + * We need to d/l the f/w in probe and since this api
> + * is called per uart, the request_mem_region should
> + * be called in probe itself.
> + */
> +static s32 pruss_suart_request_port(struct uart_port *port)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + struct platform_device *pdev = to_platform_device(port->dev);
> + struct device *dev = soft_uart->dev;
> + struct suart_config pru_suart_config;
> + s16 timeout = 0;
> + u32 err = 0;
> +
> + if (soft_uart == NULL) {
> + dev_err(&pdev->dev, "soft_uart ptr failed\n");
> + return -ENODEV;
> + }
> + err = pru_softuart_open(&soft_uart->suart_hdl[port->line]);
> + if (err != 0) {
> + dev_err(&pdev->dev, "failed to open suart: %d\n", err);
> + err = -ENODEV;
> + goto exit;
> + }
> + set_bit(0, &soft_uart->tx_empty[port->line]);
> +
> + /* set fifo /timeout */
> + if (SUART_FIFO_TIMEOUT_MIN > suart_timeout) {
> + dev_err(&pdev->dev, "fifo timeout less than %d ms not supported\n",
> +     SUART_FIFO_TIMEOUT_MIN);
> + suart_timeout = SUART_FIFO_TIMEOUT_MIN;
> + } else if (SUART_FIFO_TIMEOUT_MAX < suart_timeout) {
> + dev_err(&pdev->dev, "fifo timeout more than %d ms not supported\n",
> +     SUART_FIFO_TIMEOUT_MAX);
> + suart_timeout = SUART_FIFO_TIMEOUT_MAX;
> + }
> +
> + /* This is only for x8 */
> + timeout = (SUART_DEFAULT_BAUD * suart_timeout) / 1000;
> + pru_set_fifo_timeout(dev, timeout);
> +
> + if (soft_uart->suart_hdl[port->line].uart_num == PRU_SUART_UART1) {
> + pru_suart_config.tx_serializer = PRU_SUART0_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART0_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART2) {
> + pru_suart_config.tx_serializer = PRU_SUART1_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART1_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART3) {
> + pru_suart_config.tx_serializer = PRU_SUART2_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART2_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART4) {
> + pru_suart_config.tx_serializer = PRU_SUART3_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART3_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART5) {
> + pru_suart_config.tx_serializer = PRU_SUART4_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART4_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART6) {
> + pru_suart_config.tx_serializer = PRU_SUART5_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART5_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART7) {
> + pru_suart_config.tx_serializer = PRU_SUART6_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART6_CONFIG_RX_SER;
> + } else if (soft_uart->suart_hdl[port->line].uart_num ==
> + PRU_SUART_UART8) {
> + pru_suart_config.tx_serializer = PRU_SUART7_CONFIG_TX_SER;
> + pru_suart_config.rx_serializer = PRU_SUART7_CONFIG_RX_SER;
> + } else {
> + return -ENOTSUPP;
> + }
> +
> + /* Some defaults to startup. reconfigured by terimos later */
> + pru_suart_config.tx_clk_divisor = 1;
> + pru_suart_config.rx_clk_divisor = 1;
> + pru_suart_config.tx_bits_per_char = ePRU_SUART_DATA_BITS8;
> + pru_suart_config.rx_bits_per_char = ePRU_SUART_DATA_BITS8;
> + pru_suart_config.oversampling = SUART_DEFAULT_OVRSMPL;
> +
> + if (pru_softuart_setconfig(dev, &soft_uart->suart_hdl[port->line],
> + &pru_suart_config) != 0) {
> + dev_err(&pdev->dev,
> + "pru_softuart_setconfig: failed to set config: %X\n",
> + err);
> + }
> +exit:
> + return err;
> +}
> +
> +/*
> + * Perform any autoconfiguration steps required for the port.  `flag`
> + * contains a bit mask of the required configuration.  UART_CONFIG_TYPE
> + * indicates that the port requires detection and identification.
> + * port->type should be set to the type found, or PORT_UNKNOWN if
> + * no port was detected.
> + *
> + * UART_CONFIG_IRQ indicates autoconfiguration of the interrupt signal,
> + * which should be probed using standard kernel autoprobing techniques.
> + * This is not necessary on platforms where ports have interrupts
> + * internally hard wired (eg, system on a chip implementations).
> + *
> + * Locking: none.
> + * Interrupts: caller dependent.
> + */
> +
> +static void pruss_suart_config_port(struct uart_port *port, s32 flags)
> +{
> + if (flags & UART_CONFIG_TYPE && pruss_suart_request_port(port) == 0)
> + port->type = PORT_DA8XX_PRU_SUART;
> +}
> +
> +/*
> + * Verify the new serial port information contained within serinfo is
> + * suitable for this port type.
> + *
> + * Locking: none.
> + * Interrupts: caller dependent.
> + */
> +static s32 pruss_suart_verify_port(struct uart_port *port,
> + struct serial_struct *ser)
> +{
> + struct omapl_pru_suart *soft_uart =
> +     container_of(port, struct omapl_pru_suart, port[port->line]);
> + s32 ret = 0;
> +
> + if (ser->type != PORT_UNKNOWN && ser->type != PORT_DA8XX_PRU_SUART)
> + ret = -EINVAL;
> + if (soft_uart->port[port->line].irq != ser->irq)
> + ret = -EINVAL;
> + if (ser->io_type != UPIO_MEM)
> + ret = -EINVAL;
> + if (soft_uart->port[port->line].uartclk / 16 != ser->baud_base)
> + ret = -EINVAL;
> + if ((void *)soft_uart->port[port->line].mapbase != ser->iomem_base)
> + ret = -EINVAL;
> + if (soft_uart->port[port->line].iobase != ser->port)
> + ret = -EINVAL;
> + return ret;
> +}
> +
> +static struct uart_ops pruss_suart_ops = {
> + .tx_empty = pruss_suart_tx_empty,
> + .set_mctrl = pruss_suart_set_mctrl,
> + .get_mctrl = pruss_suart_get_mctrl,
> + .stop_tx = pruss_suart_stop_tx,
> + .start_tx = pruss_suart_start_tx,
> + .stop_rx = pruss_suart_stop_rx,
> + .enable_ms = pruss_suart_enable_ms,
> + .break_ctl = pruss_suart_break_ctl,
> + .startup = pruss_suart_startup,
> + .shutdown = pruss_suart_shutdown,
> + .set_termios = pruss_suart_set_termios,
> + .type = pruss_suart_type,
> + .release_port = pruss_suart_release_port,
> + .request_port = pruss_suart_request_port,
> + .config_port = pruss_suart_config_port,
> + .verify_port = pruss_suart_verify_port,
> +};
> +
> +static struct uart_driver pruss_suart_reg = {
> + .owner = THIS_MODULE,
> + .driver_name = DRV_NAME,
> + .dev_name = "ttySU",
> + .major = 0,
> + .minor = 16,
> + .nr = NR_SUART,
> +};
> +
> +static struct pruss_suart_initparams init_params = {
> + .tx_baud_value = SUART_DEFAULT_BAUD,
> + .rx_baud_value = SUART_DEFAULT_BAUD,
> + .oversampling = SUART_DEFAULT_OVRSMPL,
> +};
> +
> +static s32 __devinit pruss_suart_probe(struct platform_device *pdev)
> +{
> + struct omapl_pru_suart *soft_uart;
> + const struct da850_evm_pruss_suart_data *pdata;
> + struct device *dev = &pdev->dev;
> + struct resource *res;
> + struct clk *clk_pruss = NULL;
> + const struct firmware *fw;
> + s32 err, i;
> +
> + pdata = dev->platform_data;
> + if (!pdata) {
> + dev_err(&pdev->dev, "platform data not found\n");
> + return -EINVAL;
> + }
> + (pdata->setup)();
> +
> + soft_uart = kzalloc(sizeof(struct omapl_pru_suart), GFP_KERNEL);
> + if (!soft_uart)
> + return -ENOMEM;
> +
> + res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + if (!res) {
> + dev_err(&pdev->dev, "failed to get resource");
> + return -ENOMEM;
> + }
> +
> + if (!request_mem_region(res->start,
> + resource_size(res),
> + dev_name(&pdev->dev))) {
> + dev_err(&pdev->dev, "mcasp memory region already claimed!\n");
> + err = -EBUSY;
> + goto probe_exit;
> + }
> +
> + soft_uart->suart_iomap.mcasp_io_addr = ioremap(res->start,
> + resource_size(res));
> + if (!soft_uart->suart_iomap.mcasp_io_addr) {
> + dev_err(&pdev->dev, "mcasp ioremap failed\n");
> + err = -EFAULT;
> + goto probe_exit_1;
> + }
> +
> + soft_uart->suart_iomap.p_fifo_buff_virt_base =
> + sram_alloc(SUART_CNTX_SZ * NR_SUART * 2,
> + (dma_addr_t *) &soft_uart->suart_iomap.p_fifo_buff_phys_base);
> + if (!soft_uart->suart_iomap.p_fifo_buff_virt_base)
> + goto probe_exit_iounmap;
> +
> + clk_pruss = clk_get(NULL, "pruss");
> + if (IS_ERR(clk_pruss)) {
> + dev_err(&pdev->dev, "no clock available: pruss\n");
> + err = -ENODEV;
> + goto probe_exit_iounmap;
> + }
> + soft_uart->clk_freq_pru = clk_get_rate(clk_pruss);
> + clk_put(clk_pruss);
> +
> + soft_uart->clk_mcasp = clk_get(&pdev->dev, NULL);
> + if (IS_ERR(soft_uart->clk_mcasp)) {
> + dev_err(&pdev->dev, "no clock available: mcasp\n");
> + err = -ENODEV;
> + soft_uart->clk_mcasp = NULL;
> + goto probe_exit_sram_free;
> + }
> +
> + soft_uart->clk_freq_mcasp = clk_get_rate(soft_uart->clk_mcasp);
> + clk_enable(soft_uart->clk_mcasp);
> +
> + err = request_firmware(&fw, "PRU_SUART_Emulation.bin",
> +        &pdev->dev);
> + if (err) {
> + dev_err(&pdev->dev, "can't load firmware\n");
> + err = -ENODEV;
> + goto probe_exit_clk;
> + }
> + dev_info(&pdev->dev, "fw size %td. downloading...\n", fw->size);
> +
> + /* download firmware into pru  & init */
> + err = pru_softuart_init(dev, &init_params, fw->data, fw->size,
> + soft_uart->clk_freq_pru / 1000000,
> + &soft_uart->suart_iomap);
> + if (err) {
> + dev_err(&pdev->dev, "pruss init error\n");
> + err = -ENODEV;
> + goto probe_release_fw;
> + }
> + release_firmware(fw);
> +
> + platform_set_drvdata(pdev, &soft_uart->port[0]);
> + soft_uart->dev = dev;
> +
> + for (i = 0; i < NR_SUART; i++) {
> + soft_uart->port[i].ops = &pruss_suart_ops;
> + soft_uart->port[i].iotype = UPIO_MEM;
> + soft_uart->port[i].flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP;
> + soft_uart->port[i].mapbase =
> + (u32)soft_uart->suart_iomap.p_fifo_buff_virt_base;
> + soft_uart->port[i].membase =
> + soft_uart->suart_iomap.mcasp_io_addr;
> + soft_uart->port[i].type = PORT_DA8XX_PRU_SUART;
> + soft_uart->port[i].irq =
> + platform_get_irq(to_platform_device(dev->parent), i);
> + soft_uart->port[i].dev = &pdev->dev;
> + soft_uart->port[i].irqflags = IRQF_SHARED;
> + soft_uart->port[i].uartclk = soft_uart->clk_freq_mcasp;
> + soft_uart->port[i].fifosize = SUART_FIFO_LEN;
> + soft_uart->tx_loadsz = SUART_FIFO_LEN;
> + soft_uart->port[i].custom_divisor = 1;
> + soft_uart->port[i].line = i;
> + soft_uart->suart_hdl[i].uart_num = i + 1;
> + soft_uart->port[i].serial_in = NULL;
> +
> + soft_uart->suart_fifo_addr[i].fifo_vaddr_buff_tx =
> + soft_uart->suart_iomap.p_fifo_buff_virt_base +
> + (2 * SUART_CNTX_SZ * i);
> +
> + soft_uart->suart_fifo_addr[i].fifo_vaddr_buff_rx =
> + soft_uart->suart_iomap.p_fifo_buff_virt_base +
> + ((2 * SUART_CNTX_SZ * i) + SUART_CNTX_SZ);
> +
> + soft_uart->suart_fifo_addr[i].fifo_phys_addr_tx =
> + soft_uart->suart_iomap.p_fifo_buff_phys_base +
> + (2 * SUART_CNTX_SZ * i);
> +
> + soft_uart->suart_fifo_addr[i].fifo_phys_addr_rx =
> + soft_uart->suart_iomap.p_fifo_buff_phys_base +
> + ((2 * SUART_CNTX_SZ * i) + SUART_CNTX_SZ);
> +
> + soft_uart->port[i].serial_out = NULL;
> + tasklet_init(&soft_uart->tx_task[i], suart_tx_task,
> + (unsigned long)&soft_uart->port[i]);
> + uart_add_one_port(&pruss_suart_reg, &soft_uart->port[i]);
> + }
> +
> + dev_info(&pdev->dev,
> + "%s device registered (pru_clk=%d, asp_clk=%d)\n",
> + DRV_NAME, soft_uart->clk_freq_pru, soft_uart->clk_freq_mcasp);
> +
> + return 0;
> +
> +probe_release_fw:
> + release_firmware(fw);
> +probe_exit_clk:
> + clk_put(soft_uart->clk_mcasp);
> + clk_disable(soft_uart->clk_mcasp);
> +probe_exit_sram_free:
> + sram_free(soft_uart->suart_iomap.p_fifo_buff_virt_base,
> + SUART_CNTX_SZ * NR_SUART * 2);
> +probe_exit_iounmap:
> + iounmap(soft_uart->suart_iomap.mcasp_io_addr);
> +probe_exit_1:
> + release_mem_region(res->start,
> + resource_size(res));
> +probe_exit:
> + kfree(soft_uart);
> + return err;
> +}
> +
> +static s32 __devexit pruss_suart_remove(struct platform_device *pdev)
> +{
> + struct omapl_pru_suart *soft_uart = platform_get_drvdata(pdev);
> + const struct da850_evm_pruss_suart_data *pdata;
> + struct device *dev = &pdev->dev;
> + struct resource *res;
> + int i;
> +
> + pdata = dev->platform_data;
> + if (!pdata)
> + dev_err(&pdev->dev, "platform data not found\n");
> +
> + res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + if (!res) {
> + dev_err(&pdev->dev, "failed to get resource");
> + return -ENOMEM;
> + }
> +
> + platform_set_drvdata(pdev, NULL);
> +
> + if (soft_uart) {
> + for (i = 0; i < NR_SUART; i++) {
> + uart_remove_one_port(&pruss_suart_reg,
> + &soft_uart->port[i]);
> + }
> + }
> +
> + sram_free(soft_uart->suart_iomap.p_fifo_buff_virt_base,
> + SUART_CNTX_SZ * NR_SUART * 2);
> + clk_put(soft_uart->clk_mcasp);
> + pru_mcasp_deinit();
> + clk_disable(soft_uart->clk_mcasp);
> + iounmap(soft_uart->suart_iomap.mcasp_io_addr);
> + if (pdata) {
> + release_mem_region(res->start,
> + resource_size(res));
> + }
> + kfree(soft_uart);
> + return 0;
> +}
> +
> +#define pruss_suart_suspend NULL
> +#define pruss_suart_resume NULL
> +
> +static struct platform_driver serial_pruss_driver = {
> + .probe = pruss_suart_probe,
> + .remove = __devexit_p(pruss_suart_remove),
> + .suspend = pruss_suart_suspend,
> + .resume = pruss_suart_resume,
> + .driver = {
> + .name = DRV_NAME,
> + .owner = THIS_MODULE,
> + },
> +};
> +
> +static s32 __init pruss_suart_init(void)
> +{
> + s32 ret;
> +
> + pruss_suart_reg.nr = NR_SUART;
> + ret = uart_register_driver(&pruss_suart_reg);
> + if (ret)
> + return ret;
> + ret = platform_driver_register(&serial_pruss_driver);
> + if (ret)
> + goto out;
> +
> + pr_debug("SUART serial driver loaded\n");
> + return ret;
> +out:
> + uart_unregister_driver(&pruss_suart_reg);
> + return ret;
> +}
> +
> +module_init(pruss_suart_init);
> +
> +static void __exit pruss_suart_exit(void)
> +{
> + platform_driver_unregister(&serial_pruss_driver);
> + uart_unregister_driver(&pruss_suart_reg);
> + pr_debug("SUART serial driver unloaded\n");
> +}
> +
> +module_exit(pruss_suart_exit);
> +
> +/* Module information */
> +MODULE_AUTHOR("Subhasish Ghosh <subhasish@mistralsolutions.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION(DRV_DESC);
> diff --git a/drivers/tty/serial/pruss_suart.h 
> b/drivers/tty/serial/pruss_suart.h
> new file mode 100644
> index 0000000..f3a2a9d
> --- /dev/null
> +++ b/drivers/tty/serial/pruss_suart.h
> @@ -0,0 +1,1038 @@
> +/*
> + * Copyright (C) 2010, 2011 Texas Instruments Incorporated
> + * Author: Jitendra Kumar <jitendra@mistralsolutions.com>
> + *
> + * This program is free software; you can redistribute it and/or modify 
> it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#ifndef _SUART_API_H_
> +#define _SUART_API_H_
> +
> +#include <linux/types.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/mfd/pruss.h>
> +
> +#define SINGLE_PRU 0
> +#define BOTH_PRU 1
> +#define PRU_ACTIVE BOTH_PRU
> +#define PRU_CLK_228 228
> +#define PRU_CLK_186 186
> +
> +#define PRU_SUART_SERIALIZER_0 (0u)
> +#define PRU_SUART_SERIALIZER_1 (1u)
> +#define PRU_SUART_SERIALIZER_2 (2u)
> +#define PRU_SUART_SERIALIZER_3 (3u)
> +#define PRU_SUART_SERIALIZER_4 (4u)
> +#define PRU_SUART_SERIALIZER_5 (5u)
> +#define PRU_SUART_SERIALIZER_6 (6u)
> +#define PRU_SUART_SERIALIZER_7 (7u)
> +#define PRU_SUART_SERIALIZER_8 (8u)
> +#define PRU_SUART_SERIALIZER_9 (9u)
> +#define PRU_SUART_SERIALIZER_10 (10u)
> +#define PRU_SUART_SERIALIZER_11 (11u)
> +#define PRU_SUART_SERIALIZER_12 (12u)
> +#define PRU_SUART_SERIALIZER_13 (13u)
> +#define PRU_SUART_SERIALIZER_14 (14u)
> +#define PRU_SUART_SERIALIZER_15 (15u)
> +#define PRU_SUART_SERIALIZER_NONE (16u)
> +
> +#define PRU_SUART_UART1 (1u)
> +#define PRU_SUART_UART2 (2u)
> +#define PRU_SUART_UART3 (3u)
> +#define PRU_SUART_UART4 (4u)
> +#define PRU_SUART_UART5 (5u)
> +#define PRU_SUART_UART6 (6u)
> +#define PRU_SUART_UART7 (7u)
> +#define PRU_SUART_UART8 (8u)
> +#define PRU_SUART_UARTx_INVALID (9u)
> +
> +#define PRU_SUART_HALF_TX (1u)
> +#define PRU_SUART_HALF_RX (2u)
> +#define PRU_SUART_HALF_TX_DISABLED (4u)
> +#define PRU_SUART_HALF_RX_DISABLED (8u)
> +
> +#define PRU_SUART0_CONFIG_DUPLEX (PRU_SUART_HALF_TX_DISABLED | \
> + PRU_SUART_HALF_RX_DISABLED)
> +#define PRU_SUART0_CONFIG_RX_SER (PRU_SUART_SERIALIZER_NONE)
> +#define PRU_SUART0_CONFIG_TX_SER (PRU_SUART_SERIALIZER_NONE)
> +
> +#define PRU_SUART1_CONFIG_DUPLEX (PRU_SUART_HALF_TX | \
> + PRU_SUART_HALF_RX)
> +#define PRU_SUART1_CONFIG_RX_SER (PRU_SUART_SERIALIZER_7)
> +#define PRU_SUART1_CONFIG_TX_SER (PRU_SUART_SERIALIZER_8)
> +
> +#define PRU_SUART2_CONFIG_DUPLEX (PRU_SUART_HALF_TX | \
> + PRU_SUART_HALF_RX)
> +#define PRU_SUART2_CONFIG_RX_SER (PRU_SUART_SERIALIZER_9)
> +#define PRU_SUART2_CONFIG_TX_SER (PRU_SUART_SERIALIZER_10)
> +
> +#define PRU_SUART3_CONFIG_DUPLEX (PRU_SUART_HALF_TX | \
> + PRU_SUART_HALF_RX)
> +#define PRU_SUART3_CONFIG_RX_SER (PRU_SUART_SERIALIZER_13)
> +#define PRU_SUART3_CONFIG_TX_SER (PRU_SUART_SERIALIZER_14)
> +
> +#define PRU_SUART4_CONFIG_DUPLEX (PRU_SUART_HALF_TX_DISABLED | \
> + PRU_SUART_HALF_RX_DISABLED)
> +#define PRU_SUART4_CONFIG_RX_SER (PRU_SUART_SERIALIZER_NONE)
> +#define PRU_SUART4_CONFIG_TX_SER (PRU_SUART_SERIALIZER_NONE)
> +
> +#define PRU_SUART5_CONFIG_DUPLEX (PRU_SUART_HALF_TX_DISABLED | \
> + PRU_SUART_HALF_RX_DISABLED)
> +#define PRU_SUART5_CONFIG_RX_SER (PRU_SUART_SERIALIZER_NONE)
> +#define PRU_SUART5_CONFIG_TX_SER (PRU_SUART_SERIALIZER_NONE)
> +
> +#define PRU_SUART6_CONFIG_DUPLEX (PRU_SUART_HALF_TX_DISABLED | \
> + PRU_SUART_HALF_RX_DISABLED)
> +#define PRU_SUART6_CONFIG_RX_SER (PRU_SUART_SERIALIZER_NONE)
> +#define PRU_SUART6_CONFIG_TX_SER (PRU_SUART_SERIALIZER_NONE)
> +
> +#define PRU_SUART7_CONFIG_DUPLEX (PRU_SUART_HALF_TX_DISABLED | \
> + PRU_SUART_HALF_RX_DISABLED)
> +#define PRU_SUART7_CONFIG_RX_SER (PRU_SUART_SERIALIZER_NONE)
> +#define PRU_SUART7_CONFIG_TX_SER (PRU_SUART_SERIALIZER_NONE)
> +
> +#define SUART_NUM_OF_CHANNELS_PER_SUART 2
> +#define SUART_NUM_OF_BYTES_PER_CHANNEL 16
> +
> +#define PRU_TX_INTR 1
> +#define PRU_RX_INTR 2
> +
> +#define CHN_TXRX_STATUS_TIMEOUT BIT(6)
> +#define CHN_TXRX_STATUS_BI BIT(5)
> +#define CHN_TXRX_STATUS_FE BIT(4)
> +#define CHN_TXRX_STATUS_UNERR BIT(3)
> +#define CHN_TXRX_STATUS_OVRNERR BIT(3)
> +#define CHN_TXRX_STATUS_ERR BIT(2)
> +#define CHN_TXRX_STATUS_CMPLT BIT(1)
> +#define CHN_TXRX_STATUS_RDY BIT(0)
> +
> +#define CHN_TXRX_IE_MASK_TIMEOUT BIT(14)
> +#define CHN_TXRX_IE_MASK_BI BIT(13)
> +#define CHN_TXRX_IE_MASK_FE BIT(12)
> +#define CHN_TXRX_IE_MASK_CMPLT BIT(1)
> +
> +#define SUART_GBL_INTR_ERR_MASK BIT(9)
> +#define SUART_PRU_ID_MASK 0xFF
> +
> +#define SUART_FIFO_LEN 15
> +#define SUART_8X_OVRSMPL 1
> +#define SUART_16X_OVRSMPL 2
> +#define SUART_TX_OVRSMPL 0
> +#define SUART_DEFAULT_OVRSMPL SUART_8X_OVRSMPL
> +
> +#define SUART_DEFAULT_OVRSMPL_OFFSET 26
> +#define SUART_CHN_OFFSET 31
> +#define SERIALIZER_OFFSET 8
> +
> +#if (SUART_DEFAULT_OVRSMPL == SUART_16X_OVRSMPL)
> +#define SUART_DEFAULT_BAUD 57600
> +#else
> +#define SUART_DEFAULT_BAUD 115200
> +#endif
> +
> +#define PRU_MODE_INVALID 0x0
> +#define PRU_MODE_TX_ONLY 0x1
> +#define PRU_MODE_RX_ONLY 0x2
> +#define PRU_MODE_RX_TX_BOTH 0x3
> +
> +#if (PRU_ACTIVE == BOTH_PRU)
> +#define PRU0_MODE PRU_MODE_RX_ONLY
> +#define PRU1_MODE PRU_MODE_TX_ONLY
> +#elif (PRU_ACTIVE ==  SINGLE_PRU)
> +#define PRU0_MODE PRU_MODE_RX_TX_BOTH
> +#define PRU1_MODE PRU_MODE_INVALID
> +#else
> +#define PRU0_MODE PRU_MODE_INVALID
> +#define PRU1_MODE PRU_MODE_INVALID
> +#endif
> +
> +#define MCASP_XBUF_BASE_ADDR (0x01d00200)
> +#define MCASP_RBUF_BASE_ADDR (0x01d00280)
> +#define MCASP_SRCTL_BASE_ADDR (0x01d00180)
> +
> +#define MCASP_SRCTL_TX_MODE (0x000D)
> +#define MCASP_SRCTL_RX_MODE (0x000E)
> +
> +/* Since only PRU0 can work as RX */
> +#define RX_DEFAULT_DATA_DUMP_ADDR (0x00001FC)
> +#define PRU_NUM_OF_CHANNELS (16)
> +
> +/* MCASP */
> +
> +#define OMAPL_MCASP_PFUNC_AFSR_MASK (0x80000000u)
> +#define OMAPL_MCASP_PFUNC_AFSR_SHIFT (0x0000001Fu)
> +#define OMAPL_MCASP_PFUNC_AFSR_RESETVAL (0x00000000u)
> +/* AFSR Tokens */
> +#define OMAPL_MCASP_PFUNC_AFSR_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AFSR_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AHCLKR_MASK (0x40000000u)
> +#define OMAPL_MCASP_PFUNC_AHCLKR_SHIFT (0x0000001Eu)
> +#define OMAPL_MCASP_PFUNC_AHCLKR_RESETVAL (0x00000000u)
> +/* AHCLKR Tokens */
> +#define OMAPL_MCASP_PFUNC_AHCLKR_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AHCLKR_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_ACLKR_MASK (0x20000000u)
> +#define OMAPL_MCASP_PFUNC_ACLKR_SHIFT (0x0000001Du)
> +#define OMAPL_MCASP_PFUNC_ACLKR_RESETVAL (0x00000000u)
> +/* ACLKR Tokens */
> +#define OMAPL_MCASP_PFUNC_ACLKR_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_ACLKR_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AFSX_MASK (0x10000000u)
> +#define OMAPL_MCASP_PFUNC_AFSX_SHIFT (0x0000001Cu)
> +#define OMAPL_MCASP_PFUNC_AFSX_RESETVAL (0x00000000u)
> +/* AFSX Tokens */
> +#define OMAPL_MCASP_PFUNC_AFSX_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AFSX_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AHCLKX_MASK (0x08000000u)
> +#define OMAPL_MCASP_PFUNC_AHCLKX_SHIFT (0x0000001Bu)
> +#define OMAPL_MCASP_PFUNC_AHCLKX_RESETVAL (0x00000000u)
> +/* AHCLKX Tokens */
> +#define OMAPL_MCASP_PFUNC_AHCLKX_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AHCLKX_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_ACLKX_MASK (0x04000000u)
> +#define OMAPL_MCASP_PFUNC_ACLKX_SHIFT (0x0000001Au)
> +#define OMAPL_MCASP_PFUNC_ACLKX_RESETVAL (0x00000000u)
> +/* ACLKX Tokens */
> +#define OMAPL_MCASP_PFUNC_ACLKX_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_ACLKX_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AMUTE_MASK (0x02000000u)
> +#define OMAPL_MCASP_PFUNC_AMUTE_SHIFT (0x00000019u)
> +#define OMAPL_MCASP_PFUNC_AMUTE_RESETVAL (0x00000000u)
> +/* AMUTE Tokens */
> +#define OMAPL_MCASP_PFUNC_AMUTE_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AMUTE_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR15_MASK (0x00008000u)
> +#define OMAPL_MCASP_PFUNC_AXR15_SHIFT (0x0000000Fu)
> +#define OMAPL_MCASP_PFUNC_AXR15_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR15_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR15_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR14_MASK (0x00004000u)
> +#define OMAPL_MCASP_PFUNC_AXR14_SHIFT (0x0000000Eu)
> +#define OMAPL_MCASP_PFUNC_AXR14_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR14_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR14_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR13_MASK (0x00002000u)
> +#define OMAPL_MCASP_PFUNC_AXR13_SHIFT (0x0000000Du)
> +#define OMAPL_MCASP_PFUNC_AXR13_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR13_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR13_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR12_MASK (0x00001000u)
> +#define OMAPL_MCASP_PFUNC_AXR12_SHIFT (0x0000000Cu)
> +#define OMAPL_MCASP_PFUNC_AXR12_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR12_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR12_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR11_MASK (0x00000800u)
> +#define OMAPL_MCASP_PFUNC_AXR11_SHIFT (0x0000000Bu)
> +#define OMAPL_MCASP_PFUNC_AXR11_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR11_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR11_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR10_MASK (0x00000400u)
> +#define OMAPL_MCASP_PFUNC_AXR10_SHIFT (0x0000000Au)
> +#define OMAPL_MCASP_PFUNC_AXR10_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR10_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR10_GPIO (0x00000001u)
> +#define OMAPL_MCASP_PFUNC_AXR9_MASK (0x00000200u)
> +#define OMAPL_MCASP_PFUNC_AXR9_SHIFT (0x00000009u)
> +#define OMAPL_MCASP_PFUNC_AXR9_RESETVAL (0x00000000u)
> +/* AXR9 Token */
> +#define OMAPL_MCASP_PFUNC_AXR9_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR9_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR8_MASK (0x00000100u)
> +#define OMAPL_MCASP_PFUNC_AXR8_SHIFT (0x00000008u)
> +#define OMAPL_MCASP_PFUNC_AXR8_RESETVAL (0x00000000u)
> +/* AXR8 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR8_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR8_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR7_MASK (0x00000080u)
> +#define OMAPL_MCASP_PFUNC_AXR7_SHIFT (0x00000007u)
> +#define OMAPL_MCASP_PFUNC_AXR7_RESETVAL (0x00000000u)
> +/* AXR7 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR7_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR7_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR6_MASK (0x00000040u)
> +#define OMAPL_MCASP_PFUNC_AXR6_SHIFT (0x00000006u)
> +#define OMAPL_MCASP_PFUNC_AXR6_RESETVAL (0x00000000u)
> +/* AXR6 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR6_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR6_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR5_MASK (0x00000020u)
> +#define OMAPL_MCASP_PFUNC_AXR5_SHIFT (0x00000005u)
> +#define OMAPL_MCASP_PFUNC_AXR5_RESETVAL (0x00000000u)
> +/* AXR5 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR5_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR5_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR4_MASK (0x00000010u)
> +#define OMAPL_MCASP_PFUNC_AXR4_SHIFT (0x00000004u)
> +#define OMAPL_MCASP_PFUNC_AXR4_RESETVAL (0x00000000u)
> +/* AXR4 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR4_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR4_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR3_MASK (0x00000008u)
> +#define OMAPL_MCASP_PFUNC_AXR3_SHIFT (0x00000003u)
> +#define OMAPL_MCASP_PFUNC_AXR3_RESETVAL (0x00000000u)
> +/* AXR3 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR3_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR3_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR2_MASK (0x00000004u)
> +#define OMAPL_MCASP_PFUNC_AXR2_SHIFT (0x00000002u)
> +#define OMAPL_MCASP_PFUNC_AXR2_RESETVAL (0x00000000u)
> +/* AXR2 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR2_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR2_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR1_MASK (0x00000002u)
> +#define OMAPL_MCASP_PFUNC_AXR1_SHIFT (0x00000001u)
> +#define OMAPL_MCASP_PFUNC_AXR1_RESETVAL (0x00000000u)
> +/* AXR1 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR1_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR1_GPIO (0x00000001u)
> +
> +#define OMAPL_MCASP_PFUNC_AXR0_MASK (0x00000001u)
> +#define OMAPL_MCASP_PFUNC_AXR0_SHIFT (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR0_RESETVAL (0x00000000u)
> +/* AXR0 Tokens */
> +#define OMAPL_MCASP_PFUNC_AXR0_MCASP (0x00000000u)
> +#define OMAPL_MCASP_PFUNC_AXR0_GPIO (0x00000001u)
> +#define OMAPL_MCASP_PFUNC_RESETVAL (0x00000000u)
> +
> +#define OMAPL_MCASP_PDIR_AFSR_MASK (0x80000000u)
> +#define OMAPL_MCASP_PDIR_AFSR_SHIFT (0x0000001Fu)
> +#define OMAPL_MCASP_PDIR_AFSR_RESETVAL (0x00000000u)
> +/* AFSR Tokens */
> +#define OMAPL_MCASP_PDIR_AFSR_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AFSR_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AHCLKR_MASK (0x40000000u)
> +#define OMAPL_MCASP_PDIR_AHCLKR_SHIFT (0x0000001Eu)
> +#define OMAPL_MCASP_PDIR_AHCLKR_RESETVAL (0x00000000u)
> +/* AHCLKR Tokens */
> +#define OMAPL_MCASP_PDIR_AHCLKR_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AHCLKR_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_ACLKR_MASK (0x20000000u)
> +#define OMAPL_MCASP_PDIR_ACLKR_SHIFT (0x0000001Du)
> +#define OMAPL_MCASP_PDIR_ACLKR_RESETVAL (0x00000000u)
> +/* ACLKR Tokens */
> +#define OMAPL_MCASP_PDIR_ACLKR_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_ACLKR_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AFSX_MASK (0x10000000u)
> +#define OMAPL_MCASP_PDIR_AFSX_SHIFT (0x0000001Cu)
> +#define OMAPL_MCASP_PDIR_AFSX_RESETVAL (0x00000000u)
> +/* AFSX Tokens */
> +#define OMAPL_MCASP_PDIR_AFSX_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AFSX_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AHCLKX_MASK (0x08000000u)
> +#define OMAPL_MCASP_PDIR_AHCLKX_SHIFT (0x0000001Bu)
> +#define OMAPL_MCASP_PDIR_AHCLKX_RESETVAL (0x00000000u)
> +/* AHCLKX Tokens */
> +#define OMAPL_MCASP_PDIR_AHCLKX_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AHCLKX_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_ACLKX_MASK (0x04000000u)
> +#define OMAPL_MCASP_PDIR_ACLKX_SHIFT (0x0000001Au)
> +#define OMAPL_MCASP_PDIR_ACLKX_RESETVAL (0x00000000u)
> +/* ACLKX Tokens */
> +#define OMAPL_MCASP_PDIR_ACLKX_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_ACLKX_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AMUTE_MASK (0x02000000u)
> +#define OMAPL_MCASP_PDIR_AMUTE_SHIFT (0x00000019u)
> +#define OMAPL_MCASP_PDIR_AMUTE_RESETVAL (0x00000000u)
> +/* AMUTE Tokens */
> +#define OMAPL_MCASP_PDIR_AMUTE_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AMUTE_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR15_MASK (0x00008000u)
> +#define OMAPL_MCASP_PDIR_AXR15_SHIFT (0x0000000Fu)
> +#define OMAPL_MCASP_PDIR_AXR15_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR15_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR15_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR14_MASK (0x00004000u)
> +#define OMAPL_MCASP_PDIR_AXR14_SHIFT (0x0000000Eu)
> +#define OMAPL_MCASP_PDIR_AXR14_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR14_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR14_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR13_MASK (0x00002000u)
> +#define OMAPL_MCASP_PDIR_AXR13_SHIFT (0x0000000Du)
> +#define OMAPL_MCASP_PDIR_AXR13_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR13_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR13_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR12_MASK (0x00001000u)
> +#define OMAPL_MCASP_PDIR_AXR12_SHIFT (0x0000000Cu)
> +#define OMAPL_MCASP_PDIR_AXR12_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR12_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR12_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR11_MASK (0x00000800u)
> +#define OMAPL_MCASP_PDIR_AXR11_SHIFT (0x0000000Bu)
> +#define OMAPL_MCASP_PDIR_AXR11_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR11_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR11_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR10_MASK (0x00000400u)
> +#define OMAPL_MCASP_PDIR_AXR10_SHIFT (0x0000000Au)
> +#define OMAPL_MCASP_PDIR_AXR10_RESETVAL (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR10_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR10_OUTPUT (0x00000001u)
> +#define OMAPL_MCASP_PDIR_AXR9_MASK (0x00000200u)
> +#define OMAPL_MCASP_PDIR_AXR9_SHIFT (0x00000009u)
> +#define OMAPL_MCASP_PDIR_AXR9_RESETVAL (0x00000000u)
> +/* AXR9 Tokens */
> +#define OMAPL_MCASP_PDIR_AXR9_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR9_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR8_MASK (0x00000100u)
> +#define OMAPL_MCASP_PDIR_AXR8_SHIFT (0x00000008u)
> +#define OMAPL_MCASP_PDIR_AXR8_RESETVAL (0x00000000u)
> +/* AXR8 Tokens */
> +#define OMAPL_MCASP_PDIR_AXR8_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR8_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR7_MASK (0x00000080u)
> +#define OMAPL_MCASP_PDIR_AXR7_SHIFT (0x00000007u)
> +#define OMAPL_MCASP_PDIR_AXR7_RESETVAL (0x00000000u)
> +/*----AXR7 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR7_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR7_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR6_MASK (0x00000040u)
> +#define OMAPL_MCASP_PDIR_AXR6_SHIFT (0x00000006u)
> +#define OMAPL_MCASP_PDIR_AXR6_RESETVAL (0x00000000u)
> +/*----AXR6 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR6_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR6_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR5_MASK (0x00000020u)
> +#define OMAPL_MCASP_PDIR_AXR5_SHIFT (0x00000005u)
> +#define OMAPL_MCASP_PDIR_AXR5_RESETVAL (0x00000000u)
> +/*----AXR5 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR5_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR5_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR4_MASK (0x00000010u)
> +#define OMAPL_MCASP_PDIR_AXR4_SHIFT (0x00000004u)
> +#define OMAPL_MCASP_PDIR_AXR4_RESETVAL (0x00000000u)
> +/*----AXR4 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR4_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR4_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR3_MASK (0x00000008u)
> +#define OMAPL_MCASP_PDIR_AXR3_SHIFT (0x00000003u)
> +#define OMAPL_MCASP_PDIR_AXR3_RESETVAL (0x00000000u)
> +/*----AXR3 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR3_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR3_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR2_MASK (0x00000004u)
> +#define OMAPL_MCASP_PDIR_AXR2_SHIFT (0x00000002u)
> +#define OMAPL_MCASP_PDIR_AXR2_RESETVAL (0x00000000u)
> +/*----AXR2 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR2_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR2_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR1_MASK (0x00000002u)
> +#define OMAPL_MCASP_PDIR_AXR1_SHIFT (0x00000001u)
> +#define OMAPL_MCASP_PDIR_AXR1_RESETVAL (0x00000000u)
> +/*----AXR1 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR1_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR1_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_AXR0_MASK (0x00000001u)
> +#define OMAPL_MCASP_PDIR_AXR0_SHIFT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR0_RESETVAL (0x00000000u)
> +/*----AXR0 Tokens----*/
> +#define OMAPL_MCASP_PDIR_AXR0_INPUT (0x00000000u)
> +#define OMAPL_MCASP_PDIR_AXR0_OUTPUT (0x00000001u)
> +
> +#define OMAPL_MCASP_PDIR_RESETVAL (0x00000000u)
> +
> +#define OMAPL_MCASP_ACLKXCTL_CLKXP_MASK (0x00000080u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXP_SHIFT (0x00000007u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXP_RESETVAL (0x00000000u)
> +/*----CLKXP Tokens----*/
> +#define OMAPL_MCASP_ACLKXCTL_CLKXP_RISINGEDGE (0x00000000u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXP_FALLINGEDGE (0x00000001u)
> +
> +#define OMAPL_MCASP_ACLKXCTL_ASYNC_MASK (0x00000040u)
> +#define OMAPL_MCASP_ACLKXCTL_ASYNC_SHIFT (0x00000006u)
> +#define OMAPL_MCASP_ACLKXCTL_ASYNC_RESETVAL (0x00000001u)
> +/*----ASYNC Tokens----*/
> +#define OMAPL_MCASP_ACLKXCTL_ASYNC_SYNC (0x00000000u)
> +#define OMAPL_MCASP_ACLKXCTL_ASYNC_ASYNC (0x00000001u)
> +
> +#define OMAPL_MCASP_ACLKXCTL_CLKXM_MASK (0x00000020u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXM_SHIFT (0x00000005u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXM_RESETVAL (0x00000001u)
> +/*----CLKXM Tokens----*/
> +#define OMAPL_MCASP_ACLKXCTL_CLKXM_EXTERNAL (0x00000000u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXM_INTERNAL (0x00000001u)
> +
> +#define OMAPL_MCASP_ACLKXCTL_CLKXDIV_MASK (0x0000001Fu)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXDIV_SHIFT (0x00000000u)
> +#define OMAPL_MCASP_ACLKXCTL_CLKXDIV_RESETVAL (0x00000000u)
> +
> +#define OMAPL_MCASP_ACLKXCTL_RESETVAL (0x00000060u)
> +
> +/* AHCLKXCTL */
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXM_MASK (0x00008000u)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXM_SHIFT (0x0000000Fu)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXM_RESETVAL (0x00000001u)
> +/*----HCLKXM Tokens----*/
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXM_EXTERNAL (0x00000000u)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXM_INTERNAL (0x00000001u)
> +
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXP_MASK (0x00004000u)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXP_SHIFT (0x0000000Eu)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXP_RESETVAL (0x00000000u)
> +/*----HCLKXP Tokens----*/
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXP_NOTINVERTED (0x00000000u)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXP_INVERTED (0x00000001u)
> +
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_MASK (0x00000FFFu)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_SHIFT (0x00000000u)
> +#define OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_RESETVAL (0x00000000u)
> +
> +#define OMAPL_MCASP_AHCLKXCTL_RESETVAL (0x00008000u)
> +
> +#define MCASP_SUART_GBLCTL (0X00000000)
> +#define MCASP_SUART_RGBLCTL (0X00000000)
> +#define MCASP_SUART_XGBLCTL (0X00000000)
> +#define MCASP_SUART_RMASK_8 (0x000000FF)
> +#define MCASP_SUART_RMASK_16 (0x0000FFFF)
> +#define MCASP_SUART_RFMT_8 (0x0000A038)
> +#define MCASP_SUART_RFMT_16 (0x0000A078)
> +#define MCASP_SUART_FSRM (0X00000002)
> +#define MCASP_SUART_CLKRM_CLKRP (0X000000A0)
> +#define MCASP_SUART_HCLKRP (0X00008000)
> +#define MCASP_SUART_RTDMS0 (0X00000001)
> +#define MCASP_SUART_RSYNCERR (0X00000002)
> +#define MCASP_SUART_RMAX_RPS_256 (0x00FF0008)
> +#define MCASP_SUART_XMASK_0_31 (0X0000FFFF)
> +#define MCASP_SUART_XBUSEL_XSSZ_16_XPAD_0 (0x00002078)
> +#define MCASP_SUART_FSXM (0x00000002)
> +#define MCASP_SUART_CLKXM_ASYNC_CLKXP (0x000000E0)
> +#define MCASP_SUART_HCLKXM (0x00008000)
> +#define MCASP_SUART_XTDMS0 (0X00000001)
> +#define MCASP_SUART_XSYNCERR (0x00000002)
> +#define MCASP_SUART_XMAX_XPS_256 (0x00FF0008)
> +#define MCASP_SUART_SRCTL_DISMOD (0x0000000c)
> +#define MCASP_SUART_DIT_DISABLE (0X00000000)
> +#define MCASP_SUART_LOOPBACK_DISABLE (0x00000000)
> +#define MCASP_SUART_AMUTE_DISABLE (0X00000000)
> +#define MCASP_SUART_XSTAT (0x0000FFFF)
> +#define MCASP_SUART_RSTAT (0x0000FFFF)
> +
> +/* SUART REGS */
> +
> +/* PRU0 DATA RAM base address */
> +#define PRU0_DATARAM_OFFSET (0x0000u)
> +/* PRU1 DATA RAM base address */
> +#define PRU1_DATARAM_OFFSET (0x2000u)
> +
> +/* PRU0 DATA RAM size */
> +#define PRU0_DATARAM_SIZE (0x200u)
> +/* PRU1 DATA RAM size */
> +#define PRU1_DATARAM_SIZE (0x200u)
> +
> +#define PRU_SUART_PRU0_CH0_OFFSET (0x0000)
> +#define PRU_SUART_PRU0_CH1_OFFSET (0x0010)
> +#define PRU_SUART_PRU0_CH2_OFFSET (0x0020)
> +#define PRU_SUART_PRU0_CH3_OFFSET (0x0030)
> +#define PRU_SUART_PRU0_CH4_OFFSET (0x0040)
> +#define PRU_SUART_PRU0_CH5_OFFSET (0x0050)
> +#define PRU_SUART_PRU0_CH6_OFFSET (0x0060)
> +#define PRU_SUART_PRU0_CH7_OFFSET (0x0070)
> +#define PRU_SUART_PRU0_IMR_OFFSET (0x0080)
> +/* Interrupt Mask Register */
> +#define PRU_SUART_PRU0_ISR_OFFSET (0x0082)
> +/* Interrupt Status Register */
> +#define PRU_SUART_PRU0_ID_ADDR (0x0084)
> +/* PRU ID Register */
> +#define PRU_SUART_PRU0_RX_TX_MODE (0x0085)
> +#define PRU_SUART_PRU0_DELAY_OFFSET (0x0086)
> +#define PRU_SUART_PRU0_IDLE_TIMEOUT_OFFSET (0x0088)
> +
> +/* PRU 1 Macros */
> +#define PRU_SUART_PRU1_CH0_OFFSET (0x2000)
> +#define PRU_SUART_PRU1_CH1_OFFSET (0x2010)
> +#define PRU_SUART_PRU1_CH2_OFFSET (0x2020)
> +#define PRU_SUART_PRU1_CH3_OFFSET (0x2030)
> +#define PRU_SUART_PRU1_CH4_OFFSET (0x2040)
> +#define PRU_SUART_PRU1_CH5_OFFSET (0x2050)
> +#define PRU_SUART_PRU1_CH6_OFFSET (0x2060)
> +#define PRU_SUART_PRU1_CH7_OFFSET (0x2070)
> +#define PRU_SUART_PRU1_IMR_OFFSET (0x2080)
> +#define PRU_SUART_PRU1_ISR_OFFSET (0x2082)
> +#define PRU_SUART_PRU1_ID_ADDR (0x2084)
> +#define PRU_SUART_PRU1_RX_TX_MODE (0x2085)
> +#define PRU_SUART_PRU1_DELAY_OFFSET (0x2086)
> +#define PRU_SUART_PRU1_IDLE_TIMEOUT_OFFSET (0x2088)
> +
> +/* SUART Channel Control Register bit descriptions */
> +#define PRU_SUART_CH_CTRL_MODE_SHIFT 0x0000
> +#define PRU_SUART_CH_CTRL_MODE_MASK 0x0003
> +#define PRU_SUART_CH_CTRL_TX_MODE 0x0001
> +#define PRU_SUART_CH_CTRL_RX_MODE 0x0002
> +
> +/* Service Request */
> +#define PRU_SUART_CH_CTRL_SREQ_SHIFT 0x0002
> +#define PRU_SUART_CH_CTRL_SREQ_MASK 0x0004
> +#define PRU_SUART_CH_CTRL_SREQ 0x0001
> +
> +/* McASP Instance */
> +#define PRU_SUART_CH_CTRL_MCASP_SHIFT 0x0003
> +#define PRU_SUART_CH_CTRL_MCASP_MASK 0x0018
> +#define PRU_SUART_CH_CTRL_SR_SHIFT 0x0008
> +#define PRU_SUART_CH_CTRL_SR_MASK 0x0F00
> +
> +/* SUART channel configuration1 register descriptions */
> +
> +/* clock divisor -  relative baud value */
> +#define PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT 0x0000
> +#define PRU_SUART_CH_CONFIG1_DIVISOR_MASK 0x03FF
> +/* oversampling */
> +#define PRU_SUART_CH_CONFIG1_OVS_SHIFT 0x000A
> +#define PRU_SUART_CH_CONFIG1_OVS_MASK 0x0C00
> +
> +/* SUART channel configuration2 register descriptions */
> +/* Bits per character */
> +#define PRU_SUART_CH_CONFIG2_BITPERCHAR_SHIFT 0x0000
> +#define PRU_SUART_CH_CONFIG2_BITPERCHAR_MASK 0x000F
> +
> +/* Bits per character */
> +#define PRU_SUART_CH_CONFIG2_DATALEN_SHIFT 0x0008
> +#define PRU_SUART_CH_CONFIG2_DATALEN_MASK 0x0F00
> +
> +/* SUART Channel STATUS Register*/
> +#define PRU_SUART_CH_STATUS_EN_BIT_MASK 0x8000
> +
> +/* SUART Channel register offsets */
> +#define PRU_SUART_CH_CTRL_OFFSET 0x00
> +#define PRU_SUART_CH_CONFIG1_OFFSET 0x02
> +#define PRU_SUART_CH_CONFIG2_OFFSET 0x04
> +#define PRU_SUART_CH_TXRXSTATUS_OFFSET 0x06
> +#define PRU_SUART_CH_TXRXDATA_OFFSET 0x08
> +#define PRU_SUART_CH_BYTESDONECNTR_OFFSET 0x0C
> +
> +/* SUART Event Numbers macros */
> +#define PRU_SUART0_TX_EVT 34
> +#define PRU_SUART0_RX_EVT 35
> +#define PRU_SUART1_TX_EVT 36
> +#define PRU_SUART1_RX_EVT 37
> +#define PRU_SUART2_TX_EVT 38
> +#define PRU_SUART2_RX_EVT 39
> +#define PRU_SUART3_TX_EVT 40
> +#define PRU_SUART3_RX_EVT 41
> +#define PRU_SUART4_TX_EVT 42
> +#define PRU_SUART4_RX_EVT 43
> +#define PRU_SUART5_TX_EVT 44
> +#define PRU_SUART5_RX_EVT 45
> +#define PRU_SUART6_TX_EVT 46
> +#define PRU_SUART6_RX_EVT 47
> +#define PRU_SUART7_TX_EVT 48
> +#define PRU_SUART7_RX_EVT 49
> +
> +#define PRU_SUART0_TX_EVT_BIT BIT(2)
> +#define PRU_SUART0_RX_EVT_BIT BIT(3)
> +#define PRU_SUART1_TX_EVT_BIT BIT(4)
> +#define PRU_SUART1_RX_EVT_BIT BIT(5)
> +#define PRU_SUART2_TX_EVT_BIT BIT(6)
> +#define PRU_SUART2_RX_EVT_BIT BIT(7)
> +#define PRU_SUART3_TX_EVT_BIT BIT(8)
> +#define PRU_SUART3_RX_EVT_BIT BIT(9)
> +#define PRU_SUART4_TX_EVT_BIT BIT(10)
> +#define PRU_SUART4_RX_EVT_BIT BIT(11)
> +#define PRU_SUART5_TX_EVT_BIT BIT(12)
> +#define PRU_SUART5_RX_EVT_BIT BIT(13)
> +#define PRU_SUART6_TX_EVT_BIT BIT(14)
> +#define PRU_SUART6_RX_EVT_BIT BIT(15)
> +#define PRU_SUART7_TX_EVT_BIT BIT(16)
> +#define PRU_SUART7_RX_EVT_BIT BIT(17)
> +
> +/* Total number of baud rates supported */
> +#define SUART_NUM_OF_BAUDS_SUPPORTED 13
> +
> +#define MCASP_PDIR_VAL ( \
> + OMAPL_MCASP_PDIR_AFSR_OUTPUT<<OMAPL_MCASP_PDIR_AFSR_SHIFT | \
> + OMAPL_MCASP_PDIR_AHCLKR_OUTPUT<<OMAPL_MCASP_PDIR_AHCLKR_SHIFT | \
> + OMAPL_MCASP_PDIR_ACLKR_OUTPUT<<OMAPL_MCASP_PDIR_ACLKR_SHIFT | \
> + OMAPL_MCASP_PDIR_AFSX_OUTPUT<<OMAPL_MCASP_PDIR_AFSX_SHIFT | \
> + OMAPL_MCASP_PDIR_AHCLKX_OUTPUT<<OMAPL_MCASP_PDIR_AHCLKX_SHIFT | \
> + OMAPL_MCASP_PDIR_ACLKX_OUTPUT<<OMAPL_MCASP_PDIR_ACLKX_SHIFT)
> +
> +/*
> + *  This enum is used to specify the direction of the channel in UART
> + */
> +enum SUART_CHN_DIR {
> + SUART_CHN_TX = 1,
> + SUART_CHN_RX = 2
> +};
> +
> +/*
> + *  This enum is used to specify the state of the channel in UART. It
> + *  is either enabled or disabled.
> + */
> +enum SUART_CHN_STATE {
> + SUART_CHN_DISABLED = 0,
> + SUART_CHN_ENABLED = 1
> +};
> +
> +enum SUART_EN_BITSPERCHAR {
> + ePRU_SUART_DATA_BITS6 = 8,
> + ePRU_SUART_DATA_BITS7,
> + ePRU_SUART_DATA_BITS8,
> + ePRU_SUART_DATA_BITS9,
> + ePRU_SUART_DATA_BITS10,
> + ePRU_SUART_DATA_BITS11,
> + ePRU_SUART_DATA_BITS12
> +};
> +
> +enum SUART_EN_UARTNUM {
> + ePRU_SUART_NUM_1 = 1,
> + ePRU_SUART_NUM_2,
> + ePRU_SUART_NUM_3,
> + ePRU_SUART_NUM_4,
> + ePRU_SUART_NUM_5,
> + ePRU_SUART_NUM_6,
> + ePRU_SUART_NUM_7,
> + ePRU_SUART_NUM_8
> +};
> +
> +enum SUART_EN_UARTTYPE {
> + ePRU_SUART_HALF_TX = 1,
> + ePRU_SUART_HALF_RX,
> + ePRU_SUART_FULL_TX_RX,
> + ePRU_SUART_HALF_TX_DISABLED = 4,
> + ePRU_SUART_HALF_RX_DISABLED = 8
> +};
> +
> +enum SUART_EN_TXCHANNEL {
> + ePRU_SUART_TX_CH0 = 0,
> + ePRU_SUART_TX_CH1,
> + ePRU_SUART_TX_CH2,
> + ePRU_SUART_TX_CH3,
> + ePRU_SUART_TX_CH4,
> + ePRU_SUART_TX_CH5,
> + ePRU_SUART_TX_CH6,
> + ePRU_SUART_TX_CH7
> +};
> +
> +enum SUART_EN_RXCHANNEL {
> + ePRU_SUART_RX_CH0 = 0,
> + ePRU_SUART_RX_CH1,
> + ePRU_SUART_RX_CH2,
> + ePRU_SUART_RX_CH3,
> + ePRU_SUART_RX_CH4,
> + ePRU_SUART_RX_CH5,
> + ePRU_SUART_RX_CH6,
> + ePRU_SUART_RX_CH7
> +};
> +
> +enum SUART_EN_UART_STATUS {
> + ePRU_SUART_UART_FREE = 0,
> + ePRU_SUART_UART_IN_USE
> +};
> +
> +struct pru_suart_cnh_cntrl_config1 {
> + u32 mode:2;
> + u32 service_req:1;
> + u32 asp_id:2;
> + u32 reserved1:3;
> + u32 serializer_num:4;
> + u32 reserved2:4;
> + u32 presacler:10;
> + u32 over_sampling:2;
> + u32 framing_mask:1;
> + u32 break_mask:1;
> + u32 timeout_mask:1;
> + u32 reserved3:1;
> +};
> +
> +struct pru_suart_chn_config2_status {
> + u32 bits_per_char:4;
> + u32 reserved1:4;
> + u32 data_len:4;
> + u32 reserved2:4;
> + u32 txrx_ready:1;
> + u32 txrx_complete:1;
> + u32 txrx_error:1;
> + u32 txrx_underrun:1;
> + u32 framing_error:1;
> + u32 break_error:1;
> + u32 timeout_error:1;
> + u32 reserved3:8;
> + u32 chn_state:1;
> +};
> +
> +struct pru_suart_regs_ovly {
> + struct pru_suart_cnh_cntrl_config1 ch_ctrl_config1;
> + struct pru_suart_chn_config2_status ch_config2_txrx_status;
> + u32 ch_txrx_data;
> + u32 reserved1;
> +};
> +
> +struct pru_suart_tx_cntx_priv {
> + u32 asp_xsrctl_base;
> + u32 asp_xbuf_base;
> + u16 buff_addr;
> + u8 buff_size;
> + u8 bits_loaded;
> +};
> +
> +struct pru_suart_rx_cntx_priv {
> + u32 asp_rbuf_base;
> + u32 asp_rsrctl_base;
> + u32 reserved1;
> + u32 reserved2;
> + u32 reserved3;
> + u32 reserved4;
> +};
> +
> +struct suart_config {
> + u8  tx_serializer;
> + u8  rx_serializer;
> + u16 tx_clk_divisor;
> + u16 rx_clk_divisor;
> + u8  tx_bits_per_char;
> + u8  rx_bits_per_char;
> + u8  oversampling;
> + u8  bi_inter_mask;
> + u8  fe_intr_mask;
> +};
> +
> +struct suart_handle {
> + u16 uart_num;
> + u16 uart_type;
> + u16 uart_tx_channel;
> + u16 uart_rx_channel;
> + u16 uart_status;
> +};
> +
> +struct pruss_suart_iomap {
> + void __iomem *mcasp_io_addr;
> + void *p_fifo_buff_phys_base;
> + void *p_fifo_buff_virt_base;
> +};
> +
> +struct pruss_suart_initparams {
> + u32 tx_baud_value;
> + u32 rx_baud_value;
> + u32 oversampling;
> +};
> +
> +/* MCASP */
> +struct omapl_mcasp_regs_ovly {
> + u32 revid;
> + u32 rsvd0[3];
> + u32 pfunc;
> + u32 pdir;
> + u32 pdout;
> + u32 pdin;
> + u32 pdclr;
> + u32 rsvd1[8];
> + u32 gblctl;
> + u32 amute;
> + u32 dlbctl;
> + u32 ditctl;
> + u32 rsvd2[3];
> + u32 rgblctl;
> + u32 rmask;
> + u32 rfmt;
> + u32 afsrctl;
> + u32 aclkrctl;
> + u32 ahclkrctl;
> + u32 rtdm;
> + u32 rintctl;
> + u32 rstat;
> + u32 rslot;
> + u32 rclkchk;
> + u32 revtctl;
> + u32 rsvd3[4];
> + u32 xgblctl;
> + u32 xmask;
> + u32 xfmt;
> + u32 afsxctl;
> + u32 aclkxctl;
> + u32 ahclkxctl;
> + u32 xtdm;
> + u32 xintctl;
> + u32 xstat;
> + u32 xslot;
> + u32 xclkchk;
> + u32 xevtctl;
> + u32 rsvd4[12];
> + u32 ditcsra[6];
> + u32 ditcsrb[6];
> + u32 ditudra[6];
> + u32 ditudrb[6];
> + u32 rsvd5[8];
> + u32 srctl0;
> + u32 srctl1;
> + u32 srctl2;
> + u32 srctl3;
> + u32 srctl4;
> + u32 srctl5;
> + u32 srctl6;
> + u32 srctl7;
> + u32 srctl8;
> + u32 srctl9;
> + u32 srctl10;
> + u32 srctl11;
> + u32 srctl12;
> + u32 srctl13;
> + u32 srctl14;
> + u32 srctl15;
> + u32 rsvd6[16];
> + u32 xbuf[16];
> + u32 rsvd7[16];
> + u32 rbuf[16];
> +};
> +
> +/*
> + *  SUART Config regs
> + */
> +struct suart_struct_pru_regs {
> + u16 chn_ctrl;
> + u16 chn_config1;
> + u16 chn_config2;
> + u16 chn_txrx_status;
> + u32 chn_txrx_data;
> +};
> +
> +extern s32 pru_softuart_init(struct device *dev,
> + struct pruss_suart_initparams *,
> + const u8 *pru_suart_emu_code, u32 fw_size,
> + u32 clk_rate_pruss,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +
> +extern s32 pru_softuart_open(struct suart_handle *h_suart);
> +
> +extern s32 pru_softuart_close(struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_setbaud(struct device *dev,
> + struct suart_handle *h_uart,
> + u16 tx_clk_divisor, u16 rx_clk_divisor);
> +
> +extern s32 pru_softuart_setdatabits(struct device *dev,
> + struct suart_handle *h_uart,
> + u16 tx_data_bits, u16 rx_data_bits);
> +
> +extern s32 pru_softuart_setconfig(struct device *dev,
> + struct suart_handle *h_uart,
> + struct suart_config *config_uart);
> +
> +extern s32 pru_softuart_getconfig(struct device *dev,
> + struct suart_handle *h_uart,
> + struct suart_config *config_uart);
> +
> +extern s32 pru_softuart_pending_tx_request(struct device *dev);
> +
> +extern s32 pru_softuart_write(struct device *dev,
> + struct suart_handle *h_uart,
> + u32 *pt_tx_data_buf, u16 data_len);
> +
> +extern s32 pru_softuart_read(struct device *dev,
> + struct suart_handle *h_uart,
> + u32 *pt_data_buf, u16 data_len);
> +
> +extern s32 suart_intr_clrmask(struct device *dev, u16 uart_num,
> + u32 txrxmode,
> + u32 intrmask);
> +
> +extern s32 pru_softuart_clr_tx_status(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_get_tx_status(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_clr_rx_status(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_get_rx_status(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_get_isrstatus(struct device *dev, u16 uart_num,
> + u16 *txrx_flag);
> +
> +extern s32 pru_intr_clr_isrstatus(struct device *dev, u16 uart_num,
> + u32 txrxmode);
> +
> +extern s32 suart_intr_getmask(struct device *dev, u16 uart_num,
> + u32 txrxmode,
> + u32 intrmask);
> +
> +extern s32 suart_intr_setmask(struct device *dev, u16 uart_num,
> + u32 txrxmode, u32 intrmask);
> +
> +extern s32 pru_softuart_get_tx_data_len(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 pru_softuart_get_rx_data_len(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 suart_arm_to_pru_intr(struct device *dev, u16 uart_num);
> +
> +extern void pru_mcasp_deinit(void);
> +
> +extern s32 pru_softuart_read_data(struct device *dev,
> + struct suart_handle *h_uart,
> + u8 *p_data_buffer, s32 max_len,
> + u32 *pdata_read);
> +
> +extern s32 pru_softuart_stop_receive(struct device *dev,
> + struct suart_handle *h_uart);
> +
> +extern s32 suart_pru_to_host_intr_enable(struct device *dev,
> + u16 uart_num,
> + u32 txrxmode, s32 flag);
> +
> +extern void pru_set_fifo_timeout(struct device *dev, s16 timeout);
> +
> +extern void suart_mcasp_config(u32 tx_baud_value,
> + u32 rx_baud_value, u32 oversampling,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +
> +extern void suart_mcasp_reset(struct pruss_suart_iomap *pruss_ioaddr);
> +
> +extern short suart_asp_baud_set(u32 tx_baud_value,
> + u32 rx_baud_value, u32 oversampling,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +
> +extern short suart_asp_serializer_deactivate(u16 sr_num,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +
> +extern void suart_mcasp_tx_serialzier_set(u32 serializer_num,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +#endif
> diff --git a/drivers/tty/serial/pruss_suart_api.c 
> b/drivers/tty/serial/pruss_suart_api.c
> new file mode 100644
> index 0000000..15178f5
> --- /dev/null
> +++ b/drivers/tty/serial/pruss_suart_api.c
> @@ -0,0 +1,1710 @@
> +/*
> + * Copyright (C) 2010, 2011 Texas Instruments Incorporated
> + * Author: Jitendra Kumar <jitendra@mistralsolutions.com>
> + *
> + * This program is free software; you can redistribute it and/or modify 
> it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/mfd/pruss.h>
> +#include "pruss_suart.h"
> +
> +static u8 uart_statu_table[8];
> +static struct pruss_suart_iomap suart_iomap;
> +
> +static u32 uart_rx[8] = {PRU_SUART0_CONFIG_RX_SER, 
> PRU_SUART1_CONFIG_RX_SER,
> + PRU_SUART2_CONFIG_RX_SER, PRU_SUART3_CONFIG_RX_SER,
> + PRU_SUART4_CONFIG_RX_SER, PRU_SUART5_CONFIG_RX_SER,
> + PRU_SUART6_CONFIG_RX_SER, PRU_SUART7_CONFIG_RX_SER};
> +
> +static u32 uart_tx[8] = {PRU_SUART0_CONFIG_TX_SER, 
> PRU_SUART1_CONFIG_TX_SER,
> + PRU_SUART2_CONFIG_TX_SER, PRU_SUART3_CONFIG_TX_SER,
> + PRU_SUART4_CONFIG_TX_SER, PRU_SUART5_CONFIG_TX_SER,
> + PRU_SUART6_CONFIG_TX_SER, PRU_SUART7_CONFIG_TX_SER};
> +
> +static u32 uart_config[8] = {PRU_SUART0_CONFIG_DUPLEX, 
> PRU_SUART1_CONFIG_DUPLEX,
> + PRU_SUART2_CONFIG_DUPLEX, PRU_SUART3_CONFIG_DUPLEX,
> + PRU_SUART4_CONFIG_DUPLEX, PRU_SUART5_CONFIG_DUPLEX,
> + PRU_SUART6_CONFIG_DUPLEX, PRU_SUART7_CONFIG_DUPLEX};
> +
> +static  s32 pru_softuart_clr_rx_fifo(struct device *dev,
> + struct suart_handle *h_uart);
> +static s32 arm_to_pru_intr_init(struct device *dev);
> +
> +#if (PRU_ACTIVE == BOTH_PRU)
> +static void pru_set_ram_data(struct device *dev,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + u32 datatowrite;
> + u32 i;
> + struct pru_suart_regs_ovly *pru_suart_regs = NULL;
> + u32 __iomem *p_sr_ctl_addr = (u32 __iomem *)(pruss_ioaddr->
> + mcasp_io_addr + 0x180);
> + struct pru_suart_tx_cntx_priv *pru_suart_tx_priv = NULL;
> + struct pru_suart_rx_cntx_priv *pru_suart_rx_priv = NULL;
> +
> + /* RX PRU - 0 Chanel 0-7 context information */
> + for (i = 0; i < 8; i++, pru_suart_regs++) {
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + 0x3, SUART_CHN_RX);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0xF << SERIALIZER_OFFSET),
> + ((0xF & uart_rx[i]) << SERIALIZER_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0x3 << SUART_DEFAULT_OVRSMPL_OFFSET),
> + (SUART_DEFAULT_OVRSMPL <<
> + SUART_DEFAULT_OVRSMPL_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_config2_txrx_status,
> + 0xF, 8);
> + if ((uart_config[i] & PRU_SUART_HALF_RX_DISABLED) ==
> + PRU_SUART_HALF_RX_DISABLED) {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_DISABLED << SUART_CHN_OFFSET));
> + } else {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_ENABLED << SUART_CHN_OFFSET));
> + iowrite32(MCASP_SRCTL_RX_MODE, p_sr_ctl_addr +
> + uart_rx[i]);
> + }
> + /*
> + * RX is active by default, write the dummy received data at
> + * PRU RAM addr 0x1FC to avoid memory corruption.
> + */
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_txrx_data,
> + 0xFFFF, RX_DEFAULT_DATA_DUMP_ADDR);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->reserved1, 0xFFFF, 0);
> + /* SUART1 RX context base addr */
> + pru_suart_rx_priv = (struct pru_suart_rx_cntx_priv *)
> + (PRU0_DATARAM_OFFSET + (0x090 + (i * 0x020)));
> + datatowrite = (MCASP_RBUF_BASE_ADDR + (uart_rx[i] << 2));
> + pruss_writel(dev, (u32) &pru_suart_rx_priv->asp_rbuf_base,
> + datatowrite);
> + datatowrite = (MCASP_SRCTL_BASE_ADDR + (uart_rx[i] << 2));
> + pruss_writel(dev, (u32) &pru_suart_rx_priv->asp_rsrctl_base,
> + datatowrite);
> + }
> +
> + /* PRU1 RAM BASE ADDR */
> + pru_suart_regs = (struct pru_suart_regs_ovly *) PRU1_DATARAM_OFFSET;
> +
> + /* TX PRU - 1 */
> + /* Channel 0-7 context information */
> + for (i = 0; i < 8; i++, pru_suart_regs++) {
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + 0x3, SUART_CHN_TX);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0xF << SERIALIZER_OFFSET),
> + ((0xF & uart_tx[i]) << SERIALIZER_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0x3 << SUART_DEFAULT_OVRSMPL_OFFSET),
> + (SUART_DEFAULT_OVRSMPL <<
> + SUART_DEFAULT_OVRSMPL_OFFSET));
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status, 0xF, 8);
> +
> + if ((uart_config[i] & PRU_SUART_HALF_TX_DISABLED) ==
> + PRU_SUART_HALF_TX_DISABLED) {
> + pruss_rmwl(dev, (u32)
> + &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_DISABLED << SUART_CHN_OFFSET));
> + } else {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_ENABLED << SUART_CHN_OFFSET));
> + iowrite32(MCASP_SRCTL_TX_MODE,
> + p_sr_ctl_addr + uart_tx[i]);
> + }
> + pruss_rmwl(dev, (u32) &pru_suart_regs->reserved1, 0xFFFF, 1);
> +
> + /* SUART1 TX context base addr */
> + pru_suart_tx_priv = (struct pru_suart_tx_cntx_priv *)
> + (PRU1_DATARAM_OFFSET + (0x0B0 + (i * 0x02C)));
> + datatowrite = (MCASP_SRCTL_BASE_ADDR + (uart_tx[i] << 2));
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->asp_xsrctl_base,
> + datatowrite);
> + datatowrite = (MCASP_XBUF_BASE_ADDR + (uart_tx[i] << 2));
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->asp_xbuf_base,
> + datatowrite);
> + /* SUART1 TX formatted data base addr */
> + datatowrite = (0x0090 + (i * 0x002C));
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->buff_addr,
> + datatowrite);
> + }
> +}
> +#else
> +static void pru_set_ram_data(struct device *dev,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> +
> + struct pru_suart_regs_ovly *pru_suart_regs =
> + (struct pru_suart_regs_ovly *)pruss_ioaddr->pru_io_addr;
> + u32 i;
> + u32 *p_sr_ctl_addr = (u32 *)(pruss_ioaddr->mcasp_io_addr + 0x180);
> + struct pru_suart_tx_cntx_priv *pru_suart_tx_priv = NULL;
> + struct pru_suart_rx_cntx_priv *pru_suart_rx_priv = NULL;
> +
> + /* Channel 0 context information is Tx */
> + for (i = 0; i < 4; i++, pru_suart_regs++) {
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + 0x3, SUART_CHN_TX);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0xF << SERIALIZER_OFFSET),
> + ((0xF & uart_tx[i]) << SERIALIZER_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0x3 << SUART_DEFAULT_OVRSMPL_OFFSET),
> + (SUART_DEFAULT_OVRSMPL <<
> + SUART_DEFAULT_OVRSMPL_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_config2_txrx_status,
> + 0xF, 8);
> + if ((uart_config[i] & PRU_SUART_HALF_TX_DISABLED) ==
> + PRU_SUART_HALF_TX_DISABLED){
> + pruss_rmwl(dev, (u32)
> + &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_DISABLED << SUART_CHN_OFFSET));
> + } else {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_ENABLED << SUART_CHN_OFFSET));
> + iowrite32(MCASP_SRCTL_TX_MODE,
> + p_sr_ctl_addr + uart_tx[i]);
> + }
> + pruss_rmwl(dev, (u32) &pru_suart_regs->reserved1, 0xFFFF, 1);
> +
> + /* SUART1 TX context base addr */
> + pru_suart_tx_priv = (struct pru_suart_tx_cntx_priv *)
> + (PRU0_DATARAM_OFFSET + (0x0B0 + (i * 0x50)));
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->asp_xsrctl_base,
> + (MCASP_SRCTL_BASE_ADDR + (uart_tx[i] << 2)));
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->asp_xbuf_base,
> + (MCASP_XBUF_BASE_ADDR + (uart_tx[i] << 2)));
> + /* SUART1 TX formatted data base addr */
> + pruss_writel(dev, (u32) &pru_suart_tx_priv->buff_addr,
> + (0x0090 + (i * 0x050)));
> +
> + /* Channel 1 is Rx context information */
> + pru_suart_regs++;
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + 0x3, SUART_CHN_RX);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0xF << SERIALIZER_OFFSET),
> + ((0xF & uart_rx[i]) << SERIALIZER_OFFSET));
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_ctrl_config1,
> + (0x3 << SUART_DEFAULT_OVRSMPL_OFFSET),
> + (SUART_DEFAULT_OVRSMPL <<
> + SUART_DEFAULT_OVRSMPL_OFFSET));
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status, 0xF, 8);
> +
> + if ((uart_config[i] & PRU_SUART_HALF_RX_DISABLED) ==
> + PRU_SUART_HALF_RX_DISABLED) {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_DISABLED << SUART_CHN_OFFSET));
> + } else {
> + pruss_rmwl(dev,
> + (u32) &pru_suart_regs->ch_config2_txrx_status,
> + (0x1 << SUART_CHN_OFFSET),
> + (SUART_CHN_ENABLED << SUART_CHN_OFFSET));
> + iowrite32(MCASP_SRCTL_RX_MODE,
> + p_sr_ctl_addr + uart_rx[i]);
> + }
> + /*
> + * RX is active by default, write the dummy received data
> + * at PRU RAM addr 0x1FC to avoid memory corruption
> + */
> + pruss_rmwl(dev, (u32) &pru_suart_regs->ch_txrx_data,
> + 0xFFFF, RX_DEFAULT_DATA_DUMP_ADDR);
> + pruss_rmwl(dev, (u32) &pru_suart_regs->reserved1, 0xFFFF, 0);
> + /* SUART1 RX context base addr */
> + pru_suart_rx_priv = (struct pru_suart_rx_cntx_priv *)
> + (PRU0_DATARAM_OFFSET + (0x0C0 + (i * 0x50)));
> + pruss_writel(dev, (u32) &pru_suart_rx_priv->asp_rbuf_base,
> + (MCASP_RBUF_BASE_ADDR + (uart_rx[i] << 2)));
> + pruss_writel(dev, (u32) &pru_suart_rx_priv->asp_rsrctl_base,
> + (MCASP_SRCTL_BASE_ADDR + (uart_rx[i] << 2)));
> + }
> +}
> +#endif
> +
> +static void pru_set_rx_tx_mode(struct device *dev, u32 pru_mode, u32 
> pru_num)
> +{
> + u32 pru_offset;
> +
> + if (pru_num == PRUSS_NUM0)
> + pru_offset = PRU_SUART_PRU0_RX_TX_MODE;
> + else if (pru_num == PRUSS_NUM1)
> + pru_offset = PRU_SUART_PRU1_RX_TX_MODE;
> + else
> + return;
> + pruss_writeb(dev, pru_offset, (u8) pru_mode);
> +}
> +
> +static void pru_set_delay_count(struct device *dev, u32 pru_freq)
> +{
> + u32 delay_cnt;
> +
> + if (pru_freq == PRU_CLK_228)
> + delay_cnt = 5;
> + else if (pru_freq == PRU_CLK_186)
> + delay_cnt = 5;
> + else
> + delay_cnt = 3;
> +
> + /* PRU 0 */
> + pruss_writeb(dev, PRU_SUART_PRU0_DELAY_OFFSET,
> + (u8) delay_cnt);
> +
> + /* PRU 1 */
> + pruss_writeb(dev, PRU_SUART_PRU1_DELAY_OFFSET,
> + (u8) delay_cnt);
> +}
> +
> +static s32 suart_set_pru_id(struct device *dev, u32 pru_no)
> +{
> + u32 offset;
> + u8 reg_val = 0;
> +
> + if (PRUSS_NUM0 == pru_no)
> + offset = PRU_SUART_PRU0_ID_ADDR;
> + else if (PRUSS_NUM1 == pru_no)
> + offset = PRU_SUART_PRU1_ID_ADDR;
> + else
> + return -EINVAL;
> +
> + reg_val = pru_no;
> + pruss_writeb(dev, offset, reg_val);
> +
> + return 0;
> +}
> +
> +/*
> + * suart Initialization routine
> + */
> +s32 pru_softuart_init(struct device *dev,
> + struct pruss_suart_initparams *init_params,
> + const u8 *pru_suart_emu_code, u32 fw_size,
> + u32 clk_rate_pruss,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + u32 datatowrite[128] = {0};
> + s16 status = 0;
> + s16 idx;
> + s16 retval;
> + u16 i;
> +
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) &&
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH))
> + return -EINVAL;
> +
> + suart_iomap.mcasp_io_addr = pruss_ioaddr->mcasp_io_addr;
> + suart_iomap.p_fifo_buff_phys_base =
> + pruss_ioaddr->p_fifo_buff_phys_base;
> + suart_iomap.p_fifo_buff_virt_base =
> + pruss_ioaddr->p_fifo_buff_virt_base;
> + /* Configure McASP0  */
> + suart_mcasp_config(init_params->tx_baud_value,
> + init_params->rx_baud_value,
> + init_params->oversampling, pruss_ioaddr);
> + pruss_enable(dev, PRUSS_NUM0);
> +
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + pruss_enable(dev, PRUSS_NUM1);
> +
> + /* Reset PRU RAM */
> + for (i = 0; i < (PRU0_DATARAM_SIZE / sizeof(int)); i++)
> + pruss_writel(dev, (PRU0_DATARAM_OFFSET + (i * sizeof(int))),
> + datatowrite[i]);
> + if (PRU1_MODE != PRU_MODE_INVALID) {
> + for (i = 0; i < (PRU1_DATARAM_SIZE / sizeof(int)); i++)
> + pruss_writel(dev, (PRU1_DATARAM_OFFSET +
> + (i * sizeof(int))), datatowrite[i]);
> + }
> +
> + pruss_load(dev, PRUSS_NUM0, (u32 *)pru_suart_emu_code,
> + (fw_size / sizeof(u32)));
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + pruss_load(dev, PRUSS_NUM1, (u32 *)pru_suart_emu_code,
> + (fw_size / sizeof(u32)));
> +
> + retval = arm_to_pru_intr_init(dev);
> + if (-1 == retval)
> + return status;
> + pru_set_delay_count(dev, clk_rate_pruss);
> + suart_set_pru_id(dev, PRUSS_NUM0);
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + suart_set_pru_id(dev, PRUSS_NUM1);
> +
> + pru_set_rx_tx_mode(dev, PRU0_MODE, PRUSS_NUM0);
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + pru_set_rx_tx_mode(dev, PRU1_MODE, PRUSS_NUM1);
> +
> + pru_set_ram_data(dev, pruss_ioaddr);
> + pruss_run(dev, PRUSS_NUM0);
> +
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + pruss_run(dev, PRUSS_NUM1);
> +
> + /* Initialize uart_statu_table */
> + for (idx = 0; idx < 8; idx++)
> + uart_statu_table[idx] = ePRU_SUART_UART_FREE;
> +
> + return status;
> +}
> +
> +void pru_set_fifo_timeout(struct device *dev, s16 timeout)
> +{
> + pruss_writew(dev, PRU_SUART_PRU0_IDLE_TIMEOUT_OFFSET, (u16) timeout);
> + if (PRU1_MODE != PRU_MODE_INVALID)
> + pruss_writew(dev, PRU_SUART_PRU1_IDLE_TIMEOUT_OFFSET,
> + (u16) timeout);
> +}
> +
> +void pru_mcasp_deinit(void)
> +{
> + suart_mcasp_reset(&suart_iomap);
> +}
> +
> +/* suart Instance open routine  */
> +s32 pru_softuart_open(struct suart_handle *h_suart)
> +{
> + s16 status = 0;
> + u16 uart_num = h_suart->uart_num - 1;
> +
> + if (uart_statu_table[h_suart->uart_num - 1] ==
> + ePRU_SUART_UART_IN_USE) {
> + return -EUSERS;
> + } else {
> + h_suart->uart_type = uart_config[uart_num];
> + h_suart->uart_tx_channel = uart_tx[uart_num];
> + h_suart->uart_rx_channel = uart_rx[uart_num];
> + h_suart->uart_status = ePRU_SUART_UART_IN_USE;
> + uart_statu_table[h_suart->uart_num - 1] =
> + ePRU_SUART_UART_IN_USE;
> + }
> + return status;
> +}
> +
> +/* suart instance close routine */
> +s32 pru_softuart_close(struct suart_handle *h_uart)
> +{
> + s16 status = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + } else {
> + uart_statu_table[h_uart->uart_num - 1] =
> + ePRU_SUART_UART_FREE;
> + /* Reset the Instance to Invalid */
> + h_uart->uart_num = PRU_SUART_UARTx_INVALID;
> + h_uart->uart_status = ePRU_SUART_UART_FREE;
> + }
> + return status;
> +}
> +
> +static s32 search_chnum(u16 uart_num, u16 *ch_num, u32 *pru_offset, u16 
> mode)
> +{
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> + || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + *ch_num = (uart_num * SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> + if (uart_num <= 4) {
> + *pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + } else {
> + *pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + *ch_num -= 8;
> + }
> + (mode == 2) ? ++*ch_num : *ch_num;
> + } else if (mode == 1) {
> + if (PRU0_MODE == PRU_MODE_TX_ONLY)
> + *pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + else if (PRU1_MODE == PRU_MODE_TX_ONLY)
> + *pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + } else if (mode == 2) {
> + if (PRU0_MODE == PRU_MODE_RX_ONLY)
> + *pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + else if (PRU1_MODE == PRU_MODE_RX_ONLY)
> + *pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + }
> + return 0;
> +}
> +
> +/*
> + * suart routine for setting relative baud rate
> + */
> +s32 pru_softuart_setbaud(struct device *dev, struct suart_handle *h_uart,
> + u16 tx_clk_divisor, u16 rx_clk_divisor)
> +{
> + u32 offset;
> + u32 pru_offset;
> + s16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 regval = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + /* Set the clock divisor value s32o the McASP */
> + if ((tx_clk_divisor > 385) || (tx_clk_divisor == 0))
> + return -EINVAL;
> + if ((rx_clk_divisor > 385) || (rx_clk_divisor == 0))
> + return -EINVAL;
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + if (tx_clk_divisor != 0) {
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= (~0x3FF);
> + regval |= tx_clk_divisor;
> + pruss_writew(dev, offset, regval);
> + }
> + if (PRU0_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + } else if (PRU1_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + } else if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + ch_num++;
> + } else {
> + return 0;
> + }
> + regval = 0;
> + if (rx_clk_divisor != 0) {
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= (~0x3FF);
> + regval |= tx_clk_divisor;
> + pruss_writew(dev, offset, regval);
> + }
> + return status;
> +}
> +
> +/*
> + * suart routine for setting number of bits per character for a specific 
> uart
> + */
> +s32 pru_softuart_setdatabits(struct device *dev, struct suart_handle 
> *h_uart,
> + u16 tx_data_bits, u16 rx_data_bits)
> +{
> + u32 offset;
> + u32 pru_offset;
> + s16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u32 reg_val;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + /*
> + * NOTE:
> + * The supported data bits are 6,7,8,9,10,11,12 bits per character
> + */
> +
> + if ((tx_data_bits < ePRU_SUART_DATA_BITS6)
> + || (tx_data_bits > ePRU_SUART_DATA_BITS12))
> + return -EINVAL;
> +
> + if ((rx_data_bits < ePRU_SUART_DATA_BITS6)
> + || (rx_data_bits > ePRU_SUART_DATA_BITS12))
> + return -EINVAL;
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + if (tx_data_bits != 0) {
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &reg_val);
> + reg_val &= ~(0xF);
> + reg_val |= tx_data_bits;
> + pruss_writeb(dev, offset, (u8) reg_val);
> + }
> + if (PRU0_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + } else if (PRU1_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + } else if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> + || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + ch_num++;
> + } else {
> + return 0;
> + }
> + if (rx_data_bits != 0) {
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &reg_val);
> + reg_val &= ~(0xF);
> + reg_val |= rx_data_bits;
> + pruss_writeb(dev, offset, (u8) rx_data_bits);
> + }
> +
> + return status;
> +}
> +
> +/*
> + * suart routine to configure specific uart
> + */
> +s32 pru_softuart_setconfig(struct device *dev, struct suart_handle 
> *h_uart,
> + struct suart_config *config_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + s16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 reg_val = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + /*
> + * NOTE:
> + * Dependent baud rate for the given UART,the value MUST BE LESS THAN OR
> + * EQUAL TO 64, preScalarValue <= 64
> + */
> + if ((config_uart->tx_clk_divisor > 384)
> + || (config_uart->rx_clk_divisor > 384)) {
> + return -EINVAL;
> + }
> + if ((config_uart->tx_bits_per_char < 8)
> + || (config_uart->tx_bits_per_char > 14)) {
> + return -EINVAL;
> + }
> + if ((config_uart->rx_bits_per_char < 8)
> + || (config_uart->rx_bits_per_char > 14)) {
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + /*
> + * Configuring the Transmit part of the given UART
> + * Serializer has been as TX in mcasp config, by writing 1 in bits
> + * corresponding to tx serializer in PFUNC regsiter ie already set
> + * to GPIO mode PRU code will set then back to MCASP mode once TX
> + * request for that serializer is posted.It is required because at this
> + * pos32 Mcasp is accessed by both PRU and DSP have lower priority for
> + * Mcasp in comparison to PRU and DPS keeps on looping there only
> + *
> + * suart_mcasp_tx_serialzier_set
> + * (config_uart->tx_serializer, &suart_iomap);
> + */
> +
> + /* Configuring TX serializer  */
> + if (config_uart->tx_serializer != PRU_SUART_SERIALIZER_NONE) {
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->tx_serializer <<
> + PRU_SUART_CH_CTRL_SR_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->tx_clk_divisor <<
> + PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->tx_bits_per_char <<
> + PRU_SUART_CH_CONFIG2_BITPERCHAR_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> + }
> +
> + if (PRU0_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + } else if (PRU1_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + } else if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + ch_num++;
> + } else {
> + return 0;
> + }
> +
> + /* Configuring the Transmit part of the given UART */
> + if (config_uart->rx_serializer != PRU_SUART_SERIALIZER_NONE) {
> + /* Configuring RX serializer  */
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->rx_serializer <<
> + PRU_SUART_CH_CTRL_SR_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* Configuring RX prescalar value and Oversampling */
> + offset = pru_offset +
> + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->rx_clk_divisor <<
> + PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT) |
> + (config_uart->oversampling <<
> + PRU_SUART_CH_CONFIG1_OVS_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* Configuring RX bits per character value */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL)
> + + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val = reg_val | (config_uart->rx_bits_per_char <<
> + PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> + }
> + return status;
> +}
> +
> +/*
> + * suart routine for getting the number of bytes transfered
> + */
> +s32 pru_softuart_get_tx_data_len(struct device *dev,
> + struct suart_handle *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 read_value = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &read_value);
> + read_value = ((read_value & PRU_SUART_CH_CONFIG1_DIVISOR_MASK)
> + >> PRU_SUART_CH_CONFIG2_DATALEN_SHIFT);
> + return read_value;
> +}
> +
> +/*
> + * suart routine for getting the number of bytes received
> + */
> +s32 pru_softuart_get_rx_data_len(struct device *dev,
> + struct suart_handle *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 read_value = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> +
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &read_value);
> + read_value = ((read_value & PRU_SUART_CH_CONFIG1_DIVISOR_MASK)
> + >> PRU_SUART_CH_CONFIG2_DATALEN_SHIFT);
> + return read_value;
> +}
> +
> +/*
> + * suart routine to get the configuration information from a specific 
> uart
> + */
> +s32 pru_softuart_getconfig(struct device *dev,
> + struct suart_handle *h_uart,
> + struct suart_config *config_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 reg_val = 0;
> + s16 status = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> +
> + /*
> + * NOTE:
> + * Dependent baud rate for the given UART,the value MUST BE LESS THAN OR
> + * EQUAL TO 64, preScalarValue <= 64
> + */
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + /* Configuring the Transmit part of the given UART */
> + /* Configuring TX serializer  */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->tx_serializer = ((reg_val & PRU_SUART_CH_CTRL_SR_MASK) >>
> + PRU_SUART_CH_CTRL_SR_SHIFT);
> + /* Configuring TX prescalar value */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->tx_clk_divisor = ((reg_val &
> + PRU_SUART_CH_CONFIG1_DIVISOR_MASK) >>
> + PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> +
> + /* Configuring TX bits per character value */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->tx_bits_per_char = ((reg_val &
> + PRU_SUART_CH_CONFIG1_DIVISOR_MASK) >>
> + PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> +
> + if (PRU0_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + } else if (PRU1_MODE == PRU_MODE_RX_ONLY) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + } else if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + ch_num++;
> + } else {
> + return 0;
> + }
> + /* Configuring the Transmit part of the given UART */
> + /* Configuring RX serializer  */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->rx_serializer = ((reg_val & PRU_SUART_CH_CTRL_SR_MASK) >>
> + PRU_SUART_CH_CTRL_SR_SHIFT);
> +
> + /* Configuring RX prescalar value and oversampling */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG1_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->rx_clk_divisor = ((reg_val &
> + PRU_SUART_CH_CONFIG1_DIVISOR_MASK)
> + >> PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> + config_uart->oversampling = ((reg_val &
> + PRU_SUART_CH_CONFIG1_OVS_MASK) >>
> + PRU_SUART_CH_CONFIG1_OVS_SHIFT);
> +
> + /* Configuring RX bits per character value */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + config_uart->rx_bits_per_char = ((reg_val &
> + PRU_SUART_CH_CONFIG1_DIVISOR_MASK)
> + >> PRU_SUART_CH_CONFIG1_DIVISOR_SHIFT);
> +
> + return status;
> +}
> +
> +s32 pru_softuart_pending_tx_request(struct device *dev)
> +{
> + u32 offset = 0;
> + u32 ISR_value = 0;
> +
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + return 0;
> + } else if (PRU0_MODE == PRU_MODE_TX_ONLY) {
> + /* Read PRU Interrupt Status Register from PRU */
> + offset = (u32) (PRUSS_INTC_STATCLRINT1 & 0xFFFF);
> + pruss_readl(dev, offset, (u32 *)&ISR_value);
> + if ((ISR_value & 0x1) == 0x1)
> + return -EINVAL;
> + } else if (PRU1_MODE == PRU_MODE_TX_ONLY) {
> + /* Read PRU Interrupt Status Register from PRU */
> + offset = (u32) (PRUSS_INTC_STATCLRINT1 & 0xFFFF);
> + pruss_readl(dev, offset, (u32 *)&ISR_value);
> + if ((ISR_value & 0x2) == 0x2)
> + return -EINVAL;
> + } else {
> + return 0;
> + }
> +
> + return 0;
> +}
> +
> +/*
> + * suart data transmit routine
> + */
> +s32 pru_softuart_write(struct device *dev, struct suart_handle *h_uart,
> + u32 *pt_tx_data_buf, u16 data_len)
> +{
> + u32 offset = 0;
> + u32 pru_offset;
> + s16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 reg_val = 0;
> + u16 pru_num;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH))
> + pru_num = h_uart->uart_num;
> + else if (PRU0_MODE == PRU_MODE_TX_ONLY)
> + pru_num = 0;
> + else if (PRU1_MODE == PRU_MODE_TX_ONLY)
> + pru_num = 1;
> + else
> + return 0;
> +
> + /* Writing data length to SUART channel register */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= ~PRU_SUART_CH_CONFIG2_DATALEN_MASK;
> + reg_val = reg_val | (data_len << PRU_SUART_CH_CONFIG2_DATALEN_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* Writing the data pos32er to channel TX data pointer */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXDATA_OFFSET;
> + pruss_writel(dev, offset, (u32) *pt_tx_data_buf);
> +
> + /* Service Request to PRU */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= ~(PRU_SUART_CH_CTRL_MODE_MASK |
> + PRU_SUART_CH_CTRL_SREQ_MASK);
> + reg_val |= (PRU_SUART_CH_CTRL_TX_MODE <<
> + PRU_SUART_CH_CTRL_MODE_SHIFT) | (PRU_SUART_CH_CTRL_SREQ <<
> + PRU_SUART_CH_CTRL_SREQ_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* generate ARM->PRU event */
> + suart_arm_to_pru_intr(dev, pru_num);
> +
> + return status;
> +}
> +
> +/*
> + * suart data receive routine
> + */
> +s32 pru_softuart_read(struct device *dev, struct suart_handle *h_uart,
> + u32 *ptDataBuf, u16 data_len)
> +{
> + u32 offset = 0;
> + u32 pru_offset;
> + s16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 reg_val = 0;
> + u16 pru_num;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* channel starts from 0 and uart instance starts from 1 */
> + ch_num = (h_uart->uart_num *
> + SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> + pru_num = h_uart->uart_num;
> + } else if (PRU0_MODE == PRU_MODE_RX_ONLY) {
> + pru_num = 0;
> + } else if (PRU1_MODE == PRU_MODE_RX_ONLY) {
> + pru_num = 1;
> + } else {
> + return 0;
> + }
> + /* Writing data length to SUART channel register */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= ~PRU_SUART_CH_CONFIG2_DATALEN_MASK;
> + reg_val = reg_val | (data_len << PRU_SUART_CH_CONFIG2_DATALEN_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* Writing the data pos32er to channel RX data pointer */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXDATA_OFFSET;
> + pruss_writel(dev, offset, (u32) *ptDataBuf);
> +
> + /* Service Request to PRU */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= ~(PRU_SUART_CH_CTRL_MODE_MASK |
> + PRU_SUART_CH_CTRL_SREQ_MASK);
> + reg_val |= (PRU_SUART_CH_CTRL_RX_MODE <<
> + PRU_SUART_CH_CTRL_MODE_SHIFT) | (PRU_SUART_CH_CTRL_SREQ <<
> + PRU_SUART_CH_CTRL_SREQ_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> +
> + /* enable the timeout s32errupt */
> + suart_intr_setmask(dev, h_uart->uart_num, PRU_RX_INTR,
> + CHN_TXRX_IE_MASK_TIMEOUT);
> +
> + /* generate ARM->PRU event */
> + suart_arm_to_pru_intr(dev, pru_num);
> +
> + return status;
> +}
> +
> +/*
> + * suart routine to read the data from the RX FIFO
> + */
> +s32 pru_softuart_read_data(struct device *dev, struct suart_handle 
> *h_uart,
> + u8 *p_data_buffer, s32 max_len,
> + u32 *pdata_read)
> +{
> + s16 ret_val = 0;
> + u8 *psrc_addr = NULL;
> + u32 data_read = 0;
> + u32 data_len = 0;
> + u32 char_len = 0;
> + u32 offset = 0;
> + u32 pru_offset;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 status = 0;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> +
> + /* Get the data pos32er from channel RX data pointer */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXDATA_OFFSET;
> + pruss_readb_multi(dev, offset, (u8 *) &psrc_addr, 4);
> +
> + /* Reading data length from SUART channel register */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CONFIG2_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &data_len);
> +
> + /* read the character length */
> + char_len = data_len & PRU_SUART_CH_CONFIG2_BITPERCHAR_MASK;
> + char_len -= 2; /* remove the START & STOP bit */
> +
> + data_len &= PRU_SUART_CH_CONFIG2_DATALEN_MASK;
> + data_len = data_len >> PRU_SUART_CH_CONFIG2_DATALEN_SHIFT;
> + data_len++;
> +
> + /* if the character length is greater than 8, then the size doubles */
> + if (char_len > 8)
> + data_len *= 2;
> +
> + /* Check if the time-out had occured. If, yes, then we need to find the
> + * number of bytes read from PRU. Else, we need to
> + * read the requested bytes
> + */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> + if (CHN_TXRX_STATUS_TIMEOUT == (status & CHN_TXRX_STATUS_TIMEOUT)) {
> + /* determine the number of bytes read s32o the FIFO */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL)
> + + PRU_SUART_CH_BYTESDONECNTR_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &data_read);
> +
> + /* if the character length is greater than 8,
> + then the size doubles */
> + if (char_len > 8)
> + data_read *= 2;
> +
> +/*
> + * the data corresponding is loaded in second
> + * half during the timeout
> + */
> + if (data_read > data_len) {
> + data_read -= data_len;
> + psrc_addr += data_len;
> + }
> +
> + pru_softuart_clr_rx_fifo(dev, h_uart);
> + } else {
> + data_read = data_len;
> +/*
> + * if the bit is set, the data is in the first
> + * half of the FIFO else the data is in the second half
> + */
> + /* Determine the buffer index by reading FIFO_OddEven flag*/
> + if (status & CHN_TXRX_STATUS_CMPLT)
> + psrc_addr += data_len;
> + }
> +
> + /* we should be copying only max len given by the application */
> + if (data_read > max_len)
> + data_read = max_len;
> +
> +/* evaluate the virtual address of the FIFO address
> + * based on the physical addr
> + */
> + psrc_addr = (u8 *)((u32) psrc_addr -
> + (u32) suart_iomap.p_fifo_buff_phys_base +
> + (u32) suart_iomap.p_fifo_buff_virt_base);
> +
> + /* Now we have both the data length and the source address. copy */
> + for (offset = 0; offset < data_read; offset++)
> + *p_data_buffer++ = *psrc_addr++;
> + *pdata_read = data_read;
> + ret_val = 0;
> +
> + return ret_val;
> +}
> +
> +/*
> + * suart routine to disable the receive functionality.
> + * This routine stops the PRU from receiving on selected
> + * UART and also disables the McASP serializer corresponding
> + * to this UART Rx line.
> + */
> +s32 pru_softuart_stop_receive(struct device *dev, struct suart_handle 
> *h_uart)
> +{
> + u16 ret_status = 0;
> + u32 offset;
> + u32 pru_offset;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 status;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> +
> + /* read the existing value of status flag */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> +
> + /* we need to clear the busy bit corresponding to receive channel */
> + status &= ~(CHN_TXRX_STATUS_RDY);
> + pruss_writeb(dev, offset, (u8) status);
> +
> + /* get the serizlizer number being used for this Rx channel */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &status);
> + status &= PRU_SUART_CH_CTRL_SR_MASK;
> + status = status >> PRU_SUART_CH_CTRL_SR_SHIFT;
> +
> + /* we need to de-activate the serializer corresponding to this rx */
> + ret_status = suart_asp_serializer_deactivate(status, &suart_iomap);
> +
> + return ret_status;
> +}
> +
> +/*
> + * suart routine to get the tx status for a specific uart
> + */
> +s32 pru_softuart_get_tx_status(struct device *dev, struct suart_handle 
> *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> + return status;
> +}
> +
> +s32 pru_softuart_clr_tx_status(struct device *dev, struct suart_handle 
> *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 1);
> +
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> + status &= ~(0x2);
> + pruss_writeb(dev, offset, (u8) status);
> + return status;
> +}
> +
> +/*
> + * suart routine to get the rx status for a specific uart
> + */
> +s32 pru_softuart_get_rx_status(struct device *dev, struct suart_handle 
> *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> +
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> + return status;
> +}
> +
> +static s32 pru_softuart_clr_rx_fifo(struct device *dev,
> + struct suart_handle *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> + u16 reg_val;
> + u16 uart_num;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + uart_num = h_uart->uart_num;
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> + if (PRU0_MODE == PRU_MODE_RX_ONLY)
> + uart_num = 0;
> + else if (PRU1_MODE == PRU_MODE_RX_ONLY)
> + uart_num = 1;
> +
> + /* Reset the number of bytes read into the FIFO */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL)
> + + PRU_SUART_CH_BYTESDONECNTR_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= 0x00;
> + pruss_writew(dev, offset, reg_val);
> +
> +
> + /* Service Request to PRU */
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_CTRL_OFFSET;
> + pruss_readw(dev, offset, (u16 *) &reg_val);
> + reg_val &= ~(PRU_SUART_CH_CTRL_MODE_MASK | PRU_SUART_CH_CTRL_SREQ_MASK);
> + reg_val |= (PRU_SUART_CH_CTRL_RX_MODE << PRU_SUART_CH_CTRL_MODE_SHIFT) |
> + (PRU_SUART_CH_CTRL_SREQ << PRU_SUART_CH_CTRL_SREQ_SHIFT);
> + pruss_writew(dev, offset, reg_val);
> + suart_intr_setmask(dev, h_uart->uart_num, PRU_RX_INTR,
> + CHN_TXRX_IE_MASK_TIMEOUT);
> +
> + /* generate ARM->PRU event */
> + suart_arm_to_pru_intr(dev, uart_num);
> +
> + return status;
> +}
> +
> +s32 pru_softuart_clr_rx_status(struct device *dev, struct suart_handle 
> *h_uart)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 status = 0;
> + u16 ch_num = h_uart->uart_num - 1;
> +
> + if (h_uart == NULL) {
> + WARN_ON(1);
> + return -EINVAL;
> + }
> + search_chnum(h_uart->uart_num, &ch_num, &pru_offset, 2);
> +
> + offset = pru_offset + (ch_num * SUART_NUM_OF_BYTES_PER_CHANNEL) +
> + PRU_SUART_CH_TXRXSTATUS_OFFSET;
> + pruss_readb(dev, offset, (u8 *) &status);
> + status &= ~(0x3C);
> + pruss_writeb(dev, offset, (u8) status);
> + return status;
> +}
> +
> +/*
> + * suart_s32r_status_read: Gets the Global Interrupt status register
> + * for the specified SUART.
> + * uart_num < 1 to 6 >
> + * txrx_flag < Indicates TX or RX s32errupt for the uart >
> + */
> +s32 pru_softuart_get_isrstatus(struct device *dev, u16 uart_num, u16 
> *txrx_flag)
> +{
> + u32 intc_offset;
> + u32 ch_num = 0xFF;
> + u32 reg_val = 0;
> + u32 reg_val2 = 0;
> + u32 ISR_value = 0;
> + u32 ack_reg_val = 0;
> + u32 stat_inx_clr_regoffset = 0;
> +
> + /* initialize the status & Flag to known value */
> + *txrx_flag = 0;
> +
> + stat_inx_clr_regoffset = (u32) (PRUSS_INTC_STATIDXCLR & 0xFFFF);
> +
> + /* Read PRU Interrupt Status Register from PRU */
> + intc_offset = (u32) (PRUSS_INTC_STATCLRINT1 & 0xFFFF);
> +
> + pruss_readl(dev, intc_offset, (u32 *)&ISR_value);
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> + || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* Check if the interrupt occured for Tx */
> + ch_num = uart_num * 2 - 2;
> + reg_val2 = PRU_SUART0_TX_EVT_BIT << ((uart_num - 1) * 2);
> + if (ISR_value & reg_val2) {
> + /* interupt occured for TX */
> + *txrx_flag |= PRU_TX_INTR;
> + /* acknowledge the RX interrupt  */
> + ack_reg_val  = ch_num + PRU_SUART0_TX_EVT;
> + pruss_writel(dev, stat_inx_clr_regoffset,
> + ack_reg_val);
> + }
> +
> + /* Check if the interrupt occured for Rx */
> + reg_val2 = PRU_SUART0_RX_EVT_BIT << ((uart_num - 1) * 2);
> + pruss_readl(dev, intc_offset, (u32 *)&ISR_value);
> + if (ISR_value & reg_val2) {
> + /* interupt occured for RX */
> + *txrx_flag |= PRU_RX_INTR;
> + ch_num += 1;
> +
> + /* acknowledge the RX interrupt  */
> + ack_reg_val  = ch_num + PRU_SUART0_TX_EVT;
> + pruss_writel(dev, stat_inx_clr_regoffset,
> + ack_reg_val);
> + }
> + } else {
> + ch_num = uart_num - 1;
> + if ((ISR_value & 0x03FC) != 0) {
> + reg_val2 = 1 << (uart_num + 1);
> + if (ISR_value & reg_val2) {
> + /* acknowledge the s32errupt  */
> + ack_reg_val = ch_num + PRU_SUART0_TX_EVT;
> + pruss_writel(dev, stat_inx_clr_regoffset,
> + ack_reg_val);
> + *txrx_flag |= PRU_RX_INTR;
> + }
> + }
> + pruss_readl(dev, intc_offset, (u32 *)&ISR_value);
> + if (ISR_value & 0x3FC00) {
> + reg_val2 = 1 << (uart_num + 9);
> + if (ISR_value & reg_val2) {
> + /* acknowledge the s32errupt  */
> + ack_reg_val = ch_num + PRU_SUART4_TX_EVT;
> + pruss_writel(dev, stat_inx_clr_regoffset,
> + ack_reg_val);
> + *txrx_flag |= PRU_TX_INTR;
> + }
> + }
> + }
> + return reg_val;
> +}
> +
> +s32 pru_intr_clr_isrstatus(struct device *dev, u16 uart_num, u32 
> txrxmode)
> +{
> + u32 offset;
> + u16 txrx_flag = 0;
> + u16 chn_num;
> +
> + chn_num = uart_num - 1;
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* channel starts from 0 and uart instance starts from 1 */
> + chn_num = (uart_num * SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> + if (uart_num <= 4) {
> + /* PRU0 */
> + offset = PRU_SUART_PRU0_ISR_OFFSET + 1;
> + } else {
> + /* PRU1 */
> + offset = PRU_SUART_PRU1_ISR_OFFSET + 1;
> + /* First 8 channel corresponds to PRU0 */
> + chn_num -= 8;
> + }
> + if (2 == txrxmode)
> + chn_num++;
> + } else if (PRU0_MODE == txrxmode) {
> + offset = PRU_SUART_PRU0_ISR_OFFSET + 1;
> + } else if (PRU1_MODE == txrxmode) {
> + offset = PRU_SUART_PRU1_ISR_OFFSET + 1;
> + } else {
> + return 0;
> + }
> +
> + pruss_readb(dev, offset, (u8 *) &txrx_flag);
> + txrx_flag &= ~(0x2);
> + pruss_writeb(dev, offset, (u8) txrx_flag);
> +
> + return 0;
> +}
> +
> +s32 suart_arm_to_pru_intr(struct device *dev, u16 uart_num)
> +{
> + u32 value;
> +
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + if ((uart_num > 0) && (uart_num <= 4))
> + value = 0x20; /* PRU0 SYS_EVT32 */
> + else if ((uart_num > 4) && (uart_num <= 8))
> + value = 0x21; /* PRU0 SYS_EVT33 */
> + else
> + return -EINVAL;
> + }
> + if ((PRU0_MODE == PRU_MODE_RX_ONLY)
> + || (PRU1_MODE == PRU_MODE_RX_ONLY)
> + || (PRU0_MODE == PRU_MODE_TX_ONLY)
> + || (PRU1_MODE == PRU_MODE_TX_ONLY)) {
> + if (uart_num == PRUSS_NUM0)
> + value = 0x20; /* PRU0 SYS_EVT32 */
> + else if (uart_num == PRUSS_NUM1)
> + value = 0x21; /* PRU0 SYS_EVT33 */
> + else
> + return -EINVAL;
> + }
> + return pruss_writel(dev, PRUSS_INTC_STATIDXSET, value);
> +}
> +
> +static s32 arm_to_pru_intr_init(struct device *dev)
> +{
> + u32 value;
> + u32 int_offset;
> +
> + /* Clear all the host interrupts */
> + for (int_offset = 0; int_offset <= PRUSS_INTC_HOSTINTLVL_MAX;
> + int_offset++)
> + pruss_idx_writel(dev, PRUSS_INTC_HSTINTENIDXCLR, int_offset);
> +
> + /* Enable the global s32errupt */
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_GLBLEN & 0xFFFF), 0, 1);
> +
> + /* Enable the Host interrupts for all host channels */
> + for (int_offset = 0; int_offset <= PRUSS_INTC_HOSTINTLVL_MAX;
> + int_offset++)
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_HSTINTENIDXSET & 0xFFFF),
> + 0, int_offset);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_HOSTMAP0 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_HOSTMAP0_CHAN);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_HOSTMAP1 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_HOSTMAP1_CHAN);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_HOSTMAP2 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_HOSTMAP2_CHAN);
> +
> + /* MAP Channel 0 to SYS_EVT31 */
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP7 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP7_SYS_EVT31);
> +
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* Sets the channels for the system interrupt */
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP8 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP8_FULL);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP9 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP9_FULL);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP10 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP10_FULL);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP11 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP11_FULL);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP12 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP12_FULL);
> + }
> + if ((PRU0_MODE == PRU_MODE_RX_ONLY)
> + || (PRU1_MODE == PRU_MODE_RX_ONLY)
> + || (PRU0_MODE == PRU_MODE_TX_ONLY)
> + || (PRU1_MODE == PRU_MODE_TX_ONLY)) {
> +
> + /* Sets the channels for the system interrupt */
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP8 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP8_HALF);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP9 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP9_HALF);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP10 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP10_HALF);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP11 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP11_HALF);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_CHANMAP12 & 0xFFFF),
> + PRU_INTC_REGMAP_MASK, PRU_INTC_CHANMAP12_HALF);
> + }
> +
> + /* Clear required set of system events
> + * and enable them using indexed register
> + */
> + for (int_offset = 0; int_offset < 18; int_offset++) {
> + value = 32 + int_offset;
> + pruss_idx_writel(dev, PRUSS_INTC_STATIDXCLR, value);
> + }
> +
> + /* enable only the HOST to PRU interrupts and let the PRU to Host events
> + * enabled by the separate API on demand basis.
> + */
> + pruss_idx_writel(dev, PRUSS_INTC_ENIDXSET, 31);
> + pruss_idx_writel(dev, PRUSS_INTC_ENIDXSET, 32);
> + pruss_idx_writel(dev, PRUSS_INTC_ENIDXSET, 33);
> + pruss_idx_writel(dev, PRUSS_INTC_ENIDXSET, 50);
> + pruss_rmwl(dev, (u32) (PRUSS_INTC_GLBLEN & 0xFFFF), 0, 1);
> +
> + /* Enable the Host interrupts for all host channels */
> + for (int_offset = 0; int_offset <= PRUSS_INTC_HOSTINTLVL_MAX;
> + int_offset++)
> + pruss_idx_writel(dev, PRUSS_INTC_HSTINTENIDXSET, int_offset);
> +
> + return 0;
> +}
> +
> +s32 suart_pru_to_host_intr_enable(struct device *dev, u16 uart_num,
> + u32 txrxmode, s32 flag)
> +{
> + u32 chn_num;
> + u32 value;
> + s16 retval = 0;
> +
> + if (uart_num > 8)
> + return -EINVAL;
> +
> + chn_num = uart_num - 1;
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH) ||
> + (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + chn_num = (uart_num * 2) - 2;
> + if (2 == txrxmode) /* Rx mode */
> + chn_num++;
> + value = 34 + chn_num;
> + } else if ((PRU_MODE_RX_ONLY == txrxmode)
> + && (PRU0_MODE == PRU_MODE_RX_ONLY))
> + value = 34 + chn_num;
> + else if ((PRU_MODE_RX_ONLY == txrxmode)
> + && (PRU1_MODE == PRU_MODE_RX_ONLY))
> + value = 42 + chn_num;
> + else if ((PRU_MODE_TX_ONLY == txrxmode)
> + && (PRU0_MODE == PRU_MODE_TX_ONLY))
> + value = 34 + chn_num;
> + else if ((PRU_MODE_TX_ONLY == txrxmode)
> + && (PRU1_MODE == PRU_MODE_TX_ONLY))
> + value = 42 + chn_num;
> + else
> + return -EINVAL;
> +
> + retval = flag ? pruss_idx_writel(dev, PRUSS_INTC_ENIDXSET, value) :
> + pruss_idx_writel(dev, PRUSS_INTC_ENIDXCLR, value);
> + return retval;
> +}
> +
> +s32 suart_intr_setmask(struct device *dev, u16 uart_num,
> + u32 txrxmode, u32 rmask)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u32 regval = 0;
> + u32 chn_num = uart_num - 1;
> +
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* channel starts from 0 and uart instance starts from 1 */
> + chn_num = (uart_num * SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> +
> + if ((uart_num > 0) && (uart_num <= 4)) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + } else if ((uart_num > 4) && (uart_num <= 8)) {
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + chn_num -= 8;
> + } else {
> + return -EINVAL;
> + }
> + if (2 == txrxmode)
> + chn_num++;
> + } else if (PRU0_MODE == txrxmode) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + } else if (PRU1_MODE == txrxmode) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + } else
> + return 0;
> +
> + regval = 1 << chn_num;
> + if (CHN_TXRX_IE_MASK_CMPLT == (rmask & CHN_TXRX_IE_MASK_CMPLT))
> + pruss_rmww(dev, offset, regval, regval);
> +
> + if ((rmask & SUART_GBL_INTR_ERR_MASK) ==
> + SUART_GBL_INTR_ERR_MASK) {
> + regval = SUART_GBL_INTR_ERR_MASK;
> + pruss_rmww(dev, offset, regval, regval);
> + }
> +
> + offset = pru_offset +
> + (chn_num * SUART_NUM_OF_BYTES_PER_CHANNEL)
> + + PRU_SUART_CH_CONFIG1_OFFSET;
> + /* Framing Error Interrupt Masked */
> + if ((rmask & CHN_TXRX_IE_MASK_FE) == CHN_TXRX_IE_MASK_FE) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_FE);
> + regval |= CHN_TXRX_IE_MASK_FE;
> + pruss_writew(dev, offset, (u16) regval);
> + }
> +
> + /* Break Indicator Interrupt Masked */
> + if (CHN_TXRX_IE_MASK_BI == (rmask & CHN_TXRX_IE_MASK_BI)) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_BI);
> + regval |= CHN_TXRX_IE_MASK_BI;
> + pruss_writew(dev, offset, (u16) regval);
> + }
> +
> + /* Timeout error Interrupt Masked */
> + if (CHN_TXRX_IE_MASK_TIMEOUT ==
> + (rmask & CHN_TXRX_IE_MASK_TIMEOUT)) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_TIMEOUT);
> + regval |= CHN_TXRX_IE_MASK_TIMEOUT;
> + pruss_writew(dev, offset, (u16) regval);
> + }
> + return 0;
> +}
> +
> +s32 suart_intr_clrmask(struct device *dev, u16 uart_num,
> + u32 txrxmode, u32 rmask)
> +{
> + u32 offset;
> + u32 pru_offset;
> + u16 regval = 0;
> + u16 chn_num;
> +
> + chn_num = uart_num - 1;
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* channel starts from 0 and uart instance starts from 1 */
> + chn_num = (uart_num * SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> + if ((uart_num > 0) && (uart_num <= 4)) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + } else if ((uart_num > 4) && (uart_num <= 8)) {
> + /* PRU1 */
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + /* First 8 channel corresponds to PRU0 */
> + chn_num -= 8;
> + } else
> + return -EINVAL;
> + if (2 == txrxmode)
> + chn_num++;
> + } else if (PRU0_MODE == txrxmode) {
> + pru_offset = PRU_SUART_PRU0_CH0_OFFSET;
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + } else if (PRU1_MODE == txrxmode) {
> + pru_offset = PRU_SUART_PRU1_CH0_OFFSET;
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + } else
> + return 0;
> +
> + regval = 1 << chn_num;
> + if (CHN_TXRX_IE_MASK_CMPLT == (rmask & CHN_TXRX_IE_MASK_CMPLT))
> + pruss_rmww(dev, offset, regval, 0);
> +
> + if ((rmask & SUART_GBL_INTR_ERR_MASK) == SUART_GBL_INTR_ERR_MASK)
> + pruss_rmww(dev, offset, SUART_GBL_INTR_ERR_MASK, 0);
> +
> + offset = pru_offset +
> + (chn_num * SUART_NUM_OF_BYTES_PER_CHANNEL)
> + + PRU_SUART_CH_CONFIG1_OFFSET;
> +
> + /* Framing Error Interrupt Masked */
> + if ((rmask & CHN_TXRX_IE_MASK_FE) == CHN_TXRX_IE_MASK_FE) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_FE);
> + pruss_writew(dev, offset, regval);
> + }
> +
> + /* Break Indicator Interrupt Masked */
> + if (CHN_TXRX_IE_MASK_BI == (rmask & CHN_TXRX_IE_MASK_BI)) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_BI);
> + pruss_writew(dev, offset, regval);
> + }
> +
> + /* Timeout error Interrupt Masked */
> + if (CHN_TXRX_IE_MASK_TIMEOUT ==
> + (rmask & CHN_TXRX_IE_MASK_TIMEOUT)) {
> + regval = 0;
> + pruss_readw(dev, offset, (u16 *) &regval);
> + regval &= ~(CHN_TXRX_IE_MASK_TIMEOUT);
> + pruss_writew(dev, offset, regval);
> + }
> + return 0;
> +}
> +
> +s32 suart_intr_getmask(struct device *dev, u16 uart_num,
> + u32 txrxmode, u32 rmask)
> +{
> + u16 chn_num;
> + u32 offset;
> + u16 txrx_flag;
> + u16 regval = 1;
> +
> + chn_num = uart_num - 1;
> + if ((PRU0_MODE == PRU_MODE_RX_TX_BOTH)
> +     || (PRU1_MODE == PRU_MODE_RX_TX_BOTH)) {
> + /* channel starts from 0 and uart instance starts from 1 */
> + chn_num = (uart_num * SUART_NUM_OF_CHANNELS_PER_SUART) - 2;
> +
> + if ((uart_num > 0) && (uart_num <= 4)) {
> +
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + } else if ((uart_num > 4) && (uart_num <= 8)) {
> + /* PRU1 */
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + /* First 8 channel corresponds to PRU0 */
> + chn_num -= 8;
> + } else
> + return -EINVAL;
> +
> + if (2 == txrxmode)
> + chn_num++;
> +
> + } else if (PRU0_MODE == txrxmode)
> + offset = PRU_SUART_PRU0_IMR_OFFSET;
> + else if (PRU1_MODE == txrxmode)
> + offset = PRU_SUART_PRU1_IMR_OFFSET;
> + else
> + return 0;
> +
> + regval = regval << chn_num;
> + pruss_readw(dev, offset, (u16 *) &txrx_flag);
> + txrx_flag &= regval;
> +
> + if ((rmask && (txrx_flag == regval)) || (!rmask && !txrx_flag))
> + return 1;
> +
> + return 0;
> +}
> diff --git a/drivers/tty/serial/pruss_suart_utils.c 
> b/drivers/tty/serial/pruss_suart_utils.c
> new file mode 100644
> index 0000000..5ee340e
> --- /dev/null
> +++ b/drivers/tty/serial/pruss_suart_utils.c
> @@ -0,0 +1,393 @@
> +/*
> + * Copyright (C) 2010, 2011 Texas Instruments Incorporated
> + * Author: Jitendra Kumar <jitendra@mistralsolutions.com>
> + *
> + * This program is free software; you can redistribute it and/or modify 
> it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +
> +#include <linux/mfd/pruss.h>
> +#include "pruss_suart.h"
> +
> +#define SUART_TRX_DIV_CONF_SZ 4
> +
> +static s16 suart_mcasp_tx_baud_set(u32 tx_baud_value,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +static s16 suart_mcasp_rx_baud_set(u32 rx_baud_value, u32 oversampling,
> + struct pruss_suart_iomap *pruss_ioaddr);
> +
> +/*
> + * Lookup table for TX baud rate
> + * The divisor value is calculated using the formula
> + *
> + * ACLKX = (AUXCLK)/(CLKXDIV * HCLKXDIV)
> + *
> + * Where
> + * CLKXDIV takes values from 1-32
> + * HCLKXDIV takes values from 1-4096
> + * Here
> + * AUXCLK = 24MHz
> + */
> +static u32 lt_tx_baud_rate[][SUART_TRX_DIV_CONF_SZ] = {
> + /*BaudRate, Divisor, CLKXDIV,HCLKXDIV */
> + {300, 80000, 24, 3200},
> + {600, 40000, 15, 2500},
> + {1800, 13333, 10, 1212},
> + {2400, 10000, 4, 2000},
> + {4800, 5000, 1, 2500},
> + {7200, 3333, 0, 3333},
> + {9600, 2500, 0, 2500},
> + {14400, 1666, 0, 1666},
> + {19200, 1250, 0, 1250},
> + {38400, 625, 0, 625},
> + {57600, 416, 0, 416},
> + {115200, 208, 0, 208},
> + {230400, 104, 0, 104}
> +};
> +
> +/*
> + * Lookup table for RX baud rate for 8 bit oversampling
> + * The divisor value is calculated using the formula
> + *
> + * ACLKR = (AUXCLK)/(CLKRDIV * HCLKRDIV) * Oversampling
> + *
> + * Where
> + * CLKRDIV takes values from 1-32
> + * HCLKRDIV takes values from 1-4096
> + * Here
> + * AUXCLK = 24MHz
> + */
> +static u32 lt_rx_8x_baud_rate[][SUART_TRX_DIV_CONF_SZ] = {
> +/* BaudRate, Divisor, CLKXDIV, HCLKXDIV */
> + {300, 10000, 4, 2000},
> + {600, 5000, 1, 2500},
> + {1800, 1667, 0, 1667},
> + {2400, 1250, 0, 1250},
> + {7200, 417, 0, 417},
> + {4800, 625, 0, 625},
> + {9600, 312, 0, 312},
> + {14400, 208, 0, 208},
> + {19200, 156, 0, 156},
> + {38400, 78, 0, 78},
> + {57600, 52, 0, 52},
> + {115200, 26, 0, 26},
> + {230400, 13, 0, 13}
> +};
> +
> +/*
> + * Lookup table for RX baud rate for 16 bit oversampling
> + * The divisor value is calculated using the formula
> + *
> + * ACLKR = (AUXCLK)/(CLKRDIV * HCLKRDIV) * Oversampling
> + *
> + * Where
> + * CLKRDIV takes values from 1-32
> + * HCLKRDIV takes values from 1-4096
> + * Here
> + * AUXCLK = 24MHz
> + */
> +static u32 lt_rx_16x_baud_rate[][SUART_TRX_DIV_CONF_SZ] = {
> +/*BaudRate, Divisor, CLKXDIV, HCLKXDIV */
> + {300, 5000, 1, 2500},
> + {600, 2500, 0, 2500},
> + {1800, 833, 0, 833},
> + {2400, 625, 0, 625},
> + {4800, 312, 0, 312},
> + {7200, 208, 0, 208},
> + {9600, 156, 0, 156},
> + {14400, 104, 0, 104},
> + {19200, 78, 0, 78},
> + {38400, 39, 0, 39},
> + {57600, 26, 0, 26},
> + {115200, 13, 0, 13},
> + {230400, 6, 0, 6}
> +};
> +
> +/*
> + * McASP configuration routine
> + */
> +
> +void suart_mcasp_reset(struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> + /* reset mcasp. */
> + iowrite32(MCASP_SUART_GBLCTL, &mcasp0_regs->gblctl);
> + iowrite32(MCASP_SUART_RGBLCTL, &mcasp0_regs->rgblctl);
> + iowrite32(MCASP_SUART_XGBLCTL, &mcasp0_regs->xgblctl);
> + iowrite32(MCASP_SUART_XSTAT, &mcasp0_regs->xstat);
> + iowrite32(MCASP_SUART_RSTAT, &mcasp0_regs->rstat);
> +}
> +
> +void suart_mcasp_config(u32 tx_baud_value,
> + u32 rx_baud_value,
> + u32 oversampling,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> + u32 temp_reg;
> +
> + /* reset mcasp */
> + iowrite32(MCASP_SUART_GBLCTL, &mcasp0_regs->gblctl);
> + iowrite32(MCASP_SUART_RGBLCTL, &mcasp0_regs->rgblctl);
> + iowrite32(MCASP_SUART_XGBLCTL, &mcasp0_regs->xgblctl);
> +
> + /* configure receive registers */
> + if ((SUART_8X_OVRSMPL == oversampling) || (0 == oversampling)) {
> + iowrite32(MCASP_SUART_RMASK_8, &mcasp0_regs->rmask);
> + iowrite32(MCASP_SUART_RFMT_8, &mcasp0_regs->rfmt);
> + }
> + if (SUART_16X_OVRSMPL == oversampling) {
> + iowrite32(MCASP_SUART_RMASK_16, &mcasp0_regs->rmask);
> + iowrite32(MCASP_SUART_RFMT_16, &mcasp0_regs->rfmt);
> +
> + }
> +
> + iowrite32(MCASP_SUART_FSRM, &mcasp0_regs->afsrctl);
> + iowrite32(MCASP_SUART_CLKRM_CLKRP, &mcasp0_regs->aclkrctl);
> + iowrite32(MCASP_SUART_HCLKRP, &mcasp0_regs->ahclkrctl);
> + suart_mcasp_rx_baud_set(rx_baud_value, oversampling, pruss_ioaddr);
> + iowrite32(MCASP_SUART_RTDMS0, &mcasp0_regs->rtdm);
> + iowrite32(MCASP_SUART_RSYNCERR, &mcasp0_regs->rintctl);
> + iowrite32(MCASP_SUART_RMAX_RPS_256, &mcasp0_regs->rclkchk);
> +
> + /* configure transmit registers. */
> + iowrite32(MCASP_SUART_XMASK_0_31, &mcasp0_regs->xmask);
> + iowrite32(MCASP_SUART_XBUSEL_XSSZ_16_XPAD_0, &mcasp0_regs->xfmt);
> + iowrite32(MCASP_SUART_FSXM, &mcasp0_regs->afsxctl);
> + iowrite32(MCASP_SUART_CLKXM_ASYNC_CLKXP, &mcasp0_regs->aclkxctl);
> + iowrite32(MCASP_SUART_HCLKXM, &mcasp0_regs->ahclkxctl);
> +
> + suart_mcasp_tx_baud_set(tx_baud_value, pruss_ioaddr);
> + iowrite32(MCASP_SUART_XTDMS0, &mcasp0_regs->xtdm);
> + iowrite32(MCASP_SUART_XSYNCERR, &mcasp0_regs->xintctl);
> + iowrite32(MCASP_SUART_XMAX_XPS_256, &mcasp0_regs->xclkchk);
> +
> + /* Serializer as a transmitter */
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl0);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl1);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl2);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl3);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl4);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl5);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl6);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl7);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl8);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl9);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl10);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl11);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl12);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl13);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl14);
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl15);
> +
> + /* Configure all AXR[n] as McASP pins  */
> +
> + /*
> + *  Setting  all TX MCASP AXR[n] Pin mapped to Even Serializer number
> + *  (0,2,4,6,8,10,12,14) to GPIO Mode by default. During setting the
> + *  serializer to TX mode in PRU assembly code, the MCASP AXR[n] Pin
> + *  would get configured to MCASP mode of operation,
> + *  before Actual Data Transfer
> + */
> +
> + /* Setting  all TX Pin to GPIO Mode by default */
> + temp_reg = (OMAPL_MCASP_PFUNC_RESETVAL) |
> +     (1 << PRU_SUART0_CONFIG_TX_SER) | (1 << PRU_SUART1_CONFIG_TX_SER) |
> +     (1 << PRU_SUART2_CONFIG_TX_SER) | (1 << PRU_SUART3_CONFIG_TX_SER) |
> +     (1 << PRU_SUART4_CONFIG_TX_SER) | (1 << PRU_SUART5_CONFIG_TX_SER) |
> +     (1 << PRU_SUART6_CONFIG_TX_SER) | (1 << PRU_SUART7_CONFIG_TX_SER);
> + iowrite32(temp_reg, &mcasp0_regs->pfunc);
> +
> + iowrite32(0xFFF, &mcasp0_regs->pdout);
> +
> + /* config pin function and direction */
> + iowrite32(0x00000000, &mcasp0_regs->pdir);
> + temp_reg =
> +     (1 << PRU_SUART0_CONFIG_TX_SER) | (1 << PRU_SUART1_CONFIG_TX_SER) |
> +     (1 << PRU_SUART2_CONFIG_TX_SER) | (1 << PRU_SUART3_CONFIG_TX_SER) |
> +     (1 << PRU_SUART4_CONFIG_TX_SER) | (1 << PRU_SUART5_CONFIG_TX_SER) |
> +     (1 << PRU_SUART6_CONFIG_TX_SER) | (1 << PRU_SUART7_CONFIG_TX_SER) |
> +     (MCASP_PDIR_VAL);
> + iowrite32(temp_reg, &mcasp0_regs->pdir);
> +
> + iowrite32(MCASP_SUART_DIT_DISABLE, &mcasp0_regs->ditctl);
> + iowrite32(MCASP_SUART_LOOPBACK_DISABLE, &mcasp0_regs->dlbctl);
> + iowrite32(MCASP_SUART_AMUTE_DISABLE, &mcasp0_regs->amute);
> +
> + iowrite32(MCASP_SUART_XSTAT, &mcasp0_regs->xstat);
> + iowrite32(MCASP_SUART_RSTAT, &mcasp0_regs->rstat);
> +}
> +
> +void suart_mcasp_tx_serialzier_set(u32 serializer_num,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> + u32 temp_reg;
> + temp_reg = ioread32(&mcasp0_regs->pfunc);
> + temp_reg |= (0x1 << serializer_num);
> + iowrite32(temp_reg, &mcasp0_regs->pfunc);
> +}
> +
> +/*
> + * mcasp TX buard rate setting routine
> + */
> +static s16 suart_mcasp_tx_baud_set(u32 tx_baud_value,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + u32 clk_div_val;
> + u32 loop_cnt;
> + s16 status = 0;
> + s16 found_val = false;
> +
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> + u32 temp_reg;
> +
> + /* Search the supported baud rate in the table */
> + for (loop_cnt = 0; loop_cnt < SUART_NUM_OF_BAUDS_SUPPORTED;
> + loop_cnt++) {
> + if (tx_baud_value == lt_tx_baud_rate[loop_cnt][0]) {
> + found_val = true;
> + break;
> + }
> + }
> + if (found_val == true) {
> + clk_div_val = lt_tx_baud_rate[loop_cnt][2];
> + temp_reg = ioread32(&mcasp0_regs->aclkxctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_ACLKXCTL_CLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->aclkxctl);
> + clk_div_val = lt_tx_baud_rate[loop_cnt][3];
> + temp_reg = ioread32(&mcasp0_regs->ahclkxctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->ahclkxctl);
> + } else {
> + return -EINVAL ;
> + }
> + return status;
> +}
> +
> +/*
> + * mcasp RX buard rate setting routine
> + */
> +static s16 suart_mcasp_rx_baud_set(u32 rx_baud_value,
> + u32 oversampling, struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + u32 clk_div_val = 0;
> + u32 loop_cnt = 0;
> + s16 status = 0;
> + u32 temp_reg = 0;
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> +
> + switch (oversampling) {
> + case SUART_8X_OVRSMPL:
> + for (loop_cnt = 0; loop_cnt < SUART_NUM_OF_BAUDS_SUPPORTED;
> +      loop_cnt++) {
> + if (rx_baud_value == lt_rx_8x_baud_rate[loop_cnt][0]) {
> + clk_div_val = lt_rx_8x_baud_rate[loop_cnt][2];
> + temp_reg = ioread32(&mcasp0_regs->aclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_ACLKXCTL_CLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->aclkrctl);
> +
> + clk_div_val =
> + lt_rx_8x_baud_rate[loop_cnt][3] - 1;
> +
> + temp_reg = ioread32(&mcasp0_regs->ahclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->ahclkrctl);
> + break;
> + }
> + }
> + status = -EINVAL;
> + break;
> + case SUART_16X_OVRSMPL:
> + for (loop_cnt = 0; loop_cnt < SUART_NUM_OF_BAUDS_SUPPORTED;
> +      loop_cnt++) {
> + if (rx_baud_value == lt_rx_16x_baud_rate[loop_cnt][0]) {
> + clk_div_val = lt_rx_16x_baud_rate[loop_cnt][2];
> + temp_reg = ioread32(&mcasp0_regs->aclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_ACLKXCTL_CLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->aclkrctl);
> + clk_div_val = lt_rx_16x_baud_rate[loop_cnt][3];
> + temp_reg = ioread32(&mcasp0_regs->ahclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->ahclkrctl);
> + break;
> + }
> + }
> + status = -EINVAL;
> + break;
> + case SUART_TX_OVRSMPL:
> + for (loop_cnt = 0; loop_cnt < SUART_NUM_OF_BAUDS_SUPPORTED;
> +      loop_cnt++) {
> + if (rx_baud_value == lt_tx_baud_rate[loop_cnt][0]) {
> + clk_div_val = lt_tx_baud_rate[loop_cnt][2];
> + temp_reg = ioread32(&mcasp0_regs->aclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_ACLKXCTL_CLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->aclkrctl);
> + clk_div_val = lt_tx_baud_rate[loop_cnt][3];
> + temp_reg = ioread32(&mcasp0_regs->ahclkrctl);
> + temp_reg |= (clk_div_val <<
> + OMAPL_MCASP_AHCLKXCTL_HCLKXDIV_SHIFT);
> + iowrite32(temp_reg, &mcasp0_regs->ahclkrctl);
> + break;
> + }
> + }
> + status = -EINVAL;
> + break;
> + default:
> + status = -EINVAL;
> + break;
> + }
> +
> + return status;
> +}
> +
> +/*
> + * mcasp buard rate setting routine
> + */
> +s16 suart_asp_baud_set(u32 tx_baud_value, u32 rx_baud_value, u32 
> oversampling,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + s16 status = 0;
> +
> + status = suart_mcasp_tx_baud_set(tx_baud_value, pruss_ioaddr);
> + status = suart_mcasp_rx_baud_set(rx_baud_value, oversampling,
> + pruss_ioaddr);
> +
> + return status;
> +}
> +
> +/*
> + * mcasp deactivate the selected serializer
> + */
> +s16 suart_asp_serializer_deactivate(u16 sr_num,
> + struct pruss_suart_iomap *pruss_ioaddr)
> +{
> + s16 status = 0;
> + struct omapl_mcasp_regs_ovly __iomem *mcasp0_regs =
> + pruss_ioaddr->mcasp_io_addr;
> + if (sr_num > 15)
> + status = -EINVAL;
> + else
> + iowrite32(MCASP_SUART_SRCTL_DISMOD, &mcasp0_regs->srctl0);
> +
> + return status;
> +}
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 758c5b0..eae37fe 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -202,6 +202,8 @@
> /* VIA VT8500 SoC */
> #define PORT_VT8500 97
>
> +#define PORT_DA8XX_PRU_SUART 98
> +
> #ifdef __KERNEL__
>
> #include <linux/compiler.h>
> -- 
> 1.7.2.3
> 


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.231.1305382889.1530.linux-arm-kernel@lists.infradead.org>

get benefit from this. Some client driver can be written as regulator
platform device.
And mfd driver can use them seamless. What's your opinion?

Best Regards
Haojian


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.232.1305406685.1530.linux-arm-kernel@lists.infradead.org>

don't see a clean way of integrating over the existing interfaces to
the ftrace framework (e.g., the global perf event pump seems to be a
mismatch), but I may be missing something obvious.   In my view,
implementing this nestled between the seccomp/ftrace world provides a
stepping stone forward without being too restrictive.  No matter how
we change security events in the future, system calls will always be
the first line of attack surface reduction.  It could just mean that,
in the long term, accessing the "security event filtering" framework
is done through another new interface with seccomp providing only a
targeted syscall filtering featureset that may one day be deprecated
(if that day ever comes).

If there's a clear way to cleanly expand this interface that I'm
missing, I'd love to know - thanks!
will

> Also, to answer you, do you say that by my argument someone should have s=
tood
> up and said 'no' to the LSM mess that was introduced a couple of years ag=
o and
> which caused so many problems:
>
> =A0- kernel inefficiencies and user-space overhead
>
> =A0- stalled security efforts
>
> =A0- infighting
>
> =A0- friction, fragmentation, overmodularization
>
> =A0- non-stackability
>
> =A0- security annoyances on the Linux desktop
>
> =A0- probably *less* Linux security
>
> and should have asked them to do something better designed instead?
>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>


>From bogus@does.not.exist.com  Fri Oct 22 17:57:35 2010
From: bogus@does.not.exist.com ()
Date: Fri, 22 Oct 2010 21:57:35 -0000
Subject: No subject
Message-ID: <mailman.242.1305639040.1530.linux-arm-kernel@lists.infradead.org>

point you'd start thinking about configuration, assumptions, filesystem 
access, namespaces, indirect access (e.g. via sockets, rpc, ipc, shared 
memory, invocation).

Anyway, this is getting off track from the main discussion, but you 
asked...



- James
-- 
James Morris
<jmorris@namei.org>
