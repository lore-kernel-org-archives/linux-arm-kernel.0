From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 30 Sep 2014 14:44:04 +0530
Subject: [PATCH 1/6] pci,
 thunder: Add support for Thunder PCIe host controller
In-Reply-To: <20140924164946.GI16244@arm.com>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-2-git-send-email-rric@kernel.org>
 <27476217.5ToIFGoMDz@wuerfel> <20140924164946.GI16244@arm.com>
Message-ID: <CA+sq2CdUW2qr1wD2aF4QU+R0-V_A5+aMHPT+Opo0hA4D5a_QtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will/Arnd

Thanks for the comments.
There is another patch submitted for adding MSI controller to Generic driver.
https://lkml.org/lkml/2014/9/28/150

Will go through these and comeback.

On Wed, Sep 24, 2014 at 10:19 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 24, 2014 at 05:12:26PM +0100, Arnd Bergmann wrote:
>> On Wednesday 24 September 2014 17:37:43 Robert Richter wrote:
>> > From: Sunil Goutham <sgoutham@cavium.com>
>> >
>> > This patch adds support for PCI host controller of Cavium Thunder
>> > SoCs.
>>
>> I had expected this hardware to be SBSA compliant. Why do you need
>> a hardware specific driver, is this a workaround for buggy hardware
>> or just noncompliant?
>
> Patches welcome to pci-host-generic.c :) Lorenzo already has code to port
> it to Liviu's new API, so do shout if it's not suitable for your needs.
>
>> > +static int thunder_pcie_msi_enable(struct thunder_pcie *pcie,
>> > +                                   struct pci_bus *bus)
>> > +{
>> > +   struct device_node *msi_node;
>> > +
>> > +   msi_node = of_parse_phandle(pcie->node, "msi-parent", 0);
>> > +   if (!msi_node)
>> > +           return -ENODEV;
>> > +
>> > +   pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
>> > +   if (!pcie->msi)
>> > +           return -ENODEV;
>> > +
>> > +   pcie->msi->dev = pcie->dev;
>> > +   bus->msi = pcie->msi;
>> > +
>> > +   return 0;
>> > +}
>>
>> This is probably something we should add to the generic host driver as well,
>> so it can work with SBSA compliant implementations that come with an MSI
>> controller. Maybe move it into common code so it can be shared with that
>> driver.
>
> Agreed. I've been carrying something similar [1] (based on a hacked-up version
> of bios32, so not bothered to post it) whilst I've been waiting for the
> arm64 core PCI code to get merged.
>
> Will
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/drivers/pci/host/pci-host-generic.c?h=iommu/pci&id=b719acf062ceccfbd79ee7b1ae0b7904ea4da27e
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
