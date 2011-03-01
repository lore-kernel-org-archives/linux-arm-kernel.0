From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 1 Mar 2011 10:51:43 +0100 (CET)
Subject: [PATCH v6 1/1] PRUSS UIO driver support
In-Reply-To: <1298926895-5294-2-git-send-email-pratheesh@ti.com>
References: <1298926895-5294-1-git-send-email-pratheesh@ti.com>
	<1298926895-5294-2-git-send-email-pratheesh@ti.com>
Message-ID: <alpine.LFD.2.00.1103011045340.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, Pratheesh Gangadhar wrote:
> +
> +static spinlock_t lock;

static DEFINE_SPINLOCK(lock);

> +static struct clk *pruss_clk;
> +static struct uio_info *info;
> +static dma_addr_t sram_paddr, ddr_paddr;
> +static void *prussio_vaddr, *sram_vaddr, *ddr_vaddr;
> +
> +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> +{
> +	unsigned long flags;
> +	int val, intr_mask = (1 << (irq - 1));
> +	void __iomem *base = dev_info->mem[0].internal_addr;
> +	void __iomem *intren_reg = base + PINTC_HIER;
> +	void __iomem *intrstat_reg = base + PINTC_HIPIR + ((irq - 1) << 2);
> +
> +	spin_lock_irqsave(&lock, flags);

spin_lock() is enough as we run handlers with interrupts disabled.

> +	val = ioread32(intren_reg);
> +	/* Is interrupt enabled and active ? */
> +	if (!(val & intr_mask) && (ioread32(intrstat_reg) & HIPIR_NOPEND)) {
> +		spin_unlock_irqrestore(&lock, flags);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Disable interrupt */
> +	iowrite32((val & ~intr_mask), intren_reg);
> +	spin_unlock_irqrestore(&lock, flags);
> +	return IRQ_HANDLED;
> +}

So now you still have not solved the problem of user space enabling an
interrupt again. That's racy as well and you can solve it by providing
an uio->irq_control function which handles the interrupt enable
register under the lock as well.

Thanks,

	tglx
