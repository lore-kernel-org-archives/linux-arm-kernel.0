From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 3 Nov 2015 18:00:10 +0000
Subject: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
In-Reply-To: <5638F13D.3080406@caviumnetworks.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <20151103141512.GC3574@red-moon>
 <5638D07B.2030001@linaro.org> <5638F13D.3080406@caviumnetworks.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1629984F@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David

> -----Original Message-----
> From: David Daney [mailto:ddaney at caviumnetworks.com]
> Sent: 03 November 2015 17:39
> To: Hanjun Guo
> Cc: Lorenzo Pieralisi; Sinan Kaya; Tomasz Nowicki; bhelgaas at google.com;
> arnd at arndb.de; will.deacon at arm.com; catalin.marinas at arm.com; rjw at rjwysocki.net;
> jiang.liu at linux.intel.com; robert.richter at caviumnetworks.com;
> Narinder.Dhillon at caviumnetworks.com; Liviu.Dudau at arm.com; tglx at linutronix.de;
> Wangyijing; Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; Gabriele Paoloni; Wangzhou
> (B); liudongdong (C)
> Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
> hostbridge init
> 
> On 11/03/2015 07:19 AM, Hanjun Guo wrote:
> > On 11/03/2015 10:15 PM, Lorenzo Pieralisi wrote:
> >> On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:
> >>
> >> [...]
> >>
> >>>> -int raw_pci_write(unsigned int domain, unsigned int bus,
> >>>> -        unsigned int devfn, int reg, int len, u32 val)
> >>>> +struct pci_ops pci_root_ops = {
> >>>> +    .map_bus = pci_mcfg_dev_base,
> >>>> +    .read = pci_generic_config_read,
> >>>> +    .write = pci_generic_config_write,
> >>>
> >>>
> >>> Can you change these with pci_generic_config_read32 and
> >>> pci_generic_config_write32? We have some targets that can only do 32
> >>> bits PCI config space access.
> >>
> >> No.
> >>
> >> http://www.spinics.net/lists/linux-pci/msg44869.html
> >>
> >> Can you be a bit more specific please ?
> >>
> >> Sigh. Looks like we have to start adding platform specific quirks even
> >> before we merged the generic ACPI PCIe host controller implementation.
> >
> > Cc Gab, Zhou, and Dondong who upstream the hip05 (designware) PCIe host
> > support.
> >
> > I think so, some platform may not support ECAM for root complex,
> > which needs special handling of access config space, we may need
> > to consider those cases.
> >
> 
> Yes, it is indeed true.  For example, some Cavium ThunderX processors
> fall into this category.
> 
> Some options I thought of are:
> 
>   o Use DECLARE_ACPI_MCFG_FIXUP() in the kernel to supply the needed
> config space accessors.
> 
>   o Define additional root_device_ids that imply the needed config space
> accessors.

Yes I like this

it would fit designware too

Gab

> 
> 
> > Thanks
> > Hanjun
