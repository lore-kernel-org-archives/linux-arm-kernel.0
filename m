From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:49:33 -0700
Subject: [PATCH 5/9] KVM: Add documentation for KVM_ARM_PREFERRED_TARGET ioctl
In-Reply-To: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
References: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1381884577-24747-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

To implement CPU=Host we have added KVM_ARM_PREFERRED_TARGET
vm ioctl which provides information to user space required for
creating VCPU matching underlying Host.

This patch adds info related to this new KVM_ARM_PREFERRED_TARGET
vm ioctl in the KVM API documentation.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 858aecf..076b849 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2304,7 +2304,31 @@ Possible features:
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
 
 
-4.83 KVM_GET_REG_LIST
+4.83 KVM_ARM_PREFERRED_TARGET
+
+Capability: basic
+Architectures: arm, arm64
+Type: vm ioctl
+Parameters: struct struct kvm_vcpu_init (out)
+Returns: 0 on success; -1 on error
+Errors:
+  ENODEV:    no preferred target available for the host
+
+This queries KVM for preferred CPU target type which can be emulated
+by KVM on underlying host.
+
+The ioctl returns struct kvm_vcpu_init instance containing information
+about preferred CPU target type and recommended features for it.  The
+kvm_vcpu_init->features bitmap returned will have feature bits set if
+the preferred target recommends setting these features, but this is
+not mandatory.
+
+The information returned by this ioctl can be used to prepare an instance
+of struct kvm_vcpu_init for KVM_ARM_VCPU_INIT ioctl which will result in
+in VCPU matching underlying host.
+
+
+4.84 KVM_GET_REG_LIST
 
 Capability: basic
 Architectures: arm, arm64
@@ -2323,8 +2347,7 @@ struct kvm_reg_list {
 This ioctl returns the guest registers that are supported for the
 KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
 
-
-4.84 KVM_ARM_SET_DEVICE_ADDR
+4.85 KVM_ARM_SET_DEVICE_ADDR
 
 Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
 Architectures: arm, arm64
@@ -2362,7 +2385,7 @@ must be called after calling KVM_CREATE_IRQCHIP, but before calling
 KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
 base addresses will return -EEXIST.
 
-4.85 KVM_PPC_RTAS_DEFINE_TOKEN
+4.86 KVM_PPC_RTAS_DEFINE_TOKEN
 
 Capability: KVM_CAP_PPC_RTAS
 Architectures: ppc
-- 
1.7.10.4
