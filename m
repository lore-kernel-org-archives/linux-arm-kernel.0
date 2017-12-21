From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Thu, 21 Dec 2017 15:01:12 +0800
Subject: [PATCH v2 2/2] PCI: mediatek: Fixup class type for MT7622
In-Reply-To: <1513838476.23174.3.camel@mhfsdcap03>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
 <1513822277-18329-3-git-send-email-honghui.zhang@mediatek.com>
 <1513838476.23174.3.camel@mhfsdcap03>
Message-ID: <1513839672.25872.13.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-21 at 14:41 +0800, Yong Wu wrote:
> On Thu, 2017-12-21 at 10:11 +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The host bridge of MT7622 has hardware code the class code to an
> > arbitrary, meaningless value, fix that.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > index 3248771..ae8d367 100644
> > --- a/drivers/pci/host/pcie-mediatek.c
> > +++ b/drivers/pci/host/pcie-mediatek.c
> > @@ -1174,3 +1174,15 @@ static struct platform_driver mtk_pcie_driver = {
> >  	},
> >  };
> >  builtin_platform_driver(mtk_pcie_driver);
> > +
> > +/* The host bridge of MT7622 advertises the wrong device class. */
> > +static void mtk_fixup_class(struct pci_dev *dev)
> > +{
> > +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > +}
> > +
> > +/*
> > + * The HW default value of vendor id and device id for mt7622 are 0x0e8d,
> > + * 0x3258, which are arbitrary, meaningless values.
> > + */
> 
> What's the right vendor id and device id? is it possible to fix them
> too?

Vendor ID is managed by PCI-SIG, you may get the assigned vendor ID
from:
https://pci-ids.ucw.cz/read/PC?restrict=

The vendor ID for Mediatek Corp. should be 14c3.
Device ID is something like vendor-defined.
Those values are in the configuration space and are read-only defined by
spec, it's been stored at the pci_dev, we may change the vendor and
device values in pci_dev, but I don't think it's necessary to change
that.
BTW, Does anyone really cares about the vendor ID and device ID except
the device's driver?

thanks.

> 
> > +DECLARE_PCI_FIXUP_EARLY(0x0e8d, 0x3258, mtk_fixup_class);
> 
> 
