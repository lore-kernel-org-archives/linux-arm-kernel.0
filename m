From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:45 +0100
Subject: [KVMTOOL][PATCH v2 6/9] arm: Move anything related to RAM
 initialization in kvm__init_ram
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-7-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RAM initialization is currently split between kvm__init_ram and
kvm__arch_init. Move all code related to RAM initialization in the
former, this will help with the introduction of multi-banks support in a
follow-up patch.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Add missing commit message
---
 arm/kvm.c | 68 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/arm/kvm.c b/arm/kvm.c
index 45022aa..9623aa5 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -29,6 +29,39 @@ static void kvm__init_ram(struct kvm *kvm)
 	int err;
 	u64 phys_start, phys_size;
 	void *host_mem;
+	unsigned long alignment;
+	/* Convenience aliases */
+	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+
+	/*
+	 * Allocate guest memory. We must align our buffer to 64K to
+	 * correlate with the maximum guest page size for virtio-mmio.
+	 * If using THP, then our minimal alignment becomes 2M.
+	 * 2M trumps 64K, so let's go with that.
+	 * If we are running with 16K page size, align the memory to
+	 * 32M, so that we can make use of the THP.
+	 */
+	if (sysconf(_SC_PAGESIZE) == SZ_16K)
+		alignment = SZ_32M;
+	else
+		alignment = SZ_2M;
+	kvm->ram_size = kvm->cfg.ram_size;
+	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
+	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
+						kvm->arch.ram_alloc_size);
+
+	if (kvm->arch.ram_alloc_start == MAP_FAILED)
+		die("Failed to map %lld bytes for guest memory (%d)",
+		    kvm->arch.ram_alloc_size, errno);
+
+	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
+					SZ_2M);
+
+	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
+		MADV_MERGEABLE);
+
+	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
+		MADV_HUGEPAGE);
 
 	phys_start	= ARM_MEMORY_AREA;
 	phys_size	= kvm->ram_size;
@@ -68,43 +101,8 @@ static void kvm__arch_sanitize_cfg(struct kvm_config *cfg)
 
 void kvm__arch_init(struct kvm *kvm)
 {
-	unsigned long alignment;
-
-	/* Convenience aliases */
-	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
-
 	kvm__arch_sanitize_cfg(&kvm->cfg);
 
-	/*
-	 * Allocate guest memory. We must align our buffer to 64K to
-	 * correlate with the maximum guest page size for virtio-mmio.
-	 * If using THP, then our minimal alignment becomes 2M.
-	 * 2M trumps 64K, so let's go with that.
-	 * If we are running with 16K page size, align the memory to
-	 * 32M, so that we can make use of the THP.
-	 */
-	if (sysconf(_SC_PAGESIZE) == SZ_16K)
-		alignment = SZ_32M;
-	else
-		alignment = SZ_2M;
-	kvm->ram_size = kvm->cfg.ram_size;
-	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
-	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
-						kvm->arch.ram_alloc_size);
-
-	if (kvm->arch.ram_alloc_start == MAP_FAILED)
-		die("Failed to map %lld bytes for guest memory (%d)",
-		    kvm->arch.ram_alloc_size, errno);
-
-	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-					alignment);
-
-	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
-		MADV_MERGEABLE);
-
-	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
-		MADV_HUGEPAGE);
-
 	/* Create the virtual GIC. */
 	if (gic__create(kvm, kvm->cfg.arch.irqchip))
 		die("Failed to create virtual GIC");
-- 
2.11.0
