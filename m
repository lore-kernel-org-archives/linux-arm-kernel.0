From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Mar 2016 16:03:48 +0200
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
In-Reply-To: <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160327140348.GA19498@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> +	void __iomem *base = pcie->base;
> +	u32 val;
> +
> +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> +
> +	return IRQ_HANDLED;

Hi Thomas

Maybe a comment as to why you are just throwing them away.

> +}
> +
> +static struct pcie_host_ops armada8k_pcie_host_ops = {
> +	.link_up = armada8k_pcie_link_up,
> +	.host_init = armada8k_pcie_host_init,
> +};
> +
> +static int armada8k_pcie_probe(struct platform_device *pdev)
> +{
> +	struct armada8k_pcie *pcie;
> +	struct pcie_port *pp;
> +	struct device *dev = &pdev->dev;
> +	struct resource *base;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->main_clk = devm_clk_get(dev, "main");
> +	if (!IS_ERR(pcie->main_clk))
> +		clk_prepare_enable(pcie->main_clk);
> +
> +	pcie->lane_clk = devm_clk_get(dev, "port");
> +	if (!IS_ERR(pcie->lane_clk))
> +		clk_prepare_enable(pcie->lane_clk);

Any need to handle -EPRODE_DEFERED here?

    Andrew
