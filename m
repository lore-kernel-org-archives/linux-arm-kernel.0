From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 6 Nov 2018 16:34:08 +0000
Subject: [PATCH 00/12] error handling and pciehp maintenance
In-Reply-To: <20181008161847.GA30971@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
Message-ID: <20181106163400.GA21193@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:18:47AM -0600, Keith Busch wrote:
> On Fri, Oct 05, 2018 at 12:31:45PM -0500, Bjorn Helgaas wrote:
> > [+cc arm64 folks, LKML: This conversation is about this patch:
> > 
> >   https://lore.kernel.org/linux-pci/20180918235848.26694-3-keith.busch at intel.com
> > 
> > which fixes some PCIe AER error injection bugs, but also makes the error
> > injector dependent on DYNAMIC_FTRACE_WITH_REGS, which not all arches
> > support.  Note that this question is only about the error *injection*
> > module used for testing.  It doesn't affect AER support itself.]
> > 
> > On Thu, Oct 04, 2018 at 04:11:37PM -0600, Keith Busch wrote:
> > > On Thu, Oct 04, 2018 at 04:40:15PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Sep 18, 2018 at 05:58:36PM -0600, Keith Busch wrote:
> > > > > I ran into a lot of trouble testing error handling, and this series is
> > > > > just trying to simplify some things. The first 4 fix up aer_inject, and
> > > > > the rest are cleanup to make better use of kernel APIs.
> > > > > 
> > > > > Keith Busch (12):
> > > > >   PCI: Set PCI bus accessors to noinline
> > > > >   PCI/AER: Covertly inject errors
> > > > >   PCI/AER: Reuse existing service device lookup
> > > > >   PCI/AER: Abstract AER interrupt handling
> > > > >   PCI/AER: Remove dead code
> > > > >   PCI/AER: Remove error source from aer struct
> > > > >   PCI/AER: Use kfifo for tracking events
> > > > >   PCI/AER: Use kfifo helper inserting locked elements
> > > > >   PCI/AER: Don't read upstream ports below fatal errors
> > > > >   PCI/AER: Use threaded IRQ for bottom half
> > > > >   PCI/AER: Use managed resource allocations
> > > > >   PCI/pciehp: Use device managed allocations
> > > > > 
> > > > >  drivers/pci/access.c              |   4 +-
> > > > >  drivers/pci/hotplug/pciehp_core.c |  14 +-
> > > > >  drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
> > > > >  drivers/pci/pcie/Kconfig          |   2 +-
> > > > >  drivers/pci/pcie/aer.c            | 219 ++++++---------------------
> > > > >  drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
> > > > >  drivers/pci/pcie/portdrv.h        |   4 -
> > > > >  drivers/pci/pcie/portdrv_core.c   |   1 +
> > > > >  8 files changed, 227 insertions(+), 371 deletions(-)
> > > > 
> > > > Thanks a lot for doing this!  I applied these to pci/hotplug for
> > > > v4.20, except for "PCI/AER: Don't read upstream ports below fatal
> > > > errors", which seems to be already there via another posting, and
> > > > "PCI/pciehp: Use device managed allocations", which needs a few
> > > > tweaks.
> > > 
> > > Sounds good, and thanks for applying!
> > > 
> > > In case this went unnoticed, patch 2's aer_inject using ftrace hooks
> > > to pci config accessors is really cool and fixes several kernel crashes
> > > I encountered, but it may not work on every architecture. I'm not sure
> > > how widely aer_inject is used, so maybe there are no concerns with the
> > > DYNAMIC_FTRACE_WITH_REGS dependency, but I just want to reemphasize that
> > > dependency in case there are valid objections.
> > 
> > Oh, indeed, I hadn't noticed this arch dependency.  AFAICT, the new
> > DYNAMIC_FTRACE_WITH_REGS dependency means aer_inject will work only
> > on these arches:
> > 
> >   arm		# if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> >   powerpc	# if PPC64 && CPU_LITTLE_ENDIAN
> >   riscv		# ARCH_RV64I only
> >   s390
> >   x86
> > 
> > Notably missing is arm64, which has DYNAMIC_FTRACE but not
> > DYNAMIC_FTRACE_WITH_REGS.
> > 
> > Bjorn
> 
> Looks like the kbuild bot found an ARM kernel config that has
> DYNAMIC_FTRACE_WITH_REGS set, and then the module can't compile
> there. I'll need to update this patch regardless, and I think the right
> thing to do is maintain the "old" way with conditional compiling for
> any arch specific features.

The question is whether we really need to dynamically patch the kernel
with ftrace to achieve what that patch does.

Furthermore, it would also be good to report what bugs we are actually
fixing, from what you are writing falling back to the current method if
!DYNAMIC_FTRACE_WITH_REGS is broken in many ways and I would start with
fixing the current behaviour with something that does not depend on arch
features that may not even be implemented.

Anyway - please CC me in in the follow up series, I am happy to help you
test it.

Thanks,
Lorenzo
