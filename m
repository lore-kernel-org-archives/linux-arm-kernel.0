From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 27 Jul 2015 13:58:17 +0000
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1507261346250.18576@nanos>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1507261346250.18576@nanos>
Message-ID: <CY1PR0301MB08438E910102580D0C0ECEBD838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?7?26? 6:48
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: Re: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Wed, 22 Jul 2015, Shenwei Wang wrote:
> > +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int
> > +on) {
> > +	struct imx_gpcv2_irq *cd = d->chip_data;
> > +	unsigned int idx = d->hwirq / 32;
> > +	unsigned long flags;
> > +	void __iomem *reg;
> > +	u32 mask, val;
> > +
> > +	raw_spin_lock_irqsave(&cd->lock.rlock, flags);
> 
> Oh no. You need to make cd->lock a raw_spinlock and then use
> raw_spin_lock_irqsave() on it. How on earth did you come up with this hackery?

I was thinking to use one spin_lock between the current two modules. But it should be 
okay to use a dedicate one for irqchip.

> Thanks,
> 
> 	tglx
