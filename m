From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:16 +0100
Subject: [PATCH v3 01/19] KVM: arm/arm64: Add vITS save/restore API
 documentation
In-Reply-To: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1488800074-21991-2-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for how to access vITS registers and how to flush/restore
vITS tables into/from memory

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- DTE and ITE now are 8 bytes
- DTE and ITE now indexed by deviceid/eventid
- use ITE name instead of ITTE
- mentions ITT_addr matches bits [51:8] of the actual address
- mentions LE layout
---
 Documentation/virtual/kvm/devices/arm-vgic-its.txt | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
index 6081a5b..49ade0c 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
@@ -36,3 +36,81 @@ Groups:
     -ENXIO:  ITS not properly configured as required prior to setting
              this attribute
     -ENOMEM: Memory shortage when allocating ITS internal data
+
+  KVM_DEV_ARM_VGIC_GRP_ITS_REGS
+  Attributes:
+      The attr field of kvm_device_attr encodes the offset of the
+      ITS register, relative to the ITS control frame base address
+      (ITS_base).
+
+      kvm_device_attr.addr points to a __u64 value whatever the width
+      of the addressed register (32/64 bits).
+
+      Writes to read-only registers are ignored by the kernel except
+      for a single register, GITS_READR. Normally this register is RO
+      but it needs to be restored otherwise commands in the queue will
+      be re-executed after CWRITER setting.
+
+      For other registers, Getting or setting a register has the same
+      effect as reading/writing the register on real hardware.
+  Errors:
+    -ENXIO: Offset does not correspond to any supported register
+    -EFAULT: Invalid user pointer for attr->addr
+    -EINVAL: Offset is not 64-bit aligned
+
+  KVM_DEV_ARM_VGIC_GRP_ITS_TABLES
+  Attributes
+       The attr field of kvm_device_attr is not used.
+
+       request the flush-save/restore of the ITS tables, namely
+       the device table, the collection table, all the ITT tables,
+       the LPI pending tables. On save, the tables are flushed
+       into guest memory at the location provisioned by the guest
+       in GITS_BASER (device and collection tables), on MAPD command
+       (ITT_addr), GICR_PENDBASERs (pending tables).
+
+       This means the GIC should be restored before the ITS and all
+       ITS registers but the GITS_CTRL must be restored before
+       restoring the ITS tables.
+
+       Note the LPI configuration table is read-only for the
+       in-kernel ITS and its save/restore goes through the standard
+       RAM save/restore.
+
+       The layout of the tables in guest memory defines an ABI.
+       The entries are laid in little endian format as follows;
+
+    The device table and ITE are respectively indexed by device id and
+    eventid. The collection table however is not indexed by collection id:
+    CTE are written at the beginning of the buffer.
+
+    Device Table Entry (DTE) layout: entry size = 8 bytes
+
+    bits:     | 63 ... 45 | 44 ... 5 | 4 ... 0 |
+    values:   |   next    | ITT_addr |  Size   |
+
+    where
+    - ITT_addr matches bits [48:8] of the ITT address (256B aligned).
+    - next field is meaningful only if the entry is valid (ITT_addr != NULL).
+    It equals to 0 if this entry is the last one; otherwise it corresponds
+    to the minimum between the offset to the next device id and 2^19 -1.
+
+    Collection Table Entry (CTE) layout: entry size = 8 bytes
+
+    bits:     | 63| 62 ..  52  | 51 ... 16 | 15  ...   0 |
+    values:   | V |    RES0    |  RDBase   |    ICID     |
+
+    Interrupt Translation Entry (ITE) layout: entry size = 8 bytes
+
+    bits:     | 63 ... 48 | 47 ... 16 | 15 ... 0 |
+    values:   |    next   |   pINTID  |  ICID    |
+
+    - next field is meaningful only if the entry is valid (pINTID != NULL).
+    It equals to 0 if this entry is the last one; otherwise it corresponds
+    to the minimum between the eventid offset to the next ITE and 2^16 -1.
+
+    LPI Pending Table layout:
+
+    As specified in the ARM Generic Interrupt Controller Architecture
+    Specification GIC Architecture version 3.0 and version 4. The first
+    1kB is not modified and therefore should contain zeroes.
-- 
2.5.5
