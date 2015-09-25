From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:02 +0100
Subject: [PATCH v1 3/8] xen/arm: Support sign-extension for every read access
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-4-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The guest may try to load data from the emulated MMIO region using
instruction with Sign-Extension (i.e ldrs*). This can happen for any
access smaller than the register size (byte/half-word for aarch32,
byte/half-word/word for aarch64).

The support of sign-extension was limited for byte access in vGIG
emulation. Although there is no reason to not have it generically.

So move the support just after we get the data from the MMIO emulation.

Signed-off-by: Julien Grall <julien.grall@citrix.com>

---

I was thinking to completely drop the sign-extension support in Xen as
it will be very unlikely to use ldrs* instruction to access MMIO.
Although the code is fairly small, so it doesn't harm to keep it
generically.

    Changes in v2:
        - Patch added
---
 xen/arch/arm/io.c          | 29 ++++++++++++++++++++++++++++-
 xen/arch/arm/vgic-v2.c     | 10 +++++-----
 xen/arch/arm/vgic-v3.c     |  4 ++--
 xen/include/asm-arm/vgic.h |  8 +++-----
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/xen/arch/arm/io.c b/xen/arch/arm/io.c
index 32b2194..e1b03a2 100644
--- a/xen/arch/arm/io.c
+++ b/xen/arch/arm/io.c
@@ -23,6 +23,32 @@
 #include <asm/current.h>
 #include <asm/mmio.h>
 
+static int handle_read(mmio_read_t read_cb, struct vcpu *v,
+                       mmio_info_t *info, register_t *r)
+{
+    uint8_t size = (1 << info->dabt.size) * 8;
+
+    if ( !read_cb(v, info, r) )
+        return 0;
+
+    /*
+     * Extend the bit sign if required.
+     * Note that we expect the read handler to have zeroed the bit
+     * unused in the register.
+     */
+    if ( info->dabt.sign && (*r & (1UL << (size - 1)) ))
+    {
+        /*
+         * We are relying on register_t as the same size as
+         * an unsigned long or order to keep the 32bit some smaller
+         */
+        BUILD_BUG_ON(sizeof(register_t) != sizeof(unsigned long));
+        *r |= (~0UL) << size;
+    }
+
+    return 1;
+}
+
 int handle_mmio(mmio_info_t *info)
 {
     struct vcpu *v = current;
@@ -48,7 +74,8 @@ found:
     if ( info->dabt.write )
         return mmio_handler->mmio_handler_ops->write_handler(v, info, *r);
     else
-        return mmio_handler->mmio_handler_ops->read_handler(v, info, r);
+        return handle_read(mmio_handler->mmio_handler_ops->read_handler,
+                           v, info, r);
 }
 
 void register_mmio_handler(struct domain *d,
diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index 3d0ce1d..47f9da9 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -129,7 +129,7 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         *r = rank->v2.itargets[REG_RANK_INDEX(8, gicd_reg - GICD_ITARGETSR,
                                               DABT_WORD)];
         if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, dabt.sign, gicd_reg);
+            *r = vgic_byte_read(*r, gicd_reg);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -142,7 +142,7 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         *r = rank->ipriority[REG_RANK_INDEX(8, gicd_reg - GICD_IPRIORITYR,
                                             DABT_WORD)];
         if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, dabt.sign, gicd_reg);
+            *r = vgic_byte_read(*r, gicd_reg);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -377,7 +377,7 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
 
             new_target = i % 8;
             old_target_mask = vgic_byte_read(rank->v2.itargets[REG_RANK_INDEX(8,
-                                             gicd_reg - GICD_ITARGETSR, DABT_WORD)], 0, i/8);
+                                             gicd_reg - GICD_ITARGETSR, DABT_WORD)], i/8);
             old_target = find_first_bit(&old_target_mask, 8);
 
             if ( new_target != old_target )
@@ -503,7 +503,7 @@ static struct vcpu *vgic_v2_get_target_vcpu(struct vcpu *v, unsigned int irq)
     ASSERT(spin_is_locked(&rank->lock));
 
     target = vgic_byte_read(rank->v2.itargets[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], 0, irq & 0x3);
+                                              irq, DABT_WORD)], irq & 0x3);
 
     /* 1-N SPI should be delivered as pending to all the vcpus in the
      * mask, but here we just return the first vcpu for simplicity and
@@ -521,7 +521,7 @@ static int vgic_v2_get_irq_priority(struct vcpu *v, unsigned int irq)
 
     ASSERT(spin_is_locked(&rank->lock));
     priority = vgic_byte_read(rank->ipriority[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], 0, irq & 0x3);
+                                              irq, DABT_WORD)], irq & 0x3);
 
     return priority;
 }
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index 94f1a5c..c013200 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -336,7 +336,7 @@ static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
         *r = rank->ipriority[REG_RANK_INDEX(8, reg - GICD_IPRIORITYR,
                                             DABT_WORD)];
         if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, dabt.sign, reg);
+            *r = vgic_byte_read(*r, reg);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ICFGR ... GICD_ICFGRN:
@@ -1062,7 +1062,7 @@ static int vgic_v3_get_irq_priority(struct vcpu *v, unsigned int irq)
 
     ASSERT(spin_is_locked(&rank->lock));
     priority = vgic_byte_read(rank->ipriority[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], 0, irq & 0x3);
+                                              irq, DABT_WORD)], irq & 0x3);
 
     return priority;
 }
diff --git a/xen/include/asm-arm/vgic.h b/xen/include/asm-arm/vgic.h
index 96839f0..354c0d4 100644
--- a/xen/include/asm-arm/vgic.h
+++ b/xen/include/asm-arm/vgic.h
@@ -158,15 +158,13 @@ static inline int REG_RANK_NR(int b, uint32_t n)
     }
 }
 
-static inline uint32_t vgic_byte_read(uint32_t val, int sign, int offset)
+static inline uint32_t vgic_byte_read(uint32_t val, int offset)
 {
     int byte = offset & 0x3;
 
     val = val >> (8*byte);
-    if ( sign && (val & 0x80) )
-        val |= 0xffffff00;
-    else
-        val &= 0x000000ff;
+    val &= 0x000000ff;
+
     return val;
 }
 
-- 
2.1.4
