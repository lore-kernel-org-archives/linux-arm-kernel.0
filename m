From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Feb 2014 17:54:32 +0100
Subject: [PATCH] PCI: MVEBU: Use Device ID and revision from underlying
 endpoint
In-Reply-To: <20140205172110.22507687@skate>
References: <1391597749-29807-1-git-send-email-andrew@lunn.ch>
 <20140205172110.22507687@skate>
Message-ID: <20140205165432.GD29860@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > @@ -388,7 +380,8 @@ static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
> >  
> >  	bridge->class = PCI_CLASS_BRIDGE_PCI;
> >  	bridge->vendor = PCI_VENDOR_ID_MARVELL;
> 
> This could also have been replaced by:
> 
> 	bridge->vendor = mvebu_readl(port, PCIE_DEV_ID_OFF) & 0xff;

O.K, but do we ever expect it not to be PCI_VENDOR_ID_MARVELL on the
underlying hardware?

> 
> > -	bridge->device = MARVELL_EMULATED_PCI_PCI_BRIDGE_ID;
> > +	bridge->device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
> > +	bridge->revision = mvebu_readl(port, PCIE_DEV_REV_OFF) & 0xff;
> 
> On Armada 370 and XP, this field is apparently always 0x0, so not very
> useful. But if it's useful on other mvebu SoCs, that's fine, it's just
> an informative field anyway.

Humm, that should be the stepping, unless i have made a mistake. The
code Gregory wrote for mvebu-soc-id.c does:

       /* SoC ID */
        soc_dev_id = readl(pci_base + PCIE_DEV_ID_OFF) >> 16;

        /* SoC revision */
        soc_rev = readl(pci_base + PCIE_DEV_REV_OFF) & SOC_REV_MASK;

However, the box i'm testing on has stepping 0, so it is hard to test.
Could you test this in an OpenBlocks AX3 B0, or some other B0 device?

Thanks
	Andrew
