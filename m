From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 26 Jul 2015 13:48:03 +0200 (CEST)
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
Message-ID: <alpine.DEB.2.11.1507261346250.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jul 2015, Shenwei Wang wrote:
> +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct imx_gpcv2_irq *cd = d->chip_data;
> +	unsigned int idx = d->hwirq / 32;
> +	unsigned long flags;
> +	void __iomem *reg;
> +	u32 mask, val;
> +
> +	raw_spin_lock_irqsave(&cd->lock.rlock, flags);

Oh no. You need to make cd->lock a raw_spinlock and then use
raw_spin_lock_irqsave() on it. How on earth did you come up with this
hackery?

Thanks,

	tglx
