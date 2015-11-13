From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 13 Nov 2015 03:06:27 +0000
Subject: [PATCH] PCI: hisi: fix deferred probing
In-Reply-To: <4417267.EzK5DAjM5p@wuerfel>
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
 <4417267.EzK5DAjM5p@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162AA609@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd, this looks ok to me

Zhou Wang can you please Ack?

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: 12 November 2015 12:22
> To: linux-arm-kernel at lists.infradead.org
> Cc: Jisheng Zhang; Wangzhou (B); bhelgaas at google.com; linux-
> pci at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] PCI: hisi: fix deferred probing
> 
> The hisi_pcie_probe function is incorrectly marked as __init, as Kconfig
> tells us:
> 
> WARNING: drivers/pci/host/built-in.o(.data+0x7780): Section mismatch in
> reference from the variable hisi_pcie_driver to the
> function .init.text:hisi_pcie_probe()
> 
> If the probe for this device gets deferred past the point where __init
> functions are removed, or the device is unbound and then reattached to
> the driver, we branch into uninitialized memory, which is bad.
> 
> This removes the __init annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 35457ecd8e70..163671a4f798 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -111,7 +111,7 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
>  	.link_up = hisi_pcie_link_up,
>  };
> 
> -static int __init hisi_add_pcie_port(struct pcie_port *pp,
> +static int hisi_add_pcie_port(struct pcie_port *pp,
>  				     struct platform_device *pdev)
>  {
>  	int ret;
> @@ -139,7 +139,7 @@ static int __init hisi_add_pcie_port(struct pcie_port *pp,
>  	return 0;
>  }
> 
> -static int __init hisi_pcie_probe(struct platform_device *pdev)
> +static int hisi_pcie_probe(struct platform_device *pdev)
>  {
>  	struct hisi_pcie *hisi_pcie;
>  	struct pcie_port *pp;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
