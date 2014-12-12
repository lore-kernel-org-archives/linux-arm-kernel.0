From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Dec 2014 18:30:03 +0100
Subject: [PATCH 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
 <1418404441-5518-5-git-send-email-svarbanov@mm-sol.com>
Message-ID: <2577563.x0mEZJNVDQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 December 2014 19:14:00 Stanimir Varbanov wrote:
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Looks nice!

> +static int
> +qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size, u32 *val)
> +{
> +	if (where == PCI_CLASS_REVISION && size == 4) {
> +		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
> +		*val &= ~(0xffff << 16);
> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> +				size, val);
> +}

Could you add a comment here to explain what this is for?

> +static int __init qcom_pcie_probe(struct platform_device *pdev)
> +{

I think it's a bug to mark this function as __init. It breaks
deferred probing and detaching/reattaching the device trough sysfs.

After you fix that, you can remove the __refdata below.

> +static struct platform_driver __refdata qcom_pcie_driver = {
> +	.probe = qcom_pcie_probe,
> +	.remove = qcom_pcie_remove,
> +	.driver = {
> +		.name = "qcom-pcie",
> +		.of_match_table = qcom_pcie_match,
> +	},
> +};

	Arnd
