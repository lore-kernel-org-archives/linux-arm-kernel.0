From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 16:04:09 -0700
Subject: [PATCH v3 00/32] Port of KVM to arm64
In-Reply-To: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423230409.GA32157@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:02PM +0100, Marc Zyngier wrote:
> This series contains the third version of KVM for arm64.
> 
> It depends on the following branches/series:
> - git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-model
>   Catalin's platform support branch for v8 models
> - git://github.com/columbia/linux-kvm-arm.git kvm-arm-fixes
>   mostly reworking the 32bit port to accomodate for arm64
> - git://github.com/columbia/linux-kvm-arm.git kvm-arm-next
>   adding perf support
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161381.html
>   reworking the whole init procedure for KVM/ARM
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161395.html
>   more 32bit rework
> 
> The code is unsurprisingly extremely similar to the KVM/arm code, and
> a lot of it is actually shared with the 32bit version. Some of the
> include files are duplicated though (I'm definitely willing to fix
> that).
> 
> In terms of features:
> - Support for 4k and 64k pages
> - Support for 32bit and 64bit guests
> - PSCI support for SMP booting
> 
> Testing has been done on both AEMv8 and Foundation models, with
> various 32 and 64bit guests running a variety of distributions (OE,
> Ubuntu and openSUSE for 64bit, Debian and Ubuntu on 32bit).
> 
> The patches are also available on the following branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvm

Hi Marc,

Nice job! I finally got through this series, and besides the mostly
cosmetic comments it looks pretty good to me.  I hope we can do slightly
more code sharing between the two platforms before a merge (especially
the identical header files and some of the fault injection stuff), but I
realize there may be technical reasons that make this hard to
accomplish.  Definitely kudos on being so feature complete that early.

I haven't been able to verify every bit and piece of control registers
and such, since I don't have the necessary docs, but from what I can
gather this looks pretty good, so, assuming you address the comments I
gave (especially at the least clearly commenting on the index into the
kvm_regs struct):

	Acked-by: Christoffer Dall <cdall@cs.columbia.edu>

-Christoffer

> 
> As we do not have a 64bit QEMU port, it has been tested using
> kvmtools. Note that some of the changes have broken the userspace ABI
> in v2, and you must update and rebuild your kvmtools (the previous
> version won't work anymore):
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvmtool
> 
> >From v2:
> - Dropped the idmap code and use the new KVM/ARM boot protocol
> - New KVM_CAP_ARM_EL1_32BIT capability to let userspace detect if EL1
>   is 32bit capable
> - Fixed a bug in arch/arm/entry.S, where EL0/EL1 breakpoint handling was
>   mixed up (spotted by Catalin Marinas)
> - Some sparse fixes (courtesy of Geoff Levand)
> - Dropped the "shared" attribute from device mappings (spotted by Catalin)
> - Add API documentation
> - Add MAINTAINERS entry
> 
> >From v1:
> - Rework of the world-switch to use common structure between host and
>   guests (suggested by Christopher Covington)
> - Some additional constants to make the EL1 fault injection clearer
>   (suggested by Christopher Covington)
> - Use of __u64 instead of "unsigned long" in the userspace API
>   (suggested by Michael S. Tsirkin)
> - Move the FP/SIMD registers into the "core" registers, dropping the
>   specific accessors.
> - Generic MPIDR implementation (suggested by Christopher Covington)
> - Cleaner handling of the various host implementations
> 
> Marc Zyngier (32):
>   arm64: add explicit symbols to ESR_EL1 decoding
>   arm64: KVM: define HYP and Stage-2 translation page flags
>   arm64: KVM: HYP mode idmap support
>   arm64: KVM: EL2 register definitions
>   arm64: KVM: system register definitions for 64bit guests
>   arm64: KVM: Basic ESR_EL2 helpers and vcpu register access
>   arm64: KVM: fault injection into a guest
>   arm64: KVM: architecture specific MMU backend
>   arm64: KVM: user space interface
>   arm64: KVM: system register handling
>   arm64: KVM: CPU specific system registers handling
>   arm64: KVM: virtual CPU reset
>   arm64: KVM: kvm_arch and kvm_vcpu_arch definitions
>   arm64: KVM: MMIO access backend
>   arm64: KVM: guest one-reg interface
>   arm64: KVM: hypervisor initialization code
>   arm64: KVM: HYP mode world switch implementation
>   arm64: KVM: Exit handling
>   arm64: KVM: Plug the VGIC
>   arm64: KVM: Plug the arch timer
>   arm64: KVM: PSCI implementation
>   arm64: KVM: Build system integration
>   arm64: KVM: define 32bit specific registers
>   arm64: KVM: 32bit GP register access
>   arm64: KVM: 32bit conditional execution emulation
>   arm64: KVM: 32bit handling of coprocessor traps
>   arm64: KVM: CPU specific 32bit coprocessor access
>   arm64: KVM: 32bit specific register world switch
>   arm64: KVM: 32bit guest fault injection
>   arm64: KVM: enable initialization of a 32bit vcpu
>   arm64: KVM: userspace API documentation
>   arm64: KVM: MAINTAINERS update
> 
>  Documentation/virtual/kvm/api.txt       |   55 +-
>  MAINTAINERS                             |    9 +
>  arch/arm/kvm/arch_timer.c               |    1 +
>  arch/arm64/Kconfig                      |    2 +
>  arch/arm64/Makefile                     |    2 +-
>  arch/arm64/include/asm/esr.h            |   55 ++
>  arch/arm64/include/asm/kvm_arch_timer.h |   58 ++
>  arch/arm64/include/asm/kvm_arm.h        |  243 ++++++++
>  arch/arm64/include/asm/kvm_asm.h        |  104 ++++
>  arch/arm64/include/asm/kvm_coproc.h     |   56 ++
>  arch/arm64/include/asm/kvm_emulate.h    |  185 ++++++
>  arch/arm64/include/asm/kvm_host.h       |  202 ++++++
>  arch/arm64/include/asm/kvm_mmio.h       |   59 ++
>  arch/arm64/include/asm/kvm_mmu.h        |  136 ++++
>  arch/arm64/include/asm/kvm_psci.h       |   23 +
>  arch/arm64/include/asm/kvm_vgic.h       |  156 +++++
>  arch/arm64/include/asm/pgtable-hwdef.h  |   13 +
>  arch/arm64/include/asm/pgtable.h        |   12 +
>  arch/arm64/include/uapi/asm/kvm.h       |  168 +++++
>  arch/arm64/kernel/asm-offsets.c         |   34 +
>  arch/arm64/kernel/entry.S               |   53 +-
>  arch/arm64/kernel/vmlinux.lds.S         |   16 +
>  arch/arm64/kvm/Kconfig                  |   59 ++
>  arch/arm64/kvm/Makefile                 |   19 +
>  arch/arm64/kvm/emulate.c                |  154 +++++
>  arch/arm64/kvm/guest.c                  |  260 ++++++++
>  arch/arm64/kvm/handle_exit.c            |  124 ++++
>  arch/arm64/kvm/hyp-init.S               |  112 ++++
>  arch/arm64/kvm/hyp.S                    |  816 ++++++++++++++++++++++++
>  arch/arm64/kvm/inject_fault.c           |  195 ++++++
>  arch/arm64/kvm/regmap.c                 |  168 +++++
>  arch/arm64/kvm/reset.c                  |   99 +++
>  arch/arm64/kvm/sys_regs.c               | 1035 +++++++++++++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.h               |  138 +++++
>  arch/arm64/kvm/sys_regs_generic_v8.c    |   95 +++
>  include/uapi/linux/kvm.h                |    2 +
>  36 files changed, 4872 insertions(+), 46 deletions(-)
>  create mode 100644 arch/arm64/include/asm/esr.h
>  create mode 100644 arch/arm64/include/asm/kvm_arch_timer.h
>  create mode 100644 arch/arm64/include/asm/kvm_arm.h
>  create mode 100644 arch/arm64/include/asm/kvm_asm.h
>  create mode 100644 arch/arm64/include/asm/kvm_coproc.h
>  create mode 100644 arch/arm64/include/asm/kvm_emulate.h
>  create mode 100644 arch/arm64/include/asm/kvm_host.h
>  create mode 100644 arch/arm64/include/asm/kvm_mmio.h
>  create mode 100644 arch/arm64/include/asm/kvm_mmu.h
>  create mode 100644 arch/arm64/include/asm/kvm_psci.h
>  create mode 100644 arch/arm64/include/asm/kvm_vgic.h
>  create mode 100644 arch/arm64/include/uapi/asm/kvm.h
>  create mode 100644 arch/arm64/kvm/Kconfig
>  create mode 100644 arch/arm64/kvm/Makefile
>  create mode 100644 arch/arm64/kvm/emulate.c
>  create mode 100644 arch/arm64/kvm/guest.c
>  create mode 100644 arch/arm64/kvm/handle_exit.c
>  create mode 100644 arch/arm64/kvm/hyp-init.S
>  create mode 100644 arch/arm64/kvm/hyp.S
>  create mode 100644 arch/arm64/kvm/inject_fault.c
>  create mode 100644 arch/arm64/kvm/regmap.c
>  create mode 100644 arch/arm64/kvm/reset.c
>  create mode 100644 arch/arm64/kvm/sys_regs.c
>  create mode 100644 arch/arm64/kvm/sys_regs.h
>  create mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c
> 
> -- 
> 1.8.1.4
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
