From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 13 May 2015 08:27:47 +0200
Subject: [PATCH 2/2] PCI: iproc: add bcma pcie driver
In-Reply-To: <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
 <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rxVpJ-4b_5jG91JN62jQHh8u=QaLpO+_7J9mFr+_ScPaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2015 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver adds support for the PCIe 2.0 controller found on the bcma
> bus. This controller can be found on (mostly) all Broadcom BCM470X /
> BCM5301X ARM SoCs.
>
> The driver found in the Broadcom SDK does some more stuff, like setting
> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
> PHY changes like "improving" the PCIe jitter and doing some special
> initializations for the 3rd PCIe port.
>
> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
> connected to them.
>
> PCI_DOMAINS is needed by this driver, because normally there is more
> than one PCIe controller and without PCI_DOMAINS only the first
> controller gets registered.
> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafa? Mi?ecki <zajec5@gmail.com>


> +static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
> +{
> +       struct iproc_pcie *pcie;
> +       LIST_HEAD(res);
> +       struct resource res_mem;
> +       int ret;
> +
> +       pcie = devm_kzalloc(&bdev->dev, sizeof(*pcie), GFP_KERNEL);
> +       if (!pcie)
> +               return -ENOMEM;
> +
> +       pcie->dev = &bdev->dev;
> +       bcma_set_drvdata(bdev, pcie);
> +
> +       pcie->base = bdev->io_addr;
> +
> +       res_mem.start = bdev->addr_s[0];
> +       res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> +       res_mem.name = "PCIe MEM space";
> +       res_mem.flags = IORESOURCE_MEM;
> +       pci_add_resource(&res, &res_mem);
> +
> +       pcie->resources = &res;
> +
> +       pcie->map_irq = iproc_pcie_bcma_map_irq;
> +
> +       ret = iproc_pcie_setup(pcie);

I think I don't like this part of iproc design. It lefts
pcie->resources pointing to some random memory after the setup/probe
are done. Guess it should be a separated parameter or sth.

The patch is still OK, I just refer to generic iproc possible issue.
