From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 2 Oct 2018 12:01:14 +0100
Subject: [PATCH v5 6/9] PCI: mediatek: Enable msi after clock enabled
In-Reply-To: <1538129080-8206-7-git-send-email-honghui.zhang@mediatek.com>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
 <1538129080-8206-7-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20181002110114.GB27736@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 06:04:37PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The clocks was not enabled when enable MSI. This patch fix this
> issue by calling mtk_pcie_enable_msi in mtk_pcie_startup_port_v2
> since the clock was all enabled at that time.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

If this is a fix, and I think it is, I would appreciate a Fixes: tag
so that we can actully pinpoint the faulty commit.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index d150be1..be38b38 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -572,8 +572,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  		ret = mtk_pcie_allocate_msi_domains(port);
>  		if (ret)
>  			return ret;
> -
> -		mtk_pcie_enable_msi(port);
>  	}
>  
>  	return 0;
> @@ -694,6 +692,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	val &= ~INTX_MASK;
>  	writel(val, port->base + PCIE_INT_MASK);
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		mtk_pcie_enable_msi(port);
> +
>  	/* Set AHB to PCIe translation windows */
>  	size = mem->end - mem->start;
>  	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> -- 
> 2.6.4
> 
