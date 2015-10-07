From: andre.przywara@arm.com (Andre Przywara)
Date: Wed,  7 Oct 2015 15:55:13 +0100
Subject: [PATCH v3 03/16] KVM: extend struct kvm_msi to hold a 32-bit device ID
In-Reply-To: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1444229726-31559-4-git-send-email-andre.przywara@arm.com>
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
Changelog v2..v3:
- adjust KVM_CAP number to not clash with upstream

 Documentation/virtual/kvm/api.txt | 12 ++++++++++--
 include/uapi/linux/kvm.h          |  5 ++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d9eccee..a302e0a 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2147,10 +2147,18 @@ struct kvm_msi {
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
index a9256f0..eae9ba1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -824,6 +824,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_MULTI_ADDRESS_SPACE 118
 #define KVM_CAP_GUEST_DEBUG_HW_BPS 119
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
+#define KVM_CAP_MSI_DEVID 121
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -975,12 +976,14 @@ struct kvm_one_reg {
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
2.5.1
