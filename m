From: drjones@redhat.com (Andrew Jones)
Date: Fri, 5 Dec 2014 18:24:25 +0100
Subject: [PATCH v2 0/6] Improve PSCI system events and fix reboot bugs
In-Reply-To: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
References: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20141205172425.GA3563@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 10:18:36PM +0100, Christoffer Dall wrote:
> Several people have reported problems with rebooting ARM VMs, especially
> on 32-bit ARM.  This is mainly due to the same reason we were seeing
> boot errors in the past, namely that the ram, dcache, and icache weren't
> coherent on guest boot with the guest (stage-1) MMU disabled.  We solved
> this by ensuring coherency when we fault in pages, but since most memory
> is already mapped after a reboot, we don't do anything.
> 
> The solution is to unmap the regular RAM on VCPU init, but we must
> take care to not unmap the GIC or other IO regions, hence the somehwat
> complicated solution.
> 
> As part of figuring this out, it became clear that some semantics around
> the KVM_ARM_VCPU_INIT ABI and system event ABI was unclear (what is
> userspace expected to do when it receives a system event).  This series
> also clarifies the ABI and changes the kernel functionality to do what
> userspace expects (turn off VCPUs on a system shutdown event).
> 
> The code is avaliable here as well:
> http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes-v2
> 
> There is an alternative version with more code-reuse for the unmapping
> implementation for the previous version of this patch series available
> in the following git repo:
> 
> http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes-alternative
> 
> Testing
> -------
> This has been tested on CubieBoard, Arndale, TC2, and Juno.  On Arndale
> and TC2 it was extremely easy to reproduce the problem (just start a VM
> that runs reboot from /etc/rc.local or similar) and this series clearly
> fixes the behavior.  For the previous version of this series, I was
> seeing some problems on Juno, but it turned out to be because I wasn't
> limiting my testing to one of the clusters, and since we don't support
> re-initing a VCPU on a different physical host CPU (big.LITTLE), it was
> failing.  For this version of the patch series, it has been running a
> reboot loop on Juno for hours.

Just tested this version. Looks good. No problems after install nor
after many, many reboots.

drew

> 
> Changelog
> ---------
> Changes v1->v2:
>  - New patch to not clear the VCPU_POWER_OFF flag
>  - Fixed spelling error in commit message
>  - Adapted ABI texts based on Peter's feedback
>  - Check for changed parameters to KVM_ARM_VCPU_INIT
>  - Now unmap the Stage-2 RAM mappings at VCPU init instead of at PSCI
>    system event time.
> 
> Christoffer Dall (6):
>   arm/arm64: KVM: Don't clear the VCPU_POWER_OFF flag
>   arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off option
>   arm/arm64: KVM: Reset the HCR on each vcpu when resetting the vcpu
>   arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
>   arm/arm64: KVM: Turn off vcpus on PSCI shutdown/reboot
>   arm/arm64: KVM: Introduce stage2_unmap_vm
> 
>  Documentation/virtual/kvm/api.txt    | 17 +++++++++-
>  arch/arm/include/asm/kvm_emulate.h   |  5 +++
>  arch/arm/include/asm/kvm_host.h      |  2 --
>  arch/arm/include/asm/kvm_mmu.h       |  1 +
>  arch/arm/kvm/arm.c                   | 56 ++++++++++++++++++++++++++++++-
>  arch/arm/kvm/guest.c                 | 26 ---------------
>  arch/arm/kvm/mmu.c                   | 65 ++++++++++++++++++++++++++++++++++++
>  arch/arm/kvm/psci.c                  | 19 +++++++++++
>  arch/arm64/include/asm/kvm_emulate.h |  5 +++
>  arch/arm64/include/asm/kvm_host.h    |  3 +-
>  arch/arm64/include/asm/kvm_mmu.h     |  1 +
>  arch/arm64/kvm/guest.c               | 26 ---------------
>  12 files changed, 168 insertions(+), 58 deletions(-)
> 
> -- 
> 2.1.2.330.g565301e.dirty
> 
