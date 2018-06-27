From: james.morse@arm.com (James Morse)
Date: Wed, 27 Jun 2018 09:40:21 +0100
Subject: [PATCH v5 12/20] ACPI / APEI: Don't store CPER records physical
 address in struct ghes
In-Reply-To: <201806270332.vrWmASbO%fengguang.wu@intel.com>
References: <20180626170116.25825-13-james.morse@arm.com>
 <201806270332.vrWmASbO%fengguang.wu@intel.com>
Message-ID: <5a35a9d3-c536-998d-7a76-e18206305ea6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/18 21:55, kbuild test robot wrote:
>         # save the attached .config to linux build tree
>         make ARCH=i386 

Gah, guess who forgot about 32bit.


> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/apei/ghes.c: In function 'ghes_read_estatus':
>>> drivers/acpi/apei/ghes.c:300:17: error: passing argument 1 of 'apei_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      rc = apei_read(buf_paddr, &g->error_status_address);
>                     ^~~~~~~~~

This takes a u64 pointer even on 32bit systems, because that's the size of the
GAS structure in the spec. (I wonder what it expects you to do if the high bits
are set...)

I'll fix this locally[0].


Thanks,

James



[0] phys_addr_t is a good thing, lets not use it:
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b7b335450a6b..930adecd87d4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -267,7 +267,7 @@ static inline int ghes_severity(int severity)
        }
 }

-static void ghes_copy_tofrom_phys(void *buffer, phys_addr_t paddr, u32 len,
+static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
                                  int from_phys, int fixmap_idx)
 {
        void __iomem *vaddr;
@@ -292,7 +292,7 @@ static void ghes_copy_tofrom_phys(void *buffer, phys_addr_t
paddr, u32 len,

 /* read the CPER block returning its address and size */
 static int ghes_peek_estatus(struct ghes *ghes, int fixmap_idx,
-                            phys_addr_t *buf_paddr, u32 *buf_len)
+                            u64 *buf_paddr, u32 *buf_len)
 {
        struct acpi_hest_generic *g = ghes->generic;
        struct acpi_hest_generic_status estatus;

@@ -337,7 +337,7 @@ static int ghes_peek_estatus(struct ghes *ghes, int fixmap_idx,
 }

 static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
-                              phys_addr_t buf_paddr, size_t buf_len,
+                              u64 buf_paddr, size_t buf_len,
                               int fixmap_idx)
 {
        ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
@@ -353,7 +353,7 @@ static int __ghes_read_estatus(struct
acpi_hest_generic_status *estatus,

 static int ghes_read_estatus(struct ghes *ghes,
                             struct acpi_hest_generic_status *estatus,
-                            phys_addr_t *buf_paddr, int fixmap_idx)
+                            u64 *buf_paddr, int fixmap_idx)
 {
        int rc;
        u32 buf_len;
@@ -366,7 +366,7 @@ static int ghes_read_estatus(struct ghes *ghes,
 }

 static void ghes_clear_estatus(struct acpi_hest_generic_status *estatus,
-                              phys_addr_t buf_paddr, int fixmap_idx)
+                              u64 buf_paddr, int fixmap_idx)
 {
        estatus->block_status = 0;
        if (buf_paddr)
@@ -716,9 +716,9 @@ static void ghes_print_queued_estatus(void)

 static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 {
+       u64 buf_paddr;
        int sev, rc = 0;
        u32 len, node_len;
-       phys_addr_t buf_paddr;
        struct ghes_estatus_node *estatus_node;
        struct acpi_hest_generic_status *estatus;

@@ -876,8 +876,8 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 static int ghes_proc(struct ghes *ghes)
 {
        int rc;
+       u64 buf_paddr;
        unsigned long flags;
-       phys_addr_t buf_paddr;
        struct acpi_hest_generic_status *estatus = ghes->estatus;

        spin_lock_irqsave(&ghes_notify_lock_irq, flags);
