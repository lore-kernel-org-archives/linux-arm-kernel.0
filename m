From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 16:25:28 +0200
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
In-Reply-To: <20160411175651.5f32a990@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160327140348.GA19498@lunn.ch>
 <20160411175651.5f32a990@free-electrons.com>
Message-ID: <20160414162528.678be5b7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 11 Apr 2016 17:56:51 +0200, Thomas Petazzoni wrote:

> > > +	struct pcie_port *pp = arg;
> > > +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> > > +	void __iomem *base = pcie->base;
> > > +	u32 val;
> > > +
> > > +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > > +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > > +
> > > +	return IRQ_HANDLED;
> > 
> > Maybe a comment as to why you are just throwing them away.
> 
> I'll have a look into this.

Enabling the INT A-D interrupts is needed for the PCI device drivers to
receive interrupts from their respective PCI devices. But then, once
you enable the INT A-D interrupts, they are also latched into the PCIe
controller, so if you don't acknowledge them in the PCIe controller
level, at the first interrupt coming from a PCI device, the system
hangs. I've added a comment in the driver about this.

> Is this needed? The clocks are registered in of_clk_init(), i.e at
> time_init() time. This is way before the device drivers get probed, no?

The clock drivers are now regular platform drivers, so I'll add the
EPROBE_DEFER handling logic.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
