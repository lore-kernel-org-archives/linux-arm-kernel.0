From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 25 Feb 2011 10:54:28 +0100 (CET)
Subject: [PATCH v5 1/2] PRUSS UIO driver support
In-Reply-To: <1298623530-10294-2-git-send-email-pratheesh@ti.com>
References: <1298623530-10294-1-git-send-email-pratheesh@ti.com>
	<1298623530-10294-2-git-send-email-pratheesh@ti.com>
Message-ID: <alpine.LFD.2.00.1102251049090.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Feb 2011, Pratheesh Gangadhar wrote:
> +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> +{
> +	void __iomem *base = dev_info->mem[0].internal_addr;
> +	void __iomem *intren_reg = base + PINTC_HIER;
> +	void __iomem *intrstat_reg = base + PINTC_HIPIR + ((irq - 1) << 2);
> +	int val = ioread32(intren_reg), intr_mask = (1 << (irq - 1));
> +
> +	/* Is interrupt enabled and active ? */
> +	if (!(val & intr_mask) && (ioread32(intrstat_reg) & HIPIR_NOPEND))
> +		return IRQ_NONE;
> +
> +	/* Disable interrupt */
> +	iowrite32((val & ~intr_mask), intren_reg);
> +	return IRQ_HANDLED;
> +}

Hmm, just noticed, that you fiddle with the interrupt enable register
here totally unprotected. So on a SMP system you might haandle two
different interrupts at the same time. That wants locking.

And even on UP, you have a problem as you reenable that thing from
user space which requires a read modify write. Racy as hell.

Please look at the other UIO drivers which have the same problem.
Sorry for not noticing earlier!

Thanks,

	tglx
