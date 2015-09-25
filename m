From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:07 +0100
Subject: [PATCH v1 8/8] xen/arm: vgic-v3: Support 32-bit access for 64-bit
 registers
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-9-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on 8.1.3 (IHI 0069A), unless stated otherwise, the 64-bit registers
supports both 32-bit and 64-bits access.

All the registers we properly emulate (i.e not RAZ/WI) supports 32-bit access.

For RAZ/WI, it's also seems to be the case but I'm not 100% sure. Anyway,
emulating 32-bit access for them doesn't hurt. Note that we would need
some extra care when they will be implemented (for instance GICR_PROPBASER).

Signed-off-by: Julien Grall <julien.grall@citrix.com>
---
    This is technically fixing boot of FreeBSD ARM64 guest with GICv3.

    AFAICT, Linux is not using 32-bit access in the GICv3 code expect
    for the ITS (which we don't support yet).

    So this patch is a good candiate for Xen 4.6. Although this patch is
    heavily depend on previous patches. It may be possible to shuffle
    and move the "opmitization" patches towards the end. I haven't yet
    done that because I feel this series makes more sense in the current
    order.

    Also, I haven't move vgic_reg64_check_access in vgic.h because there
    is no usage in this series outside of vgic-v3.c and the helpers is
    GICv3 oriented.

    Changes in v2:
        - Support 32bit access on the most significant word of
        GICR_TYPER
---
 xen/arch/arm/vgic-v3.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index 8da695f..46b5ad8 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -162,6 +162,15 @@ static struct vcpu *vgic_v3_get_target_vcpu(struct vcpu *v, unsigned int irq)
     return v->domain->vcpu[rank->vcpu[irq & INTERRUPT_RANK_MASK]];
 }
 
+static inline bool vgic_reg64_check_access(struct hsr_dabt dabt)
+{
+    /*
+     * 64 bits registers can be accessible using 32-bit and 64-bit unless
+     * stated otherwise (See 8.1.3 ARM IHI 0069A).
+     */
+    return ( dabt.size == DABT_DOUBLE_WORD || dabt.size == DABT_WORD );
+}
+
 static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
                                          uint32_t gicr_reg,
                                          register_t *r)
@@ -178,10 +187,11 @@ static int __vgic_v3_rdistr_rd_mmio_read(struct vcpu *v, mmio_info_t *info,
         *r = vgic_reg32_read(GICV3_GICR_IIDR_VAL, info);
         return 1;
     case GICR_TYPER:
+    case GICR_TYPER + 4:
     {
         uint64_t typer, aff;
 
-        if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+        if ( !vgic_reg64_check_access(dabt) ) goto bad_width;
         /* TBD: Update processor id in [23:8] when ITS support is added */
         aff = (MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 3) << 56 |
                MPIDR_AFFINITY_LEVEL(v->arch.vmpidr, 2) << 48 |
@@ -267,7 +277,7 @@ bad_width:
     return 0;
 
 read_as_zero_64:
-    if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+    if ( !vgic_reg64_check_access(dabt) ) goto bad_width;
     *r = 0;
     return 1;
 
@@ -343,7 +353,7 @@ bad_width:
     return 0;
 
 write_ignore_64:
-    if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+    if ( vgic_reg64_check_access(dabt) ) goto bad_width;
     return 1;
 
 write_ignore_32:
@@ -833,7 +843,7 @@ static int vgic_v3_distr_mmio_read(struct vcpu *v, mmio_info_t *info,
     {
         uint64_t irouter;
 
-        if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+        if ( !vgic_reg64_check_access(dabt) ) goto bad_width;
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto read_as_zero;
@@ -908,7 +918,7 @@ bad_width:
     return 0;
 
 read_as_zero_64:
-    if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+    if ( vgic_reg64_check_access(dabt) ) goto bad_width;
     *r = 0;
     return 1;
 
@@ -994,7 +1004,7 @@ static int vgic_v3_distr_mmio_write(struct vcpu *v, mmio_info_t *info,
     {
         uint64_t irouter;
 
-        if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+        if ( !vgic_reg64_check_access(dabt) ) goto bad_width;
         rank = vgic_rank_offset(v, 64, gicd_reg - GICD_IROUTER,
                                 DABT_DOUBLE_WORD);
         if ( rank == NULL ) goto write_ignore;
@@ -1053,7 +1063,7 @@ write_ignore_32:
     return 1;
 
 write_ignore_64:
-    if ( dabt.size != DABT_DOUBLE_WORD ) goto bad_width;
+    if ( vgic_reg64_check_access(dabt) ) goto bad_width;
     return 1;
 
 write_ignore:
-- 
2.1.4
