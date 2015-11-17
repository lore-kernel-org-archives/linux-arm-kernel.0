From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:00 +0800
Subject: [PATCH v3 01/62] Revert "xen/arm: vgic-v2: Drop cbase from
 arch_domain"
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-2-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

This reverts commit 810a50db69703f715d199d6b3a5f08193155d48b.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Conflicts:
	xen/arch/arm/vgic-v2.c
---
 xen/arch/arm/vgic-v2.c       | 10 +++++-----
 xen/include/asm-arm/domain.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index f7d784b..ba7ddac 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -531,7 +531,7 @@ static int vgic_v2_vcpu_init(struct vcpu *v)
 static int vgic_v2_domain_init(struct domain *d)
 {
     int i, ret;
-    paddr_t cbase, csize;
+    paddr_t csize;
     paddr_t vbase;
 
     /*
@@ -541,6 +541,7 @@ static int vgic_v2_domain_init(struct domain *d)
     if ( is_hardware_domain(d) )
     {
         d->arch.vgic.dbase = vgic_v2_hw.dbase;
+        d->arch.vgic.cbase = vgic_v2_hw.cbase;
         /*
          * For the hardware domain, we always map the whole HW CPU
          * interface region in order to match the device tree (the "reg"
@@ -548,13 +549,13 @@ static int vgic_v2_domain_init(struct domain *d)
          * Note that we assume the size of the CPU interface is always
          * aligned to PAGE_SIZE.
          */
-        cbase = vgic_v2_hw.cbase;
         csize = vgic_v2_hw.csize;
         vbase = vgic_v2_hw.vbase;
     }
     else
     {
         d->arch.vgic.dbase = GUEST_GICD_BASE;
+        d->arch.vgic.cbase = GUEST_GICC_BASE;
         /*
          * The CPU interface exposed to the guest is always 8kB. We may
          * need to add an offset to the virtual CPU interface base
@@ -562,7 +563,6 @@ static int vgic_v2_domain_init(struct domain *d)
          * region.
          */
         BUILD_BUG_ON(GUEST_GICC_SIZE != SZ_8K);
-        cbase = GUEST_GICC_BASE;
         csize = GUEST_GICC_SIZE;
         vbase = vgic_v2_hw.vbase + vgic_v2_hw.aliased_offset;
     }
@@ -571,8 +571,8 @@ static int vgic_v2_domain_init(struct domain *d)
      * Map the gic virtual cpu interface in the gic cpu interface
      * region of the guest.
      */
-    ret = map_mmio_regions(d, paddr_to_pfn(cbase), csize / PAGE_SIZE,
-                           paddr_to_pfn(vbase));
+    ret = map_mmio_regions(d, paddr_to_pfn(d->arch.vgic.cbase),
+                           csize / PAGE_SIZE, paddr_to_pfn(vbase));
     if ( ret )
         return ret;
 
diff --git a/xen/include/asm-arm/domain.h b/xen/include/asm-arm/domain.h
index e7e40da..1e61f30 100644
--- a/xen/include/asm-arm/domain.h
+++ b/xen/include/asm-arm/domain.h
@@ -102,6 +102,7 @@ struct arch_domain
         struct pending_irq *pending_irqs;
         /* Base address for guest GIC */
         paddr_t dbase; /* Distributor base address */
+        paddr_t cbase; /* CPU base address */
 #ifdef HAS_GICV3
         /* GIC V3 addressing */
         /* List of contiguous occupied by the redistributors */
-- 
2.1.0
