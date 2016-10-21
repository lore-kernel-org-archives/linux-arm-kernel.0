From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 21 Oct 2016 10:37:01 -0500
Subject: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL
 pointer
In-Reply-To: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
References: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <20161021153701.GC9007@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 04:44:06PM -0500, Li Yang wrote:
> Commit fefe6733e added reference to the pcie->drvdata before it is
> initialized which causes a kernel panic.  Fix the problem by
> initializing the pcie->drvdata earlier before it is used.
> 
> Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

I applied Marc Zyngier's identical patch to for-linus for v4.9.  I don't
know which was posted first, but I saw Marc's first.  Sorry I didn't at
least credit you when I applied it.

> ---
>  drivers/pci/host/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 2cb7315..958187f 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -245,6 +245,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	if (!pcie)
>  		return -ENOMEM;
>  
> +	pcie->drvdata = match->data;
>  	pp = &pcie->pp;
>  	pp->dev = dev;
>  	pp->ops = pcie->drvdata->ops;
> @@ -256,7 +257,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->pp.dbi_base);
>  	}
>  
> -	pcie->drvdata = match->data;
>  	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
>  
>  	if (!ls_pcie_is_bridge(pcie))
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
