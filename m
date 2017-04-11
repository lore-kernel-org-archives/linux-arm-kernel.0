From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Apr 2017 15:08:57 +0100
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <1491917906.7236.7.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
Message-ID: <20170411140857.GA6821@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 11:38:26PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> > This patch series[1] is a v3 of a previous version:
> > 
> > v2: https://lkml.org/lkml/2017/3/27/220
> 
> I am not a fan of this at All.
> 
> That whole concept of "ioremap_nopost" is simply not applicable to the
> majority of architectures and certainly not in a way that can apply to
> arbitrary mappings.
> 
> It's also very wrong to provide a "default" operation whose semantics
> are weaker than what it's supposed to implement. Very wrong actually.
> People will use it assuming the non-posted behaviour and things will
> break in subtle way when it cannot be provided.

Well, what's very wrong for you it is not very wrong for others
(it is just v3, that's fine, see thread below).

I can easily make ioremap_nopost() mirror ioremap_uc() (ie return
NULL unless overriden so that basically you can't use in on an arch
that can't provide its semantics) but then that becomes very wrong
for other reviewers.

https://lkml.org/lkml/2017/4/6/396

> What exactly are you trying to fix here ?

I wrote in the commit logs and cover letter what I am fixing here.

Anyway:

"The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
Posting") mandate non-posted configuration transactions. As further
highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
Considerations for the Enhanced Configuration Access Mechanism"),
through ECAM and ECAM-derivative configuration mechanism, the memory
mapped transactions from the host CPU into Configuration Requests on the
PCI express fabric may create ordering problems for software because
writes to memory address are typically posted transactions (unless the
architecture can enforce through virtual address mapping non-posted
write transactions behaviour) but writes to Configuration Space are not
posted on the PCI express fabric."

On ARM64:

"This rule is reinforced by the ARM v8 architecture reference manual
(issue A.k, Early Write Acknowledgment) that explicitly recommends
that No Early Write Acknowledgment attribute should be used to map
PCI configuration (write) transactions."

> If a given PCIe host bridge (architecture specific) require a special
> sauce to provide the illusion of non-posting, then implement this in
> the actual root complex code.

> 
> BTW. I'm pretty sure we "accidentally" made config writes posted at
> least to the PHB on a number of powerpc systems forever and we *never*
> had a problem because of it ;)

Ok so we should ignore the PCIe specifications and ARM v8 reference
manual waiting for a kernel bug to appear ? Is that what you suggest
doing ?

Lorenzo

> > v2 -> v3:
> > 	- Created a default ioremap_nopost() implementation in a
> > separate
> > 	??asm-generic header and patched all arches to make use of it
> > 	- Removed PCI drivers patches from the series to simplify the
> > 	??review, they will be posted separately once the
> > ioremap_nopost()
> > 	??interface is settled
> > 	- Fixed devm_ioremap_* BUS offset comments and implemented
> > 	??nopost interface on top of it
> > 	- Added collected tags
> > 
> > v1: https://lkml.org/lkml/2017/2/27/228
> > 
> > v1 -> v2:
> > 	- Changed pci_remap_cfgspace() to more generic ioremap_nopost()
> > 	??interface
> > 	- Added pgprot_nonposted
> > 	- Fixed build errors on arches not relying on asm-generic
> > headers
> > 	- Added PCI versatile host controller driver patch
> > 	- Added missing config space remapping to hisilicon host
> > controller
> > 
> > ---------------------
> > Original cover letter
> > ---------------------
> > 
> > PCI local bus specifications (Rev3.0, 3.2.5 "Transaction Ordering
> > and Posting") strictly require PCI configuration and I/O Address
> > space
> > write transactions to be non-posted.
> > 
> > Current crop of DT/ACPI PCI host controllers drivers relies on
> > the ioremap interface to map ECAM and ECAM-derivative PCI config
> > regions and pci_remap_iospace() to create a VMA for mapping
> > PCI host bridge I/O Address space transactions to CPU virtual address
> > space.
> > 
> > On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> > configuration non-posted write transactions requirement, because it
> > provides a memory mapping that issues "bufferable" or, in PCI terms
> > "posted" write transactions. Likewise, the current
> > pci_remap_iospace()
> > implementation maps the physical address range that the PCI
> > translates
> > to I/O space cycles to virtual address space through pgprot_device()
> > attributes that on eg ARM64 provides a memory mapping issuing
> > posted writes transactions, which is not PCI specifications
> > compliant.
> > 
> > This patch series[1] addresses both issues in one go:
> > 
> > - It updates the pci_remap_iospace() function to use a page mapping
> > ? that guarantees non-posted write transactions for I/O space
> > addresses
> > - It adds a kernel API to remap PCI config space resources, so that
> > ? architecture can override it with a mapping implementation that
> > ? guarantees PCI specifications compliancy wrt non-posted write
> > ? configuration transactions
> > - It updates all PCI host controller implementations (and the generic
> > ? ECAM layer) to use the newly introduced mapping interface
> > 
> > Tested on Juno ECAM based interface (DT/ACPI).
> > 
> > Non-ECAM PCI host controller drivers patches need checking to make
> > sure that:
> > 
> > - I patched the correct resource region mapping for config space
> > - There are not any other ways to ensure posted-write completion
> > ? in the respective pci_ops that make the relevant patch unnecessary
> > 
> > [1]
> > git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git
> > pci/config-io-mappings-fix-v3
> > 
> > Lorenzo Pieralisi (32):
> > ? PCI: remove __weak tag from pci_remap_iospace()
> > ? asm-generic/pgtable.h: introduce pgprot_nonposted remap attribute
> > ? PCI: fix pci_remap_iospace() remap attribute
> > ? asm-generic: add ioremap_nopost() remap interface
> > ? alpha: include default ioremap_nopost() implementation
> > ? avr32: include default ioremap_nopost() implementation
> > ? arc: include default ioremap_nopost() implementation
> > ? cris: include default ioremap_nopost() implementation
> > ? frv: include default ioremap_nopost() implementation
> > ? hexagon: include default ioremap_nopost() implementation
> > ? ia64: include default ioremap_nopost() implementation
> > ? m32r: include default ioremap_nopost() implementation
> > ? m68k: include default ioremap_nopost() implementation
> > ? metag: include default ioremap_nopost() implementation
> > ? microblaze: include default ioremap_nopost() implementation
> > ? mips: include default ioremap_nopost() implementation
> > ? mn10300: include default ioremap_nopost() implementation
> > ? nios2: include default ioremap_nopost() implementation
> > ? openrisc: include default ioremap_nopost() implementation
> > ? parisc: include default ioremap_nopost() implementation
> > ? powerpc: include default ioremap_nopost() implementation
> > ? s390: include default ioremap_nopost() implementation
> > ? sh: include default ioremap_nopost() implementation
> > ? sparc: include default ioremap_nopost() implementation
> > ? tile: include default ioremap_nopost() implementation
> > ? unicore32: include default ioremap_nopost() implementation
> > ? x86: include default ioremap_nopost() implementation
> > ? xtensa: include default ioremap_nopost() implementation
> > ? arm64: implement ioremap_nopost() interface
> > ? arm: implement ioremap_nopost() interface
> > ? lib: fix Devres devm_ioremap_* offset parameter kerneldoc
> > description
> > ? lib: implement Devres ioremap_nopost() interface
> > 
> > ?Documentation/driver-model/devres.txt |??3 ++
> > ?arch/alpha/include/asm/io.h???????????|??1 +
> > ?arch/arc/include/asm/io.h?????????????|??1 +
> > ?arch/arm/include/asm/io.h?????????????|??9 ++++
> > ?arch/arm/mm/ioremap.c?????????????????|??7 +++
> > ?arch/arm/mm/nommu.c???????????????????|??9 ++++
> > ?arch/arm64/include/asm/io.h???????????| 12 +++++
> > ?arch/avr32/include/asm/io.h???????????|??1 +
> > ?arch/cris/include/asm/io.h????????????|??1 +
> > ?arch/frv/include/asm/io.h?????????????|??1 +
> > ?arch/hexagon/include/asm/io.h?????????|??2 +
> > ?arch/ia64/include/asm/io.h????????????|??1 +
> > ?arch/m32r/include/asm/io.h????????????|??1 +
> > ?arch/m68k/include/asm/io.h????????????|??1 +
> > ?arch/metag/include/asm/io.h???????????|??2 +
> > ?arch/microblaze/include/asm/io.h??????|??1 +
> > ?arch/mips/include/asm/io.h????????????|??1 +
> > ?arch/mn10300/include/asm/io.h?????????|??1 +
> > ?arch/nios2/include/asm/io.h???????????|??1 +
> > ?arch/openrisc/include/asm/io.h????????|??2 +
> > ?arch/parisc/include/asm/io.h??????????|??1 +
> > ?arch/powerpc/include/asm/io.h?????????|??1 +
> > ?arch/s390/include/asm/io.h????????????|??1 +
> > ?arch/sh/include/asm/io.h??????????????|??1 +
> > ?arch/sparc/include/asm/io.h???????????|??1 +
> > ?arch/tile/include/asm/io.h????????????|??1 +
> > ?arch/unicore32/include/asm/io.h???????|??1 +
> > ?arch/x86/include/asm/io.h?????????????|??1 +
> > ?arch/xtensa/include/asm/io.h??????????|??1 +
> > ?drivers/pci/pci.c?????????????????????|??4 +-
> > ?include/asm-generic/ioremap-nopost.h??|??9 ++++
> > ?include/asm-generic/pgtable.h?????????|??4 ++
> > ?include/linux/device.h????????????????|??2 +
> > ?include/linux/io.h????????????????????|??2 +
> > ?lib/devres.c??????????????????????????| 84
> > +++++++++++++++++++++++++++++++++--
> > ?35 files changed, 167 insertions(+), 5 deletions(-)
> > ?create mode 100644 include/asm-generic/ioremap-nopost.h
> > 
