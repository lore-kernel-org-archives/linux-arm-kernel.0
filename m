From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 May 2013 14:15:19 +0200
Subject: [RFCv1 09/11] pci: mvebu: add MSI support
In-Reply-To: <CAErSpo7yC_97Vg-zuype-jyfqiY+77OE97cxYoEO9ZZnXjQ95A@mail.gmail.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo7yC_97Vg-zuype-jyfqiY+77OE97cxYoEO9ZZnXjQ95A@mail.gmail.com>
Message-ID: <20130530121518.GA20267@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 04:29:07PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
[...]
> > +static int mvebu_pcie_setup_msi_irq(struct msi_chip *chip,
> > +                                   struct pci_dev *pdev,
> > +                                   struct msi_desc *desc)
> > +{
> > +       struct mvebu_pcie_msi *msi = to_mvebu_msi(chip);
> 
> If this took only the pci_dev (not the msi_chip), I think you could do this:
> 
>   struct mvebu_pcie_msi *msi = &pdev->bus->sysdata->msi;

That would mean that the arch_setup_msi_irq() and friends could still be
architecture-agnostic because they only pass around pci_dev, and the
driver specific implementations would know how to lookup sysdata and
from there the MSI chip.

So I was almost convinced that putting the struct msi_chip pointer into
sysdata is a good idea. However that also means that each PCI host
bridge driver becomes architecture-specific. If we ever get a driver
that can be used on multiple architectures (however unlikely), the only
way to make it work would be to #ifdef those parts. We could make that
easier to deal with by providing an accessor (pci_sysdata_set_msi_chip()
or similar), though.

But maybe it's something we don't need to be concerned about because no
PCI host bridge driver will ever support two different architecture?

One related point is compile coverage. If the drivers are completely
architecture-agnostic it makes it a lot easier to compile-test all
drivers, which might come in useful when doing core changes and such.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130530/062557b1/attachment.sig>
