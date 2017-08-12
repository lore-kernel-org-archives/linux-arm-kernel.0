From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sat, 12 Aug 2017 08:57:21 +0800
Subject: [PATCH] PCI: mediatek: add msi support for mt2712 and mt7622
In-Reply-To: <1502454469-29230-1-git-send-email-honghui.zhang@mediatek.com>
References: <1502454469-29230-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1502499441.31707.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Honghui,

On Fri, 2017-08-11 at 20:27 +0800, honghui.zhang at mediatek.com wrote:
...
> +static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> +{
> +	u32 val;
> +
> +	val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> +	writel(val, port->base + PCIE_IMSI_ADDR);
> +
> +	val = readl(port->base + PCIE_INT_MASK);
> +	val &= ~MSI_MASK;
> +	writel(val, port->base + PCIE_INT_MASK);
> +}
> +
>  static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  			     irq_hw_number_t hwirq)
>  {
> @@ -460,6 +574,18 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  		return PTR_ERR(port->irq_domain);
>  	}
>  
> +	/* Setup MSI */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
> +							 &msi_domain_ops,
> +							 &mtk_pcie_msi_chip);
> +		if (!port->msi_domain) {
> +			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> +			return PTR_ERR(port->msi_domain);

Just return -ENOMEM. PTR_ERR(NULL) will cause a static checker warning.

> +		}
> +		mtk_pcie_enable_msi(port);
> +	}
> +
>  	return 0;
>  }

Ryder
