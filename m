From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:40:55 +0100
Subject: [PATCH 0/5] Improve PSCI system events and fix reboot bugs
Message-ID: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several people have reported problems with rebooting ARM VMs, especially
on 32-bit ARM.  This is mainly due to the same reason we were seeing
boot errors in the past, namely that the ram, dcache, and icache weren't
coherent on guest boot with the guest (stage-1) MMU disabled.  We solved
this by ensuring coherency when we fault in pages, but since most memory
is already mapped after a reboot, we don't do anything.

The solution is to unmap the regular RAM on system events, but we must
take care to not unmap the GIC or other IO regions, hence the somehwat
complicated solution.

As part of figuring this out, it became clear that some semantics around
the KVM_ARM_VCPU_INIT ABI and system event ABI was unclear (what is
userspace expected to do when it receives a system event).  This series
also clarifies the ABI and changes the kernel functionality to do what
userspace expects (turn off VCPUs on a system shutdown event).

The code is avaliable here as well:
http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes

There is an alternative version with more code reuse for what is patch 4
in this series available here:
http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes-alternative

See patch 4 for more info on this one.

Testing
-------
This has been tested on CubieBoard, Arndale, TC2, and Juno.  On Arndale
and TC2 it was extremely easy to reproduce the setup (just start a VM
that runs reboot from /etc/rc.local or similar) and this series clearly
fixes the behavior.

On Juno we occasionally see lockups of reboot, but I see this both with
and without this series.  I have run a VM in a loop where the guest
shuts itself down (same code path) a couple of hundred times without
seeing any issues, so I think it's safe to merge this and further
investigate the Juno reboot issue.


Christoffer Dall (5):
  arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off option
  arm/arm64: KVM: Reset the HCR on each vcpu when resetting the vcpu
  arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
  arm/arm64: KVM: Introduce stage2_unmap_vm
  arm/arm64: KVM: Turn off vcpus and flush stage-2 pgtables on sytem
    exit events

 Documentation/virtual/kvm/api.txt    | 10 +++++-
 arch/arm/include/asm/kvm_emulate.h   |  5 +++
 arch/arm/include/asm/kvm_mmu.h       |  1 +
 arch/arm/kvm/arm.c                   |  4 +++
 arch/arm/kvm/guest.c                 |  1 -
 arch/arm/kvm/mmu.c                   | 65 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/psci.c                  | 18 ++++++++++
 arch/arm64/include/asm/kvm_emulate.h |  5 +++
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/include/asm/kvm_mmu.h     |  1 +
 arch/arm64/kvm/guest.c               |  1 -
 11 files changed, 109 insertions(+), 3 deletions(-)

-- 
2.1.2.330.g565301e.dirty
