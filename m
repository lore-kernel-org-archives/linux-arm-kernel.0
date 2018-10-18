From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:46 +0100
Subject: [KVMTOOL][PATCH v2 7/9] Allow the user to specify where the RAM is
 placed in the memory
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-8-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment the user is only able to give the amount of memory used by
the guest. The placement of the RAM in the layout is left to the
software. It would be useful to give more freedom to the user where the
RAM regions will live in the memory layout and the size of them.

The command line to specify the size of the memory (-m/-mem) is now extended
in a compatible way to allow specifiying the base address: <size>[@<addr>].

The <addr> is mandatory if the option is specified multiple (i.e the
user request).

As not all the architecture will support multiple RAM region or even
specificying the address, it is left to the architecture to enable the
feature (see MAX_RAM_BANKS and ARCH_SUPPORT_CFG_RAM_BASE).

At the moment no-one is taking advantages of it, this will change in a
follow-up patch.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arm/fdt.c                |  2 +-
 arm/kvm.c                | 33 +++++++++---------
 builtin-run.c            | 87 +++++++++++++++++++++++++++++++++++++++++++-----
 include/kvm/kvm-config.h | 16 ++++++++-
 include/kvm/kvm.h        | 21 ++++++++++--
 kvm.c                    |  4 +++
 mips/kvm.c               | 40 ++++++++++++----------
 powerpc/kvm.c            | 26 ++++++++-------
 x86/bios.c               |  8 +++--
 x86/kvm.c                | 47 +++++++++++++++-----------
 10 files changed, 204 insertions(+), 80 deletions(-)

diff --git a/arm/fdt.c b/arm/fdt.c
index 980015b..6ac0b33 100644
--- a/arm/fdt.c
+++ b/arm/fdt.c
@@ -116,7 +116,7 @@ static int setup_fdt(struct kvm *kvm)
 	u8 staging_fdt[FDT_MAX_SIZE];
 	u64 mem_reg_prop[]	= {
 		cpu_to_fdt64(kvm->arch.memory_guest_start),
-		cpu_to_fdt64(kvm->ram_size),
+		cpu_to_fdt64(kvm->ram[0].size),
 	};
 	struct psci_fns *fns;
 	void *fdt		= staging_fdt;
diff --git a/arm/kvm.c b/arm/kvm.c
index 9623aa5..2a55b41 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -27,11 +27,11 @@ bool kvm__arch_cpu_supports_vm(void)
 static void kvm__init_ram(struct kvm *kvm)
 {
 	int err;
-	u64 phys_start, phys_size;
-	void *host_mem;
+	u64 phys_start;
 	unsigned long alignment;
 	/* Convenience aliases */
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+	struct kvm_ram_region *ram = &kvm->ram[0];
 
 	/*
 	 * Allocate guest memory. We must align our buffer to 64K to
@@ -45,8 +45,8 @@ static void kvm__init_ram(struct kvm *kvm)
 		alignment = SZ_32M;
 	else
 		alignment = SZ_2M;
-	kvm->ram_size = kvm->cfg.ram_size;
-	kvm->arch.ram_alloc_size = kvm->ram_size + alignment;
+	ram->size = kvm->cfg.ram[0].size;
+	kvm->arch.ram_alloc_size = ram->size + alignment;
 	kvm->arch.ram_alloc_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
 						kvm->arch.ram_alloc_size);
 
@@ -54,8 +54,8 @@ static void kvm__init_ram(struct kvm *kvm)
 		die("Failed to map %lld bytes for guest memory (%d)",
 		    kvm->arch.ram_alloc_size, errno);
 
-	kvm->ram_start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
-					SZ_2M);
+	ram->start = (void *)ALIGN((unsigned long)kvm->arch.ram_alloc_start,
+				   SZ_2M);
 
 	madvise(kvm->arch.ram_alloc_start, kvm->arch.ram_alloc_size,
 		MADV_MERGEABLE);
@@ -64,13 +64,11 @@ static void kvm__init_ram(struct kvm *kvm)
 		MADV_HUGEPAGE);
 
 	phys_start	= ARM_MEMORY_AREA;
-	phys_size	= kvm->ram_size;
-	host_mem	= kvm->ram_start;
 
-	err = kvm__register_ram(kvm, phys_start, phys_size, host_mem);
+	err = kvm__register_ram(kvm, phys_start, ram->size, ram->start);
 	if (err)
 		die("Failed to register %lld bytes of memory at physical "
-		    "address 0x%llx [err %d]", phys_size, phys_start, err);
+		    "address 0x%llx [err %d]", ram->size, phys_start, err);
 
 	kvm->arch.memory_guest_start = phys_start;
 }
@@ -92,10 +90,13 @@ void kvm__arch_set_cmdline(char *cmdline, bool video)
 
 static void kvm__arch_sanitize_cfg(struct kvm_config *cfg)
 {
-	if (cfg->ram_size > ARM_MAX_MEMORY(cfg)) {
-		cfg->ram_size = ARM_MAX_MEMORY(cfg);
+	/* Convenience aliases */
+	struct kvm_ram_config *bank0 = &cfg->ram[0];
+
+	if (bank0->size > ARM_MAX_MEMORY(cfg)) {
+		bank0->size = ARM_MAX_MEMORY(cfg);
 		pr_warning("sanitize: Capping memory to %lluMB",
-			   cfg->ram_size >> 20);
+			   bank0->size >> 20);
 	}
 }
 
@@ -118,14 +119,16 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	void *pos, *kernel_end, *limit;
 	unsigned long guest_addr;
 	ssize_t file_size;
+	/* Convenience aliases */
+	struct kvm_ram_region *ram0 = &kvm->ram[0];
 
 	/*
 	 * Linux requires the initrd and dtb to be mapped inside lowmem,
 	 * so we can't just place them at the top of memory.
 	 */
-	limit = kvm->ram_start + min(kvm->ram_size, (u64)SZ_256M) - 1;
+	limit = ram0->start + min(ram0->size, (u64)SZ_256M) - 1;
 
-	pos = kvm->ram_start + ARM_KERN_OFFSET(kvm);
+	pos = ram0->start + ARM_KERN_OFFSET(kvm);
 	kvm->arch.kern_guest_start = host_to_guest_flat(kvm, pos);
 	file_size = read_file(fd_kernel, pos, limit - pos);
 	if (file_size < 0) {
diff --git a/builtin-run.c b/builtin-run.c
index 443c10b..568af5c 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -87,6 +87,63 @@ void kvm_run_set_wrapper_sandbox(void)
 	kvm_run_wrapper = KVM_RUN_SANDBOX;
 }
 
+static int mem_parser(const struct option *opt, const char *arg, int unset)
+{
+	struct kvm_config *cfg = opt->value;
+	const char *p = arg;
+	char *next;
+	u64 size, addr;
+	int base;
+
+	/* parse out size */
+	size = strtoll(p, &next, 10);
+
+	if (next == p)
+		die("mem: no size specified.\n");
+
+	if (*next != '@' && *next != '\0')
+		die("mem: unexpected chars after size.\n");
+
+	if (*next == '\0')
+		p = next;
+	else
+		p = next + 1;
+
+	/* parse out guest addr */
+	base = 10;
+	if (strcasestr(p, "0x"))
+		base = 16;
+	addr = strtoll(p, &next, base);
+	if (next == p && addr == 0) {
+		/*
+		 * To keep backward compatibility, the <addr> is not
+		 * mandatory for the first bank.
+		 */
+		if (cfg->nr_ram > 0)
+			die("mem: <addr> must be specified\n");
+		addr = INVALID_RAM_ADDR;
+	}
+
+	if ( cfg->nr_ram == MAX_RAM_BANKS )
+		die("mem: Too many banks\n");
+
+	/*
+	 * Allow the architecture to tell whether it is possible to configure
+	 * the RAM base address.
+	 */
+#ifndef ARCH_SUPPORT_CFG_RAM_BASE
+	if (addr == INVALID_RAM_ADDR)
+		die("mem: specifying <addr> is not allowed\n");
+#endif
+
+	cfg->ram[cfg->nr_ram].base = addr;
+	cfg->ram[cfg->nr_ram].size = size;
+
+	cfg->nr_ram++;
+
+	return 0;
+}
+
 #ifndef OPT_ARCH_RUN
 #define OPT_ARCH_RUN(...)
 #endif
@@ -97,8 +154,11 @@ void kvm_run_set_wrapper_sandbox(void)
 	OPT_STRING('\0', "name", &(cfg)->guest_name, "guest name",	\
 			"A name for the guest"),			\
 	OPT_INTEGER('c', "cpus", &(cfg)->nrcpus, "Number of CPUs"),	\
-	OPT_U64('m', "mem", &(cfg)->ram_size, "Virtual machine memory"	\
-		" size in MiB."),					\
+	OPT_CALLBACK('m', "mem", cfg,					\
+		     "<size>[@<addr>]",					\
+		     "Virtual machine memory region, size in MiB."	\
+		     "<addr> must be specified in case of multiple regions", \
+		     mem_parser, NULL),					\
 	OPT_CALLBACK('\0', "shmem", NULL,				\
 		     "[pci:]<addr>:<size>[:handle=<handle>][:create]",	\
 		     "Share host shmem with guest via pci device",	\
@@ -460,6 +520,8 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 	unsigned int nr_online_cpus;
 	struct kvm *kvm = kvm__new();
 	bool video;
+	u64 total_ram = 0;
+	unsigned int i;
 
 	if (IS_ERR(kvm))
 		return kvm;
@@ -526,16 +588,23 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 	if (kvm->cfg.nrcpus == 0)
 		kvm->cfg.nrcpus = nr_online_cpus;
 
-	if (!kvm->cfg.ram_size)
-		kvm->cfg.ram_size = get_ram_size(kvm->cfg.nrcpus);
+	/* Deal with user not specifiying memory */
+	if (kvm->cfg.nr_ram == 0 && !kvm->cfg.ram[0].size) {
+		kvm->cfg.ram[0].size = get_ram_size(kvm->cfg.nrcpus);
+		kvm->cfg.nr_ram = 1;
+	}
+
+	for (i = 0; i < kvm->cfg.nr_ram; i++) {
+		total_ram += kvm->cfg.ram[i].size;
+		/* The user input is in MB, but the internal deals with bytes */
+		kvm->cfg.ram[i].size <<= MB_SHIFT;
+	}
 
-	if (kvm->cfg.ram_size > host_ram_size())
+	if (total_ram > host_ram_size())
 		pr_warning("Guest memory size %lluMB exceeds host physical RAM size %lluMB",
-			(unsigned long long)kvm->cfg.ram_size,
+			(unsigned long long)total_ram,
 			(unsigned long long)host_ram_size());
 
-	kvm->cfg.ram_size <<= MB_SHIFT;
-
 	if (!kvm->cfg.dev)
 		kvm->cfg.dev = DEFAULT_KVM_DEV;
 
@@ -641,7 +710,7 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 
 	printf("  # %s run -k %s -m %Lu -c %d --name %s\n", KVM_BINARY_NAME,
 		kvm->cfg.kernel_filename,
-		(unsigned long long)kvm->cfg.ram_size / 1024 / 1024,
+		(unsigned long long)kvm->cfg.ram[0].size / 1024 / 1024,
 		kvm->cfg.nrcpus, kvm->cfg.guest_name);
 
 	if (init_list__init(kvm) < 0)
diff --git a/include/kvm/kvm-config.h b/include/kvm/kvm-config.h
index a052b0b..f258316 100644
--- a/include/kvm/kvm-config.h
+++ b/include/kvm/kvm-config.h
@@ -18,11 +18,25 @@
 #define MIN_RAM_SIZE_MB		(64ULL)
 #define MIN_RAM_SIZE_BYTE	(MIN_RAM_SIZE_MB << MB_SHIFT)
 
+#define INVALID_RAM_ADDR	(~0ULL)
+
+/* By default the user is only able to speficy one RAM bank */
+#ifndef MAX_RAM_BANKS
+#define MAX_RAM_BANKS	1
+#endif
+
+struct kvm_ram_config
+{
+	u64 base;
+	u64 size;
+};
+
 struct kvm_config {
 	struct kvm_config_arch arch;
 	struct disk_image_params disk_image[MAX_DISK_IMAGES];
 	struct vfio_device_params *vfio_devices;
-	u64 ram_size;
+	struct kvm_ram_config ram[MAX_RAM_BANKS];
+	u8 nr_ram;
 	u8  image_count;
 	u8 num_net_devices;
 	u8 num_vfio_devices;
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index ee2c5ab..2eb25cf 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -57,6 +57,11 @@ struct kvm_mem_bank {
 	enum kvm_mem_type	type;
 };
 
+struct kvm_ram_region {
+	void			*start;
+	u64			size;
+};
+
 struct kvm {
 	struct kvm_arch		arch;
 	struct kvm_config	cfg;
@@ -68,8 +73,8 @@ struct kvm {
 	struct kvm_cpu		**cpus;
 
 	u32			mem_slots;	/* for KVM_SET_USER_MEMORY_REGION */
-	u64			ram_size;
-	void			*ram_start;
+	struct kvm_ram_region	ram[MAX_RAM_BANKS];
+	u32			nr_ram;
 	u64			ram_pagesize;
 	struct list_head	mem_banks;
 
@@ -177,7 +182,17 @@ extern const char *kvm_exit_reasons[];
 
 static inline bool host_ptr_in_ram(struct kvm *kvm, void *p)
 {
-	return kvm->ram_start <= p && p < (kvm->ram_start + kvm->ram_size);
+	unsigned int i;
+
+	for (i = 0; i < kvm->nr_ram; i++ )
+	{
+		struct kvm_ram_region *ram = &kvm->ram[i];
+
+		if (ram->start <= p && p < (ram->start + ram->size))
+			return true;
+	}
+
+	return false;
 }
 
 bool kvm__supports_extension(struct kvm *kvm, unsigned int extension);
diff --git a/kvm.c b/kvm.c
index 81e8a70..dffe574 100644
--- a/kvm.c
+++ b/kvm.c
@@ -151,6 +151,7 @@ static int kvm__check_extensions(struct kvm *kvm)
 
 struct kvm *kvm__new(void)
 {
+	unsigned int i;
 	struct kvm *kvm = calloc(1, sizeof(*kvm));
 	if (!kvm)
 		return ERR_PTR(-ENOMEM);
@@ -158,6 +159,9 @@ struct kvm *kvm__new(void)
 	kvm->sys_fd = -1;
 	kvm->vm_fd = -1;
 
+	for ( i = 0; i < MAX_RAM_BANKS; i++)
+		kvm->cfg.ram[i].base = INVALID_RAM_ADDR;
+
 	return kvm;
 }
 
diff --git a/mips/kvm.c b/mips/kvm.c
index 2ccefe8..13d2255 100644
--- a/mips/kvm.c
+++ b/mips/kvm.c
@@ -21,26 +21,28 @@ static void kvm__init_ram(struct kvm *kvm)
 {
 	u64	phys_start, phys_size;
 	void	*host_mem;
+	/* Convenience aliases */
+	const struct kvm_ram_region *ram = &kvm->ram[0];
 
-	if (kvm->ram_size <= KVM_MMIO_START) {
+	if (ram->size <= KVM_MMIO_START) {
 		/* one region for all memory */
 		phys_start = 0;
-		phys_size  = kvm->ram_size;
-		host_mem   = kvm->ram_start;
+		phys_size  = ram->size;
+		host_mem   = ram->start;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 	} else {
 		/* one region for memory that fits below MMIO range */
 		phys_start = 0;
 		phys_size  = KVM_MMIO_START;
-		host_mem   = kvm->ram_start;
+		host_mem   = ram->start;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 
 		/* one region for rest of memory */
 		phys_start = KVM_MMIO_START + KVM_MMIO_SIZE;
-		phys_size  = kvm->ram_size - KVM_MMIO_START;
-		host_mem   = kvm->ram_start + KVM_MMIO_START;
+		phys_size  = ram->size - KVM_MMIO_START;
+		host_mem   = ram->start + KVM_MMIO_START;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 	}
@@ -48,7 +50,7 @@ static void kvm__init_ram(struct kvm *kvm)
 
 void kvm__arch_delete_ram(struct kvm *kvm)
 {
-	munmap(kvm->ram_start, kvm->ram_size);
+	munmap(kvm->ram[0].start, kvm->ram[0].size);
 }
 
 void kvm__arch_set_cmdline(char *cmdline, bool video)
@@ -61,16 +63,18 @@ void kvm__arch_init(struct kvm *kvm)
 {
 	int ret;
 	/* Convenience aliases */
-	u64 ram_size = kvm->cfg.ram_size;
+	u64 ram_size = kvm->cfg.ram[0].size;
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+	struct kvm_ram_region *ram = &kvm->ram[0];
 
-	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
-	kvm->ram_size = ram_size;
+	kvm->nr_ram = 1;
+	ram->start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
+	ram->size = ram_size;
 
-	if (kvm->ram_start == MAP_FAILED)
+	if (ram->start == MAP_FAILED)
 		die("out of memory");
 
-	madvise(kvm->ram_start, kvm->ram_size, MADV_MERGEABLE);
+	madvise(ram->start, ram->size, MADV_MERGEABLE);
 
 	ret = ioctl(kvm->vm_fd, KVM_CREATE_IRQCHIP);
 	if (ret < 0)
@@ -124,20 +128,22 @@ int kvm__arch_setup_firmware(struct kvm *kvm)
 
 static void kvm__mips_install_cmdline(struct kvm *kvm)
 {
-	char *p = kvm->ram_start;
 	u64 cmdline_offset = 0x2000;
 	u64 argv_start = 0x3000;
 	u64 argv_offset = argv_start;
 	u64 argc = 0;
+	/* Convenience aliases */
+	struct kvm_ram_region *ram = &kvm->ram[0];
 
+	char *p = ram->start;
 
-	if ((u64) kvm->ram_size <= KVM_MMIO_START)
+	if ((u64) ram->size <= KVM_MMIO_START)
 		sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
-			(unsigned long long)kvm->ram_size);
+			(unsigned long long)ram->size);
 	else
 		sprintf(p + cmdline_offset, "mem=0x%llx at 0 mem=0x%llx at 0x%llx ",
 			(unsigned long long)KVM_MMIO_START,
-			(unsigned long long)kvm->ram_size - KVM_MMIO_START,
+			(unsigned long long)ram->size - KVM_MMIO_START,
 			(unsigned long long)(KVM_MMIO_START + KVM_MMIO_SIZE));
 
 	strcat(p + cmdline_offset, kvm->cfg.real_cmdline); /* maximum size is 2K */
@@ -181,7 +187,7 @@ static bool load_flat_binary(struct kvm *kvm, int fd_kernel)
 	p = k_start = guest_flat_to_host(kvm, KERNEL_LOAD_ADDR);
 
 	kernel_size = read_file(fd_kernel, p,
-				kvm->cfg.ram_size - KERNEL_LOAD_ADDR);
+				kvm->cfg.ram[0].size - KERNEL_LOAD_ADDR);
 	if (kernel_size == -1) {
 		if (errno == ENOMEM)
 			die("kernel too big for guest memory");
diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index be99598..4b1c34a 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -66,8 +66,8 @@ static void kvm__init_ram(struct kvm *kvm)
 	void	*host_mem;
 
 	phys_start = 0;
-	phys_size  = kvm->ram_size;
-	host_mem   = kvm->ram_start;
+	phys_size  = kvm->ram[0].size;
+	host_mem   = kvm->ram[0].start;
 
 	/*
 	 * We put MMIO at PPC_MMIO_START, high up.  Make sure that this doesn't
@@ -93,26 +93,28 @@ void kvm__arch_init(struct kvm *kvm)
 	int cap_ppc_rma;
 	unsigned long hpt;
 	/* Convenience aliases */
-	u64 ram_size = kvm->cfg.ram_size;
+	u64 ram_size = kvm->cfg.ram[0].size;
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+	struct kvm_ram_region *ram = &kvm->ram[0];
 
-	kvm->ram_size		= ram_size;
+	kvm->nr_ram		= 1;
+	ram->size		= ram_size;
 
 	/* Map "default" hugetblfs path to the standard 16M mount point */
 	if (hugetlbfs_path && !strcmp(hugetlbfs_path, "default"))
 		hugetlbfs_path = HUGETLBFS_PATH;
 
-	kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, kvm->ram_size);
+	ram->start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram->size);
 
-	if (kvm->ram_start == MAP_FAILED)
+	if (ram->start == MAP_FAILED)
 		die("Couldn't map %lld bytes for RAM (%d)\n",
-		    kvm->ram_size, errno);
+		    ram->size, errno);
 
 	/* FDT goes at top of memory, RTAS just below */
-	kvm->arch.fdt_gra = kvm->ram_size - FDT_MAX_SIZE;
+	kvm->arch.fdt_gra = ram->size - FDT_MAX_SIZE;
 	/* FIXME: Not all PPC systems have RTAS */
 	kvm->arch.rtas_gra = kvm->arch.fdt_gra - RTAS_MAX_SIZE;
-	madvise(kvm->ram_start, kvm->ram_size, MADV_MERGEABLE);
+	madvise(ram->start, ram->size, MADV_MERGEABLE);
 
 	/* FIXME:  SPAPR-PR specific; allocate a guest HPT. */
 	if (posix_memalign((void **)&hpt, (1<<HPT_ORDER), (1<<HPT_ORDER)))
@@ -145,7 +147,7 @@ void kvm__arch_init(struct kvm *kvm)
 
 void kvm__arch_delete_ram(struct kvm *kvm)
 {
-	munmap(kvm->ram_start, kvm->ram_size);
+	munmap(kvm->ram[0].start, kvm->ram[0].size);
 }
 
 void kvm__irq_trigger(struct kvm *kvm, int irq)
@@ -186,7 +188,7 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 		p = guest_flat_to_host(kvm, INITRD_LOAD_ADDR);
 
 		filesize = read_file(fd_initrd, p,
-			       (kvm->ram_start + kvm->ram_size) - p);
+			       (kvm->ram[0].start + kvm->ram[0].size) - p);
 		if (filesize < 0) {
 			if (errno == ENOMEM)
 				die("initrd too big to contain in guest RAM.\n");
@@ -283,7 +285,7 @@ static void generate_segment_page_sizes(struct kvm_ppc_smmu_info *info, struct f
  */
 static int setup_fdt(struct kvm *kvm)
 {
-	uint64_t 	mem_reg_property[] = { 0, cpu_to_be64(kvm->ram_size) };
+	uint64_t 	mem_reg_property[] = { 0, cpu_to_be64(kvm->ram[0].size) };
 	int 		smp_cpus = kvm->nrcpus;
 	uint32_t	int_server_ranges_prop[] = {0, cpu_to_be32(smp_cpus)};
 	char 		hypertas_prop_kvm[] = "hcall-pft\0hcall-term\0"
diff --git a/x86/bios.c b/x86/bios.c
index 5ac9e24..2efd771 100644
--- a/x86/bios.c
+++ b/x86/bios.c
@@ -59,6 +59,8 @@ static void e820_setup(struct kvm *kvm)
 	struct e820map *e820;
 	struct e820entry *mem_map;
 	unsigned int i = 0;
+	/* Convenience aliases */
+	const struct kvm_ram_region *ram = &kvm->ram[0];
 
 	e820		= guest_flat_to_host(kvm, E820_MAP_START);
 	mem_map		= e820->map;
@@ -78,10 +80,10 @@ static void e820_setup(struct kvm *kvm)
 		.size		= MB_BIOS_END - MB_BIOS_BEGIN,
 		.type		= E820_RESERVED,
 	};
-	if (kvm->ram_size < KVM_32BIT_GAP_START) {
+	if (ram->size < KVM_32BIT_GAP_START) {
 		mem_map[i++]	= (struct e820entry) {
 			.addr		= BZ_KERNEL_START,
-			.size		= kvm->ram_size - BZ_KERNEL_START,
+			.size		= ram->size - BZ_KERNEL_START,
 			.type		= E820_RAM,
 		};
 	} else {
@@ -92,7 +94,7 @@ static void e820_setup(struct kvm *kvm)
 		};
 		mem_map[i++]	= (struct e820entry) {
 			.addr		= KVM_32BIT_MAX_MEM_SIZE,
-			.size		= kvm->ram_size - KVM_32BIT_MAX_MEM_SIZE,
+			.size		= ram->size - KVM_32BIT_MAX_MEM_SIZE,
 			.type		= E820_RAM,
 		};
 	}
diff --git a/x86/kvm.c b/x86/kvm.c
index a22fa65..2fe4928 100644
--- a/x86/kvm.c
+++ b/x86/kvm.c
@@ -90,13 +90,15 @@ static void kvm__init_ram(struct kvm *kvm)
 {
 	u64	phys_start, phys_size;
 	void	*host_mem;
+	/* Convenience aliases */
+	const struct kvm_ram_region *ram = &kvm->ram[0];
 
-	if (kvm->ram_size < KVM_32BIT_GAP_START) {
+	if (ram->size < KVM_32BIT_GAP_START) {
 		/* Use a single block of RAM for 32bit RAM */
 
 		phys_start = 0;
-		phys_size  = kvm->ram_size;
-		host_mem   = kvm->ram_start;
+		phys_size  = ram->size;
+		host_mem   = ram->start;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 	} else {
@@ -104,15 +106,15 @@ static void kvm__init_ram(struct kvm *kvm)
 
 		phys_start = 0;
 		phys_size  = KVM_32BIT_GAP_START;
-		host_mem   = kvm->ram_start;
+		host_mem   = ram->start;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 
 		/* Second RAM range from 4GB to the end of RAM: */
 
 		phys_start = KVM_32BIT_MAX_MEM_SIZE;
-		phys_size  = kvm->ram_size - phys_start;
-		host_mem   = kvm->ram_start + phys_start;
+		phys_size  = ram->size - phys_start;
+		host_mem   = ram->start + phys_start;
 
 		kvm__register_ram(kvm, phys_start, phys_size, host_mem);
 	}
@@ -135,8 +137,9 @@ void kvm__arch_init(struct kvm *kvm)
 	struct kvm_pit_config pit_config = { .flags = 0, };
 	int ret;
 	/* Convenience aliases */
-	u64 ram_size = kvm->cfg.ram_size;
+	u64 ram_size = kvm->cfg.ram[0].size;
 	const char *hugetlbfs_path = kvm->cfg.hugetlbfs_path;
+	struct kvm_ram_region *ram = &kvm->ram[0];
 
 	ret = ioctl(kvm->vm_fd, KVM_SET_TSS_ADDR, 0xfffbd000);
 	if (ret < 0)
@@ -146,23 +149,29 @@ void kvm__arch_init(struct kvm *kvm)
 	if (ret < 0)
 		die_perror("KVM_CREATE_PIT2 ioctl");
 
+	kvm->nr_ram = 1;
 	if (ram_size < KVM_32BIT_GAP_START) {
-		kvm->ram_size = ram_size;
-		kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size);
+		ram->size = ram_size;
+		ram->start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path,
+						    ram_size);
 	} else {
-		kvm->ram_start = mmap_anon_or_hugetlbfs(kvm, hugetlbfs_path, ram_size + KVM_32BIT_GAP_SIZE);
-		kvm->ram_size = ram_size + KVM_32BIT_GAP_SIZE;
-		if (kvm->ram_start != MAP_FAILED)
+		ram->start = mmap_anon_or_hugetlbfs(kvm,
+						    hugetlbfs_path,
+						    ram_size + KVM_32BIT_GAP_SIZE);
+		ram->size = ram_size + KVM_32BIT_GAP_SIZE;
+		if (ram->start != MAP_FAILED)
 			/*
 			 * We mprotect the gap (see kvm__init_ram() for details) PROT_NONE so that
 			 * if we accidently write to it, we will know.
 			 */
-			mprotect(kvm->ram_start + KVM_32BIT_GAP_START, KVM_32BIT_GAP_SIZE, PROT_NONE);
+			mprotect(ram->start + KVM_32BIT_GAP_START,
+				 KVM_32BIT_GAP_SIZE, PROT_NONE);
 	}
-	if (kvm->ram_start == MAP_FAILED)
+	if (ram->start == MAP_FAILED)
 		die("out of memory");
 
-	madvise(kvm->ram_start, kvm->ram_size, MADV_MERGEABLE);
+	madvise(ram->start, ram->size,
+		MADV_MERGEABLE);
 
 	ret = ioctl(kvm->vm_fd, KVM_CREATE_IRQCHIP);
 	if (ret < 0)
@@ -173,7 +182,7 @@ void kvm__arch_init(struct kvm *kvm)
 
 void kvm__arch_delete_ram(struct kvm *kvm)
 {
-	munmap(kvm->ram_start, kvm->ram_size);
+	munmap(kvm->ram[0].start, kvm->ram[0].size);
 }
 
 void kvm__irq_line(struct kvm *kvm, int irq, int level)
@@ -221,7 +230,7 @@ static bool load_flat_binary(struct kvm *kvm, int fd_kernel)
 
 	p = guest_real_to_host(kvm, BOOT_LOADER_SELECTOR, BOOT_LOADER_IP);
 
-	if (read_file(fd_kernel, p, kvm->cfg.ram_size) < 0)
+	if (read_file(fd_kernel, p, kvm->cfg.ram[0].size) < 0)
 		die_perror("read");
 
 	kvm->arch.boot_selector	= BOOT_LOADER_SELECTOR;
@@ -270,7 +279,7 @@ static bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	/* read actual kernel image (vmlinux.bin) to BZ_KERNEL_START */
 	p = guest_flat_to_host(kvm, BZ_KERNEL_START);
 	file_size = read_file(fd_kernel, p,
-			      kvm->cfg.ram_size - BZ_KERNEL_START);
+			      kvm->cfg.ram[0].size - BZ_KERNEL_START);
 	if (file_size < 0)
 		die_perror("kernel read");
 
@@ -316,7 +325,7 @@ static bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
 		for (;;) {
 			if (addr < BZ_KERNEL_START)
 				die("Not enough memory for initrd");
-			else if (addr < (kvm->ram_size - initrd_stat.st_size))
+			else if (addr < (kvm->ram[0].size - initrd_stat.st_size))
 				break;
 			addr -= 0x100000;
 		}
-- 
2.11.0
