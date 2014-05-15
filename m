From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 20:20:13 +0200
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on designware
 core driver
In-Reply-To: <5374FD24.8000806@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel> <5374FD24.8000806@ti.com>
Message-ID: <22200719.Jb5jnJylJH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 13:45:08 Murali Karicheri wrote:
> >> +#ifdef CONFIG_PCI_KEYSTONE
> >> +/*
> >> + * The KeyStone PCIe controller has maximum read request size of 256 bytes.
> >> + */
> >> +static void quirk_limit_readrequest(struct pci_dev *dev)
> >> +{
> >> +    int readrq = pcie_get_readrq(dev);
> >> +
> >> +    if (readrq > 256)
> >> +            pcie_set_readrq(dev, 256);
> >> +}
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_readrequest);
> >> +#endif /* CONFIG_PCI_KEYSTONE */
> > This doesn't work: you can't just limit do this for all devices just based
> > on PCI_KEYSTONE being enabled, you have to check if you are actually using
> > this controller.
> >
> >       Arnd
>   I assume, I need to check if PCI controller's vendor ID/ device ID 
> match with the keystone
>   PCI controller's ID and call pcie_set_readrq() for all of the slave 
> PCI devices and do this fixup.
> Is this correct understanding?  If you can point me to an example code 
> for this that will be
> really helpful so that I can avoid re-inventing the wheel.

I think it would be best to move the quirk into the keystone pci driver
and compare compare the dev->driver pointer of the PCI controller device.

	Arnd
