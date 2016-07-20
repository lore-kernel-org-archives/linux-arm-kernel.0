From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 20 Jul 2016 08:54:00 -0500
Subject: [PATCH V3 4/4] arm/vgic: Change fixed number of mmio handlers to
 variable number
In-Reply-To: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
References: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1469022840-2142-5-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compute the number of mmio handlers that are required for vGICv3 and
vGICv2 emulation drivers in vgic_v3_init()/vgic_v2_init(). Augment
this variable number of mmio handers to a fixed number MAX_IO_HANDLER
and pass it to domain_io_init() to allocate enough memory.

New code path:
 domain_vgic_register(&count)
   domain_io_init(count + MAX_IO_HANDLER)
     domain_vgic_init()

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 xen/arch/arm/domain.c      | 12 +++++++-----
 xen/arch/arm/vgic-v2.c     |  3 ++-
 xen/arch/arm/vgic-v3.c     |  5 ++++-
 xen/arch/arm/vgic.c        | 10 +++-------
 xen/include/asm-arm/vgic.h |  5 +++--
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/xen/arch/arm/domain.c b/xen/arch/arm/domain.c
index 0170cee..4e5259b 100644
--- a/xen/arch/arm/domain.c
+++ b/xen/arch/arm/domain.c
@@ -546,7 +546,7 @@ void vcpu_destroy(struct vcpu *v)
 int arch_domain_create(struct domain *d, unsigned int domcr_flags,
                        struct xen_arch_domainconfig *config)
 {
-    int rc, count;
+    int rc, count = 0;
 
     d->arch.relmem = RELMEM_not_started;
 
@@ -569,10 +569,6 @@ int arch_domain_create(struct domain *d, unsigned int domcr_flags,
     share_xen_page_with_guest(
         virt_to_page(d->shared_info), d, XENSHARE_writable);
 
-    count = MAX_IO_HANDLER;
-    if ( (rc = domain_io_init(d, count)) != 0 )
-        goto fail;
-
     if ( (rc = p2m_alloc_table(d)) != 0 )
         goto fail;
 
@@ -609,6 +605,12 @@ int arch_domain_create(struct domain *d, unsigned int domcr_flags,
         goto fail;
     }
 
+    if ( (rc = domain_vgic_register(d, &count)) != 0 )
+        goto fail;
+
+    if ( (rc = domain_io_init(d, count + MAX_IO_HANDLER)) != 0 )
+        goto fail;
+
     if ( (rc = domain_vgic_init(d, config->nr_spis)) != 0 )
         goto fail;
 
diff --git a/xen/arch/arm/vgic-v2.c b/xen/arch/arm/vgic-v2.c
index 6a5e67b..c6d280e 100644
--- a/xen/arch/arm/vgic-v2.c
+++ b/xen/arch/arm/vgic-v2.c
@@ -711,7 +711,7 @@ static const struct vgic_ops vgic_v2_ops = {
     .max_vcpus = 8,
 };
 
-int vgic_v2_init(struct domain *d)
+int vgic_v2_init(struct domain *d, int *mmio_count)
 {
     if ( !vgic_v2_hw.enabled )
     {
@@ -721,6 +721,7 @@ int vgic_v2_init(struct domain *d)
         return -ENODEV;
     }
 
+    *mmio_count = 1; /* Only GICD region */
     register_vgic_ops(d, &vgic_v2_ops);
 
     return 0;
diff --git a/xen/arch/arm/vgic-v3.c b/xen/arch/arm/vgic-v3.c
index be9a9a3..ec038a3 100644
--- a/xen/arch/arm/vgic-v3.c
+++ b/xen/arch/arm/vgic-v3.c
@@ -1499,7 +1499,7 @@ static const struct vgic_ops v3_ops = {
     .max_vcpus = 4096,
 };
 
-int vgic_v3_init(struct domain *d)
+int vgic_v3_init(struct domain *d, int *mmio_count)
 {
     if ( !vgic_v3_hw.enabled )
     {
@@ -1509,6 +1509,9 @@ int vgic_v3_init(struct domain *d)
         return -ENODEV;
     }
 
+    /* GICD region + number of Redistributors */
+    *mmio_count = vgic_v3_rdist_count(d) + 1;
+
     register_vgic_ops(d, &v3_ops);
 
     return 0;
diff --git a/xen/arch/arm/vgic.c b/xen/arch/arm/vgic.c
index a7ccfe7..768cb91 100644
--- a/xen/arch/arm/vgic.c
+++ b/xen/arch/arm/vgic.c
@@ -88,18 +88,18 @@ static void vgic_rank_init(struct vgic_irq_rank *rank, uint8_t index,
         rank->vcpu[i] = vcpu;
 }
 
-static int domain_vgic_register(struct domain *d)
+int domain_vgic_register(struct domain *d, int *mmio_count)
 {
     switch ( d->arch.vgic.version )
     {
 #ifdef CONFIG_HAS_GICV3
     case GIC_V3:
-        if ( vgic_v3_init(d) )
+        if ( vgic_v3_init(d, mmio_count) )
            return -ENODEV;
         break;
 #endif
     case GIC_V2:
-        if ( vgic_v2_init(d) )
+        if ( vgic_v2_init(d, mmio_count) )
             return -ENODEV;
         break;
     default:
@@ -124,10 +124,6 @@ int domain_vgic_init(struct domain *d, unsigned int nr_spis)
 
     d->arch.vgic.nr_spis = nr_spis;
 
-    ret = domain_vgic_register(d);
-    if ( ret < 0 )
-        return ret;
-
     spin_lock_init(&d->arch.vgic.lock);
 
     d->arch.vgic.shared_irqs =
diff --git a/xen/include/asm-arm/vgic.h b/xen/include/asm-arm/vgic.h
index c3cc4f6..300f461 100644
--- a/xen/include/asm-arm/vgic.h
+++ b/xen/include/asm-arm/vgic.h
@@ -304,9 +304,10 @@ extern int vgic_emulate(struct cpu_user_regs *regs, union hsr hsr);
 extern void vgic_disable_irqs(struct vcpu *v, uint32_t r, int n);
 extern void vgic_enable_irqs(struct vcpu *v, uint32_t r, int n);
 extern void register_vgic_ops(struct domain *d, const struct vgic_ops *ops);
-int vgic_v2_init(struct domain *d);
-int vgic_v3_init(struct domain *d);
+int vgic_v2_init(struct domain *d, int *mmio_count);
+int vgic_v3_init(struct domain *d, int *mmio_count);
 
+extern int domain_vgic_register(struct domain *d, int *mmio_count);
 extern int vcpu_vgic_free(struct vcpu *v);
 extern int vgic_to_sgi(struct vcpu *v, register_t sgir,
                        enum gic_sgi_mode irqmode, int virq,
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
