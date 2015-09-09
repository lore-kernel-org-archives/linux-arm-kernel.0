From: tushar.jagad@linaro.org (Tushar Jagad)
Date: Wed,  9 Sep 2015 14:08:30 +0530
Subject: [PATCH RFC 0/4] arm64: cross cpu support
Message-ID: <1441787914-3191-1-git-send-email-tushar.jagad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently running guests having vcpus different from the host cpu
(for example running cortex-a57 guest on X-Gene) is not supported in
arm64 kvm.

This patchset adds basic support for running guests in cross cpu
configuration. Currently the cross cpu functionality is limited
to
- Target specific MIDR register value i.e. /proc/cpuinfo will reflect the
  value of cpu requested.
- Hardware debug capability infomation i.e. guest kernel will see the number
  of breakpoints and watchpoints as requested by the user.

These patches are based on top of kernel tag v4.2.

Marc Zyngier (1):
  arm64: KVM: add MIDR_EL1 switching

Tushar Jagad (3):
  arm64: kvm: enable trapping of read access to regs in TID3 group
  arm64: kvm: Setup MIDR as per target vcpu
  arm/arm64: kvm: Disable comparision of cpu and vcpu target

 Documentation/virtual/kvm/api.txt |    8 +
 arch/arm/kvm/arm.c                |   53 +++-
 arch/arm64/include/asm/kvm_arm.h  |    2 +-
 arch/arm64/include/asm/kvm_asm.h  |   40 ++-
 arch/arm64/include/asm/kvm_host.h |    4 +-
 arch/arm64/include/uapi/asm/kvm.h |    7 +
 arch/arm64/kvm/hyp.S              |    4 +
 arch/arm64/kvm/sys_regs.c         |  496 +++++++++++++++++++++++++++++++++----
 8 files changed, 556 insertions(+), 58 deletions(-)

--
1.7.9.5
