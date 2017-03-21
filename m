From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Mar 2017 12:05:26 +0100
Subject: [PATCH 1/5] KVM: arm/arm64: Clarify GICC_PMR export format
In-Reply-To: <20170321110530.15857-1-cdall@linaro.org>
References: <20170321110530.15857-1-cdall@linaro.org>
Message-ID: <20170321110530.15857-2-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are exporting the format of the priority field as it's stored in the
GICH_VMCR.VMPriMask field using the lower five bits when accessing
register state using the GICC_PMR offset.  This is unfortunate, but it's
ABI already, so we simply have to make it clear.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
index 76e61c8..975a904 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
@@ -83,6 +83,12 @@ Groups:
 
     Bits for undefined preemption levels are RAZ/WI.
 
+    For historical reasons we export the GICC_PMR register in the format of the
+    GICH_VMCR.VMPriMask field in the lower 5 bits of a word, meaning that
+    userspace must always use the lower 5 bits to communicate with the KVM
+    device and must shift the value left by 3 places to obtain the actual
+    priority mask level.
+
   Limitations:
     - Priorities are not implemented, and registers are RAZ/WI
     - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
-- 
2.9.0
