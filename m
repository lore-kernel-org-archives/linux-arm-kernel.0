From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 29 May 2015 14:38:38 +0900
Subject: [PATCH v5 0/2] arm64: kvm: reset hyp context for kexec
Message-ID: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch was initially intended to address a KVM issue described in
Geoff's kexec patch set[1]. But now the title of patch#1 would be more
suitable for the entire code as it was overhauled and, since the 4th
version, the fix is implemented as kvm cpu hotplug after Mark's comment.

I confirmed that it works with kexec under the following scenarios:
  - boot 1st kernel
  - run a guest OS
  - (stop a guest OS)
  - reboot 2nd kernel by kexec
  - run a guest OS

test target: MediaTek MT8173-EVB
version:     kernel v4.0-rc1 + Geoff's kexec v8 + Ard's patch[2]

But I didn't test other complicated scenarios with cpu hotplug.

On arm, Frediano[3] is no longer working on this issue as he left his
company. So patch#1 also has a stub definition for arm.


Changes from v4:
* restructured the patchset as cpu_init_hyp_mode() and kvm_cpu_reset() were
  renamed to kvm_arch_hardware_{enable,disable}() respectively
* omitted some obvious arguments from __cpu_reset_hyp_mode().

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

AKASHI Takahiro (2):
  arm64: kvm: allows kvm cpu hotplug
  arm64: kvm: remove !KEXEC dependency

 arch/arm/include/asm/kvm_host.h   |   10 ++++++-
 arch/arm/include/asm/kvm_mmu.h    |    1 +
 arch/arm/kvm/arm.c                |   58 ++++++++++++-------------------------
 arch/arm/kvm/mmu.c                |    5 ++++
 arch/arm64/include/asm/kvm_host.h |   11 ++++++-
 arch/arm64/include/asm/kvm_mmu.h  |    1 +
 arch/arm64/include/asm/virt.h     |    9 ++++++
 arch/arm64/kvm/Kconfig            |    1 -
 arch/arm64/kvm/hyp-init.S         |   33 +++++++++++++++++++++
 arch/arm64/kvm/hyp.S              |   32 +++++++++++++++++---
 10 files changed, 114 insertions(+), 47 deletions(-)

-- 
1.7.9.5
