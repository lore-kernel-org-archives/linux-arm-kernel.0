From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 19 Jan 2015 10:55:50 +0000
Subject: [PATCH v7 00/20] KVM GICv3 emulation
In-Reply-To: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
Message-ID: <54BCE2B6.5030406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/01/15 16:31, Andre Przywara wrote:
> This is version 7 of the GICv3 guest emulation series.
> As v6 this series is based on v3.19-rc3 plus Eric's explicit
> VGIC_CTRL_INIT patches.

I've been told that there is some confusion about the above feature with
vGICv3 and I just saw that I didn't mention it in the cover letter:

The GICv3 emulation does not support automatic init as the vGICv2 does.
One needs to explicitly use the brand new VGIC_CTRL_INIT KVM device
ioctl to finalise the GICv3 initialisation.

Among the three places the automatic VGIC init was done before now two
are in vgic-v2-emul.c and don't apply to a virtual GICv3. The remaining
place is in kvm_vgic_inject_irq() in vgic.c, where I explicitly added a
check to only work with a virtual GICv2.
Removing the explicit VGIC_CTRL_INIT from kvmtool resulted in the
desired effect: the VGICv3 didn't initialise and kvmtool returned with
an error.
If there should be a codepath left which allows auto-init of a virtual
GICv3, this is a bug and I'd be grateful for a report.

Thanks,
Andre.

> 
> Most visible change is that the v6 patch 18/20 (introduce
> kvm_check_device_type()) is now gone, instead the validity check
> for the GICv2 emulation is now done internally via a new member of
> struct vgic_params (see new 18/20 for the implementation).
> There is new patch (20/20) that checks the userland provided
> memory regions's address for the VGIC to be properly aligned. Since
> that is build upon a refactoring in the series, I put it at the end.
> If this should be one of the first patches, let me know and I will
> rework that.
> 
> The rest of the changes are smaller things spotted by Christoffer
> (many thanks for the repeated, surely tiresome reviews!).
> 
> For a changelog summary see below, also each patch carries a
> changelog.
> Only patches 02, 05, 08, 15, 18 and 19 had actual changes, 20/20 is
> new.
> 
> A git repo hosting all these patches lives in the kvm-gicv3/v7 branch
> of [1]. The kvm-gicv3/v6 branch has been updated to hold the delta
> patches.
> -----
> 
> GICv3 is the ARM generic interrupt controller designed to overcome
> some limits of the prevalent GICv2. Most notably it lifts the 8-CPU
> limit. Though with Linux-3.17 Marc introduced support for hosts to
> use a GICv3, the CPU limitation still applies to KVM guests, since
> the current code emulates a GICv2 only.
> Also, GICv2 backward compatibility being optional in GICv3, a number
> of systems won't be able to run GICv2 guests.
> 
> This patch series provides code to emulate a GICv3 distributor and
> redistributor for any KVM guest. It requires a GICv3 in the host to
> work. With those patches one can run guests efficiently on any GICv3
> host. It has the following features:
> - Affinity routing (support for up to 255 VCPUs, more possible)
> - System registers (as opposed to MMIO access)
> - No ITS
> - No priority support (as the GICv2 emulation)
> - No save / restore support so far (will be added soon)
> - Only Group1 interrupts support
> 
> The first patches actually refactor the current VGIC code to make
> room for a different VGIC model to be dropped in with Patch 15.
> The remaining patches connect the new model to the kernel backend and
> the userland facing code.
> 
> The series goes on top of v3.19-rc3 plus Eric's init rework patches.
> The necessary patches for kvmtool to enable the guest's GICv3 have
> been posted here before [2], an updated version will follow soon.
> 
> There was some testing on the fast model with some I/O and interrupt
> affinity shuffling in a Linux guest with a varying number of VCPUs as
> well as some testing on a Juno board (GICv2 only, to spot regressions).
> 
> Please review and test.
> I would be grateful for people to test for GICv2 regressions also
> (so on a GICv2 host with current kvmtool/qemu), as there is quite
> some refactoring on that front.
> 
> Much of the code was inspired by MarcZ, also kudos to him for doing
> the rather painful rebase on top of v3.17-rc1.
> 
> Cheers,
> Andre.
> 
> [1] https://github.com/apritzel/linux.git
> [2] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010086.html
> 
> Andre Przywara (20):
>   arm/arm64: KVM: rework MPIDR assignment and add accessors
>   arm/arm64: KVM: pass down user space provided GIC type into vGIC code
>   arm/arm64: KVM: refactor vgic_handle_mmio() function
>   arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
>   arm/arm64: KVM: introduce per-VM ops
>   arm/arm64: KVM: move kvm_register_device_ops() into vGIC probing
>   arm/arm64: KVM: dont rely on a valid GICH base address
>   arm/arm64: KVM: make the maximum number of vCPUs a per-VM value
>   arm/arm64: KVM: make the value of ICC_SRE_EL1 a per-VM variable
>   arm/arm64: KVM: refactor MMIO accessors
>   arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
>   arm/arm64: KVM: add vgic.h header file
>   arm/arm64: KVM: split GICv2 specific emulation code from vgic.c
>   arm/arm64: KVM: add opaque private pointer to MMIO data
>   arm/arm64: KVM: add virtual GICv3 distributor emulation
>   arm64: GICv3: introduce symbolic names for GICv3 ICC_SGI1R_EL1 fields
>   arm64: KVM: add SGI generation register emulation
>   arm/arm64: KVM: enable kernel side of GICv3 emulation
>   arm/arm64: KVM: allow userland to request a virtual GICv3
>   arm/arm64: KVM: force alignment of VGIC dist/CPU/redist addresses
> 
>  Documentation/virtual/kvm/api.txt              |   13 +-
>  Documentation/virtual/kvm/devices/arm-vgic.txt |   26 +-
>  arch/arm/include/asm/kvm_emulate.h             |    5 +-
>  arch/arm/include/asm/kvm_host.h                |    3 +
>  arch/arm/include/asm/kvm_mmio.h                |    1 +
>  arch/arm/kvm/Makefile                          |    1 +
>  arch/arm/kvm/arm.c                             |   23 +-
>  arch/arm/kvm/psci.c                            |   17 +-
>  arch/arm64/include/asm/kvm_emulate.h           |    5 +-
>  arch/arm64/include/asm/kvm_host.h              |    5 +
>  arch/arm64/include/asm/kvm_mmio.h              |    1 +
>  arch/arm64/include/uapi/asm/kvm.h              |    7 +
>  arch/arm64/kernel/asm-offsets.c                |    1 +
>  arch/arm64/kvm/Makefile                        |    2 +
>  arch/arm64/kvm/sys_regs.c                      |   40 +-
>  arch/arm64/kvm/vgic-v3-switch.S                |   14 +-
>  drivers/irqchip/irq-gic-v3.c                   |   14 +-
>  include/kvm/arm_vgic.h                         |   43 +-
>  include/linux/irqchip/arm-gic-v3.h             |   44 +
>  include/linux/kvm_host.h                       |    2 +
>  include/uapi/linux/kvm.h                       |    2 +
>  virt/kvm/arm/vgic-v2-emul.c                    |  847 ++++++++++++++++++
>  virt/kvm/arm/vgic-v2.c                         |    4 +
>  virt/kvm/arm/vgic-v3-emul.c                    | 1036 ++++++++++++++++++++++
>  virt/kvm/arm/vgic-v3.c                         |   82 +-
>  virt/kvm/arm/vgic.c                            | 1121 ++++++------------------
>  virt/kvm/arm/vgic.h                            |  123 +++
>  27 files changed, 2566 insertions(+), 916 deletions(-)
>  create mode 100644 virt/kvm/arm/vgic-v2-emul.c
>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
>  create mode 100644 virt/kvm/arm/vgic.h
> 
