From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 23:35:50 +0200
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device tree
 nodes
In-Reply-To: <1371554737-25319-12-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-12-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306182335.50722.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> +
> +                       ranges =
> +                              <0x82000000 0 0x40000    0xffff0001 0x40000 0 0x00002000
> +                               0x82000000 0 0x80000    0xffff0001 0x80000 0 0x00002000
> +                               0x82000000 0 0xe0000000 0xffff0002 0          0 0x08000000
> +                               0x81000000 0 0          0xffff0002 0x8000000  0 0x00100000>;

As pointed out on IRC, this is not a good representation of the memory space,
since it requires a non-zero sys->mem_offset, and it conflicts with the straight
mapping I suggested.

I think it should be

                               0x82000000 0 0xe0000000 0xffff0002 0  0xe0000000 0x08000000

if we want to encode the aperture in the ranges property here, i.e. have
a 1:1 mapping between PCI memory space and MBUS space, and in mbus,
you need the corresponding

-                           0xffff0002 0 0xe0000000 0x8100000
+                           0xffff0002 0xe0000000 0xe0000000 0x8100000

so that mbus actually translates the right addresses. You could also
have the PCI memory space start at 0, which would mean

                               0x82000000 0 0 0xffff0002 0  0 0x08000000

and

                              0xffff0002 0 0xe0000000 0x8100000

Note that the driver doesn't actually handle the generic case correctly, you would
need to apply this patch
	
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13a633b..aa674f4 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -790,6 +790,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pcie->mem);
+			sys->mem_offset = range.cpu_addr - range.pci_addr;
 			pcie->mem.name = "MEM";
 		}
 	}

to deal with the generic case where the bus address is different from the
CPU address.

	Arnd
