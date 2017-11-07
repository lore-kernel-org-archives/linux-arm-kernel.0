From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  7 Nov 2017 11:47:56 +0100
Subject: [PULL 23/26] KVM: arm/arm64: Document KVM_DEV_ARM_ITS_CTRL_RESET
In-Reply-To: <20171107104800.30021-1-christoffer.dall@linaro.org>
References: <20171107104800.30021-1-christoffer.dall@linaro.org>
Message-ID: <20171107104800.30021-24-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

At the moment, the in-kernel emulated ITS is not properly reset.
On guest restart/reset some registers keep their old values and
internal structures like device, ITE, and collection lists are not
freed.

This may lead to various bugs. Among them, we can have incorrect state
backup or failure when saving the ITS state at early guest boot stage.

This patch documents a new attribute, KVM_DEV_ARM_ITS_CTRL_RESET in
the KVM_DEV_ARM_VGIC_GRP_CTRL group.

Upon this action, we can reset registers and especially those
pointing to tables previously allocated by the guest and free
the internal data structures storing the list of devices, collections
and lpis.

The usual approach for device reset of having userspace write
the reset values of the registers to the kernel via the register
read/write APIs doesn't work for the ITS because it has some
internal state (caches) which is not exposed as registers,
and there is no register interface for "drop cached data without
writing it back to RAM". So we need a KVM API which mimics the
hardware's reset line, to provide the equivalent behaviour to
a "pull the power cord out of the back of the machine" reset.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/devices/arm-vgic-its.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
index eb06beb75960..8d5830eab26a 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
@@ -33,6 +33,10 @@ Groups:
       request the initialization of the ITS, no additional parameter in
       kvm_device_attr.addr.
 
+    KVM_DEV_ARM_ITS_CTRL_RESET
+      reset the ITS, no additional parameter in kvm_device_attr.addr.
+      See "ITS Reset State" section.
+
     KVM_DEV_ARM_ITS_SAVE_TABLES
       save the ITS table data into guest RAM, at the location provisioned
       by the guest in corresponding registers/table entries.
@@ -157,3 +161,19 @@ Then vcpus can be started.
  - pINTID is the physical LPI ID; if zero, it means the entry is not valid
    and other fields are not meaningful.
  - ICID is the collection ID
+
+ ITS Reset State:
+ ----------------
+
+RESET returns the ITS to the same state that it was when first created and
+initialized. When the RESET command returns, the following things are
+guaranteed:
+
+- The ITS is not enabled and quiescent
+  GITS_CTLR.Enabled = 0 .Quiescent=1
+- There is no internally cached state
+- No collection or device table are used
+  GITS_BASER<n>.Valid = 0
+- GITS_CBASER = 0, GITS_CREADR = 0, GITS_CWRITER = 0
+- The ABI version is unchanged and remains the one set when the ITS
+  device was first created.
-- 
2.14.2
