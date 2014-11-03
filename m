From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Nov 2014 11:09:10 +0100
Subject: [RFC PATCH 1/2] arm: cns3xxx: pci: remove artificial dependency
 on pci_sys_data domain
In-Reply-To: <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
Message-ID: <1836395.qmSSqUtRH7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 November 2014 13:32:08 Micha? Miros?aw wrote:
> > @@ -335,7 +328,8 @@ void __init cns3xxx_pcie_init_late(void)
> >                 cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
> >                 cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
> >                 cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
> > -               pci_common_init(&cns3xxx_pcie[i].hw_pci);
> > +               private_data = &cns3xxx_pcie[i];
> > +               pci_common_init(&hw_pci);
> >         }
> 
> This looks weird. hw_pci.private_data is a pointer to a (temporary)
> pointer to private data?
> 

hw_pci is a local data structure that is only used to pass arguments
to pci_common_init. hw_pci->private_data is a pointer to an array of
pointers to the private data in each host bridge that is created in
the new domain during the call to pci_common_init. Like most other
callers, cns3xxx creates only one host bridge per domain, so it's
an array that contains only one entry.

	Arnd
