From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:01 +0100
Subject: [PATCH v1 2/8] xen/arm: io: Extend write/read handler to pass the
 register in parameter
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-3-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

Rather than letting each handler to retrieve the register used by the
I/O access, add a new parameter to pass the register in parameter.

This will help to implement generic register manipulation on I/O access
such as sign-extension and endianess.

Read handlers need to modify the value of the register, so a pointer to
it is given in argument. Write handlers shouldn't modify the register,
therfore only a plain value is given.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
---
    Changes in v2:
        - Patch added
---
 xen/arch/arm/io.c          |  15 ++++---
 xen/arch/arm/vgic-v2.c     |  46 ++++++++++----------
 xen/arch/arm/vgic-v3.c     | 105 +++++++++++++++++++++------------------------
 xen/arch/arm/vuart.c       |  16 +++----
 xen/include/asm-arm/mmio.h |   4 +-
 5 files changed, 88 insertions(+), 98 deletions(-)

diff --git a/xen/arch/arm/io.c b/xen/arch/arm/io.c
index 8e55d49..32b2194 100644
--- a/xen/arch/arm/io.c
+++ b/xen/arch/arm/io.c
@@ -29,6 +29,9 @@ int handle_mmio(mmio_info_t *info)
     int i;
     const struct mmio_handler *mmio_handler;
     const struct io_handler *io_handlers = &v->domain->arch.io_handlers;
+    struct hsr_dabt dabt = info->dabt;
+    struct cpu_user_regs *regs = guest_cpu_user_regs();
+    register_t *r = select_user_reg(regs, dabt.reg);
 
     for ( i = 0; i < io_handlers->num_entries; i++ )
     {
@@ -36,14 +39,16 @@ int handle_mmio(mmio_info_t *info)
 
         if ( (info->gpa >= mmio_handler->addr) &&
              (info->gpa < (mmio_handler->addr + mmio_handler->size)) )
-        {
-            return info->dabt.write ?
-                mmio_handler->mmio_handler_ops->write_handler(v, info) :
-                mmio_handler->mmio_handler_ops->read_handler(v, info);
-        }
+            goto found;
     }
 
     return 0;
+
+found:
+    if ( info->dabt.write )
+        return mmio_handler->mmio_handler_ops->write_handler(v, info, *r);
+    else
+        return mmio_handler->mmio_handler_ops->read_handler(v, info, r);
 }
 
 void register_mmio_handler(struct domain *d,
diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index fa71598..3d0ce1d 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -50,11 +50,10 @@ void vgic_v2_setup_hw(paddr_t dbase, paddr_t cbase, paddr_t vbase)
     vgic_v2_hw.vbase = vbase;
 }
 
-static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info)
+static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
+                                   register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     int gicd_reg = (int)(info->gpa - v->domain->arch.vgic.dbase);
     unsigned long flags;
@@ -247,11 +246,10 @@ static int vgic_v2_to_sgi(struct vcpu *v, register_t sgir)
     return vgic_to_sgi(v, sgir, sgi_mode, virq, &target);
 }
 
-static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
+static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
+                                    register_t r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     int gicd_reg = (int)(info->gpa - v->domain->arch.vgic.dbase);
     uint32_t tr;
@@ -265,7 +263,7 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /* Ignore all but the enable bit */
         vgic_lock(v);
-        v->domain->arch.vgic.ctlr = (*r) & GICD_CTL_ENABLE;
+        v->domain->arch.vgic.ctlr = r & GICD_CTL_ENABLE;
         vgic_unlock(v);
 
         return 1;
@@ -289,11 +287,11 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable |= *r;
+        rank->ienable |= r;
         /* The virtual irq is derived from register offset.
          * The register difference is word difference. So divide by 2(DABT_WORD)
          * to get Virtual irq number */
-        vgic_enable_irqs(v, (*r) & (~tr),
+        vgic_enable_irqs(v, r & (~tr),
                          (gicd_reg - GICD_ISENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
@@ -304,11 +302,11 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable &= ~*r;
+        rank->ienable &= ~r;
         /* The virtual irq is derived from register offset.
          * The register difference is word difference. So divide by 2(DABT_WORD)
          * to get  Virtual irq number */
-        vgic_disable_irqs(v, (*r) & tr,
+        vgic_disable_irqs(v, r & tr,
                          (gicd_reg - GICD_ICENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
@@ -317,28 +315,28 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled word write %#"PRIregister" to ISPENDR%d\n",
-               v, *r, gicd_reg - GICD_ISPENDR);
+               v, r, gicd_reg - GICD_ISPENDR);
         return 0;
 
     case GICD_ICPENDR ... GICD_ICPENDRN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled word write %#"PRIregister" to ICPENDR%d\n",
-               v, *r, gicd_reg - GICD_ICPENDR);
+               v, r, gicd_reg - GICD_ICPENDR);
         return 0;
 
     case GICD_ISACTIVER ... GICD_ISACTIVERN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled word write %#"PRIregister" to ISACTIVER%d\n",
-               v, *r, gicd_reg - GICD_ISACTIVER);
+               v, r, gicd_reg - GICD_ISACTIVER);
         return 0;
 
     case GICD_ICACTIVER ... GICD_ICACTIVERN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled word write %#"PRIregister" to ICACTIVER%d\n",
-               v, *r, gicd_reg - GICD_ICACTIVER);
+               v, r, gicd_reg - GICD_ICACTIVER);
         return 0;
 
     case GICD_ITARGETSR ... GICD_ITARGETSR + 7:
@@ -360,7 +358,7 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
             target = target | (target << 8) | (target << 16) | (target << 24);
         else
             target = (target << (8 * (gicd_reg & 0x3)));
-        target &= *r;
+        target &= r;
         /* ignore zero writes */
         if ( !target )
             goto write_ignore;
@@ -408,10 +406,10 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         vgic_lock_rank(v, rank, flags);
         if ( dabt.size == DABT_WORD )
             rank->ipriority[REG_RANK_INDEX(8, gicd_reg - GICD_IPRIORITYR,
-                                           DABT_WORD)] = *r;
+                                           DABT_WORD)] = r;
         else
             vgic_byte_write(&rank->ipriority[REG_RANK_INDEX(8,
-                        gicd_reg - GICD_IPRIORITYR, DABT_WORD)], *r, gicd_reg);
+                        gicd_reg - GICD_IPRIORITYR, DABT_WORD)], r, gicd_reg);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -425,7 +423,7 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         rank = vgic_rank_offset(v, 2, gicd_reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR, DABT_WORD)] = *r;
+        rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR, DABT_WORD)] = r;
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -435,20 +433,20 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
 
     case GICD_SGIR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        return vgic_v2_to_sgi(v, *r);
+        return vgic_v2_to_sgi(v, r);
 
     case GICD_CPENDSGIR ... GICD_CPENDSGIRN:
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled %s write %#"PRIregister" to ICPENDSGIR%d\n",
-               v, dabt.size ? "word" : "byte", *r, gicd_reg - GICD_CPENDSGIR);
+               v, dabt.size ? "word" : "byte", r, gicd_reg - GICD_CPENDSGIR);
         return 0;
 
     case GICD_SPENDSGIR ... GICD_SPENDSGIRN:
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled %s write %#"PRIregister" to ISPENDSGIR%d\n",
-               v, dabt.size ? "word" : "byte", *r, gicd_reg - GICD_SPENDSGIR);
+               v, dabt.size ? "word" : "byte", r, gicd_reg - GICD_SPENDSGIR);
         return 0;
 
     /* Implementation defined -- write ignored */
@@ -475,14 +473,14 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
     default:
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled write r%d=%"PRIregister" offset %#08x\n",
-               v, dabt.reg, *r, gicd_reg);
+               v, dabt.reg, r, gicd_reg);
         return 0;
     }
 
 bad_width:
     printk(XENLOG_G_ERR
            "%pv: vGICD: bad write width %d r%d=%"PRIregister" offset %#08x\n",
-           v, dabt.size, dabt.reg, *r, gicd_reg);
+           v, dabt.size, dabt.reg, r, gicd_reg);
     domain_crash_synchronous();
     return 0;
 
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index f1c482d..94f1a5c 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -104,11 +104,10 @@ static struct vcpu *vgic_v3_get_target_vcpu(struct vcpu *v, unsigned int irq)
 }
 
 static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
-                                         uint32_t gicr_reg)
+                                         uint32_t gicr_reg,
+                                         register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     uint64_t aff;
 
     switch ( gicr_reg )
@@ -215,11 +214,10 @@ read_as_zero_32:
 }
 
 static int __vgic_v3_rdistr_rd_mmio_write(struct vcpu *v, mmio_info_t *info,
-                                          uint32_t gicr_reg)
+                                          uint32_t gicr_reg,
+                                          register_t r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
 
     switch ( gicr_reg )
     {
@@ -276,7 +274,7 @@ static int __vgic_v3_rdistr_rd_mmio_write(struct vcpu *v, mmio_info_t *info,
 bad_width:
     printk(XENLOG_G_ERR
           "%pv: vGICR: bad write width %d r%d=%"PRIregister" offset %#08x\n",
-          v, dabt.size, dabt.reg, *r, gicr_reg);
+          v, dabt.size, dabt.reg, r, gicr_reg);
     domain_crash_synchronous();
     return 0;
 
@@ -290,11 +288,10 @@ write_ignore_32:
 }
 
 static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
-                                            mmio_info_t *info, uint32_t reg)
+                                            mmio_info_t *info, uint32_t reg,
+                                            register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     unsigned long flags;
 
@@ -369,11 +366,10 @@ read_as_zero:
 }
 
 static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
-                                             mmio_info_t *info, uint32_t reg)
+                                             mmio_info_t *info, uint32_t reg,
+                                             register_t r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     uint32_t tr;
     unsigned long flags;
@@ -389,9 +385,9 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable |= *r;
+        rank->ienable |= r;
         /* The irq number is extracted from offset. so shift by register size */
-        vgic_enable_irqs(v, (*r) & (~tr), (reg - GICD_ISENABLER) >> DABT_WORD);
+        vgic_enable_irqs(v, r & (~tr), (reg - GICD_ISENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ICENABLER ... GICD_ICENABLERN:
@@ -400,37 +396,37 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable &= ~*r;
+        rank->ienable &= ~r;
         /* The irq number is extracted from offset. so shift by register size */
-        vgic_disable_irqs(v, (*r) & tr, (reg - GICD_ICENABLER) >> DABT_WORD);
+        vgic_disable_irqs(v, r & tr, (reg - GICD_ICENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ISPENDR ... GICD_ISPENDRN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled word write %#"PRIregister" to ISPENDR%d\n",
-               v, name, *r, reg - GICD_ISPENDR);
+               v, name, r, reg - GICD_ISPENDR);
         return 0;
 
     case GICD_ICPENDR ... GICD_ICPENDRN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled word write %#"PRIregister" to ICPENDR%d\n",
-               v, name, *r, reg - GICD_ICPENDR);
+               v, name, r, reg - GICD_ICPENDR);
         return 0;
 
     case GICD_ISACTIVER ... GICD_ISACTIVERN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled word write %#"PRIregister" to ISACTIVER%d\n",
-               v, name, *r, reg - GICD_ISACTIVER);
+               v, name, r, reg - GICD_ISACTIVER);
         return 0;
 
     case GICD_ICACTIVER ... GICD_ICACTIVERN:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled word write %#"PRIregister" to ICACTIVER%d\n",
-               v, name, *r, reg - GICD_ICACTIVER);
+               v, name, r, reg - GICD_ICACTIVER);
         return 0;
 
     case GICD_IPRIORITYR ... GICD_IPRIORITYRN:
@@ -440,10 +436,10 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         vgic_lock_rank(v, rank, flags);
         if ( dabt.size == DABT_WORD )
             rank->ipriority[REG_RANK_INDEX(8, reg - GICD_IPRIORITYR,
-                                           DABT_WORD)] = *r;
+                                           DABT_WORD)] = r;
         else
             vgic_byte_write(&rank->ipriority[REG_RANK_INDEX(8,
-                       reg - GICD_IPRIORITYR, DABT_WORD)], *r, reg);
+                       reg - GICD_IPRIORITYR, DABT_WORD)], r, reg);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ICFGR: /* Restricted to configure SGIs */
@@ -455,20 +451,20 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         rank = vgic_rank_offset(v, 2, reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR, DABT_WORD)] = *r;
+        rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR, DABT_WORD)] = r;
         vgic_unlock_rank(v, rank, flags);
         return 1;
     default:
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled write r%d=%"PRIregister" offset %#08x\n",
-               v, name, dabt.reg, *r, reg);
+               v, name, dabt.reg, r, reg);
         return 0;
     }
 
 bad_width:
     printk(XENLOG_G_ERR
            "%pv: %s: bad write width %d r%d=%"PRIregister" offset %#08x\n",
-           v, name, dabt.size, dabt.reg, *r, reg);
+           v, name, dabt.size, dabt.reg, r, reg);
     domain_crash_synchronous();
     return 0;
 
@@ -479,11 +475,9 @@ write_ignore:
 }
 
 static int vgic_v3_rdistr_sgi_mmio_read(struct vcpu *v, mmio_info_t *info,
-                                        uint32_t gicr_reg)
+                                        uint32_t gicr_reg, register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
 
     switch ( gicr_reg )
     {
@@ -502,7 +496,7 @@ static int vgic_v3_rdistr_sgi_mmio_read(struct vcpu *v, mmio_info_t *info,
           * So handle in common with GICD handling
           */
         return __vgic_v3_distr_common_mmio_read("vGICR: SGI", v, info,
-                                                gicr_reg);
+                                                gicr_reg, r);
 
     /* Read the pending status of an SGI is via GICR is not supported */
     case GICR_ISPENDR0:
@@ -533,11 +527,9 @@ read_as_zero:
 }
 
 static int vgic_v3_rdistr_sgi_mmio_write(struct vcpu *v, mmio_info_t *info,
-                                         uint32_t gicr_reg)
+                                         uint32_t gicr_reg, register_t r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
 
     switch ( gicr_reg )
     {
@@ -556,19 +548,19 @@ static int vgic_v3_rdistr_sgi_mmio_write(struct vcpu *v, mmio_info_t *info,
           * So handle common with GICD handling
           */
         return __vgic_v3_distr_common_mmio_write("vGICR: SGI", v,
-                                                 info, gicr_reg);
+                                                 info, gicr_reg, r);
     case GICR_ISPENDR0:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICR: SGI: unhandled word write %#"PRIregister" to ISPENDR0\n",
-               v, *r);
+               v, r);
         return 0;
 
     case GICR_ICPENDR0:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         printk(XENLOG_G_ERR
                "%pv: vGICR: SGI: unhandled word write %#"PRIregister" to ICPENDR0\n",
-               v, *r);
+               v, r);
         return 0;
 
     case GICR_NSACR:
@@ -584,7 +576,7 @@ static int vgic_v3_rdistr_sgi_mmio_write(struct vcpu *v, mmio_info_t *info,
 bad_width:
     printk(XENLOG_G_ERR
            "%pv: vGICR: SGI: bad write width %d r%d=%"PRIregister" offset %#08x\n",
-           v, dabt.size, dabt.reg, *r, gicr_reg);
+           v, dabt.size, dabt.reg, r, gicr_reg);
     domain_crash_synchronous();
     return 0;
 
@@ -634,7 +626,8 @@ static inline struct vcpu *get_vcpu_from_rdist(paddr_t gpa,
     return d->vcpu[vcpu_id];
 }
 
-static int vgic_v3_rdistr_mmio_read(struct vcpu *v, mmio_info_t *info)
+static int vgic_v3_rdistr_mmio_read(struct vcpu *v, mmio_info_t *info,
+                                    register_t *r)
 {
     uint32_t offset;
 
@@ -645,9 +638,9 @@ static int vgic_v3_rdistr_mmio_read(struct vcpu *v, mmio_info_t *info)
         return 0;
 
     if ( offset < SZ_64K )
-        return __vgic_v3_rdistr_rd_mmio_read(v, info, offset);
+        return __vgic_v3_rdistr_rd_mmio_read(v, info, offset, r);
     else  if ( (offset >= SZ_64K) && (offset < 2 * SZ_64K) )
-        return vgic_v3_rdistr_sgi_mmio_read(v, info, (offset - SZ_64K));
+        return vgic_v3_rdistr_sgi_mmio_read(v, info, (offset - SZ_64K), r);
     else
         printk(XENLOG_G_WARNING
                "%pv: vGICR: unknown gpa read address %"PRIpaddr"\n",
@@ -656,7 +649,8 @@ static int vgic_v3_rdistr_mmio_read(struct vcpu *v, mmio_info_t *info)
     return 0;
 }
 
-static int vgic_v3_rdistr_mmio_write(struct vcpu *v, mmio_info_t *info)
+static int vgic_v3_rdistr_mmio_write(struct vcpu *v, mmio_info_t *info,
+                                     register_t r)
 {
     uint32_t offset;
 
@@ -667,9 +661,9 @@ static int vgic_v3_rdistr_mmio_write(struct vcpu *v, mmio_info_t *info)
         return 0;
 
     if ( offset < SZ_64K )
-        return __vgic_v3_rdistr_rd_mmio_write(v, info, offset);
+        return __vgic_v3_rdistr_rd_mmio_write(v, info, offset, r);
     else  if ( (offset >= SZ_64K) && (offset < 2 * SZ_64K) )
-        return vgic_v3_rdistr_sgi_mmio_write(v, info, (offset - SZ_64K));
+        return vgic_v3_rdistr_sgi_mmio_write(v, info, (offset - SZ_64K), r);
     else
         printk(XENLOG_G_WARNING
                "%pv: vGICR: unknown gpa write address %"PRIpaddr"\n",
@@ -678,11 +672,10 @@ static int vgic_v3_rdistr_mmio_write(struct vcpu *v, mmio_info_t *info)
     return 0;
 }
 
-static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info)
+static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
+                                   register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     unsigned long flags;
     int gicd_reg = (int)(info->gpa - v->domain->arch.vgic.dbase);
@@ -745,7 +738,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info)
          * Above all register are common with GICR and GICD
          * Manage in common
          */
-        return __vgic_v3_distr_common_mmio_read("vGICD", v, info, gicd_reg);
+        return __vgic_v3_distr_common_mmio_read("vGICD", v, info, gicd_reg, r);
     case GICD_IROUTER ... GICD_IROUTER31:
         /* SGI/PPI is RES0 */
         goto read_as_zero_64;
@@ -835,11 +828,10 @@ read_as_zero:
     return 1;
 }
 
-static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
+static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
+                                    register_t r)
 {
     struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     struct vgic_irq_rank *rank;
     unsigned long flags;
     uint64_t new_irouter, old_irouter;
@@ -855,7 +847,7 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
 
         vgic_lock(v);
         /* Only EnableGrp1A can be changed */
-        if ( *r & GICD_CTLR_ENABLE_G1A )
+        if ( r & GICD_CTLR_ENABLE_G1A )
             v->domain->arch.vgic.ctlr |= GICD_CTLR_ENABLE_G1A;
         else
             v->domain->arch.vgic.ctlr &= ~GICD_CTLR_ENABLE_G1A;
@@ -901,7 +893,8 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
     case GICD_ICFGR ... GICD_ICFGRN:
         /* Above registers are common with GICR and GICD
          * Manage in common */
-        return __vgic_v3_distr_common_mmio_write("vGICD", v, info, gicd_reg);
+        return __vgic_v3_distr_common_mmio_write("vGICD", v, info,
+                                                 gicd_reg, r);
     case GICD_IROUTER ... GICD_IROUTER31:
         /* SGI/PPI is RES0 */
         goto write_ignore_64;
@@ -910,7 +903,7 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto write_ignore;
-        new_irouter = *r;
+        new_irouter = r;
         vgic_lock_rank(v, rank, flags);
 
         old_irouter = rank->v3.irouter[REG_RANK_INDEX(64,
@@ -923,7 +916,7 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
         {
             printk(XENLOG_G_DEBUG
                    "%pv: vGICD: wrong irouter at offset %#08x val %#"PRIregister,
-                   v, gicd_reg, *r);
+                   v, gicd_reg, r);
             vgic_unlock_rank(v, rank, flags);
             /*
              * TODO: Don't inject a fault to the guest when the MPIDR is
@@ -969,14 +962,14 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info)
     default:
         printk(XENLOG_G_ERR
                "%pv: vGICD: unhandled write r%d=%"PRIregister" offset %#08x\n",
-               v, dabt.reg, *r, gicd_reg);
+               v, dabt.reg, r, gicd_reg);
         return 0;
     }
 
 bad_width:
     printk(XENLOG_G_ERR
            "%pv: vGICD: bad write width %d r%d=%"PRIregister" offset %#08x\n",
-           v, dabt.size, dabt.reg, *r, gicd_reg);
+           v, dabt.size, dabt.reg, r, gicd_reg);
     domain_crash_synchronous();
     return 0;
 
diff --git a/xen/arch/arm/vuart.c b/xen/arch/arm/vuart.c
index d9f4249..5b8409c 100644
--- a/xen/arch/arm/vuart.c
+++ b/xen/arch/arm/vuart.c
@@ -45,8 +45,8 @@
 
 #define domain_has_vuart(d) ((d)->arch.vuart.info != NULL)
 
-static int vuart_mmio_read(struct vcpu *v, mmio_info_t *info);
-static int vuart_mmio_write(struct vcpu *v, mmio_info_t *info);
+static int vuart_mmio_read(struct vcpu *v, mmio_info_t *info, register_t *r);
+static int vuart_mmio_write(struct vcpu *v, mmio_info_t *info, register_t r);
 
 static const struct mmio_handler_ops vuart_mmio_handler = {
     .read_handler  = vuart_mmio_read,
@@ -105,12 +105,9 @@ static void vuart_print_char(struct vcpu *v, char c)
     spin_unlock(&uart->lock);
 }
 
-static int vuart_mmio_read(struct vcpu *v, mmio_info_t *info)
+static int vuart_mmio_read(struct vcpu *v, mmio_info_t *info, register_t *r)
 {
     struct domain *d = v->domain;
-    struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     paddr_t offset = info->gpa - d->arch.vuart.info->base_addr;
 
     perfc_incr(vuart_reads);
@@ -125,19 +122,16 @@ static int vuart_mmio_read(struct vcpu *v, mmio_info_t *info)
     return 1;
 }
 
-static int vuart_mmio_write(struct vcpu *v, mmio_info_t *info)
+static int vuart_mmio_write(struct vcpu *v, mmio_info_t *info, register_t r)
 {
     struct domain *d = v->domain;
-    struct hsr_dabt dabt = info->dabt;
-    struct cpu_user_regs *regs = guest_cpu_user_regs();
-    register_t *r = select_user_reg(regs, dabt.reg);
     paddr_t offset = info->gpa - d->arch.vuart.info->base_addr;
 
     perfc_incr(vuart_writes);
 
     if ( offset == d->arch.vuart.info->data_off )
         /* ignore any status bits */
-        vuart_print_char(v, *r & 0xFF);
+        vuart_print_char(v, r & 0xFF);
 
     return 1;
 }
diff --git a/xen/include/asm-arm/mmio.h b/xen/include/asm-arm/mmio.h
index 7278bce..b511334 100644
--- a/xen/include/asm-arm/mmio.h
+++ b/xen/include/asm-arm/mmio.h
@@ -32,8 +32,8 @@ typedef struct
     paddr_t gpa;
 } mmio_info_t;
 
-typedef int (*mmio_read_t)(struct vcpu *v, mmio_info_t *info);
-typedef int (*mmio_write_t)(struct vcpu *v, mmio_info_t *info);
+typedef int (*mmio_read_t)(struct vcpu *v, mmio_info_t *info, register_t *r);
+typedef int (*mmio_write_t)(struct vcpu *v, mmio_info_t *info, register_t r);
 
 struct mmio_handler_ops {
     mmio_read_t read_handler;
-- 
2.1.4
