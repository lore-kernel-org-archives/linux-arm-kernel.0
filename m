From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 2 Jun 2015 14:32:15 +0100
Subject: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
In-Reply-To: <55657B02.5090805@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-6-git-send-email-hanjun.guo@linaro.org>
 <20150526170817.GU1565@arm.com> <55657B02.5090805@linaro.org>
Message-ID: <20150602133215.GC23650@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 09:06:26AM +0100, Tomasz Nowicki wrote:
> On 26.05.2015 19:08, Will Deacon wrote:
> > On Tue, May 26, 2015 at 01:49:18PM +0100, Hanjun Guo wrote:
> >> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>
> >> ECAM standard and MCFG table are architecture independent and it makes
> >> sense to share common code across all architectures. Both are going to
> >> corresponding files - ecam.c and mcfg.c
> >>
> >> While we are here, rename pci_parse_mcfg to acpi_parse_mcfg.
> >> We already have acpi_parse_mcfg prototype which is used nowhere.
> >> At the same time, we need pci_parse_mcfg been global so acpi_parse_mcfg
> >> can be used perfectly here.
> >>
> >> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> ---
> >>   arch/x86/Kconfig               |   3 +
> >>   arch/x86/include/asm/pci_x86.h |  33 ------
> >>   arch/x86/pci/acpi.c            |   1 +
> >>   arch/x86/pci/mmconfig-shared.c | 244 +---------------------------------------
> >>   arch/x86/pci/mmconfig_32.c     |   1 +
> >>   arch/x86/pci/mmconfig_64.c     |   1 +
> >>   arch/x86/pci/numachip.c        |   1 +
> >>   drivers/acpi/Makefile          |   1 +
> >>   drivers/acpi/mcfg.c            |  57 ++++++++++
> >>   drivers/pci/Kconfig            |   7 ++
> >>   drivers/pci/Makefile           |   5 +
> >>   drivers/pci/ecam.c             | 245 +++++++++++++++++++++++++++++++++++++++++
> >
> > Why can't we make use of the ECAM implementation used by pci-host-generic
> > and drivers/pci/access.c?
> 
> We had that question when I had posted MMCFG patch set separately, 
> please see:
> https://lkml.org/lkml/2015/3/11/492

Yes, but the real question is, why do we need to have PCI config space
up and running before a bus struct is even created ? I think the reason is
the PCI configuration address space format (ACPI 6.0, Table 5-27, page
108):

"PCI Configuration space addresses must be confined to devices on
PCI Segment Group 0, bus 0. This restriction exists to accommodate
access to fixed hardware prior to PCI bus enumeration".

On HW reduced platforms I do not even think this is required at all,
we have to look into this to avoid code duplication that might well
turn out useless.

Lorenzo
