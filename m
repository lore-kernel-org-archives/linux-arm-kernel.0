From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 11 Apr 2016 17:56:51 +0200
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
In-Reply-To: <20160327140348.GA19498@lunn.ch>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160327140348.GA19498@lunn.ch>
Message-ID: <20160411175651.5f32a990@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, 27 Mar 2016 16:03:48 +0200, Andrew Lunn wrote:
> > +static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> > +{
> > +	struct pcie_port *pp = arg;
> > +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> > +	void __iomem *base = pcie->base;
> > +	u32 val;
> > +
> > +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > +
> > +	return IRQ_HANDLED;
> 
> Maybe a comment as to why you are just throwing them away.

I'll have a look into this.

> > +static int armada8k_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct armada8k_pcie *pcie;
> > +	struct pcie_port *pp;
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *base;
> > +	int ret;
> > +
> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pcie->main_clk = devm_clk_get(dev, "main");
> > +	if (!IS_ERR(pcie->main_clk))
> > +		clk_prepare_enable(pcie->main_clk);
> > +
> > +	pcie->lane_clk = devm_clk_get(dev, "port");
> > +	if (!IS_ERR(pcie->lane_clk))
> > +		clk_prepare_enable(pcie->lane_clk);
> 
> Any need to handle -EPRODE_DEFERED here?

Is this needed? The clocks are registered in of_clk_init(), i.e at
time_init() time. This is way before the device drivers get probed, no?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
