From: julien.grall@arm.com (Julien Grall)
Date: Thu, 10 May 2018 15:04:29 +0100
Subject: [RFC 01/13] arm: Allow use of hugepage with 16K pagesize host
In-Reply-To: <20180510140441.24573-1-julien.grall@arm.com>
References: <20180510140441.24573-1-julien.grall@arm.com>
Message-ID: <20180510140441.24573-2-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

With 16K pagesize, the hugepage size is 32M. Align the guest
memory to the hugepagesize for 16K.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arm/kvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arm/kvm.c b/arm/kvm.c
index 2ab436e..c4ab5c0 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -59,14 +59,22 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 
 void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 {
+	unsigned long alignment;
+
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
 	 * correlate with the maximum guest page size for virtio-mmio.
 	 * If using THP, then our minimal alignment becomes 2M.
 	 * 2M trumps 64K, so let's go with that.
+	 * If we are running with 16K page size, align the memory to
+	 * 32M, so that we can make use of the THP.
 	 */
+	if (sysconf(_SC_PAGESIZE) == SZ_16K)
+		alignment = SZ_32M;
+	else
+		alignment = SZ_2M;
 	kvm->ram_size = min(ram_size, (u64)ARM_MAX_MEMORY(kvm));
-	kvm->arch.ram_alloc_size = kvm->ram_size + SZ_2M;
+	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
 	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
 
@@ -75,7 +83,7 @@ void kvm__arch_init(struct kvm *kvm, const char *hugetlbfs_path, u64 ram_size)
 		    kvm->arch.ram_alloc_size, errno);
 
 	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-					SZ_2M);
+					alignment);
 
 	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
 		MADV_MERGEABLE);
-- 
2.11.0
