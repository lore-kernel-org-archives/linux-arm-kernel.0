From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:44 +0100
Subject: [KVMTOOL][PATCH v2 5/9] arm: Add an helper to sanitize KVM
 configuration
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-6-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment only the RAM size is checked. A follow-up patch will add
more sanity check.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Add missing commit message
---
 arm/aarch64/include/kvm/kvm-arch.h |  2 +-
 arm/kvm.c                          | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 9de623a..1b3d0a5 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -5,7 +5,7 @@
 				0x8000				:	\
 				0x80000)
 
-#define ARM_MAX_MEMORY(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
+#define ARM_MAX_MEMORY(cfg)	((cfg)->arch.aarch32_guest	?	\
 				ARM_LOMAP_MAX_MEMORY		:	\
 				ARM_HIMAP_MAX_MEMORY)
 
diff --git a/arm/kvm.c b/arm/kvm.c
index b6ff2e2..45022aa 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -57,6 +57,15 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 {
 }
 
+static void kvm__arch_sanitize_cfg(struct kvm_config *cfg)
+{
+	if (cfg->ram_size > ARM_MAX_MEMORY(cfg)) {
+		cfg->ram_size = ARM_MAX_MEMORY(cfg);
+		pr_warning("sanitize: Capping memory to %lluMB",
+			   cfg->ram_size >> 20);
+	}
+}
+
 void kvm__arch_init(struct kvm *kvm)
 {
 	unsigned long alignment;
@@ -64,6 +73,8 @@ void kvm__arch_init(struct kvm *kvm)
 	/* Convenience aliases */
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
 
+	kvm__arch_sanitize_cfg(&kvm->cfg);
+
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
 	 * correlate with the maximum guest page size for virtio-mmio.
@@ -76,7 +87,7 @@ void kvm__arch_init(struct kvm *kvm)
 		alignment = SZ_32M;
 	else
 		alignment = SZ_2M;
-	kvm->ram_size = min(kvm->cfg.ram_size, (u64)ARM_MAX_MEMORY(kvm));
+	kvm->ram_size = kvm->cfg.ram_size;
 	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
 	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
-- 
2.11.0
