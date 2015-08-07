From: eric.auger@linaro.org (Eric Auger)
Date: Fri,  7 Aug 2015 18:08:29 +0200
Subject: [PATCH v2 0/4] KVM: arm/arm64: guest synchronous halt/resume
Message-ID: <1438963713-10460-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces the capability to synchronously exit the guest
and prevent it from being re-entered. This modality will be used by
IRQ forwarding series when changing the state of the IRQ.

Former pause flag used when starting the vcpu in KVM_ARM_VCPU_POWER_OFF
state, in PSCI calls and in KVM_SET_MP_STATE ioctl is renamed into
power_off. A new pause flag is introduced. Both now are checked in
kvm_arch_vcpu_runnable and in the VCPU_RUN critical section, before
entering the vcpu.

Best Regards

Eric

History:

v1 -> v2:
- check pause, power_off and in kvm_arch_vcpu_runnable
- check power_off in vcpu_run critcal section before guest entry
- correct compil issue in first patch reported by Andrew
- rename vcpu_pause into vcpu_sleep

RFC -> PATCH v1:
- originally part of [RFC 00/17] ARM IRQ forward control based on IRQ
  bypass manager (https://lkml.org/lkml/2015/7/2/268) and isolated in
  this series.
- added __maybe_unused following Marc's advice


Eric Auger (4):
  KVM: arm/arm64: rename pause into power_off
  KVM: arm/arm64: check power_off in kvm_arch_vcpu_runnable
  KVM: arm/arm64: check power_off in critical section before VCPU run
  KVM: arm/arm64: implement kvm_arm_[halt,resume]_guest

 arch/arm/include/asm/kvm_host.h   |  5 +++-
 arch/arm/kvm/arm.c                | 53 ++++++++++++++++++++++++++++++---------
 arch/arm/kvm/psci.c               | 10 ++++----
 arch/arm64/include/asm/kvm_host.h |  3 +++
 4 files changed, 53 insertions(+), 18 deletions(-)

-- 
1.9.1
