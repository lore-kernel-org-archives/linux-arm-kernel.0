From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 4 Oct 2013 16:50:39 -0600
Subject: [PATCH] PCI: exynos: missing clk_disable_unprepare() on error in
 exynos_pcie_probe()
In-Reply-To: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
References: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
Message-ID: <20131004225039.GA26108@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 10:29:11AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from exynos_pcie_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied with Jingoo's ack and Sylwester's subject line to
pci/host-exynos.  Thanks!

Bjorn

> ---
>  drivers/pci/host/pci-exynos.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 94e096b..e25598a 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -487,18 +487,24 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	exynos_pcie->elbi_base = devm_ioremap_resource(&pdev->dev, elbi_base);
> -	if (IS_ERR(exynos_pcie->elbi_base))
> -		return PTR_ERR(exynos_pcie->elbi_base);
> +	if (IS_ERR(exynos_pcie->elbi_base)) {
> +		ret = PTR_ERR(exynos_pcie->elbi_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	exynos_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
> -	if (IS_ERR(exynos_pcie->phy_base))
> -		return PTR_ERR(exynos_pcie->phy_base);
> +	if (IS_ERR(exynos_pcie->phy_base)) {
> +		ret = PTR_ERR(exynos_pcie->phy_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>  	exynos_pcie->block_base = devm_ioremap_resource(&pdev->dev, block_base);
> -	if (IS_ERR(exynos_pcie->block_base))
> -		return PTR_ERR(exynos_pcie->block_base);
> +	if (IS_ERR(exynos_pcie->block_base)) {
> +		ret = PTR_ERR(exynos_pcie->block_base);
> +		goto fail_bus_clk;
> +	}
>  
>  	ret = add_pcie_port(pp, pdev);
>  	if (ret < 0)
> 
