From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Wed, 30 Apr 2014 10:20:18 +0000
Subject: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
In-Reply-To: <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
 <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
Message-ID: <0798ff58bde84f85bc389a8faccd2a4a@HKXPR06MB168.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 28 April 2014 20:11, Bjorn wrote:
> On Mon, Apr 28, 2014 at 4:03 AM, Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > Hi Bjorn,
> >
> > Thanks for the review.
> >
> > On 24 April 2014 20:19, Bjorn wrote:
> >> On Mon, Mar 31, 2014 at 11:30:46AM +0100, Phil Edworthy wrote:
> >> > This PCIe Host driver currently does not support MSI, so cards
> >> > fall back to INTx interrupts.
> >> >
> >> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >> > ...
> >>
> >> > --- /dev/null
> >> > +++ b/drivers/pci/host/pcie-rcar.c
> >> > @@ -0,0 +1,693 @@
> >> > ...
> >> > +#include <linux/slab.h>
> >> > +#include "pcie-rcar.h"
> >>
> >> It looks like the things in pcie-rcar.h are used only in this file
> >> (pcie-rcar.c), so you might as well just put the contents here and not have
> >> a pcie-rcar.h at all.  Of course, if there are things needed by more than
> >> one file, they should stay in pcie-rcar.h.
> > Nothing else uses them so I'll put in the c file.
> >
> >> > +#define DRV_NAME "rcar-pcie"
> >> > +
> >> > +#define RCONF(x)   (PCICONF(0)+(x))
> >> > +#define RPMCAP(x)  (PMCAP(0)+(x))
> >> > +#define REXPCAP(x) (EXPCAP(0)+(x))
> >> > +#define RVCCAP(x)  (VCCAP(0)+(x))
> >> > +
> >> > +#define  PCIE_CONF_BUS(b)  (((b) & 0xff) << 24)
> >> > +#define  PCIE_CONF_DEV(d)  (((d) & 0x1f) << 19)
> >> > +#define  PCIE_CONF_FUNC(f) (((f) & 0x7) << 16)
> >> > +
> >> > +#define PCI_MAX_RESOURCES 4
> >> > +#define MAX_NR_INBOUND_MAPS 6
> >> > +
> >> > +/* Structure representing the PCIe interface */
> >> > +struct rcar_pcie {
> >> > +   struct device           *dev;
> >> > +   void __iomem            *base;
> >> > +   struct resource         res[PCI_MAX_RESOURCES];
> >> > +   u8                      root_bus_nr;
> >>
> >> I don't understand how root_bus_nr works.  From its name, it sounds like
> >> it's the bus number of the PCI bus on the downstream side of the host
> >> bridge.
> > That's correct.
> >
> >> That bus number should be a property of the host bridge, i.e.,
> >> it's either hard-wired into the bridge, or it's programmable somewhere.
> >> But root_bus_nr comes from sys->busnr, which is apparently from some
> >> generic code that knows nothing about this particular host bridge.
> > The manual for this hardware says that the HW doesn't care what the bus
> number
> > is set to. The only thing the HW needs to know is that when sending config
> > accesses, we need to indicate whether it's a TYPE0 or TYPE1 header; so we
> use
> > root_bus_nr to determine this. The generic code that sets up sys->busnr
> (ARM
> > bios32 in this case), just increments bus number for each controller.
> >
> > This is very similar to the pcie-designware driver, in dw_pcie_scan_bus().
> 
> OK.  From what you said below, it sounds like you would add a DT entry
> for the bus range you want to have below this bridge, and use TYPE0
> accesses for the base of that range.
Ok. The driver already uses TYPE0 for the base, i.e. that's what root_bus_nr is used for. I'll add the ranges ability.

> I'm not sure how you reconcile this with the idea that the bios32 code
> just increments a bus number for each controller.
I looked at the bios32 code again. I was wrong to say that it just increments a bus number for each controller. The first controller always starts with busnr=0, and subsequent controllers get the next available bus number after scanning the bus.

> >> > +static int __init rcar_pcie_get_resources(struct platform_device
> *pdev,
> >> > +   struct rcar_pcie *pcie)
> >> > +{
> >> > +   struct resource res;
> >> > +   int err;
> >> > +
> >> > +   err = of_address_to_resource(pdev->dev.of_node, 0, &res);
> >> > +   if (err)
> >> > +           return err;
> >>
> >> I don't see anywhere that figures out the bus number range behind this
> host
> >> bridge.  The PCI core needs to know this.  I know the core assumes 00-ff if
> >> it's not supplied, but that's just to deal with the legacy situation where
> >> we assumed one host bridge was all anybody would ever need.
> >>
> >> For new code, we should be explicit about the range.
> > This means add a DT entry for bus-range, and simply calling
> pci_add_resource for
> > the range, right? If so, ok.
> 
> Yeah, I guess.  If the HW really doesn't look at the bus number at
> all, it sounds like the range is effectively 00-ff, and each host
> bridge should be in its own domain.
Ok.

Thanks
Phil
