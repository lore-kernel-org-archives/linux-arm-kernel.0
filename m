From: marex@denx.de (Marek Vasut)
Date: Thu, 10 Oct 2013 12:25:10 +0200
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310082256.28474.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <201310101225.10455.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> Hi Marek:
> Thanks for your kindly tests.
> 
> Regarding to my experience on 3.0.35 kernel, besides the programming the
> RdWr0 vs. RdWr1 mode into the iATU. The INTx should be configured
> properly, for example, like the following one:
> 
> static int __init imx_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
> {
>        switch (pin) {
>        case 1: return MXC_INT_PCIE_3;
>        case 2: return MXC_INT_PCIE_2;
>        case 3: return MXC_INT_PCIE_1;
>        case 4: return MXC_INT_PCIE_0;
>        default: return -1;
>        }
> }
> 
> static struct hw_pci imx_pci __initdata = {
>         .nr_controllers = 1,
>         .swizzle        = pci_std_swizzle,
>         .setup          = imx_pcie_setup,
>         .scan           = imx_pcie_scan_bus,
>         .map_irq        = imx_pcie_map_irq,
> };
> Best Regards
> Richard Zhu

Thanks for pointing this out, I'll check this. Are there plans to implement the 
PCIe switch support already so I won't step into someone else's work?

In the meantime, this is what I see upon probe with V6 of the patches:

Linux version 3.12.0-rc2-next-20130927+
[...]
imx6q-pcie 1ffc000.pcie: phy link never came up
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
PCI: Device 0000:00:00.0 not available because of resource collisions
pcieport: probe of 0000:00:00.0 failed with error -22
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0: PCI bridge to [bus 01]

Is this line normal/expected? Is this related to the PCIe switch I have there?
pcieport: probe of 0000:00:00.0 failed with error -22

Thank you for your help!

Best regards,
Marek Vasut
