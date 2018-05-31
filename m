From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 30 May 2018 23:20:20 -0500
Subject: [PATCH] PCI: mediatek: Add system pm support for MT2712
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20180531042020.GQ39853@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 10:35:36AM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The MTCMOS of PCIe Host for MT2712 will be off when system suspend, and all
> the internel control register will be reset after system resume. The PCIe
> link should be re-established and the related control register values should
> be re-set after system resume.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> CC: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 82 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index dabf1086..60f98d92 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -132,12 +132,14 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> + * @pm_support: whether the host's MTCMOS will be off when suspend
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> +	bool pm_support;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -1179,12 +1181,91 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct mtk_pcie *pcie;
> +	struct mtk_pcie_port *port;
> +	const struct mtk_pcie_soc *soc;
> +
> +	pdev = to_platform_device(dev);
> +	pcie = platform_get_drvdata(pdev);
> +	soc = pcie->soc;
> +	if (!soc->pm_support)
> +		return 0;
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		clk_disable_unprepare(port->ahb_ck);
> +		clk_disable_unprepare(port->sys_ck);
> +		phy_power_off(port->phy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)

I don't really like the __maybe_unused annotations.  Looking at the
other users of SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, I think a small majority
of them wrap the function definitions in #ifdef CONFIG_PM_SLEEP
instead of using __maybe_unused.  That's also a bit ugly, but has the
advantage of truly omitting the definitions when they're not needed.
