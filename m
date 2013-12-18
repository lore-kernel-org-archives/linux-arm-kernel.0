From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 17 Dec 2013 22:36:12 -0800
Subject: [RFC PATCH] KVM: arm/arm64: Clarify KVM_ARM_VCPU_INIT api
Message-ID: <1387348572-3636-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is nothing technically or semantically wrong with calling
KVM_ARM_VCPU_INIT more than once, and even calling this on a VCPU after
the VCPU has been executed.  It just happens that user space will need a
way to reset the VCPU or put the VCPU back in PSCI power-off mode after
the VM has run, for example when driving a system reset from user space.

Clarify that it is perfectly fine to use this API for that purpose.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index aad3244..d813a61 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2341,6 +2341,11 @@ return ENOEXEC for that vcpu.
 Note that because some registers reflect machine topology, all vcpus
 should be created before this ioctl is invoked.
 
+Calling this a second time on a VCPU will reset the cpu registers to
+their initial values and can be used with the feature bits to change the
+CPU state, for example to put the CPU into power off mode from user
+space.
+
 Possible features:
 	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
 	  Depends on KVM_CAP_ARM_PSCI.
-- 
1.8.5
