From: antonios.motakis@huawei.com (Antonios Motakis)
Date: Wed, 26 Aug 2015 11:12:27 +0200
Subject: [PATCH 00/13] arm64: Virtualization Host Extension support
In-Reply-To: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <55DD82FB.60903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On 08-Jul-15 18:19, Marc Zyngier wrote:
> ARMv8.1 comes with the "Virtualization Host Extension" (VHE for
> short), which enables simpler support of Type-2 hypervisors.
> 
> This extension allows the kernel to directly run at EL2, and
> significantly reduces the number of system registers shared between
> host and guest, reducing the overhead of virtualization.
> 
> In order to have the same kernel binary running on all versions of the
> architecture, this series makes heavy use of runtime code patching.
> 
> The first ten patches massage the KVM code to deal with VHE and enable
> Linux to run at EL2.

I am currently working on getting the Jailhouse hypervisor to work on AArch64.

I've been looking at your patches, trying to figure out the implications for Jailhouse. It seems there are a few :)

Jailhouse likes to be loaded by Linux into memory, and then to inject itself at a higher level than Linux (demoting Linux into being the "root cell"). This works on x86 and ARM (AArch32 and eventually AArch64 without VHE). What this means in ARM, is that Jailhouse hooks into the HVC stub exposed by Linux, and happily installs itself in EL2.

With Linux running in EL2 though, that won't be as straightforward. It looks like we can't just demote Linux to EL1 without breaking something. Obviously it's OK for us that KVM won't work, but it looks like at least the timer code will break horribly if we try to do something like that.

Any comments on this? One work around would be to just remap the incoming interrupt from the timer, so Linux never really realizes it's not running in EL2 anymore. Then we would also have to deal with the intricacies of removing and re-adding vCPUs to the Linux root cell, so we would have to maintain the illusion of running in EL2 for each one of them.

Cheers,
Antonios

> 
> The next patch catches an ugly case when VHE capable CPUs are paired
> with some of their less capable siblings. This should never happen,
> but hey...
> 
> The last two patches add an optimisation allowing a physical interrupt
> to be serviced on the host without doing a full save/restore, leading
> to potential reduction in interrupt latency.
> 
> This has been tested on the FVP_Base_SLV-V8-A model, and based on
> v4.2-rc1. I've put a branch out on:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vhe
> 
> Marc Zyngier (13):
>   arm/arm64: Add new is_kernel_in_hyp_mode predicate
>   arm64: Allow the arch timer to use the HYP timer
>   arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
>   arm64: KVM: skip HYP setup when already running in HYP
>   arm64: KVM: VHE: macroize VTCR_EL2 setup
>   arm64: KVM: VHE: Patch out kern_hyp_va
>   arm64: KVM: VHE: Patch out use of HVC
>   arm64: KVM: VHE: Preserve VHE config in world switch
>   arm64: KVM: VHE: Add alternatives for VHE-enabled world-switch
>   arm64: Add support for running Linux in EL2 mode
>   arm64: Panic when VHE and non VHE CPUs coexist
>   arm64: KVM: Split sysreg save/restore
>   arm64: KVM: VHE: Early interrupt handling
> 
>  arch/arm/include/asm/virt.h          |   5 +
>  arch/arm/kvm/arm.c                   | 134 ++++++++-----
>  arch/arm/kvm/mmu.c                   |   6 +
>  arch/arm64/include/asm/cpufeature.h  |   3 +-
>  arch/arm64/include/asm/kvm_arm.h     |   1 +
>  arch/arm64/include/asm/kvm_asm.h     |  40 +++-
>  arch/arm64/include/asm/kvm_emulate.h |   2 +
>  arch/arm64/include/asm/kvm_mmu.h     |  24 ++-
>  arch/arm64/include/asm/virt.h        |  25 +++
>  arch/arm64/kernel/cpufeature.c       |  11 ++
>  arch/arm64/kernel/head.S             |  38 +++-
>  arch/arm64/kernel/smp.c              |   4 +
>  arch/arm64/kvm/hyp-init.S            |   9 +-
>  arch/arm64/kvm/hyp.S                 | 363 ++++++++++++++++++++++++-----------
>  arch/arm64/kvm/vgic-v2-switch.S      |  19 +-
>  arch/arm64/kvm/vgic-v3-switch.S      |  33 ++--
>  arch/arm64/kvm/vhe-macros.h          |  54 ++++++
>  drivers/clocksource/arm_arch_timer.c |  96 +++++----
>  18 files changed, 638 insertions(+), 229 deletions(-)
>  create mode 100644 arch/arm64/kvm/vhe-macros.h
> 

-- 
Antonios Motakis
Virtualization Engineer
Huawei Technologies Duesseldorf GmbH
European Research Center
Riesstrasse 25, 80992 M?nchen
