From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 26 Mar 2016 02:13:59 +0000
Subject: [PATCH v4 01/12] KVM: extend struct kvm_msi to hold a 32-bit device ID
In-Reply-To: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458958450-19662-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM GICv3 ITS MSI controller requires a device ID to be able to
assign the proper interrupt vector. On real hardware, this ID is
sampled from the bus. To be able to emulate an ITS controller, extend
the KVM MSI interface to let userspace provide such a device ID. For
PCI devices, the device ID is simply the 16-bit bus-device-function
triplet, which should be easily available to the userland tool.

Also there is a new KVM capability which advertises whether the
current VM requires a device ID to be set along with the MSI data.
This flag is still reported as not available everywhere, later we will
enable it when ITS emulation is used.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 12 ++++++++++--
 include/uapi/linux/kvm.h          |  5 ++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cb2ef0b..8f7351d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2163,10 +2163,18 @@ struct kvm_msi {
 	__u32 address_hi;
 	__u32 data;
 	__u32 flags;
-	__u8  pad[16];
+	__u32 devid;
+	__u8  pad[12];
 };
 
-No flags are defined so far. The corresponding field must be 0.
+flags: KVM_MSI_VALID_DEVID: devid contains a valid value
+devid: If KVM_MSI_VALID_DEVID is set, contains a unique device identifier
+       for the device that wrote the MSI message.
+       For PCI, this is usually a BFD identifier in the lower 16 bits.
+
+The per-VM KVM_CAP_MSI_DEVID capability advertises the need to provide
+the device ID. If this capability is not set, userland cannot rely on
+the kernel to allow the KVM_MSI_VALID_DEVID flag being set.
 
 
 4.71 KVM_CREATE_PIT2
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 50f44a2..6a02871 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -852,6 +852,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_RI 124
 #define KVM_CAP_ARM_PMU_V3 125
 #define KVM_CAP_VCPU_ATTRIBUTES 126
+#define KVM_CAP_MSI_DEVID 127
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1010,12 +1011,14 @@ struct kvm_one_reg {
 	__u64 addr;
 };
 
+#define KVM_MSI_VALID_DEVID	(1U << 0)
 struct kvm_msi {
 	__u32 address_lo;
 	__u32 address_hi;
 	__u32 data;
 	__u32 flags;
-	__u8  pad[16];
+	__u32 devid;
+	__u8  pad[12];
 };
 
 struct kvm_arm_device_addr {
-- 
2.7.3
