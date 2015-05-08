From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  8 May 2015 10:18:00 +0900
Subject: [v4 0/4] arm64: kvm: reset hyp context for kexec
Message-ID: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set addresses KVM issue described in Geoff's kexec patch set[1].
See "Changes" below.
Initially, I used reboot notifier hook to shut down cpu cores, but in this
version, kvm cpu hotplug is implemented after Mark's comment.

I confirmed that it works with kexec under the following scenarios:
  - boot 1st kernel
  - run a guest OS
  - (stop a guest OS)
  - reboot 2nd kernel by kexec
  - run a guest OS

test target: MediaTek MT8173-EVB
version:     kernel v4.0-rc1 + Geoff's kexec v8 + Arn's patch[2]

But I didn't test other complicated scenarios with cpu hotplug.

On arm, Frediano[3] is no longer working on this issue as he left his
company. patch#4 is just a stub for arm.

Changes from v3:
* modified to use kvm cpu hotplug framework directly instead of reboot
  notifier hook

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

[1] http://lists.infradead.org/pipermail/kexec/2015-April/335533.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/334002.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322231.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/334910.html


AKASHI Takahiro (4):
  arm64: kvm: add a cpu tear-down function
  arm64: kvm: add kvm cpu hotplug
  arm64: kvm: remove !KEXEC dependency
  arm: kvm: add stub implementation for kvm_cpu_reset()

 arch/arm/include/asm/kvm_asm.h    |    1 +
 arch/arm/include/asm/kvm_host.h   |   13 ++++++++++-
 arch/arm/include/asm/kvm_mmu.h    |    5 +++++
 arch/arm/kvm/arm.c                |   44 ++++++++++++++++++++++++++++---------
 arch/arm/kvm/init.S               |    6 +++++
 arch/arm/kvm/mmu.c                |    5 +++++
 arch/arm64/include/asm/kvm_asm.h  |    1 +
 arch/arm64/include/asm/kvm_host.h |   12 +++++++++-
 arch/arm64/include/asm/kvm_mmu.h  |    7 ++++++
 arch/arm64/include/asm/virt.h     |   11 ++++++++++
 arch/arm64/kvm/Kconfig            |    1 -
 arch/arm64/kvm/hyp-init.S         |   32 +++++++++++++++++++++++++++
 arch/arm64/kvm/hyp.S              |   16 +++++++++++---
 13 files changed, 138 insertions(+), 16 deletions(-)

-- 
1.7.9.5
