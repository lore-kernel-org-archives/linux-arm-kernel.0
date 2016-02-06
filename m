From: blogic@openwrt.org (John Crispin)
Date: Sat, 6 Feb 2016 16:40:03 +0100
Subject: [PATCH] MIPS: pci-mt7620: Fix return value check in
 mt7620_pci_probe()
In-Reply-To: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
References: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
Message-ID: <56B613D3.2070709@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/02/2016 15:24, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Hi,

thanks for the fix.

Acked-by: John Crispin <blogic@openwrt.org>

@Ralf: can you merge this via LMO with the next PR please ?

@mbgg: ignore the patch please it is for the legacy MIPS SoCs

	John

> ---
>  arch/mips/pci/pci-mt7620.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
> index a009ee4..044c1cd 100644
> --- a/arch/mips/pci/pci-mt7620.c
> +++ b/arch/mips/pci/pci-mt7620.c
> @@ -297,12 +297,12 @@ static int mt7620_pci_probe(struct platform_device *pdev)
>  		return PTR_ERR(rstpcie0);
>  
>  	bridge_base = devm_ioremap_resource(&pdev->dev, bridge_res);
> -	if (!bridge_base)
> -		return -ENOMEM;
> +	if (IS_ERR(bridge_base))
> +		return PTR_ERR(bridge_base);
>  
>  	pcie_base = devm_ioremap_resource(&pdev->dev, pcie_res);
> -	if (!pcie_base)
> -		return -ENOMEM;
> +	if (IS_ERR(pcie_base))
> +		return PTR_ERR(pcie_base);
>  
>  	iomem_resource.start = 0;
>  	iomem_resource.end = ~0;
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
