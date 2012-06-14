From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 14 Jun 2012 13:58:02 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <201206141106.49142.arnd@arndb.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <201206141025.09325.arnd@arndb.de>
 <20120614103127.GA15904@avionic-0098.mockup.avionic-design.de>
 <201206141106.49142.arnd@arndb.de>
Message-ID: <20120614115802.GA22211@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 11:06:48AM +0000, Arnd Bergmann wrote:
> On Thursday 14 June 2012, Thierry Reding wrote:
> > On Thu, Jun 14, 2012 at 10:25:09AM +0000, Arnd Bergmann wrote:
> > > On Thursday 14 June 2012, Thierry Reding wrote:
> > > > > 
> > > > > I believe you will need an "interrupt-map" property here, to map the host
> > > > > interrupts to the INTA-INTD lines of the attached devices.
> > > >
> > > > Legacy interrupts are something I cannot test at all because I have no
> > > > hardware that supports them.
> > > 
> > > Hmm, I thought all PCIe hardware has to support them when you do not
> > > enable MSI. What hardware do you have then?
> > 
> > The TEC (Tamonten Evaluation Carrier) has an FPGA which is connected to one
> > of the Tegra PCIe ports and it only supports MSIs.
> 
> Ah, I see. FPGA based devices often have incomplete PCI support so that
> explains why you can't test it. The board also appears to have a
> PCIe mini port though, so anything that you could plug in there should
> also support LSI interrupts.

Yes, I haven't gotten my hands on a suitable module yet, but I'll try. I'm
not very familiar with legacy interrupts, though, and I'll have to read up
on the interrupt map bindings.

> > > > > I'm not sure whether we want to have a device_type="pciex" property here.
> > > > > powerpc and sparc seem to use that information, to distinguish a pcie
> > > > > bus from pci or cardbus.
> > > > 
> > > > That'd be rather useless information given that the Tegra is unlikely to
> > > > support either PCI or CardBus at some point.
> > > 
> > > But the generic code does not know that.
> > 
> > True. Still there's not much generic code on ARM, so maybe it'd be better to
> > add it along with the corresponding code?
> 
> I hope we can make the PCI host probing architecture independent one day,
> instead of each architecture implementing their own. I'd say better put
> that property in there so we don't have to change it in case the future
> generic code will need it. It is part of the binding at
> http://www.openfirmware.org/1275/bindings/pci/pci-express.txt after all.

There seems to be quite a lot in the PCI core already. Unfortunately every
architecture seems to do things differently, so unification is probably going
to be quite difficult.

> Note that we should generally not make /code/ be written with the
> anticipation of a future extension, but anything that concerns interfaces
> to code outside of the kernel (firmware or user space) is best written
> in a conservative way to allow later changes.

Okay, I'll add the property.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/3c9c8a18/attachment.sig>
