From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 20 Jul 2016 08:53:57 -0500
Subject: [PATCH V3 1/4] arm/io: Use separate memory allocation for mmio
 handlers
In-Reply-To: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
References: <1469022840-2142-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1469022840-2142-2-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of mmio handlers are limited to a compile time macro
MAX_IO_HANDLER which is 16. This number is not at all sufficient
to support per CPU distributor regions. Either it needs to be
increased to a bigger number, at least CONFIG_NR_CPUS+16, or
allocate a separate memory for mmio handlers dynamically during
domain build.

This patch uses the dynamic allocation strategy to reduce memory
footprint for 'struct domain' instead of static allocation.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Julien Grall <julien.grall@arm.com>
---
 xen/arch/arm/domain.c      |  6 ++++--
 xen/arch/arm/io.c          | 13 +++++++++++--
 xen/include/asm-arm/mmio.h |  7 +++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/xen/arch/arm/domain.c b/xen/arch/arm/domain.c
index 61fc08e..0170cee 100644
--- a/xen/arch/arm/domain.c
+++ b/xen/arch/arm/domain.c
@@ -546,7 +546,7 @@ void vcpu_destroy(struct vcpu *v)
 int arch_domain_create(struct domain *d, unsigned int domcr_flags,
                        struct xen_arch_domainconfig *config)
 {
-    int rc;
+    int rc, count;
 
     d->arch.relmem = RELMEM_not_started;
 
@@ -569,7 +569,8 @@ int arch_domain_create(struct domain *d, unsigned int domcr_flags,
     share_xen_page_with_guest(
         virt_to_page(d->shared_info), d, XENSHARE_writable);
 
-    if ( (rc = domain_io_init(d)) != 0 )
+    count = MAX_IO_HANDLER;
+    if ( (rc = domain_io_init(d, count)) != 0 )
         goto fail;
 
     if ( (rc = p2m_alloc_table(d)) != 0 )
@@ -663,6 +664,7 @@ void arch_domain_destroy(struct domain *d)
     free_xenheap_pages(d->arch.efi_acpi_table,
                        get_order_from_bytes(d->arch.efi_acpi_len));
 #endif
+    domain_io_free(d);
 }
 
 void arch_domain_shutdown(struct domain *d)
diff --git a/xen/arch/arm/io.c b/xen/arch/arm/io.c
index 5a96836..40330f0 100644
--- a/xen/arch/arm/io.c
+++ b/xen/arch/arm/io.c
@@ -118,7 +118,7 @@ void register_mmio_handler(struct domain *d,
     struct vmmio *vmmio = &d->arch.vmmio;
     struct mmio_handler *handler;
 
-    BUG_ON(vmmio->num_entries >= MAX_IO_HANDLER);
+    BUG_ON(vmmio->num_entries >= vmmio->max_num_entries);
 
     write_lock(&vmmio->lock);
 
@@ -134,14 +134,23 @@ void register_mmio_handler(struct domain *d,
     write_unlock(&vmmio->lock);
 }
 
-int domain_io_init(struct domain *d)
+int domain_io_init(struct domain *d, int max_count)
 {
     rwlock_init(&d->arch.vmmio.lock);
     d->arch.vmmio.num_entries = 0;
+    d->arch.vmmio.max_num_entries = max_count;
+    d->arch.vmmio.handlers = xzalloc_array(struct mmio_handler, max_count);
+    if ( !d->arch.vmmio.handlers )
+        return -ENOMEM;
 
     return 0;
 }
 
+void domain_io_free(struct domain *d)
+{
+    xfree(d->arch.vmmio.handlers);
+}
+
 /*
  * Local variables:
  * mode: C
diff --git a/xen/include/asm-arm/mmio.h b/xen/include/asm-arm/mmio.h
index 32f10f2..c620eed 100644
--- a/xen/include/asm-arm/mmio.h
+++ b/xen/include/asm-arm/mmio.h
@@ -52,15 +52,18 @@ struct mmio_handler {
 
 struct vmmio {
     int num_entries;
+    int max_num_entries;
     rwlock_t lock;
-    struct mmio_handler handlers[MAX_IO_HANDLER];
+    struct mmio_handler *handlers;
 };
 
 extern int handle_mmio(mmio_info_t *info);
 void register_mmio_handler(struct domain *d,
                            const struct mmio_handler_ops *ops,
                            paddr_t addr, paddr_t size, void *priv);
-int domain_io_init(struct domain *d);
+int domain_io_init(struct domain *d, int max_count);
+void domain_io_free(struct domain *d);
+
 
 #endif  /* __ASM_ARM_MMIO_H__ */
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
