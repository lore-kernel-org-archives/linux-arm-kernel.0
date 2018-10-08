From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 8 Oct 2018 18:23:37 +0100
Subject: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
In-Reply-To: <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The PCIe controller of MT7622 has TYPE 1 configuration space type, but
> the HW default class type values is invalid.
> 
> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> type for MT7622") have set the class ID for MT7622 as
> PCI_CLASS_BRIDGE_HOST, but it's not workable for MT7622:
> 
> In __pci_bus_assign_resources, the framework only setup bridge's
> resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
> will leave the subordinary PCIe device's MMIO window un-touched.
> 
> Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
> driver do.

I think that this patch is correct but the commit log fails to pin point
the problem. The IP you are programming is a root port, that's why you
have to have the proper class code, the patch looks fine but I would
like to peek Bjorn's brain on this since it is a fundamental concept.

If the kernel does not assign resources unless it detects a
PCI_CLASS_BRIDGE_PCI this means that for components that are
actually PCI_CLASS_BRIDGE_HOST their register set must come
preprogrammed unless I am missing something.

I would like to get to the bottom of this since it is a fundamental
enumeration concept.

Thanks,
Lorenzo

> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 288b8e2..bcdac9b 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -432,7 +432,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		val = PCI_VENDOR_ID_MEDIATEK;
>  		writew(val, port->base + PCIE_CONF_VEND_ID);
>  
> -		val = PCI_CLASS_BRIDGE_HOST;
> +		val = PCI_CLASS_BRIDGE_PCI;
>  		writew(val, port->base + PCIE_CONF_CLASS_ID);
>  	}
>  
> -- 
> 2.6.4
> 
