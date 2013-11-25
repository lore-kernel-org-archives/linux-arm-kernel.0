From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 25 Nov 2013 21:19:57 +0530
Subject: [PATCH 0/2] PSCI system off and reset for KVM ARM/ARM64
Message-ID: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power State and Coordination Interface (PSCI) specification defines
SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.

This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
KVM_EXIT_SHUTDOWN and KVM_EXIT_RESET exit reasons.

To try this patch from guest kernel, we will need PSCI-based restart and
poweroff support in the guest kenel for both ARM and ARM64.

Rob Herring has already submitted patches for PSCI-based restart and
poweroff in ARM kernel but these are not merged yet due unstable device
tree bindings of kernel PSCI support. We will be having similar patches
for PSCI-based restart and poweroff in ARM64 kernel.
(Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
(Refer http://www.spinics.net/lists/devicetree/msg05348.html)

Anup Patel (2):
  KVM: Add KVM_EXIT_RESET to user space API header
  ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and SYSTEM_RESET to user
    space

 arch/arm/include/asm/kvm_psci.h   |    2 +-
 arch/arm/include/uapi/asm/kvm.h   |    2 ++
 arch/arm/kvm/handle_exit.c        |    7 ++++++-
 arch/arm/kvm/psci.c               |   38 +++++++++++++++++++++++++++++--------
 arch/arm64/include/asm/kvm_psci.h |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |    2 ++
 arch/arm64/kvm/handle_exit.c      |   10 ++++++----
 include/uapi/linux/kvm.h          |    1 +
 8 files changed, 49 insertions(+), 15 deletions(-)

-- 
1.7.9.5
