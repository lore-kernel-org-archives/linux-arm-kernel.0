From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:05 +0100
Subject: [PATCH v1 6/8] xen/arm: vgic: Optimize the way to store the target
 vCPU in the rank
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-7-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xen is currently directly storing the value of register GICD_ITARGETSR
(for GICv2) and GICD_IROUTER (for GICv3) in the rank. This makes the
emulation of the registers access very simple but makes the code to get
the target vCPU for a given IRQ more complex.

While the target vCPU of an IRQ is retrieved everytime an IRQ is
injected to the guest, the access to the register occurs less often.

So the data structure should be optimized for the most common case
rather than the inverse.

This patch introduce the usage of an array to store the target vCPU for
every interrupt in the rank. This will make the code to get the target
very quick. The emulation code will now have to generate the GICD_ITARGETSR
and GICD_IROUTER register for read access and split it to store in a
convenient way.

Note that with these changes, any read to those registers will list only
the target vCPU used by Xen. This is fine because the GIC spec doesn't
require to return exactly the value written and it can be seen as if we
decide to implement the register read-only.

Finally take the opportunity to fix coding style in section we are
modifying.

Signed-off-by: Julien Grall <julien.grall@citrix.com>

---
    The real reason is I'd like to drop vgic_byte_* helpers in favor of more
    generic access helpers. Although it would make the code to retrieve the
    priority more complex. So reworking the code to get the target vCPU
    was the best solution.

    Changes in v2:
        - Patch added
---
 xen/arch/arm/vgic-v2.c     | 172 ++++++++++++++++++++++++++-------------------
 xen/arch/arm/vgic-v3.c     | 121 +++++++++++++++++--------------
 xen/arch/arm/vgic.c        |  28 ++++++--
 xen/include/asm-arm/vgic.h |  13 ++--
 4 files changed, 197 insertions(+), 137 deletions(-)

diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index 23d1982..b6db64f 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -50,6 +50,90 @@ void vgic_v2_setup_hw(paddr_t dbase, paddr_t cbase, paddr_t vbase)
     vgic_v2_hw.vbase = vbase;
 }
 
+#define NR_TARGET_PER_REG 4U
+#define NR_BIT_PER_TARGET 8U
+
+/*
+ * Generate the associated ITARGETSR register based on the offset from
+ * ITARGETSR0. Only one vCPU will be listed for a given IRQ.
+ *
+ * Note the offset will be round down to match a real HW register.
+ */
+static uint32_t vgic_generate_itargetsr(struct vgic_irq_rank *rank,
+                                        unsigned int offset)
+{
+    uint32_t reg = 0;
+    unsigned int i;
+
+    ASSERT(spin_is_locked(&rank->lock));
+
+    offset &= INTERRUPT_RANK_MASK;
+    offset &= ~(NR_TARGET_PER_REG - 1);
+
+    for ( i = 0; i < NR_TARGET_PER_REG; i++, offset++ )
+        reg |= (1 << rank->vcpu[offset]) << (i * NR_BIT_PER_TARGET);
+
+    return reg;
+}
+
+/*
+ * Store a ITARGETSR register in a convenient way and migrate the IRQ
+ * if necessary.
+ * Note the offset will be round down to match a real HW register.
+ */
+static void vgic_store_itargetsr(struct domain *d, struct vgic_irq_rank *rank,
+                                 unsigned int offset, uint32_t itargetsr)
+{
+    unsigned int i, rank_idx;
+
+    ASSERT(spin_is_locked(&rank->lock));
+
+    rank_idx = offset / NR_INTERRUPT_PER_RANK;
+
+    offset &= INTERRUPT_RANK_MASK;
+    offset &= ~(NR_TARGET_PER_REG - 1);
+
+    for ( i = 0; i < NR_TARGET_PER_REG; i++, offset++ )
+    {
+        unsigned int new_target, old_target;
+
+        /*
+         * SPI are using the 1-N model (see 1.4.3 in ARM IHI 0048B).
+         * While the interrupt could be set pending to all the vCPUs in
+         * target list, it's not guarantee by the spec.
+         * For simplicity, always route the IRQ to the first interrupt
+         * in the target list
+         */
+        new_target = ffs(itargetsr & ((1 << NR_BIT_PER_TARGET) - 1));
+        old_target = rank->vcpu[offset];
+
+        itargetsr >>= NR_BIT_PER_TARGET;
+
+        /*
+         * Ignore the write request for this interrupt if the new target
+         * is invalid.
+         */
+        if ( !new_target || (new_target > d->max_vcpus) )
+            continue;
+
+        /* The vCPU ID always start from 0 */
+        new_target--;
+
+        /* Only migrate the IRQ if the target vCPU has changed */
+        if ( new_target != old_target )
+        {
+            unsigned int irq = rank_idx * NR_INTERRUPT_PER_RANK + offset;
+
+            vgic_migrate_irq(d->vcpu[old_target],
+                             d->vcpu[new_target],
+                             irq);
+        }
+
+        rank->vcpu[offset] = new_target;
+    }
+
+}
+
 static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
                                    register_t *r)
 {
@@ -126,8 +210,8 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_ITARGETSR, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->v2.itargets[REG_RANK_INDEX(8, gicd_reg - GICD_ITARGETSR,
-                                              DABT_WORD)];
+        /* The recreate the ITARGETSR register */
+        *r = vgic_generate_itargetsr(rank, gicd_reg - GICD_ITARGETSR);
         if ( dabt.size == DABT_BYTE )
             *r = vgic_byte_read(*r, gicd_reg);
         vgic_unlock_rank(v, rank, flags);
@@ -345,56 +429,23 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
 
     case GICD_ITARGETSR + 8 ... GICD_ITARGETSRN:
     {
+        uint32_t itargetsr;
+
         /* unsigned long needed for find_next_bit */
-        unsigned long target;
-        int i;
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_ITARGETSR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
-        /* 8-bit vcpu mask for this domain */
-        BUG_ON(v->domain->max_vcpus > 8);
-        target = (1 << v->domain->max_vcpus) - 1;
-        if ( dabt.size == 2 )
-            target = target | (target << 8) | (target << 16) | (target << 24);
-        else
-            target = (target << (8 * (gicd_reg & 0x3)));
-        target &= r;
-        /* ignore zero writes */
-        if ( !target )
-            goto write_ignore;
-        /* For word reads ignore writes where any single byte is zero */
-        if ( dabt.size == 2 &&
-            !((target & 0xff) && (target & (0xff << 8)) &&
-             (target & (0xff << 16)) && (target & (0xff << 24))))
-            goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        i = 0;
-        while ( (i = find_next_bit(&target, 32, i)) < 32 )
-        {
-            unsigned int irq, new_target, old_target;
-            unsigned long old_target_mask;
-            struct vcpu *v_target, *v_old;
-
-            new_target = i % 8;
-            old_target_mask = vgic_byte_read(rank->v2.itargets[REG_RANK_INDEX(8,
-                                             gicd_reg - GICD_ITARGETSR, DABT_WORD)], i/8);
-            old_target = find_first_bit(&old_target_mask, 8);
-
-            if ( new_target != old_target )
-            {
-                irq = gicd_reg - GICD_ITARGETSR + (i / 8);
-                v_target = v->domain->vcpu[new_target];
-                v_old = v->domain->vcpu[old_target];
-                vgic_migrate_irq(v_old, v_target, irq);
-            }
-            i += 8 - new_target;
-        }
         if ( dabt.size == DABT_WORD )
-            rank->v2.itargets[REG_RANK_INDEX(8, gicd_reg - GICD_ITARGETSR,
-                                             DABT_WORD)] = target;
+            itargetsr = r;
         else
-            vgic_byte_write(&rank->v2.itargets[REG_RANK_INDEX(8,
-                      gicd_reg - GICD_ITARGETSR, DABT_WORD)], target, gicd_reg);
+        {
+            itargetsr = vgic_generate_itargetsr(rank,
+                                                gicd_reg - GICD_ITARGETSR);
+            vgic_byte_write(&itargetsr, r, gicd_reg);
+        }
+        vgic_store_itargetsr(v->domain, rank, gicd_reg - GICD_ITARGETSR,
+                             itargetsr);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     }
@@ -504,21 +555,11 @@ static const struct mmio_handler_ops vgic_v2_distr_mmio_handler = {
 
 static struct vcpu *vgic_v2_get_target_vcpu(struct vcpu *v, unsigned int irq)
 {
-    unsigned long target;
-    struct vcpu *v_target;
     struct vgic_irq_rank *rank = vgic_rank_irq(v, irq);
-    ASSERT(spin_is_locked(&rank->lock));
 
-    target = vgic_byte_read(rank->v2.itargets[REG_RANK_INDEX(8,
-                                              irq, DABT_WORD)], irq & 0x3);
+    ASSERT(spin_is_locked(&rank->lock));
 
-    /* 1-N SPI should be delivered as pending to all the vcpus in the
-     * mask, but here we just return the first vcpu for simplicity and
-     * because it would be too slow to do otherwise. */
-    target = find_first_bit(&target, 8);
-    ASSERT(target >= 0 && target < v->domain->max_vcpus);
-    v_target = v->domain->vcpu[target];
-    return v_target;
+    return v->domain->vcpu[rank->vcpu[irq & INTERRUPT_RANK_MASK]];
 }
 
 static int vgic_v2_get_irq_priority(struct vcpu *v, unsigned int irq)
@@ -532,22 +573,14 @@ static int vgic_v2_get_irq_priority(struct vcpu *v, unsigned int irq)
 
 static int vgic_v2_vcpu_init(struct vcpu *v)
 {
-    int i;
-
-    /* For SGI and PPI the target is always this CPU */
-    for ( i = 0 ; i < 8 ; i++ )
-        v->arch.vgic.private_irqs->v2.itargets[i] =
-              (1<<(v->vcpu_id+0))
-            | (1<<(v->vcpu_id+8))
-            | (1<<(v->vcpu_id+16))
-            | (1<<(v->vcpu_id+24));
+    /* Nothing specific to initialize for this driver */
 
     return 0;
 }
 
 static int vgic_v2_domain_init(struct domain *d)
 {
-    int i, ret;
+    int ret;
 
     /*
      * The hardware domain gets the hardware address.
@@ -586,11 +619,6 @@ static int vgic_v2_domain_init(struct domain *d)
     if ( ret )
         return ret;
 
-    /* By default deliver to CPU0 */
-    for ( i = 0; i < DOMAIN_NR_RANKS(d); i++ )
-        memset(d->arch.vgic.shared_irqs[i].v2.itargets, 0x1,
-               sizeof(d->arch.vgic.shared_irqs[i].v2.itargets));
-
     register_mmio_handler(d, &vgic_v2_distr_mmio_handler, d->arch.vgic.dbase,
                           PAGE_SIZE);
 
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index 2787507..b247043 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -89,18 +89,77 @@ static struct vcpu *vgic_v3_irouter_to_vcpu(struct domain *d, uint64_t irouter)
     return d->vcpu[vcpu_id];
 }
 
+#define NR_BYTE_PER_IROUTER 8U
+
+/*
+ * Generate the associated IROUTER register based on the offset from IROUTERO.
+ * Only one vCPU will be listed for a given IRQ.
+ *
+ * Note the offset will be round down to match a real HW register
+ */
+static uint64_t vgic_generate_irouter(struct vgic_irq_rank *rank,
+                                      unsigned int offset)
+{
+    ASSERT(spin_is_locked(&rank->lock));
+
+    /* There is exactly 1 IRQ per IROUTER */
+    offset /= NR_BYTE_PER_IROUTER;
+
+    /* Get the index in the rank */
+    offset &= INTERRUPT_RANK_MASK;
+
+    return vcpuid_to_vaffinity(rank->vcpu[offset]);
+}
+
+/*
+ * Store a IROUTER register in a convenient way and migrate the IRQ
+ * if necessary.
+ * Note the offset will be round down to match a real HW register.
+ */
+static void vgic_store_irouter(struct domain *d, struct vgic_irq_rank *rank,
+                               unsigned int offset, uint64_t irouter)
+{
+    struct vcpu *new_vcpu, *old_vcpu;
+    unsigned int rank_idx, irq;
+
+
+    /* There is 1 IRQ per IROUTER */
+    irq = offset / NR_BYTE_PER_IROUTER;
+
+    rank_idx = irq / NR_INTERRUPT_PER_RANK;
+
+    /* Get the index in the rank */
+    offset &= irq & INTERRUPT_RANK_MASK;
+
+    new_vcpu = vgic_v3_irouter_to_vcpu(d, irouter);
+    old_vcpu = d->vcpu[rank->vcpu[offset]];
+
+    /*
+     * From the spec (see 8.9.13 in IHI 0069A), any write with an
+     * invalid vCPU will lead to ignore the interrupt.
+     *
+     * But the current code to inject an IRQ is not able to cope with
+     * invalid vCPU. So for now, just ignore the write.
+     *
+     * TODO: Respect the spec
+     */
+    if ( !new_vcpu )
+        return;
+
+    /* Only migrate the IRQ if the target vCPU has changed */
+    if ( new_vcpu != old_vcpu )
+        vgic_migrate_irq(old_vcpu, new_vcpu, irq);
+
+    rank->vcpu[offset] = new_vcpu->vcpu_id;
+}
+
 static struct vcpu *vgic_v3_get_target_vcpu(struct vcpu *v, unsigned int irq)
 {
-    struct vcpu *v_target;
     struct vgic_irq_rank *rank = vgic_rank_irq(v, irq);
 
     ASSERT(spin_is_locked(&rank->lock));
 
-    v_target = vgic_v3_irouter_to_vcpu(v->domain, rank->v3.irouter[irq % 32]);
-
-    ASSERT(v_target != NULL);
-
-    return v_target;
+    return v->domain->vcpu[rank->vcpu[irq & INTERRUPT_RANK_MASK]];
 }
 
 static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
@@ -756,8 +815,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->v3.irouter[REG_RANK_INDEX(64,
-                              (gicd_reg - GICD_IROUTER), DABT_DOUBLE_WORD)];
+        *r = vgic_generate_irouter(rank, gicd_reg - GICD_IROUTER);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_NSACR ... GICD_NSACRN:
@@ -842,8 +900,6 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
     struct hsr_dabt dabt = info->dabt;
     struct vgic_irq_rank *rank;
     unsigned long flags;
-    uint64_t new_irouter, old_irouter;
-    struct vcpu *old_vcpu, *new_vcpu;
     int gicd_reg = (int)(info->gpa - v->domain->arch.vgic.dbase);
 
     perfc_incr(vgicd_writes);
@@ -911,32 +967,8 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto write_ignore;
-        new_irouter = r;
         vgic_lock_rank(v, rank, flags);
-
-        old_irouter = rank->v3.irouter[REG_RANK_INDEX(64,
-                                       (gicd_reg - GICD_IROUTER),
-                                       DABT_DOUBLE_WORD)];
-        old_vcpu = vgic_v3_irouter_to_vcpu(v->domain, old_irouter);
-        new_vcpu = vgic_v3_irouter_to_vcpu(v->domain, new_irouter);
-
-        if ( !new_vcpu )
-        {
-            printk(XENLOG_G_DEBUG
-                   "%pv: vGICD: wrong irouter at offset %#08x val %#"PRIregister,
-                   v, gicd_reg, r);
-            vgic_unlock_rank(v, rank, flags);
-            /*
-             * TODO: Don't inject a fault to the guest when the MPIDR is
-             * not valid. From the spec, the interrupt should be
-             * ignored.
-             */
-            return 0;
-        }
-        rank->v3.irouter[REG_RANK_INDEX(64, (gicd_reg - GICD_IROUTER),
-                         DABT_DOUBLE_WORD)] = new_irouter;
-        if ( old_vcpu != new_vcpu )
-            vgic_migrate_irq(old_vcpu, new_vcpu, (gicd_reg - GICD_IROUTER)/8);
+        vgic_store_irouter(v->domain, rank, gicd_reg - GICD_IROUTER, r);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_NSACR ... GICD_NSACRN:
@@ -1075,7 +1107,6 @@ static int vgic_v3_get_irq_priority(struct vcpu *v, unsigned int irq)
 static int vgic_v3_vcpu_init(struct vcpu *v)
 {
     int i;
-    uint64_t affinity;
     paddr_t rdist_base;
     struct vgic_rdist_region *region;
     unsigned int last_cpu;
@@ -1084,15 +1115,6 @@ static int vgic_v3_vcpu_init(struct vcpu *v)
     struct domain *d = v->domain;
     uint32_t rdist_stride = d->arch.vgic.rdist_stride;
 
-    /* For SGI and PPI the target is always this CPU */
-    affinity = (MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 3) << 32 |
-                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 2) << 16 |
-                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 1) << 8  |
-                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 0));
-
-    for ( i = 0 ; i < 32 ; i++ )
-        v->arch.vgic.private_irqs->v3.irouter[i] = affinity;
-
     /*
      * Find the region where the re-distributor lives. For this purpose,
      * we look one region ahead as we have only the first CPU in hand.
@@ -1137,7 +1159,7 @@ static int vgic_v3_vcpu_init(struct vcpu *v)
 
 static int vgic_v3_domain_init(struct domain *d)
 {
-    int i, idx;
+    int i;
 
     /*
      * Domain 0 gets the hardware address.
@@ -1189,13 +1211,6 @@ static int vgic_v3_domain_init(struct domain *d)
         d->arch.vgic.rdist_regions[0].first_cpu = 0;
     }
 
-    /* By default deliver to CPU0 */
-    for ( i = 0; i < DOMAIN_NR_RANKS(d); i++ )
-    {
-        for ( idx = 0; idx < 32; idx++ )
-            d->arch.vgic.shared_irqs[i].v3.irouter[idx] = 0;
-    }
-
     /* Register mmio handle for the Distributor */
     register_mmio_handler(d, &vgic_distr_mmio_handler, d->arch.vgic.dbase,
                           SZ_64K);
diff --git a/xen/arch/arm/vgic.c b/xen/arch/arm/vgic.c
index 50ad360..cce1bc2 100644
--- a/xen/arch/arm/vgic.c
+++ b/xen/arch/arm/vgic.c
@@ -65,7 +65,8 @@ struct vgic_irq_rank *vgic_rank_irq(struct vcpu *v, unsigned int irq)
 #define NR_BIT_PER_PRIORITY 8U
 
 /*
- * Generate the associated IPRIORITYR register based on an offset in the rank.
+ * Generate the associated IPRIORITYR register based on the offset from
+ * IPRIORITYR0.
  * Note the offset will be round down to match a real HW register.
  */
 uint32_t vgic_generate_ipriorityr(struct vgic_irq_rank *rank,
@@ -114,6 +115,23 @@ static void vgic_init_pending_irq(struct pending_irq *p, unsigned int virq)
     p->irq = virq;
 }
 
+static void vgic_rank_init(struct vgic_irq_rank *rank, unsigned int vcpu)
+{
+    unsigned int i;
+
+    /*
+     * Make sure that the type chosen to store the target is able to
+     * store an VCPU ID between 0 and the maximum of virtual CPUs
+     * supported.
+     */
+    BUILD_BUG_ON((1 << (sizeof(rank->vcpu[0]) * 8)) < MAX_VIRT_CPUS);
+
+    spin_lock_init(&rank->lock);
+
+    for ( i = 0; i < NR_INTERRUPT_PER_RANK; i++ )
+        rank->vcpu[i] = vcpu;
+}
+
 int domain_vgic_init(struct domain *d, unsigned int nr_spis)
 {
     int i;
@@ -160,8 +178,9 @@ int domain_vgic_init(struct domain *d, unsigned int nr_spis)
     for (i=0; i<d->arch.vgic.nr_spis; i++)
         vgic_init_pending_irq(&d->arch.vgic.pending_irqs[i], i + 32);
 
-    for (i=0; i<DOMAIN_NR_RANKS(d); i++)
-        spin_lock_init(&d->arch.vgic.shared_irqs[i].lock);
+    /* SPIs are routed to VCPU0 by default */
+    for ( i = 0; i < DOMAIN_NR_RANKS(d); i++ )
+        vgic_rank_init(&d->arch.vgic.shared_irqs[i], 0);
 
     ret = d->arch.vgic.handler->domain_init(d);
     if ( ret )
@@ -215,7 +234,8 @@ int vcpu_vgic_init(struct vcpu *v)
     if ( v->arch.vgic.private_irqs == NULL )
       return -ENOMEM;
 
-    spin_lock_init(&v->arch.vgic.private_irqs->lock);
+    /* SGIs/PPIs are routed to this VCPU by default */
+    vgic_rank_init(v->arch.vgic.private_irqs, v->vcpu_id);
 
     v->domain->arch.vgic.handler->vcpu_init(v);
 
diff --git a/xen/include/asm-arm/vgic.h b/xen/include/asm-arm/vgic.h
index ce9970e..0cb8029 100644
--- a/xen/include/asm-arm/vgic.h
+++ b/xen/include/asm-arm/vgic.h
@@ -97,14 +97,11 @@ struct vgic_irq_rank {
      */
     uint8_t priority[32];
 
-    union {
-        struct {
-            uint32_t itargets[8];
-        }v2;
-        struct {
-            uint64_t irouter[32];
-        }v3;
-    };
+    /*
+     * It's more convenient to store a target VCPU per interrupt
+     * than the register ITARGETSR/IROUTER itself
+     */
+    uint8_t vcpu[32];
 };
 
 struct sgi_target {
-- 
2.1.4
