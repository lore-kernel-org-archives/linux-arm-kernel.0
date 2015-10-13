From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 13:12:12 +0200
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <20151012213545.GA17479@localhost>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com>
 <20151012213545.GA17479@localhost>
Message-ID: <6336414.HvfCQcuT3Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 16:35:45 Bjorn Helgaas wrote:
> 
> > +{
> > +     u64 addr;
> > +     struct device_node *msi_node;
> > +     struct resource res;
> > +     struct device_node *np = pp->dev->of_node;
> > +     struct hisi_pcie *pcie = to_hisi_pcie(pp);
> > +
> > +     msi_node = of_parse_phandle(np, "msi-parent", 0);
> > +     if (!msi_node) {
> > +             dev_err(pp->dev, "failed to find msi-parent\n");
> > +             return -EINVAL;
> > +     }
> > +     of_address_to_resource(msi_node, 0, &res);
> 
> Does this use the "msi-parent" node in the same way as other drivers
> do?  I'm sure there must be other places where we extract struct
> resource information from an "msi-parent" node, but I don't see them.
> 
> I'm trying to verify that this isn't some kind of incompatible
> extension of the "msi-parent" property.  I cc'd Arnd and Rob (DT
> experts).

This is not ok, what this does is that it relies on a particular
implementation of the MSI controller and directly accesses its
registers.

Instead, it should reference only the msi irq domain and let the
driver for the MSI controller access the registers. Otherwise this
code has to be rewritten once the same PCI host code appears in
a machine that has a real GICv2m or GICv3.

	Arnd
