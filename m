From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 20 Jun 2014 09:20:31 +0100
Subject: [PATCH 00/14] KVM GICv3 emulation
In-Reply-To: <1403228344858.49974@caviumnetworks.com>
References: <1403171152-24067-1-git-send-email-andre.przywara@arm.com>
 <1403228344858.49974@caviumnetworks.com>
Message-ID: <53A3EECF.8040206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/14 02:39, Chalamarla, Tirumalesh wrote:

Hi Tirumalesh,

>  Is there a public repo where we can get this patches from easily.

Indeed, many thanks to Marc who hosts now my patches on his kernel.org
repo. Simply checkout the gicv3/kvm-guest branch from
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
to get all of GICv3 host, vgic-dyn and the GICv3 guest emualation stuff
at once.

Regards,
Andre.

> ________________________________________
> From: kvmarm-bounces at lists.cs.columbia.edu <kvmarm-bounces@lists.cs.columbia.edu> on behalf of Andre Przywara <andre.przywara@arm.com>
> Sent: Thursday, June 19, 2014 3:15 PM
> To: linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
> Cc: christoffer.dall at linaro.org
> Subject: [PATCH 00/14] KVM GICv3 emulation
>
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
> - System registers (as opposed to MMIO access)
> - No ITS
> - No priority support (as the GICv2 emulation)
> - No save / restore support so far (will be added soon)
>
> The first 10 patches actually refactor the current VGIC code to make
> room for a different VGIC model to be dropped in with Patch 11/14.
> The remaining patches connect the new model to the kernel backend and
> the userland facing code.
>
> The series goes on top of both Marc's GICv3 host support series as
> well as his vgic-dyn patches.
> The necessary patches for kvmtool to enable the guest's GICv3 will be
> posted here as well.
> There was some testing on the fast model with some I/O and interrupt
> affinity shuffling in a Linux guest with a varying number of VCPUs.
>
> Please review and test.
> I would be grateful for people to test for GICv2 regressions also
> (so on a GICv2 host with current kvmtool/qemu), as there is quite
> some refactoring on that front.
>
> Much of the code was inspired by Marc, so send all praises to him
> (while I take the blame).
>
> Cheers,
> Andre.
>
> Andre Przywara (14):
>   arm/arm64: KVM: rework MPIDR assignment and add accessors
>   arm/arm64: KVM: pass down user space provided GIC type into vGIC code
>   arm/arm64: KVM: refactor vgic_handle_mmio() function
>   arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
>   arm/arm64: KVM: introduce per-VM ops
>   arm/arm64: KVM: make the maximum number of vCPUs a per-VM value
>   arm/arm64: KVM: make the value of ICC_SRE_EL1 a per-VM variable
>   arm/arm64: KVM: refactor MMIO accessors
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
>  virt/kvm/arm/vgic-v2-emul.c          |  802 +++++++++++++++++++++++++++
>  virt/kvm/arm/vgic-v2.c               |   22 +-
>  virt/kvm/arm/vgic-v3-emul.c          |  898 ++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic-v3.c               |  157 +++++-
>  virt/kvm/arm/vgic.c                  | 1017 +++++++---------------------------
>  virt/kvm/arm/vgic.h                  |  117 ++++
>  virt/kvm/kvm_main.c                  |    3 +
>  24 files changed, 2346 insertions(+), 868 deletions(-)
>  create mode 100644 virt/kvm/arm/vgic-v2-emul.c
>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
>  create mode 100644 virt/kvm/arm/vgic.h
>
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
>

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
