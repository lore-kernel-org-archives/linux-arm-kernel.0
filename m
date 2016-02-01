From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 17:25:23 +0100
Subject: [PATCH v2 00/21] arm64: Virtualization Host Extension support
In-Reply-To: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201162523.GA6190@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:34PM +0000, Marc Zyngier wrote:
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
> The first 20 patches massage the KVM code to deal with VHE and enable
> Linux to run at EL2. The last patch catches an ugly case when VHE
> capable CPUs are paired with some of their less capable siblings. This
> should never happen, but hey...
> 
> I have deliberately left out some of the more "advanced"
> optimizations, as they are likely to distract the reviewer from the
> core infrastructure, which is what I care about at the moment.
> 
> A few things to note:
> 
> - Given that the code has been almost entierely rewritten, I've
>   dropped all Acks from the new patches
> 
> - GDB is currently busted on VHE systems, as it checks for version 6
>   on the debug architecture, while VHE is version 7. The binutils
>   people are on the case.
> 
> This has been tested on the FVP_Base_SLV-V8-A model, and based on
> v4.5-rc1. I've put a branch out on:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vhe
> 
> * From v1:
>   - Full rewrite now that the World Switch is written in C code.
>   - Dropped the "early IRQ handling" for the moment.
> 
> Marc Zyngier (21):
>   arm/arm64: Add new is_kernel_in_hyp_mode predicate
>   arm64: Allow the arch timer to use the HYP timer
>   arm64: Add ARM64_HAS_VIRT_HOST_EXTN feature
>   arm64: KVM: Skip HYP setup when already running in HYP
>   arm64: KVM: VHE: Turn VTCR_EL2 setup into a reusable macro
>   arm64: KVM: VHE: Patch out use of HVC
>   arm64: KVM: VHE: Patch out kern_hyp_va
>   arm64: KVM: VHE: Introduce unified system register accessors
>   arm64: KVM: VHE: Differenciate host/guest sysreg save/restore
>   arm64: KVM: VHE: Split save/restore of sysregs shared between EL1 and
>     EL2
>   arm64: KVM: VHE: Use unified system register accessors
>   arm64: KVM: VHE: Enable minimal sysreg save/restore
>   arm64: KVM: VHE: Make __fpsimd_enabled VHE aware
>   arm64: KVM: VHE: Implement VHE activate/deactivate_traps
>   arm64: KVM: VHE: Use unified sysreg accessors for timer
>   arm64: KVM: VHE: Add fpsimd enabling on guest access
>   arm64: KVM: VHE: Add alternative panic handling
>   arm64: KVM: Introduce hyp_alternate_value helper
>   arm64: KVM: Move most of the fault decoding to C
>   arm64: VHE: Add support for running Linux in EL2 mode
>   arm64: Panic when VHE and non VHE CPUs coexist

These patches generally look awesome!

I found some trailing white space in patch 6 and 7 that you can fix up
if you care to.

Thanks,
-Christoffer
