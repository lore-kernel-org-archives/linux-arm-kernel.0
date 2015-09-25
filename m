From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:04 +0100
Subject: [PATCH v1 5/8] xen/arm: vgic: Optimize the way to store
 GICD_IPRIORITYR in the rank
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-6-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xen is currently directly storing the value of register GICD_IPRIORITYR
in the rank. This makes emulation of the register access very simple
but makes the code to get the priority for a given IRQ more complex.

While the priority of an IRQ is retrieved everytime an IRQ is injected
to the guest, the access to register occurs less often.

So the data structure should be optimized for the most common case
rather than the inverse.

This patch introduces the usage of an array to store the priority for
every interrupt in the rank. This will make the code to get the priority
very quick. The emulation code will now have to generate the GICD_PRIORITYR
register for read access and split it to store in a convenient way.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
---

The real reason is I'd like to drop vgic_byte_* helpers in favors of more
generic access helper. Although it would make the code to retrieve the
priority more complex. So reworking the way to get the priority was the
best solution.

    Changes in v2:
        - Patch added
---
 xen/arch/arm/vgic-v2.c     | 24 ++++++++++++++----------
 xen/arch/arm/vgic-v3.c     | 27 ++++++++++++++++-----------
 xen/arch/arm/vgic.c        | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 xen/include/asm-arm/vgic.h | 18 +++++++++++++++++-
 4 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index 47f9da9..23d1982 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -139,8 +139,8 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         if ( rank == NULL) goto read_as_zero;
 
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ipriority[REG_RANK_INDEX(8, gicd_reg - GICD_IPRIORITYR,
-                                            DABT_WORD)];
+        /* Recreate the IPRIORITYR register */
+        *r = vgic_generate_ipriorityr(rank, gicd_reg - GICD_IPRIORITYR);
         if ( dabt.size == DABT_BYTE )
             *r = vgic_byte_read(*r, gicd_reg);
         vgic_unlock_rank(v, rank, flags);
@@ -400,18 +400,25 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
     }
 
     case GICD_IPRIORITYR ... GICD_IPRIORITYRN:
+    {
+        uint32_t ipriorityr;
+
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_IPRIORITYR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         if ( dabt.size == DABT_WORD )
-            rank->ipriority[REG_RANK_INDEX(8, gicd_reg - GICD_IPRIORITYR,
-                                           DABT_WORD)] = r;
+            ipriorityr = r;
         else
-            vgic_byte_write(&rank->ipriority[REG_RANK_INDEX(8,
-                        gicd_reg - GICD_IPRIORITYR, DABT_WORD)], r, gicd_reg);
+        {
+            ipriorityr = vgic_generate_ipriorityr(rank,
+                                                  gicd_reg - GICD_IPRIORITYR);
+            vgic_byte_write(&ipriorityr, r, gicd_reg);
+        }
+        vgic_store_ipriorityr(rank, gicd_reg - GICD_IPRIORITYR, ipriorityr);
         vgic_unlock_rank(v, rank, flags);
         return 1;
+    }
 
     case GICD_ICFGR: /* SGIs */
         goto write_ignore_32;
@@ -516,14 +523,11 @@ static struct vcpu *vgic_v2_get_target_vcpu(struct vcpu *v, unsigned int irq)
 
 static int vgic_v2_get_irq_priority(struct vcpu *v, unsigned int irq)
 {
-    int priority;
     struct vgic_irq_rank *rank = vgic_rank_irq(v, irq);
 
     ASSERT(spin_is_locked(&rank->lock));
-    priority = vgic_byte_read(rank->ipriority[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], irq & 0x3);
 
-    return priority;
+    return rank->priority[irq & INTERRUPT_RANK_MASK];
 }
 
 static int vgic_v2_vcpu_init(struct vcpu *v)
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index c013200..2787507 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -333,8 +333,8 @@ static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
         if ( rank == NULL ) goto read_as_zero;
 
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ipriority[REG_RANK_INDEX(8, reg - GICD_IPRIORITYR,
-                                            DABT_WORD)];
+        /* Recreate the IPRIORITYR register */
+        *r = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
         if ( dabt.size == DABT_BYTE )
             *r = vgic_byte_read(*r, reg);
         vgic_unlock_rank(v, rank, flags);
@@ -430,18 +430,26 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         return 0;
 
     case GICD_IPRIORITYR ... GICD_IPRIORITYRN:
+    {
+        uint32_t ipriorityr;
+
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, reg - GICD_IPRIORITYR, DABT_WORD);
-        if ( rank == NULL ) goto write_ignore;
+        if ( rank == NULL) goto write_ignore;
+
         vgic_lock_rank(v, rank, flags);
         if ( dabt.size == DABT_WORD )
-            rank->ipriority[REG_RANK_INDEX(8, reg - GICD_IPRIORITYR,
-                                           DABT_WORD)] = r;
+            ipriorityr = r;
         else
-            vgic_byte_write(&rank->ipriority[REG_RANK_INDEX(8,
-                       reg - GICD_IPRIORITYR, DABT_WORD)], r, reg);
+        {
+            ipriorityr = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
+            vgic_byte_write(&ipriorityr, r, reg);
+        }
+        vgic_store_ipriorityr(rank, reg - GICD_IPRIORITYR, ipriorityr);
         vgic_unlock_rank(v, rank, flags);
         return 1;
+    }
+
     case GICD_ICFGR: /* Restricted to configure SGIs */
         goto write_ignore_32;
     case GICD_ICFGR + 4 ... GICD_ICFGRN: /* PPI + SPIs */
@@ -1057,14 +1065,11 @@ static const struct mmio_handler_ops vgic_distr_mmio_handler = {
 
 static int vgic_v3_get_irq_priority(struct vcpu *v, unsigned int irq)
 {
-    int priority;
     struct vgic_irq_rank *rank = vgic_rank_irq(v, irq);
 
     ASSERT(spin_is_locked(&rank->lock));
-    priority = vgic_byte_read(rank->ipriority[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], irq & 0x3);
 
-    return priority;
+    return rank->priority[irq & INTERRUPT_RANK_MASK];
 }
 
 static int vgic_v3_vcpu_init(struct vcpu *v)
diff --git a/xen/arch/arm/vgic.c b/xen/arch/arm/vgic.c
index a6835a8..50ad360 100644
--- a/xen/arch/arm/vgic.c
+++ b/xen/arch/arm/vgic.c
@@ -61,6 +61,52 @@ struct vgic_irq_rank *vgic_rank_irq(struct vcpu *v, unsigned int irq)
     return vgic_get_rank(v, rank);
 }
 
+#define NR_PRIORITY_PER_REG 4U
+#define NR_BIT_PER_PRIORITY 8U
+
+/*
+ * Generate the associated IPRIORITYR register based on an offset in the rank.
+ * Note the offset will be round down to match a real HW register.
+ */
+uint32_t vgic_generate_ipriorityr(struct vgic_irq_rank *rank,
+                                  unsigned int offset)
+{
+    uint32_t reg = 0;
+    unsigned int i;
+
+    ASSERT(spin_is_locked(&rank->lock));
+
+    offset &= INTERRUPT_RANK_MASK;
+    offset &= ~(NR_PRIORITY_PER_REG - 1);
+
+    for ( i = 0; i < NR_PRIORITY_PER_REG; i++, offset++ )
+        reg |= rank->priority[offset] << (i * NR_BIT_PER_PRIORITY);
+
+    return reg;
+}
+
+/*
+ * Store a IPRIORITYR register in a convenient way.
+ * Note the offset will be round down to match a real HW register.
+ */
+void vgic_store_ipriorityr(struct vgic_irq_rank *rank,
+                           unsigned int offset,
+                           uint32_t reg)
+{
+    unsigned int i;
+
+    ASSERT(spin_is_locked(&rank->lock));
+
+    offset &= INTERRUPT_RANK_MASK;
+    offset &= ~(NR_PRIORITY_PER_REG - 1);
+
+    for ( i = 0; i < NR_PRIORITY_PER_REG; i++, offset++ )
+    {
+        rank->priority[offset] = reg & ((1 << NR_BIT_PER_PRIORITY) - 1);
+        reg >>= NR_BIT_PER_PRIORITY;
+    }
+}
+
 static void vgic_init_pending_irq(struct pending_irq *p, unsigned int virq)
 {
     INIT_LIST_HEAD(&p->inflight);
diff --git a/xen/include/asm-arm/vgic.h b/xen/include/asm-arm/vgic.h
index 354c0d4..ce9970e 100644
--- a/xen/include/asm-arm/vgic.h
+++ b/xen/include/asm-arm/vgic.h
@@ -82,12 +82,21 @@ struct pending_irq
     struct list_head lr_queue;
 };
 
+#define NR_INTERRUPT_PER_RANK   32
+#define INTERRUPT_RANK_MASK (NR_INTERRUPT_PER_RANK - 1)
+
 /* Represents state corresponding to a block of 32 interrupts */
 struct vgic_irq_rank {
     spinlock_t lock; /* Covers access to all other members of this struct */
     uint32_t ienable;
     uint32_t icfg[2];
-    uint32_t ipriority[8];
+
+    /*
+     * It's more convenient to store one priority per interrupt than
+     * the register IPRIORITYR itself
+     */
+    uint8_t priority[32];
+
     union {
         struct {
             uint32_t itargets[8];
@@ -244,6 +253,13 @@ void vgic_v3_setup_hw(paddr_t dbase,
                       uint32_t rdist_stride);
 #endif
 
+/* Helpers to handle the GICD_IPRIORITY register */
+uint32_t vgic_generate_ipriorityr(struct vgic_irq_rank *rank,
+                                  unsigned int offset);
+void vgic_store_ipriorityr(struct vgic_irq_rank *rank,
+                           unsigned int offset,
+                           uint32_t reg);
+
 #endif /* __ASM_ARM_VGIC_H__ */
 
 /*
-- 
2.1.4
