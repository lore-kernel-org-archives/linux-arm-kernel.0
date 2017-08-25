From: florent.revest@arm.com (Florent Revest)
Date: Fri, 25 Aug 2017 09:31:30 +0100
Subject: [RFC 00/11] KVM, EFI, arm64: EFI Runtime Services Sandboxing
Message-ID: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series implements a mechanism to sandbox EFI Runtime Services on arm64.
It can be enabled with CONFIG_EFI_SANDBOX. At boot it spawns an internal KVM
virtual machine that is ran everytime an EFI Runtime Service is called. This
limits the possible security and stability impact of EFI runtime on the kernel.

The patch set is split as follow:
 - Patches 1 and 2: Give more control over HVC handling to KVM
 - Patches 3 to 6: Introduce the concept of KVM "internal VMs"
 - Patches 7 to 9: Reorder KVM and EFI initialization on ARM
 - Patch 10: Introduces the EFI sandboxing VM and wrappers
 - Patch 11: Workarounds some EFI Runtime Services relying on EL3

The sandboxing has been tested to work reliably (rtc and efivars) on a
SoftIron OverDrive 1000 box and on a ARMv8.3 model with VHE enabled. Normal
userspace KVM instance have also been tested to still work correctly.

Those patches apply cleanly on the Linus' v4.13-rc6 tag and have no other
dependencies.

Florent Revest (11):
  arm64: Add an SMCCC function IDs header
  KVM: arm64: Return an Unknown ID on unhandled HVC
  KVM: Allow VM lifecycle management without userspace
  KVM, arm, arm64: Offer PAs to IPAs idmapping to internal VMs
  KVM: Expose VM/VCPU creation functions
  KVM, arm64: Expose a VCPU initialization function
  KVM: Allow initialization before the module target
  KVM, arm, arm64: Initialize KVM's core earlier
  EFI, arm, arm64: Enable EFI Runtime Services later
  efi, arm64: Sandbox Runtime Services in a VM
  KVM, arm64: Don't trap internal VMs SMC calls

 arch/arm/include/asm/efi.h                 |   7 +
 arch/arm/include/asm/kvm_coproc.h          |   3 +
 arch/arm/include/asm/kvm_host.h            |   1 +
 arch/arm/include/asm/kvm_psci.h            |   1 +
 arch/arm/kvm/coproc.c                      |   6 +
 arch/arm/kvm/coproc_a15.c                  |   3 +-
 arch/arm/kvm/coproc_a7.c                   |   3 +-
 arch/arm64/include/asm/efi.h               |  71 ++++
 arch/arm64/include/asm/kvm_emulate.h       |   3 +
 arch/arm64/include/asm/kvm_host.h          |   4 +
 arch/arm64/include/asm/kvm_psci.h          |   1 +
 arch/arm64/kernel/asm-offsets.c            |   3 +
 arch/arm64/kvm/handle_exit.c               |  27 +-
 arch/arm64/kvm/sys_regs_generic_v8.c       |   8 +-
 arch/x86/include/asm/efi.h                 |   2 +
 drivers/firmware/efi/Kconfig               |  10 +
 drivers/firmware/efi/Makefile              |   1 +
 drivers/firmware/efi/arm-runtime.c         |   5 +-
 drivers/firmware/efi/arm-sandbox-payload.S |  96 +++++
 drivers/firmware/efi/arm-sandbox.c         | 569 +++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c                 |   3 +
 include/linux/kvm_host.h                   |   4 +
 include/linux/smccc_fn.h                   |  53 +++
 include/uapi/linux/psci.h                  |   2 +
 virt/kvm/arm/arm.c                         |  18 +-
 virt/kvm/arm/mmu.c                         |  76 +++-
 virt/kvm/arm/psci.c                        |  21 ++
 virt/kvm/kvm_main.c                        | 102 ++++--
 28 files changed, 1050 insertions(+), 53 deletions(-)
 create mode 100644 drivers/firmware/efi/arm-sandbox-payload.S
 create mode 100644 drivers/firmware/efi/arm-sandbox.c
 create mode 100644 include/linux/smccc_fn.h

--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
