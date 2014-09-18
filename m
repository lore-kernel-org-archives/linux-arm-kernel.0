From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 18 Sep 2014 15:13:14 -0700
Subject: [PATCH v3] ARM: KVM: add irqfd support
In-Reply-To: <20140911170332.GA5535@lvm>
References: <1409561584-8050-1-git-send-email-eric.auger@linaro.org>
 <20140911030938.GB2784@lvm> <541159D5.40804@linaro.org>
 <20140911170332.GA5535@lvm>
Message-ID: <20140918221314.GA4074@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 07:03:32PM +0200, Christoffer Dall wrote:
> On Thu, Sep 11, 2014 at 10:14:13AM +0200, Eric Auger wrote:
> > On 09/11/2014 05:09 AM, Christoffer Dall wrote:
> > > On Mon, Sep 01, 2014 at 10:53:04AM +0200, Eric Auger wrote:
> > >> This patch enables irqfd on ARM.
> > >>
> > >> irqfd framework enables to inject a virtual IRQ into a guest upon an
> > >> eventfd trigger. User-side uses KVM_IRQFD VM ioctl to provide KVM with
> > >> a kvm_irqfd struct that associates a VM, an eventfd, a virtual IRQ number
> > >> (aka. the gsi). When an actor signals the eventfd (typically a VFIO
> > >> platform driver), the kvm irqfd subsystem injects the provided virtual
> > >> IRQ into the guest.
> > >>
> > >> Resamplefd also is supported for level sensitive interrupts, ie. the
> > >> user can provide another eventfd that is triggered when the completion
> > >> of the virtual IRQ (gsi) is detected by the GIC.
> > >>
> > >> The gsi must correspond to a shared peripheral interrupt (SPI), ie the
> > >> GIC interrupt ID is gsi+32.
> > >>
> > >> this patch enables CONFIG_HAVE_KVM_EVENTFD and CONFIG_HAVE_KVM_IRQFD.
> > >> CONFIG_HAVE_KVM_IRQCHIP is removed. No IRQ routing table is used
> > >> (irqchip.c and irqcomm.c are not used).
> > >>
> > >> Both KVM_CAP_IRQFD & KVM_CAP_IRQFD_RESAMPLE capabilities are exposed
> > >>
> > >> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> > >>
> > >> ---
> > >>
> > >> This patch serie deprecates the previous serie featuring GSI routing
> > >> (https://patches.linaro.org/32261/)
> > >>
> > >> The patch serie has the following dependencies:
> > >> - arm/arm64: KVM: Various VGIC cleanups and improvements
> > >>   https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/009979.html
> > >> - "KVM: EVENTFD: remove inclusion of irq.h"
> > >>
> > >> All pieces can be found on git://git.linaro.org/people/eric.auger/linux.git
> > >> branch irqfd_norouting_integ_v3
> > >>
> > >> This work was tested with Calxeda Midway xgmac main interrupt with
> > >> qemu-system-arm and QEMU VFIO platform device.
> > >>
> > >> v2 -> v3:
> > >> - removal of irq.h from eventfd.c put in a separate patch to increase
> > >>   visibility
> > >> - properly expose KVM_CAP_IRQFD capability in arm.c
> > >> - remove CONFIG_HAVE_KVM_IRQCHIP meaningfull only if irq_comm.c is used
> > >>
> > >> v1 -> v2:
> > >> - rebase on 3.17rc1
> > >> - move of the dist unlock in process_maintenance
> > >> - remove of dist lock in __kvm_vgic_sync_hwstate
> > >> - rewording of the commit message (add resamplefd reference)
> > >> - remove irq.h
> > >> ---
> > >>  Documentation/virtual/kvm/api.txt |  5 +++-
> > >>  arch/arm/include/uapi/asm/kvm.h   |  3 +++
> > >>  arch/arm/kvm/Kconfig              |  4 +--
> > >>  arch/arm/kvm/Makefile             |  2 +-
> > >>  arch/arm/kvm/arm.c                |  3 +++
> > >>  virt/kvm/arm/vgic.c               | 56 ++++++++++++++++++++++++++++++++++++---
> > >>  6 files changed, 65 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > >> index beae3fd..8118b12 100644
> > >> --- a/Documentation/virtual/kvm/api.txt
> > >> +++ b/Documentation/virtual/kvm/api.txt
> > >> @@ -2204,7 +2204,7 @@ into the hash PTE second double word).
> > >>  4.75 KVM_IRQFD
> > >>  
> > >>  Capability: KVM_CAP_IRQFD
> > >> -Architectures: x86 s390
> > >> +Architectures: x86 s390 arm
> > >>  Type: vm ioctl
> > >>  Parameters: struct kvm_irqfd (in)
> > >>  Returns: 0 on success, -1 on error
> > >> @@ -2230,6 +2230,9 @@ Note that closing the resamplefd is not sufficient to disable the
> > >>  irqfd.  The KVM_IRQFD_FLAG_RESAMPLE is only necessary on assignment
> > >>  and need not be specified with KVM_IRQFD_FLAG_DEASSIGN.
> > >>  
> > >> +On ARM/arm64 the injected must be a shared peripheral interrupt (SPI).
> > >> +This means the programmed GIC interrupt ID is gsi+32.
> > >> +
> > > 
> > > See above comment.
> > Hi Christoffer,
> > 
> > sorry which comment do you refer to?
> 
> good question, I thought I had a comment above, just disregard.
> 
> > wrt your last comment do you
> > consider PPI injection support is a mandated feature for this patch to
> > be upstreamable?
> 
> well, right now, the only reason it's not supported is "we didn't bother
> thinking about it or doing it" and I haven't heard a valid reason for
> why we should be designing a new user space API etc. without supporting
> PPIs.
> 
> So yes, either argue why it's better to not include PPI support in the
> first round, why we never need to, or just support it ;)
> 
So we had a talk at Linaro Connect between Eric, Marc, and myself, and
basically the reason not to support this is that any device using a PPI
will be a private-to-the-CPU device (think about the timer), so it's
state would have to be context-switched along with the VCPU and require
in-kernel wiring anyhow, and is therefore simply not a relevant use case
for irqfds.

Therefore, you can ignore my comments about PPI support in this patch.

Thanks,
-Christoffer
