From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:06 +0100
Subject: [PATCH v1 7/8] xen/arm: vgic: Introduce helpers to
 read/write/clear/set vGIC register ...
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-8-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

and use them in the vGIC emulation.

The GIC registers may support different access sizes. Rather than open
coding the access for every registers, provide a set of helpers to access
them.

The caller will have to call vgic_regN_* where N is the size of the
emulated registers.

The new helpers supports any access size and expect the caller to
validate the access size supported by the emulated registers.

Finally, take the opportunity to fix the coding style in section we are
modifying.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
---
    I've only done quick tests. I sent them in order to help Vijay
    supported multiple access size.

    Changes in v2:
        - Make use of the new helpers in the vGICv2 code
        - Drop vgic_byte_*
        - Use unsigned long rather than uint64_t to optimize the code
        on ARM. (~about 40% less instruction per helpers).
---
 xen/arch/arm/vgic-v2.c     |  99 ++++++++++++++++++++++++----------------
 xen/arch/arm/vgic-v3.c     | 111 +++++++++++++++++++++++++++++----------------
 xen/include/asm-arm/vgic.h | 111 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 234 insertions(+), 87 deletions(-)

diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index b6db64f..cdc0825 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -149,24 +149,31 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
     case GICD_CTLR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         vgic_lock(v);
-        *r = v->domain->arch.vgic.ctlr;
+        *r = vgic_reg32_read(v->domain->arch.vgic.ctlr, info);
         vgic_unlock(v);
         return 1;
     case GICD_TYPER:
+    {
+        uint32_t typer;
+
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /* No secure world support for guests. */
         vgic_lock(v);
-        *r = ( ((v->domain->max_vcpus - 1) << GICD_TYPE_CPUS_SHIFT) )
+        typer = ((v->domain->max_vcpus - 1) << GICD_TYPE_CPUS_SHIFT)
             | DIV_ROUND_UP(v->domain->arch.vgic.nr_spis, 32);
         vgic_unlock(v);
+
+        *r = vgic_reg32_read(typer, info);
+
         return 1;
+    }
     case GICD_IIDR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /*
          * XXX Do we need a JEP106 manufacturer ID?
          * Just use the physical h/w value for now
          */
-        *r = 0x0000043b;
+        *r = vgic_reg32_read(0x0000043b, info);
         return 1;
 
     /* Implementation defined -- read as zero */
@@ -182,7 +189,7 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 1, gicd_reg - GICD_ISENABLER, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ienable;
+        *r = vgic_reg32_read(rank->ienable, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -191,7 +198,7 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 1, gicd_reg - GICD_ICENABLER, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ienable;
+        *r = vgic_reg32_read(rank->ienable, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -206,38 +213,55 @@ static int vgic_v2_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         goto read_as_zero;
 
     case GICD_ITARGETSR ... GICD_ITARGETSRN:
+    {
+        uint32_t itargetsr;
+
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_ITARGETSR, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
         /* The recreate the ITARGETSR register */
-        *r = vgic_generate_itargetsr(rank, gicd_reg - GICD_ITARGETSR);
-        if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, gicd_reg);
+        itargetsr = vgic_generate_itargetsr(rank,
+                                            gicd_reg - GICD_ITARGETSR);
         vgic_unlock_rank(v, rank, flags);
+        *r = vgic_reg32_read(itargetsr, info);
+
         return 1;
+    }
 
     case GICD_IPRIORITYR ... GICD_IPRIORITYRN:
+    {
+        uint32_t ipriorityr;
+
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_IPRIORITYR, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
 
         vgic_lock_rank(v, rank, flags);
         /* Recreate the IPRIORITYR register */
-        *r = vgic_generate_ipriorityr(rank, gicd_reg - GICD_IPRIORITYR);
-        if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, gicd_reg);
+        ipriorityr = vgic_generate_ipriorityr(rank,
+                                              gicd_reg - GICD_IPRIORITYR);
         vgic_unlock_rank(v, rank, flags);
+        *r = vgic_reg32_read(ipriorityr, info);
+
         return 1;
+    }
 
     case GICD_ICFGR ... GICD_ICFGRN:
+    {
+        uint32_t icfgr;
+
         if ( dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 2, gicd_reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR, DABT_WORD)];
+        icfgr = rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR, DABT_WORD)];
         vgic_unlock_rank(v, rank, flags);
+
+        *r = vgic_reg32_read(icfgr, info);
+
         return 1;
+    }
 
     case GICD_NSACR ... GICD_NSACRN:
         /* We do not implement security extensions for guests, read zero */
@@ -347,7 +371,8 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /* Ignore all but the enable bit */
         vgic_lock(v);
-        v->domain->arch.vgic.ctlr = r & GICD_CTL_ENABLE;
+        vgic_reg32_write(&v->domain->arch.vgic.ctlr, r, info);
+        v->domain->arch.vgic.ctlr &= GICD_CTL_ENABLE;
         vgic_unlock(v);
 
         return 1;
@@ -371,11 +396,13 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable |= r;
-        /* The virtual irq is derived from register offset.
+        vgic_reg32_setbit(&rank->ienable, r, info);
+        /*
+         * The virtual irq is derived from register offset.
          * The register difference is word difference. So divide by 2(DABT_WORD)
-         * to get Virtual irq number */
-        vgic_enable_irqs(v, r & (~tr),
+         * to get Virtual irq number
+         */
+        vgic_enable_irqs(v, (rank->ienable) & (~tr),
                          (gicd_reg - GICD_ISENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
@@ -386,12 +413,14 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable &= ~r;
-        /* The virtual irq is derived from register offset.
+        vgic_reg32_clearbit(&rank->ienable, r, info);
+        /*
+         * The virtual irq is derived from register offset.
          * The register difference is word difference. So divide by 2(DABT_WORD)
-         * to get  Virtual irq number */
-        vgic_disable_irqs(v, r & tr,
-                         (gicd_reg - GICD_ICENABLER) >> DABT_WORD);
+         * to get  Virtual irq number
+         */
+        vgic_disable_irqs(v, (~rank->ienable) & tr,
+                          (gicd_reg - GICD_ICENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
@@ -436,14 +465,9 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_ITARGETSR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        if ( dabt.size == DABT_WORD )
-            itargetsr = r;
-        else
-        {
-            itargetsr = vgic_generate_itargetsr(rank,
-                                                gicd_reg - GICD_ITARGETSR);
-            vgic_byte_write(&itargetsr, r, gicd_reg);
-        }
+        itargetsr = vgic_generate_itargetsr(rank,
+                                            gicd_reg - GICD_ITARGETSR);
+        vgic_reg32_write(&itargetsr, r, info);
         vgic_store_itargetsr(v->domain, rank, gicd_reg - GICD_ITARGETSR,
                              itargetsr);
         vgic_unlock_rank(v, rank, flags);
@@ -458,14 +482,9 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 8, gicd_reg - GICD_IPRIORITYR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        if ( dabt.size == DABT_WORD )
-            ipriorityr = r;
-        else
-        {
-            ipriorityr = vgic_generate_ipriorityr(rank,
-                                                  gicd_reg - GICD_IPRIORITYR);
-            vgic_byte_write(&ipriorityr, r, gicd_reg);
-        }
+        ipriorityr = vgic_generate_ipriorityr(rank,
+                                              gicd_reg - GICD_IPRIORITYR);
+        vgic_reg32_write(&ipriorityr, r, info);
         vgic_store_ipriorityr(rank, gicd_reg - GICD_IPRIORITYR, ipriorityr);
         vgic_unlock_rank(v, rank, flags);
         return 1;
@@ -481,7 +500,9 @@ static int vgic_v2_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         rank = vgic_rank_offset(v, 2, gicd_reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR, DABT_WORD)] = r;
+        vgic_reg32_write(&rank->icfg[REG_RANK_INDEX(2, gicd_reg - GICD_ICFGR,
+                                                    DABT_WORD)],
+                         r, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
 
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index b247043..8da695f 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -167,7 +167,6 @@ static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
                                          register_t *r)
 {
     struct hsr_dabt dabt = info->dabt;
-    uint64_t aff;
 
     switch ( gicr_reg )
     {
@@ -176,21 +175,27 @@ static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
         goto read_as_zero_32;
     case GICR_IIDR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICR_IIDR_VAL;
+        *r = vgic_reg32_read(GICV3_GICR_IIDR_VAL, info);
         return 1;
     case GICR_TYPER:
+    {
+        uint64_t typer, aff;
+
         if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
         /* TBD: Update processor id in [23:8] when ITS support is added */
         aff = (MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 3) << 56 |
                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 2) << 48 |
                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 1) << 40 |
                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 0) << 32);
-        *r = aff;
+        typer = aff;
 
         if ( v->arch.vgic.flags & VGIC_V3_RDIST_LAST )
-            *r |= GICR_TYPER_LAST;
+            typer |= GICR_TYPER_LAST;
+
+        *r = vgic_reg64_read(typer, info);
 
         return 1;
+    }
     case GICR_STATUSR:
         /* Not implemented */
         goto read_as_zero_32;
@@ -219,7 +224,7 @@ static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
     case GICR_SYNCR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /* RO . But when read it always returns busy bito bit[0] */
-        *r = GICR_SYNCR_NOT_BUSY;
+        *r = vgic_reg32_read(GICR_SYNCR_NOT_BUSY, info);
         return 1;
     case GICR_MOVLPIR:
         /* WO Read as zero */
@@ -229,22 +234,22 @@ static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
         goto read_as_zero_64;
     case GICR_PIDR0:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICR_PIDR0;
+        *r = vgic_reg32_read(GICV3_GICR_PIDR0, info);
          return 1;
     case GICR_PIDR1:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICR_PIDR1;
+        *r = vgic_reg32_read(GICV3_GICR_PIDR1, info);
          return 1;
     case GICR_PIDR2:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICR_PIDR2;
+        *r = vgic_reg32_read(GICV3_GICR_PIDR2, info);
          return 1;
     case GICR_PIDR3:
         /* Manufacture/customer defined */
         goto read_as_zero_32;
     case GICR_PIDR4:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICR_PIDR4;
+        *r = vgic_reg32_read(GICV3_GICR_PIDR4, info);
          return 1;
     case GICR_PIDR5 ... GICR_PIDR7:
         /* Reserved0 */
@@ -365,7 +370,7 @@ static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
         rank = vgic_rank_offset(v, 1, reg - GICD_ISENABLER, DABT_WORD);
         if ( rank == NULL ) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ienable;
+        *r = vgic_reg32_read(rank->ienable, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ICENABLER ... GICD_ICENABLERN:
@@ -373,7 +378,7 @@ static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
         rank = vgic_rank_offset(v, 1, reg - GICD_ICENABLER, DABT_WORD);
         if ( rank == NULL ) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->ienable;
+        *r = vgic_reg32_read(rank->ienable, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     /* Read the pending status of an IRQ via GICD/GICR is not supported */
@@ -387,25 +392,38 @@ static int __vgic_v3_distr_common_mmio_read(const char *name, struct vcpu *v,
         goto read_as_zero;
 
     case GICD_IPRIORITYR ... GICD_IPRIORITYRN:
+    {
+        uint32_t ipriorityr;
+
         if ( dabt.size != DABT_BYTE && dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 8, reg - GICD_IPRIORITYR, DABT_WORD);
         if ( rank == NULL ) goto read_as_zero;
 
         vgic_lock_rank(v, rank, flags);
         /* Recreate the IPRIORITYR register */
-        *r = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
-        if ( dabt.size == DABT_BYTE )
-            *r = vgic_byte_read(*r, reg);
+        ipriorityr = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
         vgic_unlock_rank(v, rank, flags);
+
+        *r = vgic_reg32_read(ipriorityr, info);
+
         return 1;
+    }
+
     case GICD_ICFGR ... GICD_ICFGRN:
+    {
+        uint32_t icfgr;
+
         if ( dabt.size != DABT_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 2, reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL ) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR, DABT_WORD)];
+        icfgr = rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR, DABT_WORD)];
         vgic_unlock_rank(v, rank, flags);
+
+        *r = vgic_reg32_read(icfgr, info);
+
         return 1;
+    }
     default:
         printk(XENLOG_G_ERR
                "%pv: %s: unhandled read r%d offset %#08x\n",
@@ -444,9 +462,10 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable |= r;
+        vgic_reg32_setbit(&rank->ienable, r, info);
         /* The irq number is extracted from offset. so shift by register size */
-        vgic_enable_irqs(v, r & (~tr), (reg - GICD_ISENABLER) >> DABT_WORD);
+        vgic_enable_irqs(v, (rank->ienable) & (~tr),
+                         (reg - GICD_ISENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ICENABLER ... GICD_ICENABLERN:
@@ -455,9 +474,10 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
         tr = rank->ienable;
-        rank->ienable &= ~r;
+        vgic_reg32_clearbit(&rank->ienable, r, info);
         /* The irq number is extracted from offset. so shift by register size */
-        vgic_disable_irqs(v, r & tr, (reg - GICD_ICENABLER) >> DABT_WORD);
+        vgic_disable_irqs(v, (~rank->ienable) & tr,
+                          (reg - GICD_ICENABLER) >> DABT_WORD);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     case GICD_ISPENDR ... GICD_ISPENDRN:
@@ -497,13 +517,8 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         if ( rank == NULL) goto write_ignore;
 
         vgic_lock_rank(v, rank, flags);
-        if ( dabt.size == DABT_WORD )
-            ipriorityr = r;
-        else
-        {
-            ipriorityr = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
-            vgic_byte_write(&ipriorityr, r, reg);
-        }
+        ipriorityr = vgic_generate_ipriorityr(rank, reg - GICD_IPRIORITYR);
+        vgic_reg32_write(&ipriorityr, r, info);
         vgic_store_ipriorityr(rank, reg - GICD_IPRIORITYR, ipriorityr);
         vgic_unlock_rank(v, rank, flags);
         return 1;
@@ -518,7 +533,9 @@ static int __vgic_v3_distr_common_mmio_write(const char *name, struct vcpu *v,
         rank = vgic_rank_offset(v, 2, reg - GICD_ICFGR, DABT_WORD);
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR, DABT_WORD)] = r;
+        vgic_reg32_write(&rank->icfg[REG_RANK_INDEX(2, reg - GICD_ICFGR,
+                                                    DABT_WORD)],
+                         r, info);
         vgic_unlock_rank(v, rank, flags);
         return 1;
     default:
@@ -754,7 +771,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
     case GICD_CTLR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
         vgic_lock(v);
-        *r = v->domain->arch.vgic.ctlr;
+        *r = vgic_reg32_read(v->domain->arch.vgic.ctlr, info);
         vgic_unlock(v);
         return 1;
     case GICD_TYPER:
@@ -769,13 +786,16 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
          * bit is zero. The maximum is 8.
          */
         unsigned int ncpus = min_t(unsigned int, v->domain->max_vcpus, 8);
+        uint32_t typer;
 
         if ( dabt.size != DABT_WORD ) goto bad_width;
         /* No secure world support for guests. */
-        *r = ((ncpus - 1) << GICD_TYPE_CPUS_SHIFT |
-              DIV_ROUND_UP(v->domain->arch.vgic.nr_spis, 32));
+        typer = ((ncpus - 1) << GICD_TYPE_CPUS_SHIFT |
+                 DIV_ROUND_UP(v->domain->arch.vgic.nr_spis, 32));
 
-        *r |= (irq_bits - 1) << GICD_TYPE_ID_BITS_SHIFT;
+        typer |= (irq_bits - 1) << GICD_TYPE_ID_BITS_SHIFT;
+
+        *r = vgic_reg32_read(typer, info);
 
         return 1;
     }
@@ -787,7 +807,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         goto read_as_zero_32;
     case GICD_IIDR:
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICD_IIDR_VAL;
+        *r = vgic_reg32_read(GICV3_GICD_IIDR_VAL, info);
         return 1;
     case 0x020 ... 0x03c:
     case 0xc000 ... 0xffcc:
@@ -810,14 +830,22 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
         /* SGI/PPI is RES0 */
         goto read_as_zero_64;
     case GICD_IROUTER32 ... GICD_IROUTERN:
+    {
+        uint64_t irouter;
+
         if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto read_as_zero;
         vgic_lock_rank(v, rank, flags);
-        *r = vgic_generate_irouter(rank, gicd_reg - GICD_IROUTER);
+        irouter = vgic_generate_irouter(rank, gicd_reg - GICD_IROUTER);
         vgic_unlock_rank(v, rank, flags);
+
+        *r = vgic_reg64_read(irouter, info);
+
         return 1;
+    }
+
     case GICD_NSACR ... GICD_NSACRN:
         /* We do not implement security extensions for guests, read zero */
         goto read_as_zero_32;
@@ -833,17 +861,17 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
     case GICD_PIDR0:
         /* GICv3 identification value */
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICD_PIDR0;
+        *r = vgic_reg32_read(GICV3_GICD_PIDR0, info);
         return 1;
     case GICD_PIDR1:
         /* GICv3 identification value */
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICD_PIDR1;
+        *r = vgic_reg32_read(GICV3_GICD_PIDR1, info);
         return 1;
     case GICD_PIDR2:
         /* GICv3 identification value */
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICD_PIDR2;
+        *r = vgic_reg32_read(GICV3_GICD_PIDR2, info);
         return 1;
     case GICD_PIDR3:
         /* GICv3 identification value. Manufacturer/Customer defined */
@@ -851,7 +879,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
     case GICD_PIDR4:
         /* GICv3 identification value */
         if ( dabt.size != DABT_WORD ) goto bad_width;
-        *r = GICV3_GICD_PIDR4;
+        *r = vgic_reg32_read(GICV3_GICD_PIDR4, info);
         return 1;
     case GICD_PIDR5 ... GICD_PIDR7:
         /* Reserved0 */
@@ -963,14 +991,21 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
         /* SGI/PPI is RES0 */
         goto write_ignore_64;
     case GICD_IROUTER32 ... GICD_IROUTERN:
+    {
+        uint64_t irouter;
+
         if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto write_ignore;
         vgic_lock_rank(v, rank, flags);
-        vgic_store_irouter(v->domain, rank, gicd_reg - GICD_IROUTER, r);
+        irouter = vgic_generate_irouter(rank, gicd_reg - GICD_IROUTER);
+        vgic_reg64_write(&irouter, r, info);
+        vgic_store_irouter(v->domain, rank, gicd_reg - GICD_IROUTER, irouter);
         vgic_unlock_rank(v, rank, flags);
         return 1;
+    }
+
     case GICD_NSACR ... GICD_NSACRN:
         /* We do not implement security extensions for guests, write ignore */
         goto write_ignore_32;
diff --git a/xen/include/asm-arm/vgic.h b/xen/include/asm-arm/vgic.h
index 0cb8029..6d4c938 100644
--- a/xen/include/asm-arm/vgic.h
+++ b/xen/include/asm-arm/vgic.h
@@ -19,6 +19,7 @@
 #define __ASM_ARM_VGIC_H__
 
 #include <xen/bitops.h>
+#include <asm/mmio.h>
 
 struct pending_irq
 {
@@ -164,26 +165,116 @@ static inline int REG_RANK_NR(int b, uint32_t n)
     }
 }
 
-static inline uint32_t vgic_byte_read(uint32_t val, int offset)
+#define VGIC_REG_MASK(size) ((~0UL) >> (BITS_PER_LONG - ((1 << (size)) * 8)))
+
+/*
+ * The check on the size supported by the register has to be done by
+ * the caller of vgic_regN_*.
+ *
+ * vgic_reg_* should never be called directly. Instead use the vgic_regN_*
+ * according to size of the emulated register
+ *
+ * Note that the alignment fault will always be taken in the guest
+ * (see B3.12.7 DDI0406.b).
+ */
+static inline register_t vgic_reg_read(unsigned long reg,
+                                       unsigned int offset,
+                                       enum dabt_size size)
+{
+    reg >>= 8 * offset;
+    reg &= VGIC_REG_MASK(size);
+
+    return reg;
+}
+
+static inline void vgic_reg_write(unsigned long *reg, register_t val,
+                                  unsigned int offset,
+                                  enum dabt_size size)
 {
-    int byte = offset & 0x3;
+    unsigned long mask = VGIC_REG_MASK(size);
+    int shift = offset * 8;
 
-    val = val >> (8*byte);
-    val &= 0x000000ff;
+    *reg &= ~(mask << shift);
+    *reg |= ((unsigned long)val & mask) << shift;
+}
+
+static inline void vgic_reg_setbit(unsigned long *reg, register_t bits,
+                                   unsigned int offset,
+                                   enum dabt_size size)
+{
+    unsigned long mask = VGIC_REG_MASK(size);
+    int shift = offset * 8;
 
-    return val;
+    *reg |= ((unsigned long)bits & mask) << shift;
 }
 
-static inline void vgic_byte_write(uint32_t *reg, uint32_t var, int offset)
+static inline void vgic_reg_clearbit(unsigned long *reg, register_t bits,
+                                     unsigned int offset,
+                                     enum dabt_size size)
 {
-    int byte = offset & 0x3;
+    unsigned long mask = VGIC_REG_MASK(size);
+    int shift = offset * 8;
 
-    var &= 0xff;
+    *reg &= ~(((unsigned long)bits & mask) << shift);
+}
 
-    *reg &= ~(0xff << (8*byte));
-    *reg |= (var << (8*byte));
+/* N-bit register helpers */
+#define VGIC_REG_HELPERS(sz, offmask)                                   \
+static inline register_t vgic_reg##sz##_read(uint##sz##_t reg,          \
+                                             const mmio_info_t *info)   \
+{                                                                       \
+    return vgic_reg_read(reg, info->gpa & offmask,                      \
+                         info->dabt.size);                              \
+}                                                                       \
+                                                                        \
+static inline void vgic_reg##sz##_write(uint##sz##_t *reg,              \
+                                        register_t val,                 \
+                                        const mmio_info_t *info)        \
+{                                                                       \
+    unsigned long tmp = *reg;                                           \
+                                                                        \
+    vgic_reg_write(&tmp, val, info->gpa & offmask,                      \
+                   info->dabt.size);                                    \
+                                                                        \
+    *reg = tmp;                                                         \
+}                                                                       \
+                                                                        \
+static inline void vgic_reg##sz##_setbit(uint##sz##_t *reg,             \
+                                         register_t bits,               \
+                                         const mmio_info_t *info)       \
+{                                                                       \
+    unsigned long tmp = *reg;                                           \
+                                                                        \
+    vgic_reg_setbit(&tmp, bits, info->gpa & offmask,                    \
+                    info->dabt.size);                                   \
+                                                                        \
+    *reg = tmp;                                                         \
+}                                                                       \
+                                                                        \
+static inline void vgic_reg##sz##_clearbit(uint##sz##_t *reg,           \
+                                           register_t bits,             \
+                                           const mmio_info_t *info)     \
+{                                                                       \
+    unsigned long tmp = *reg;                                           \
+                                                                        \
+    vgic_reg_clearbit(&tmp, bits, info->gpa & offmask,                  \
+                    info->dabt.size);                                   \
+                                                                        \
+    *reg = tmp;                                                         \
 }
 
+/*
+ * 64 bits register are only supported on platform with 64-bit long.
+ * This is also allow us to optimize the 32 bit case by using
+ * unsigned long rather than uint64_t
+ */
+#if BITS_PER_LONG == 64
+VGIC_REG_HELPERS(64, 0x7);
+#endif
+VGIC_REG_HELPERS(32, 0x3);
+
+#undef VGIC_REG_HELPERS
+
 enum gic_sgi_mode;
 
 /*
-- 
2.1.4
