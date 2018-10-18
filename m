From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:47 +0100
Subject: [KVMTOOL][PATCH v2 8/9] arm: Add support for multi memory regions
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-9-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the RAM will always be contiguous and start 2GB. This patch
is giving the possibility to the user to specificy multiple RAM region
and

Note that at the moment it is not possible to place any RAM region below
2GB as the MMIO region is still static.

The implementation for multi memory regions is fairly straight-forward,
althought it the following points are worth to be mention:
    - The banks are sorted by base address, so it is easier to fetch the
    lowest bank later on and do sanity checking
    - If the user does not specify the address of the first bank, the
    old behavior is kept.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Check whether memory banks overlap with the MMIO area
---
 arm/aarch32/include/kvm/kvm-arch.h |   2 +-
 arm/aarch64/include/kvm/kvm-arch.h |   4 +-
 arm/fdt.c                          |  19 ++++--
 arm/include/arm-common/kvm-arch.h  |  24 +++++--
 arm/kvm.c                          | 129 +++++++++++++++++++++++++++++--------
 5 files changed, 133 insertions(+), 45 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index cd31e72..2ee0cb1 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -3,7 +3,7 @@
 
 #define ARM_KERN_OFFSET(...)	0x8000
 
-#define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY
+#define ARM_MAX_PHYS_SHIFT(...)	32
 
 #include "arm-common/kvm-arch.h"
 
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 1b3d0a5..53ac20f 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -5,9 +5,7 @@
 				0x8000				:	\
 				0x80000)
 
-#define ARM_MAX_MEMORY(cfg)	((cfg)->arch.aarch32_guest	?	\
-				ARM_LOMAP_MAX_MEMORY		:	\
-				ARM_HIMAP_MAX_MEMORY)
+#define ARM_MAX_PHYS_SHIFT(cfg)	((cfg)->arch.aarch32_guest ? 32 : 40)
 
 #include "arm-common/kvm-arch.h"
 
diff --git a/arm/fdt.c b/arm/fdt.c
index 6ac0b33..2a010c7 100644
--- a/arm/fdt.c
+++ b/arm/fdt.c
@@ -29,7 +29,7 @@ static void dump_fdt(const char *dtb_file, void *fdt)
 	int count, fd;
 
 	fd = open(dtb_file, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	if (fd < 0)
+
 		die("Failed to write dtb to %s", dtb_file);
 
 	count = write(fd, fdt, FDT_MAX_SIZE);
@@ -114,10 +114,7 @@ static int setup_fdt(struct kvm *kvm)
 {
 	struct device_header *dev_hdr;
 	u8 staging_fdt[FDT_MAX_SIZE];
-	u64 mem_reg_prop[]	= {
-		cpu_to_fdt64(kvm->arch.memory_guest_start),
-		cpu_to_fdt64(kvm->ram[0].size),
-	};
+	fdt64_t mem_reg_prop[2 * MAX_RAM_BANKS];
 	struct psci_fns *fns;
 	void *fdt		= staging_fdt;
 	void *fdt_dest		= guest_flat_to_host(kvm,
@@ -126,6 +123,8 @@ static int setup_fdt(struct kvm *kvm)
 					void (*)(void *, u8, enum irq_type));
 	void (*generate_cpu_peripheral_fdt_nodes)(void *, struct kvm *)
 					= kvm->cpus[0]->generate_fdt_nodes;
+	unsigned int i;
+	const struct kvm_config *cfg = &kvm->cfg;
 
 	/* Create new tree without a reserve map */
 	_FDT(fdt_create(fdt, FDT_MAX_SIZE));
@@ -158,9 +157,17 @@ static int setup_fdt(struct kvm *kvm)
 	_FDT(fdt_end_node(fdt));
 
 	/* Memory */
+	for (i = 0; i < cfg->nr_ram; i++) {
+		fdt64_t *reg = &mem_reg_prop[i * 2];
+
+		reg[0] = cpu_to_fdt64(cfg->ram[i].base);
+		reg[1] = cpu_to_fdt64(cfg->ram[i].size);
+	}
+
 	_FDT(fdt_begin_node(fdt, "memory"));
 	_FDT(fdt_property_string(fdt, "device_type", "memory"));
-	_FDT(fdt_property(fdt, "reg", mem_reg_prop, sizeof(mem_reg_prop)));
+	_FDT(fdt_property(fdt, "reg", mem_reg_prop,
+			  2 * sizeof(fdt64_t) * cfg->nr_ram));
 	_FDT(fdt_end_node(fdt));
 
 	/* CPU and peripherals (interrupt controller, timers, etc) */
diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index b9d486d..1dd4fa5 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -10,10 +10,9 @@
 #define ARM_IOPORT_AREA		_AC(0x0000000000000000, UL)
 #define ARM_MMIO_AREA		_AC(0x0000000000010000, UL)
 #define ARM_AXI_AREA		_AC(0x0000000040000000, UL)
-#define ARM_MEMORY_AREA		_AC(0x0000000080000000, UL)
+#define ARM_IOMEM_AREA_END	_AC(0x0000000080000000, UL)
 
-#define ARM_LOMAP_MAX_MEMORY	((1ULL << 32) - ARM_MEMORY_AREA)
-#define ARM_HIMAP_MAX_MEMORY	((1ULL << 40) - ARM_MEMORY_AREA)
+#define ARM_MEMORY_AREA		ARM_IOMEM_AREA_END
 
 #define ARM_GIC_DIST_BASE	(ARM_AXI_AREA - ARM_GIC_DIST_SIZE)
 #define ARM_GIC_CPUI_BASE	(ARM_GIC_DIST_BASE - ARM_GIC_CPUI_SIZE)
@@ -24,7 +23,7 @@
 #define ARM_IOPORT_SIZE		(ARM_MMIO_AREA - ARM_IOPORT_AREA)
 #define ARM_VIRTIO_MMIO_SIZE	(ARM_AXI_AREA - (ARM_MMIO_AREA + ARM_GIC_SIZE))
 #define ARM_PCI_CFG_SIZE	(1ULL << 24)
-#define ARM_PCI_MMIO_SIZE	(ARM_MEMORY_AREA - \
+#define ARM_PCI_MMIO_SIZE	(ARM_IOMEM_AREA_END - \
 				(ARM_AXI_AREA + ARM_PCI_CFG_SIZE))
 
 #define KVM_IOPORT_AREA		ARM_IOPORT_AREA
@@ -34,6 +33,8 @@
 
 #define KVM_IOEVENTFD_HAS_PIO	0
 
+#define ARM_MAX_PHYS_ADDR(cfg)	(1UL << ARM_MAX_PHYS_SHIFT(cfg))
+
 /*
  * On a GICv3 there must be one redistributor per vCPU.
  * The value here is the size for one, we multiply this@runtime with
@@ -56,18 +57,27 @@ static inline bool arm_addr_in_ioport_region(u64 phys_addr)
 	return phys_addr >= KVM_IOPORT_AREA && phys_addr < limit;
 }
 
+#define MAX_RAM_BANKS	8
+
+#define ARCH_SUPPORT_CFG_RAM_BASE 1
+
+struct kvm_arch_ram_region
+{
+	void	*start;
+	u64	size;
+};
+
 struct kvm_arch {
 	/*
 	 * We may have to align the guest memory for virtio, so keep the
 	 * original pointers here for munmap.
 	 */
-	void	*ram_alloc_start;
-	u64	ram_alloc_size;
+	struct kvm_arch_ram_region ram_alloc[MAX_RAM_BANKS];
 
 	/*
 	 * Guest addresses for memory layout.
 	 */
-	u64	memory_guest_start;
+	unsigned int	nr_mem_banks;
 	u64	kern_guest_start;
 	u64	initrd_guest_start;
 	u64	initrd_size;
diff --git a/arm/kvm.c b/arm/kvm.c
index 2a55b41..3c93d2d 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -11,6 +11,8 @@
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 
+#include <stdlib.h>
+
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -24,14 +26,15 @@ bool kvm__arch_cpu_supports_vm(void)
 	return true;
 }
 
-static void kvm__init_ram(struct kvm *kvm)
+static void kvm__init_ram(struct kvm *kvm,
+			  const struct kvm_ram_config *ram_cfg,
+			  struct kvm_ram_region *ram,
+			  struct kvm_arch_ram_region *ram_alloc)
 {
 	int err;
-	u64 phys_start;
 	unsigned long alignment;
 	/* Convenience aliases */
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
-	struct kvm_ram_region *ram = &kvm->ram[0];
 
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
@@ -45,37 +48,42 @@ static void kvm__init_ram(struct kvm *kvm)
 		alignment = SZ_32M;
 	else
 		alignment = SZ_2M;
-	ram->size = kvm->cfg.ram[0].size;
-	kvm->arch.ram_alloc_size = ram->size + alignment;
-	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
-						kvm->arch.ram_alloc_size);
+	ram->size = ram_cfg->size;
+	ram_alloc->size = ram->size + alignment;
+	ram_alloc->start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
+						  ram_alloc->size);
 
-	if (kvm->arch.ram_alloc_start == MAP_FAILED)
+	if (ram_alloc->start == MAP_FAILED)
 		die("Failed to map %lld bytes for guest memory (%d)",
-		    kvm->arch.ram_alloc_size, errno);
-
-	ram->start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-				   SZ_2M);
+		    ram_alloc->size, errno);
 
-	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
-		MADV_MERGEABLE);
+	ram->start = (void *)ALIGN((unsigned long)ram_alloc->start, SZ_2M);
 
-	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
-		MADV_HUGEPAGE);
+	madvise(ram_alloc->start, ram_alloc->size, MADV_MERGEABLE);
 
-	phys_start	= ARM_MEMORY_AREA;
+	madvise(ram_alloc->start, ram_alloc->size, MADV_HUGEPAGE);
 
-	err = kvm__register_ram(kvm, phys_start, ram->size, ram->start);
+	err = kvm__register_ram(kvm, ram_cfg->base, ram_cfg->size,
+				ram->start);
 	if (err)
 		die("Failed to register %lld bytes of memory at physical "
-		    "address 0x%llx [err %d]", ram->size, phys_start, err);
-
-	kvm->arch.memory_guest_start = phys_start;
+		    "address 0x%llx [err %d]",
+		    ram_cfg->size,
+		    ram_cfg->base,
+		    err);
+
+	pr_info("Registered memory bank 0x%llx-0x%llx\n",
+		ram_cfg->base,
+		ram_cfg->base + ram_cfg->size);
 }
 
 void kvm__arch_delete_ram(struct kvm *kvm)
 {
-	munmap(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size);
+	unsigned int i;
+
+	for (i = 0; i < kvm->nr_ram; i++)
+		munmap(kvm->arch.ram_alloc[i].start,
+		       kvm->arch.ram_alloc[i].size);
 }
 
 void kvm__arch_read_term(struct kvm *kvm)
@@ -88,27 +96,90 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 {
 }
 
+/* Only sort the bank by base address */
+static int cmp_bank(const void *p1, const void *p2)
+{
+	const struct kvm_ram_config *bank1 = p1;
+	const struct kvm_ram_config *bank2 = p2;
+
+	if (bank1->base < bank2->base)
+		return -1;
+	else if (bank1->base == bank2->base)
+		return 0;
+	else
+		return 1;
+}
+
 static void kvm__arch_sanitize_cfg(struct kvm_config *cfg)
 {
+	unsigned int i;
 	/* Convenience aliases */
 	struct kvm_ram_config *bank0 = &cfg->ram[0];
 
-	if (bank0->size > ARM_MAX_MEMORY(cfg)) {
-		bank0->size = ARM_MAX_MEMORY(cfg);
-		pr_warning("sanitize: Capping memory to %lluMB",
-			   bank0->size >> 20);
+	/*
+	 * The user may not have set an address for the first bank. (To keep the
+	 * command line backward compatible).
+	 */
+	if (bank0->base == INVALID_RAM_ADDR) {
+		/*
+		 * Impose the user to set address for the first bank when
+		 * multiple banks are specified.
+		 */
+		if (cfg->nr_ram > 1)
+			die("sanitize: Base address should be specified for all the banks\n");
+		bank0->base = ARM_MEMORY_AREA;
+		/*
+		 * Keep compatibility with old KVM command line behavior where
+		 * the memory is capped.
+		 */
+		if ((bank0->base + bank0->size) > ARM_MAX_PHYS_ADDR(cfg)) {
+			bank0->size = ARM_MAX_PHYS_ADDR(cfg) - bank0->base;
+			pr_warning("sanitize: Capping memory to %lluMB",
+				   bank0->size >> 20);
+		}
+	}
+
+	/* Sort banks by address to make easier later on. */
+	qsort(cfg->ram, cfg->nr_ram, sizeof(*cfg->ram), cmp_bank);
+
+	/* Check banks are not overlapping */
+	for (i = 1; i < cfg->nr_ram; i++) {
+		const struct kvm_ram_config *bank1 = &cfg->ram[i - 1];
+		const struct kvm_ram_config *bank2 = &cfg->ram[i];
+		unsigned long long end1 = bank1->base + bank1->size - 1;
+		unsigned long long end2 = bank2->base + bank2->size - 1;
+
+		if (!((end1 < bank2->base) || (bank1->base > end2)))
+			die("Memory bank 0x%llx-0x%llx overlapping with 0x%llx-0x%llx\n",
+			    bank1->base, end1, bank2->base, end2);
 	}
+
+	/* Check the memory is below the IPA size supported */
+	i = cfg->nr_ram - 1;
+	if ((cfg->ram[i].base + cfg->ram[i].size) > ARM_MAX_PHYS_ADDR(cfg))
+		die("Memory bank outside of the maximum IPA\n");
+
+	/* For now, the MMIO area is static and will be below 2GB */
+	if (cfg->ram[0].base < ARM_IOMEM_AREA_END)
+		die("Memory bank overlapping with the MMIO area\n");
 }
 
 void kvm__arch_init(struct kvm *kvm)
 {
+	unsigned int i;
+	/* Convenience aliases */
+	struct kvm_config *cfg = &kvm->cfg;
+
 	kvm__arch_sanitize_cfg(&kvm->cfg);
 
 	/* Create the virtual GIC. */
 	if (gic__create(kvm, kvm->cfg.arch.irqchip))
 		die("Failed to create virtual GIC");
 
-	kvm__init_ram(kvm);
+	for (i = 0; i < cfg->nr_ram; i++)
+		kvm__init_ram(kvm, &cfg->ram[i], &kvm->ram[i],
+			      &kvm->arch.ram_alloc[i]);
+	kvm->nr_ram = cfg->nr_ram;
 }
 
 #define FDT_ALIGN	SZ_2M
@@ -125,6 +196,8 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	/*
 	 * Linux requires the initrd and dtb to be mapped inside lowmem,
 	 * so we can't just place them at the top of memory.
+	 *
+	 * Let's place it in the first memory bank.
 	 */
 	limit = ram0->start + min(ram0->size, (u64)SZ_256M) - 1;
 
@@ -133,7 +206,7 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	file_size = read_file(fd_kernel, pos, limit - pos);
 	if (file_size < 0) {
 		if (errno == ENOMEM)
-			die("kernel image too big to contain in guest memory.");
+			die("kernel image too big to contain in the first memory bank of the guest.");
 
 		die_perror("kernel read");
 	}
-- 
2.11.0
