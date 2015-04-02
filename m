From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  2 Apr 2015 14:40:11 +0900
Subject: [v3 0/5] arm64: kvm: reset hyp context for kexec
Message-ID: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set addresses KVM issue described in Geoff's kexec patch set[1].
(The subject was changed from "arm64: kexec: fix kvm issue in kexec.")
See "Changes" below.

The basic approach here is to define a kvm tear-down function and add
a reboot hook to gracefully shutdown the 1st kernel. This way, kvm gets
free from kexec-specific cleanup and yet we allows future enhancement,
like cpu hotplug & building kvm as a module, based on tear-down function.
In this sense, patch #1 & #2 (and #5) actually fix the problem, and #3 & #4
are rather informative.

I confirmed that 1st kernel successfully shut down and 2nd kernel started
with the following messages:

    kvm [1]: Using HYP init bounce page @8fa52f000
    kvm [1]: interrupt-controller at 2c02f000 IRQ6
    kvm [1]: timer IRQ3
    kvm [1]: Hyp mode initialized successfully

test target: Base fast model
version:     kernel v4.0-rc4 + Geoff's kexec v8 + Arn's patch[2]


I still have some concerns about the following points. Please let me know
if you have any comments:

1) Call kvm_cpu_reset() on non-boot cpus in reboot notifier
   We don't have to do so in kexec-specific case. But the current code runs
   the function on each cpu for safety since we use a general reboot hook.
2) Flush D$ in kvm_cpu_reset()
   Currently doesn't do so because all the cpus are just going to shut down,
   and we actually flush D$ on boot cpu in Geoff's cpu_reset().
3) Compatibility with arm implementation
   Frediano[2] is no longer working on this issue on arm as he left his
   company. But my approach here is based on a generic interface and can be
   applied to arm in a similar way.

Changes from v2:
* modified kvm_virt_to_trampoline() macro to fix a page-alignment issue[4]

Changes from v1:
* modified kvm_cpu_reset() implementation:
    - define a macro to translate va to addr in trampoline
    - use __hyp_default_vectors instead of kvm_get_hyp_stub_vectors()
    - shuffle the arguments in __cpu_reset_hyp_mode()
    - optimize TLB flush operations
* changed a patch#2's name
* added a patch#5 to add stub code for arm

[1] http://lists.infradead.org/pipermail/kexec/2015-March/013432.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/334002.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322231.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/334910.html


AKASHI Takahiro (5):
  arm64: kvm: add a cpu tear-down function
  arm64: kvm: allow EL2 context to be reset on shutdown
  arm64: kvm: add cpu reset hook for cpu hotplug
  arm64: kvm: add cpu reset at module exit
  arm: kvm: add stub implementation for kvm_cpu_reset()

 arch/arm/include/asm/kvm_asm.h    |    1 +
 arch/arm/include/asm/kvm_host.h   |   13 +++++++++-
 arch/arm/include/asm/kvm_mmu.h    |    5 ++++
 arch/arm/kvm/arm.c                |   51 +++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/init.S               |    6 +++++
 arch/arm/kvm/mmu.c                |    5 ++++
 arch/arm64/include/asm/kvm_asm.h  |    1 +
 arch/arm64/include/asm/kvm_host.h |   12 ++++++++-
 arch/arm64/include/asm/kvm_mmu.h  |    7 +++++
 arch/arm64/include/asm/virt.h     |   11 ++++++++
 arch/arm64/kvm/Kconfig            |    1 -
 arch/arm64/kvm/hyp-init.S         |   35 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp.S              |   16 +++++++++---
 13 files changed, 158 insertions(+), 6 deletions(-)

-- 
1.7.9.5
