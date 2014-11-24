From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 24 Nov 2014 17:46:20 +0000
Subject: [PATCH v4 00/19] KVM GICv3 emulation
In-Reply-To: <5472FB5C.4020104@linaro.org>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <5472FB5C.4020104@linaro.org>
Message-ID: <54736EEC.6030307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/14 09:33, Eric Auger wrote:
> On 11/14/2014 11:07 AM, Andre Przywara wrote:
>> This is version 4 of the GICv3 guest emulation series.
>>
[ ... ]
>>
>> Please review and test.
>> I would be grateful for people to test for GICv2 regressions also
>> (so on a GICv2 host with current kvmtool/qemu), as there is quite
>> some refactoring on that front.
> 
> Hi Andre,
> 
> I tested your kvm-gicv3/v4 branch on Calxeda Midway with GICv2 host in
> QEMU/VFIO passthrough use case. It behaves as expected.

Merci beaucoup, Eric!
Much appreciated.

Cheers,
Andre.

> 
> Best Regards
> 
> Eric
>>
>> Much of the code was inspired by MarcZ, also kudos to him for doing
>> the rather painful rebase on top of v3.17-rc1.
>>
>> Cheers,
>> Andre.
>>
>> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010086.html
>>
>> Changes v3 ... v4:
>> * bug-fix in handling GICv3 redistributor CFG register
>> * move set/get_lr from gic_vm_ops back to vgic_ops (get rid of v3 06/19)
>> * getting rid of init_emul() at all
>> * rework guest GIC model initialization
>> * use non-atomic bit-set and bit-clear functions
>> * split up handle_mmio_misc* into multiple functions
>> * refine handling of some reserved registers
>> * use symbolic names for ICC_SGI1R_EL1 register fields (new patch 16/19)
>> * move private parameter from MMIO accessors to struct kvm_mmio_exit
>> * added documentation of new GICv3 guest device
>> * added lots of comments
>> * some renaming of identifiers
>> * minor changes in style and code flow of various functions
>>
>> Changes v2 ... v3:
>> * rebase to v3.18-rc2
>> * adapt to new kvm_register_device() function
>> * split up vm_ops patch and the GICv2 split-off patch to ease review
>> * various smaller changes due to Christoffer's review
>> * fix compilation for arm
>> * remove support for trapping SGI sysreg accesses on arm hosts
>>
>> Changes v1 ... v2:
>> * rebase to v3.17-rc1, caused quite some changes to the init code
>> * new 9/15 patch to make 10/15 smaller
>> * fix wrongly ordered cp15 register trap entry (MarcZ)
>> * fix SGI broadcast (thanks to wanghaibin for spotting)
>> * fix broken bailout path in kvm_vgic_create (wanghaibin)
>> * check return value of init_emulation_ops() (wanghaibin)
>> * fix return value check in vgic_[sg]et_attr()
>> * add header inclusion guards
>> * remove double definition of VCPU_NOT_ALLOCATED
>> * some code move-around
>> * whitespace fixes
>>
>> Andre Przywara (19):
>>   arm/arm64: KVM: rework MPIDR assignment and add accessors
>>   arm/arm64: KVM: pass down user space provided GIC type into vGIC code
>>   arm/arm64: KVM: refactor vgic_handle_mmio() function
>>   arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
>>   arm/arm64: KVM: introduce per-VM ops
>>   arm/arm64: KVM: move kvm_register_device_ops() into vGIC probing
>>   arm/arm64: KVM: dont rely on a valid GICH base address
>>   arm/arm64: KVM: make the maximum number of vCPUs a per-VM value
>>   arm/arm64: KVM: make the value of ICC_SRE_EL1 a per-VM variable
>>   arm/arm64: KVM: refactor MMIO accessors
>>   arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
>>   arm/arm64: KVM: add vgic.h header file
>>   arm/arm64: KVM: split GICv2 specific emulation code from vgic.c
>>   arm/arm64: KVM: add opaque private pointer to MMIO data
>>   arm/arm64: KVM: add virtual GICv3 distributor emulation
>>   arm64: GICv3: introduce symbolic names for GICv3 ICC_SGI1R_EL1 fields
>>   arm64: KVM: add SGI generation register emulation
>>   arm/arm64: KVM: enable kernel side of GICv3 emulation
>>   arm/arm64: KVM: allow userland to request a virtual GICv3
>>
>>  Documentation/virtual/kvm/devices/arm-vgic.txt |   21 +-
>>  arch/arm/include/asm/kvm_emulate.h             |    5 +-
>>  arch/arm/include/asm/kvm_host.h                |    3 +
>>  arch/arm/include/asm/kvm_mmio.h                |    1 +
>>  arch/arm/kvm/Makefile                          |    1 +
>>  arch/arm/kvm/arm.c                             |   23 +-
>>  arch/arm/kvm/psci.c                            |   17 +-
>>  arch/arm64/include/asm/kvm_emulate.h           |    5 +-
>>  arch/arm64/include/asm/kvm_host.h              |    5 +
>>  arch/arm64/include/asm/kvm_mmio.h              |    1 +
>>  arch/arm64/include/uapi/asm/kvm.h              |    7 +
>>  arch/arm64/kernel/asm-offsets.c                |    1 +
>>  arch/arm64/kvm/Makefile                        |    2 +
>>  arch/arm64/kvm/sys_regs.c                      |   37 +-
>>  arch/arm64/kvm/vgic-v3-switch.S                |   14 +-
>>  drivers/irqchip/irq-gic-v3.c                   |   14 +-
>>  include/kvm/arm_vgic.h                         |   34 +-
>>  include/linux/irqchip/arm-gic-v3.h             |   44 +
>>  include/linux/kvm_host.h                       |    2 +
>>  include/uapi/linux/kvm.h                       |    2 +
>>  virt/kvm/arm/vgic-v2-emul.c                    |  805 ++++++++++++++++++
>>  virt/kvm/arm/vgic-v2.c                         |    3 +
>>  virt/kvm/arm/vgic-v3-emul.c                    | 1020 +++++++++++++++++++++++
>>  virt/kvm/arm/vgic-v3.c                         |   89 +-
>>  virt/kvm/arm/vgic.c                            | 1065 ++++++------------------
>>  virt/kvm/arm/vgic.h                            |  122 +++
>>  26 files changed, 2469 insertions(+), 874 deletions(-)
>>  create mode 100644 virt/kvm/arm/vgic-v2-emul.c
>>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
>>  create mode 100644 virt/kvm/arm/vgic.h
>>
> 
> 
