From: wanghaibin.wang@huawei.com (wanghaibin)
Date: Wed, 8 Oct 2014 12:08:05 +0800
Subject: [PATCH v2 00/15] KVM GICv3 emulation
In-Reply-To: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
Message-ID: <5434B8A5.8050108@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/21 21:06, Andre Przywara wrote:


> GICv3 is the ARM generic interrupt controller designed to overcome
> some limits of the prevalent GICv2. Most notably it lifts the 8-CPU
> limit. Though with recent patches from Marc there is support for
> hosts to use a GICv3, the CPU limitation still applies to KVM guests,
> since the current code emulates a GICv2 only.
> Also, GICv2 backward compatibility being optional in GICv3, a number
> of systems won't be able to run GICv2 guests.
> 
> This patch series provides code to emulate a GICv3 distributor and
> redistributor for any KVM guest. It requires a GICv3 in the host to
> work. With those patches one can run guests efficiently on any GICv3
> host. It has the following features:
> - Affinity routing (support for up to 255 VCPUs, more possible)

Hi, Andre, in
	struct vgic_dist {
		        ............................

		/* Bitmap indicating which CPU has something pending */
		unsigned long		irq_pending_on_cpu;
	}
the irq_pending_on_cpu parameter type just **unsigned long**.

See the vgic_update_state func:
	void vgic_update_state(struct kvm *kvm)
	{
		.......

		kvm_for_each_vcpu(c, vcpu, kvm) {
			if (compute_pending_for_cpu(vcpu)) {
				pr_debug("CPU%d has pending interrupts\n", c);
				set_bit(c, &dist->irq_pending_on_cpu);
			}
		}
	}

Maybe when the VCPU id greater than 64, and has pending irq, After calculated,  here:
	set_bit(c, &dist->irq_pending_on_cpu);
must be wrong. Isn't it ?


> - System registers (as opposed to MMIO access)
> - No ITS
> - No priority support (as the GICv2 emulation)
> - No save / restore support so far (will be added soon)
> 
> The first 11 patches actually refactor the current VGIC code to make
> room for a different VGIC model to be dropped in with Patch 12/15.
> The remaining patches connect the new model to the kernel backend and
> the userland facing code.
> 
> The series goes on top of v3.17-rc1 and Marc's vgic-dyn series[2].
> The necessary patches for kvmtool to enable the guest's GICv3 have
> been posted here before [3], an updated version will follow as soon
> as the kvmtools tree has been updated.
> 
> There was some testing on the fast model with some I/O and interrupt
> affinity shuffling in a Linux guest with a varying number of VCPUs as
> well as some testing on a Juno board (GICv2 only, to spot
> regressions).
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
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010060.html
> [2] https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/vgic-dyn
> [3] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-June/010086.html
> 
> Changes v1 ... v2:
> * rebase to v3.17-rc1, caused quite some changes to the init code
> * new 9/15 patch to make 10/15 smaller
> * fix wrongly ordered cp15 register trap entry (MarcZ)
> * fix SGI broadcast (thanks to wanghaibin for spotting)
> * fix broken bailout path in kvm_vgic_create (wanghaibin)
> * check return value of init_emulation_ops() (wanghaibin)
> * fix return value check in vgic_[sg]et_attr()
> * add header inclusion guards
> * remove double definition of VCPU_NOT_ALLOCATED
> * some code move-around
> * whitespace fixes
> 
> 
> Andre Przywara (15):
>   arm/arm64: KVM: rework MPIDR assignment and add accessors
>   arm/arm64: KVM: pass down user space provided GIC type into vGIC code
>   arm/arm64: KVM: refactor vgic_handle_mmio() function
>   arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
>   arm/arm64: KVM: introduce per-VM ops
>   arm/arm64: KVM: make the maximum number of vCPUs a per-VM value
>   arm/arm64: KVM: make the value of ICC_SRE_EL1 a per-VM variable
>   arm/arm64: KVM: refactor MMIO accessors
>   arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
>   arm/arm64: KVM: split GICv2 specific emulation code from vgic.c
>   arm/arm64: KVM: add opaque private pointer to MMIO accessors
>   arm/arm64: KVM: add virtual GICv3 distributor emulation
>   arm/arm64: KVM: add SGI system register trapping
>   arm/arm64: KVM: enable kernel side of GICv3 emulation
>   arm/arm64: KVM: allow userland to request a virtual GICv3
> 
>  arch/arm/include/asm/kvm_emulate.h   |    2 +-
>  arch/arm/include/asm/kvm_host.h      |    3 +
>  arch/arm/kvm/Makefile                |    1 +
>  arch/arm/kvm/arm.c                   |   23 +-
>  arch/arm/kvm/coproc.c                |   19 +
>  arch/arm/kvm/psci.c                  |   15 +-
>  arch/arm64/include/asm/kvm_emulate.h |    3 +-
>  arch/arm64/include/asm/kvm_host.h    |    5 +
>  arch/arm64/include/uapi/asm/kvm.h    |    7 +
>  arch/arm64/kernel/asm-offsets.c      |    1 +
>  arch/arm64/kvm/Makefile              |    2 +
>  arch/arm64/kvm/sys_regs.c            |   37 +-
>  arch/arm64/kvm/vgic-v3-switch.S      |   14 +-
>  include/kvm/arm_vgic.h               |   38 +-
>  include/linux/irqchip/arm-gic-v3.h   |   26 +
>  include/linux/kvm_host.h             |    1 +
>  include/uapi/linux/kvm.h             |    1 +
>  virt/kvm/arm/vgic-v2-emul.c          |  803 +++++++++++++++++++++++++++
>  virt/kvm/arm/vgic-v2.c               |   22 +-
>  virt/kvm/arm/vgic-v3-emul.c          |  899 ++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic-v3.c               |  187 +++++--
>  virt/kvm/arm/vgic.c                  |  992 +++++++---------------------------
>  virt/kvm/arm/vgic.h                  |  126 +++++
>  virt/kvm/kvm_main.c                  |    3 +
>  24 files changed, 2361 insertions(+), 869 deletions(-)
>  create mode 100644 virt/kvm/arm/vgic-v2-emul.c
>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
>  create mode 100644 virt/kvm/arm/vgic.h
> 
