From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 15:19:53 -0600
Subject: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
In-Reply-To: <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4FD660F9.7030807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds support for message signaled interrupts to the Tegra
> PCIe controller. Based on code by Krishna Kishore <kthota@nvidia.com>.

> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c

> +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
...
> +			irq = irq_find_mapping(pcie->msi->domain, index);
> +			if (irq) {
> +				if (test_bit(index, pcie->msi->used))
> +					generic_handle_irq(irq);

This invokes the handler first ...

...
> +			/* clear the interrupt */
> +			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
> +			/* see if there's any more pending in this vector */
> +			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);

... then clears the interrupt status in the PCIe controller. Won't that
lose interrupts if one is raised between when the handler clears the
root-cause, and when this code clears the received interrupt status?

> +static int tegra_pcie_disable_msi(struct platform_device *pdev)

Should this free pcie->msi->pages?

Why allocate pcie->msi separately; why not include the fields directly
into struct tegra_pcie_info *pcie?
