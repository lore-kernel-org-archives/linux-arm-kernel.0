From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Mar 2015 09:51:51 +0000
Subject: [PATCH v10 13/21] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <1426077587-1561-14-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-14-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150312095151.GB18414@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 12:39:39PM +0000, Hanjun Guo wrote:
> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
> but phys_id is used as int in acpi processor driver, so it will lead to
> some inconsistence for the drivers.
> 
> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
> ids a generic CPU physical id type is required.
> 
> So introduce typedef u32 phys_cpuid_t for x86 and ia64, and introduce
> a macro CPU_PHYS_ID_INVALID as (u32)(-1), use phys_cpuid_t when phys_id
> defined in acpi processor driver, and replace CPU_PHYS_ID_INVALID as -1
> for phys_id, this will solve the inconsistence in acpi processor driver,
> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware ID
> in the following patch.

Nit: Commit log above is stale (since you moved the phys_cpuid_t to
common declaration for all archs that do not define PHYS_CPUID_INVALID
and the macro name itself changed) so you should rewrite it before
asking to merge it. Furthermore you should not describe how you implemented
the change, you should describe why.

Other than that:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [hj: reworked cpu physid map return codes]
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/kernel/acpi.c       |  2 +-
>  arch/x86/kernel/acpi/boot.c   |  2 +-
>  drivers/acpi/acpi_processor.c |  7 ++++---
>  drivers/acpi/processor_core.c | 30 +++++++++++++++---------------
>  include/acpi/processor.h      |  6 +++---
>  include/linux/acpi.h          |  7 ++++++-
>  6 files changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 2c44989..067ef44 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -887,7 +887,7 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
>  }
>  
>  /* wrapper to silence section mismatch warning */
> -int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
> +int __ref acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu)
>  {
>  	return _acpi_map_lsapic(handle, physid, pcpu);
>  }
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3d525c6..e4f8582 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -757,7 +757,7 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
>  }
>  
>  /* wrapper to silence section mismatch warning */
> -int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
> +int __ref acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu)
>  {
>  	return _acpi_map_lsapic(handle, physid, pcpu);
>  }
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 1020b1b..58f335c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	acpi_status status;
>  	int ret;
>  
> -	if (pr->phys_id == -1)
> +	if (pr->phys_id == PHYS_CPUID_INVALID)
>  		return -ENODEV;
>  
>  	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> @@ -215,7 +215,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	union acpi_object object = { 0 };
>  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>  	struct acpi_processor *pr = acpi_driver_data(device);
> -	int phys_id, cpu_index, device_declaration = 0;
> +	phys_cpuid_t phys_id;
> +	int cpu_index, device_declaration = 0;
>  	acpi_status status = AE_OK;
>  	static int cpu0_initialized;
>  	unsigned long long value;
> @@ -263,7 +264,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	}
>  
>  	phys_id = acpi_get_phys_id(pr->handle, device_declaration, pr->acpi_id);
> -	if (phys_id < 0)
> +	if (phys_id == PHYS_CPUID_INVALID)
>  		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
>  	pr->phys_id = phys_id;
>  
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 7962651..51cc299 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -32,7 +32,7 @@ static struct acpi_table_madt *get_madt_table(void)
>  }
>  
>  static int map_lapic_id(struct acpi_subtable_header *entry,
> -		 u32 acpi_id, int *apic_id)
> +		 u32 acpi_id, phys_cpuid_t *apic_id)
>  {
>  	struct acpi_madt_local_apic *lapic =
>  		container_of(entry, struct acpi_madt_local_apic, header);
> @@ -48,7 +48,7 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
>  }
>  
>  static int map_x2apic_id(struct acpi_subtable_header *entry,
> -			 int device_declaration, u32 acpi_id, int *apic_id)
> +		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
>  {
>  	struct acpi_madt_local_x2apic *apic =
>  		container_of(entry, struct acpi_madt_local_x2apic, header);
> @@ -65,7 +65,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
>  }
>  
>  static int map_lsapic_id(struct acpi_subtable_header *entry,
> -		int device_declaration, u32 acpi_id, int *apic_id)
> +		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
>  {
>  	struct acpi_madt_local_sapic *lsapic =
>  		container_of(entry, struct acpi_madt_local_sapic, header);
> @@ -83,10 +83,10 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>  	return 0;
>  }
>  
> -static int map_madt_entry(int type, u32 acpi_id)
> +static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
>  {
>  	unsigned long madt_end, entry;
> -	int phys_id = -1;	/* CPU hardware ID */
> +	phys_cpuid_t phys_id = PHYS_CPUID_INVALID;	/* CPU hardware ID */
>  	struct acpi_table_madt *madt;
>  
>  	madt = get_madt_table();
> @@ -117,12 +117,12 @@ static int map_madt_entry(int type, u32 acpi_id)
>  	return phys_id;
>  }
>  
> -static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> +static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
>  	struct acpi_subtable_header *header;
> -	int phys_id = -1;
> +	phys_cpuid_t phys_id = PHYS_CPUID_INVALID;
>  
>  	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
>  		goto exit;
> @@ -149,27 +149,27 @@ exit:
>  	return phys_id;
>  }
>  
> -int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
> +phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
>  {
> -	int phys_id;
> +	phys_cpuid_t phys_id;
>  
>  	phys_id = map_mat_entry(handle, type, acpi_id);
> -	if (phys_id == -1)
> +	if (phys_id == PHYS_CPUID_INVALID)
>  		phys_id = map_madt_entry(type, acpi_id);
>  
>  	return phys_id;
>  }
>  
> -int acpi_map_cpuid(int phys_id, u32 acpi_id)
> +int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
>  {
>  #ifdef CONFIG_SMP
>  	int i;
>  #endif
>  
> -	if (phys_id == -1) {
> +	if (phys_id == PHYS_CPUID_INVALID) {
>  		/*
>  		 * On UP processor, there is no _MAT or MADT table.
> -		 * So above phys_id is always set to -1.
> +		 * So above phys_id is always set to PHYS_CPUID_INVALID.
>  		 *
>  		 * BIOS may define multiple CPU handles even for UP processor.
>  		 * For example,
> @@ -190,7 +190,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
>  		if (nr_cpu_ids <= 1 && acpi_id == 0)
>  			return acpi_id;
>  		else
> -			return phys_id;
> +			return -1;
>  	}
>  
>  #ifdef CONFIG_SMP
> @@ -208,7 +208,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
>  
>  int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
>  {
> -	int phys_id;
> +	phys_cpuid_t phys_id;
>  
>  	phys_id = acpi_get_phys_id(handle, type, acpi_id);
>  
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index b95dc32..4188a4d 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -196,7 +196,7 @@ struct acpi_processor_flags {
>  struct acpi_processor {
>  	acpi_handle handle;
>  	u32 acpi_id;
> -	u32 phys_id;	/* CPU hardware ID such as APIC ID for x86 */
> +	phys_cpuid_t phys_id;	/* CPU hardware ID such as APIC ID for x86 */
>  	u32 id;		/* CPU logical ID allocated by OS */
>  	u32 pblk;
>  	int performance_platform_limit;
> @@ -310,8 +310,8 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
>  #endif				/* CONFIG_CPU_FREQ */
>  
>  /* in processor_core.c */
> -int acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
> -int acpi_map_cpuid(int phys_id, u32 acpi_id);
> +phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
> +int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
>  int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
>  
>  /* in processor_pdc.c */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 24c7aa8..6ec33c5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -146,9 +146,14 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>  void acpi_numa_arch_fixup(void);
>  
> +#ifndef PHYS_CPUID_INVALID
> +typedef u32 phys_cpuid_t;
> +#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> +#endif
> +
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  /* Arch dependent functions for cpu hotplug support */
> -int acpi_map_cpu(acpi_handle handle, int physid, int *pcpu);
> +int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
>  int acpi_unmap_cpu(int cpu);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
> -- 
> 1.9.1
> 
> 
