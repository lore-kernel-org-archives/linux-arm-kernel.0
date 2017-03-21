From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Mar 2017 18:00:40 +0000
Subject: [PATCH 12/14] arm64: kill acpi_set_mailbox_entry()
In-Reply-To: <1489143891-11596-13-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-13-git-send-email-mark.rutland@arm.com>
Message-ID: <20170321180040.GA4849@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 11:04:49AM +0000, Mark Rutland wrote:
> Now that we have acpi_cpu_get_madt_gicc(), we can use values from the
> MADT GICC table directly, and no longer need to stash a copy in our own
> datastructure.
> 
> This allows us to kill off the acpi_set_mailbox_entry() callback, too.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h             |  5 ----
>  arch/arm64/kernel/acpi_parking_protocol.c | 38 +++++++++----------------------
>  arch/arm64/kernel/smp.c                   | 11 ---------
>  3 files changed, 11 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 0e99978..ebf88e3 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -96,13 +96,8 @@ static inline void acpi_init_cpus(void) { }
>  
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>  bool acpi_parking_protocol_valid(int cpu);
> -void __init
> -acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor);
>  #else
>  static inline bool acpi_parking_protocol_valid(int cpu) { return false; }
> -static inline void
> -acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
> -{}
>  #endif
>  
>  static inline const char *acpi_get_enable_method(int cpu)
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index 1f5655c..700a83a 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -28,36 +28,21 @@ struct parking_protocol_mailbox {
>  	__le64 entry_point;
>  };
>  
> -struct cpu_mailbox_entry {
> -	struct parking_protocol_mailbox __iomem *mailbox;
> -	phys_addr_t mailbox_addr;
> -	u8 version;
> -	u8 gic_cpu_id;
> -};
> -
> -static struct cpu_mailbox_entry cpu_mailbox_entries[NR_CPUS];
> -
> -void __init acpi_set_mailbox_entry(int cpu,
> -				   struct acpi_madt_generic_interrupt *p)
> -{
> -	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> -
> -	cpu_entry->mailbox_addr = p->parked_address;
> -	cpu_entry->version = p->parking_version;
> -	cpu_entry->gic_cpu_id = p->cpu_interface_number;
> -}
> +static struct parking_protocol_mailbox __iomem *mailboxes[NR_CPUS];

Nit: If I am not mistaken it can be made a percpu pointer.

Other than that:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  bool acpi_parking_protocol_valid(int cpu)
>  {
> -	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +	struct acpi_madt_generic_interrupt *p = acpi_cpu_get_madt_gicc(cpu);
>  
> -	return cpu_entry->mailbox_addr && cpu_entry->version;
> +	return p->parked_address && p->parking_version;
>  }
>  
>  static int acpi_parking_protocol_cpu_init(unsigned int cpu)
>  {
> +	struct acpi_madt_generic_interrupt *p = acpi_cpu_get_madt_gicc(cpu);
> +
>  	pr_debug("%s: ACPI parked addr=%llx\n", __func__,
> -		  cpu_mailbox_entries[cpu].mailbox_addr);
> +		 p->parked_address);
>  
>  	return 0;
>  }
> @@ -69,7 +54,7 @@ static int acpi_parking_protocol_cpu_prepare(unsigned int cpu)
>  
>  static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  {
> -	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +	struct acpi_madt_generic_interrupt *p = acpi_cpu_get_madt_gicc(cpu);
>  	struct parking_protocol_mailbox __iomem *mailbox;
>  	__le32 cpu_id;
>  
> @@ -84,7 +69,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  	 * by the kernel (it clashes with the linear mapping attributes
>  	 * specifications).
>  	 */
> -	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> +	mailbox = ioremap(p->parked_address, sizeof(*mailbox));
>  	if (!mailbox)
>  		return -EIO;
>  
> @@ -102,7 +87,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  	 * stash the mailbox address mapping to use it for further FW
>  	 * checks in the postboot method
>  	 */
> -	cpu_entry->mailbox = mailbox;
> +	mailboxes[cpu] = mailbox;
>  
>  	/*
>  	 * We write the entry point and cpu id as LE regardless of the
> @@ -111,7 +96,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  	 * Boot-Loader's endianness before jumping.
>  	 */
>  	writeq_relaxed(__pa_symbol(secondary_entry), &mailbox->entry_point);
> -	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
> +	writel_relaxed(p->cpu_interface_number, &mailbox->cpu_id);
>  
>  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>  
> @@ -121,8 +106,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  static void acpi_parking_protocol_cpu_postboot(void)
>  {
>  	int cpu = smp_processor_id();
> -	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> -	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
> +	struct parking_protocol_mailbox __iomem *mailbox = mailboxes[cpu];
>  	__le64 entry_point;
>  
>  	entry_point = readl_relaxed(&mailbox->entry_point);
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 390c277..b37dd83 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -572,17 +572,6 @@ struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
>  
>  	cpu_madt_gicc[cpu_count] = *processor;
>  
> -	/*
> -	 * Set-up the ACPI parking protocol cpu entries
> -	 * while initializing the cpu_logical_map to
> -	 * avoid parsing MADT entries multiple times for
> -	 * nothing (ie a valid cpu_logical_map entry should
> -	 * contain a valid parking protocol data set to
> -	 * initialize the cpu if the parking protocol is
> -	 * the only available enable method).
> -	 */
> -	acpi_set_mailbox_entry(cpu_count, processor);
> -
>  	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count, hwid));
>  
>  	cpu_count++;
> -- 
> 1.9.1
> 
