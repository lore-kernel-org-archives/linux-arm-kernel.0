From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 06 Jul 2018 09:22:47 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <87h8lc93jc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

<snip>
>
> This series is somewhat tested on Arm Juno r0 and the Arm Fast Model
> (with/without SVE support).  arch/arm builds, but I've not booted
> it -- only some trivial refactoring in this series affects arch/arm.

Now that QEMU linux-user SVE support is pretty much complete we've also
got preliminary patches for system emulation mode. However we currently
don't have VHE implemented so I guess we need to do that first before we
can test under QEMU.

>
> Cheers
> ---Dave
>
>
> [1] [PATCH v2 0/4] KVM: arm64: FPSIMD/SVE fixes for 4.17 [sic]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584281.html
>
> Dave Martin (16):
>   arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on task state flush
>   KVM: arm64: Delete orphaned declaration for __fpsimd_enabled()
>   KVM: arm64: Refactor kvm_arm_num_regs() for easier maintenance
>   KVM: arm64: Add missing #include of <linux/bitmap.h> to kvm_host.h
>   KVM: arm: Add arch init/uninit hooks
>   arm64/sve: Determine virtualisation-friendly vector lengths
>   arm64/sve: Enable SVE state tracking for non-task contexts
>   KVM: arm64: Support dynamically hideable system registers
>   KVM: arm64: Allow ID registers to by dynamically read-as-zero
>   KVM: arm64: Add a vcpu flag to control SVE visibility for the guest
>   KVM: arm64/sve: System register context switch and access support
>   KVM: arm64/sve: Context switch the SVE registers
>   KVM: Allow 2048-bit register access via KVM_{GET,SET}_ONE_REG
>   KVM: arm64/sve: Add SVE support to register access ioctl interface
>   KVM: arm64: Enumerate SVE register indices for KVM_GET_REG_LIST
>   KVM: arm64/sve: Report and enable SVE API extensions for userspace
>
>  arch/arm/include/asm/kvm_host.h   |   4 +-
>  arch/arm64/include/asm/fpsimd.h   |   4 +-
>  arch/arm64/include/asm/kvm_host.h |  18 ++-
>  arch/arm64/include/asm/kvm_hyp.h  |   1 -
>  arch/arm64/include/asm/sysreg.h   |   3 +
>  arch/arm64/include/uapi/asm/kvm.h |  11 ++
>  arch/arm64/kernel/cpufeature.c    |   2 +-
>  arch/arm64/kernel/fpsimd.c        | 131 +++++++++++++---
>  arch/arm64/kernel/signal.c        |   5 -
>  arch/arm64/kvm/fpsimd.c           |   7 +-
>  arch/arm64/kvm/guest.c            | 321 +++++++++++++++++++++++++++++++++++---
>  arch/arm64/kvm/hyp/switch.c       |  43 +++--
>  arch/arm64/kvm/hyp/sysreg-sr.c    |   5 +
>  arch/arm64/kvm/reset.c            |  14 ++
>  arch/arm64/kvm/sys_regs.c         |  73 ++++++---
>  arch/arm64/kvm/sys_regs.h         |  22 +++
>  include/uapi/linux/kvm.h          |   1 +
>  virt/kvm/arm/arm.c                |  13 +-
>  18 files changed, 587 insertions(+), 91 deletions(-)


--
Alex Benn?e
