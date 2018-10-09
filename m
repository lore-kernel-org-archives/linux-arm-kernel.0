From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2018 17:03:27 +0100
Subject: [PATCH 00/12] error handling and pciehp maintenance
In-Reply-To: <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20181009160327.GE9259@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Fri, Oct 05, 2018 at 12:31:45PM -0500, Bjorn Helgaas wrote:
> [+cc arm64 folks, LKML: This conversation is about this patch:
> 
>   https://lore.kernel.org/linux-pci/20180918235848.26694-3-keith.busch at intel.com
> 
> which fixes some PCIe AER error injection bugs, but also makes the error
> injector dependent on DYNAMIC_FTRACE_WITH_REGS, which not all arches
> support.  Note that this question is only about the error *injection*
> module used for testing.  It doesn't affect AER support itself.]
> 
> On Thu, Oct 04, 2018 at 04:11:37PM -0600, Keith Busch wrote:
> > In case this went unnoticed, patch 2's aer_inject using ftrace hooks
> > to pci config accessors is really cool and fixes several kernel crashes
> > I encountered, but it may not work on every architecture. I'm not sure
> > how widely aer_inject is used, so maybe there are no concerns with the
> > DYNAMIC_FTRACE_WITH_REGS dependency, but I just want to reemphasize that
> > dependency in case there are valid objections.
> 
> Oh, indeed, I hadn't noticed this arch dependency.  AFAICT, the new
> DYNAMIC_FTRACE_WITH_REGS dependency means aer_inject will work only
> on these arches:
> 
>   arm		# if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
>   powerpc	# if PPC64 && CPU_LITTLE_ENDIAN
>   riscv		# ARCH_RV64I only
>   s390
>   x86
> 
> Notably missing is arm64, which has DYNAMIC_FTRACE but not
> DYNAMIC_FTRACE_WITH_REGS.

Thanks for the heads-up here. This feature is currently in development for
arm64:

http://lkml.kernel.org/r/20181001141648.1DBED68BDF at newverein.lst.de

but the latest review comments suggest that it's a fair way from ready yet,
so I wouldn't hold your breath.

Will
