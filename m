From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 15:18:01 +0000
Subject: [PATCH v3 18/62] arm/acpi: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible_map
In-Reply-To: <1447753261-7552-19-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-19-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231502470.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> MADT contains the information for MPIDR which is essential for SMP
> initialization, parse the GIC cpu interface structures to get the MPIDR
> value and map it to cpu_logical_map(), and add enabled cpu with valid
> MPIDR into cpu_possible_map.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/acpi/boot.c   | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  xen/include/asm-arm/acpi.h |   2 +
>  xen/include/xen/acpi.h     |   4 ++
>  3 files changed, 127 insertions(+)
> 
> diff --git a/xen/arch/arm/acpi/boot.c b/xen/arch/arm/acpi/boot.c
> index 0fabe7d..913d2a5 100644
> --- a/xen/arch/arm/acpi/boot.c
> +++ b/xen/arch/arm/acpi/boot.c
> @@ -32,6 +32,127 @@
>  #include <xen/mm.h>
>  
>  #include <asm/acpi.h>
> +#include <asm/smp.h>
> +
> +/* Processors with enabled flag and sane MPIDR */
> +static int enabled_cpus;

unsigned int


> +/* Boot CPU is valid or not in MADT */
> +static bool_t __initdata bootcpu_valid;
> +
> +/* total number of cpus in this system */
> +static unsigned int __initdata total_cpus = 0;

no need to explicitly initialize to 0


> +/*
> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> + * and map to MPIDR represented by GICC structure
> + */
> +static void __init
> +acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
> +{
> +    int i;
> +    u64 mpidr = processor->arm_mpidr & MPIDR_HWID_MASK;
> +    bool enabled = !!(processor->flags & ACPI_MADT_ENABLED);

bool_t


> +    if (mpidr == MPIDR_INVALID) {
> +        printk("Skip MADT cpu entry with invalid MPIDR\n");
> +        return;
> +    }

I am not sure which coding style we are supposed to follow in this file.
This is the Linux coding style, not the Xen coding style.


> +    total_cpus++;
> +    if (!enabled)
> +        return;
> +
> +    if (enabled_cpus >=  NR_CPUS) {

unnecessary space


> +        printk("NR_CPUS limit of %d reached, Processor %d/0x%"PRIx64" ignored.\n",
> +               NR_CPUS, total_cpus, mpidr);
> +        return;
> +    }
> +
> +    /* Check if GICC structure of boot CPU is available in the MADT */
> +    if (cpu_logical_map(0) == mpidr) {
> +        if (bootcpu_valid) {
> +            printk("Firmware bug, duplicate CPU MPIDR: 0x%"PRIx64" in MADT\n",
> +                   mpidr);
> +            return;
> +        }
> +
> +        bootcpu_valid = true;
> +    }
> +
> +    /*
> +     * Duplicate MPIDRs are a recipe for disaster. Scan
> +     * all initialized entries and check for
> +     * duplicates. If any is found just ignore the CPU.
> +     */
> +    for (i = 1; i < enabled_cpus; i++) {
> +        if (cpu_logical_map(i) == mpidr) {
> +            printk("Firmware bug, duplicate CPU MPIDR: 0x%"PRIx64" in MADT\n",
> +                   mpidr);
> +            return;
> +        }
> +    }

I would merge this loop with the previous if statement and just add one
cpu_logical_map(0) check to set bootcpu_valid.


> +    if (!acpi_psci_present())
> +        return;
> +
> +    /* CPU 0 was already initialized */
> +    if (enabled_cpus) {
> +        if (arch_cpu_init(enabled_cpus, NULL) < 0)
> +            return;
> +
> +        /* map the logical cpu id to cpu MPIDR */
> +        cpu_logical_map(enabled_cpus) = mpidr;
> +    }
> +
> +    enabled_cpus++;
> +}
> +
> +static int __init
> +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> +                             const unsigned long end)
> +{
> +    struct acpi_madt_generic_interrupt *processor;
> +
> +    processor = (struct acpi_madt_generic_interrupt *)header;

struct acpi_madt_generic_interrupt *processor =
		container_of(header, struct acpi_madt_generic_interrupt, header);


> +    if (BAD_MADT_ENTRY(processor, end))
> +        return -EINVAL;
> +
> +    acpi_table_print_madt_entry(header);
> +    acpi_map_gic_cpu_interface(processor);
> +    return 0;
> +}
> +
> +/* Parse GIC cpu interface entries in MADT for SMP init */
> +void __init acpi_smp_init_cpus(void)
> +{
> +    int count, i;
> +
> +    /*
> +     * do a partial walk of MADT to determine how many CPUs
> +     * we have including disabled CPUs, and get information
> +     * we need for SMP init
> +     */
> +    count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> +                    acpi_parse_gic_cpu_interface, 0);
> +
> +    if (count <= 0) {
> +        printk("Error parsing GIC CPU interface entry\n");
> +        return;
> +    }
> +
> +    if (!bootcpu_valid) {
> +        printk("MADT missing boot CPU MPIDR, not enabling secondaries\n");
> +        return;
> +    }
> +
> +    for (i = 0; i < enabled_cpus; i++)
> +        cpumask_set_cpu(i, &cpu_possible_map);
> +
> +    /* Make boot-up look pretty */
> +    printk("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
> +}
>  
>  static int __init acpi_parse_fadt(struct acpi_table_header *table)
>  {
> diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
> index 65f80b1..1efa29d 100644
> --- a/xen/include/asm-arm/acpi.h
> +++ b/xen/include/asm-arm/acpi.h
> @@ -33,9 +33,11 @@ extern bool_t acpi_disabled;
>  #ifdef CONFIG_ACPI
>  bool_t __init acpi_psci_present(void);
>  bool_t __init acpi_psci_hvc_present(void);
> +void __init acpi_smp_init_cpus(void);
>  #else
>  static inline bool_t acpi_psci_present(void) { return false; }
>  static inline bool_t acpi_psci_hvc_present(void) {return false; }
> +static inline void acpi_smp_init_cpus(void) { }
>  #endif /* CONFIG_ACPI */
>  
>  /* Basic configuration for ACPI */
> diff --git a/xen/include/xen/acpi.h b/xen/include/xen/acpi.h
> index 48d7810..723ece8 100644
> --- a/xen/include/xen/acpi.h
> +++ b/xen/include/xen/acpi.h
> @@ -39,6 +39,10 @@
>  #define ACPI_MADT_GET_POLARITY(inti)	ACPI_MADT_GET_(POLARITY, inti)
>  #define ACPI_MADT_GET_TRIGGER(inti)	ACPI_MADT_GET_(TRIGGER, inti)
>  
> +#define BAD_MADT_ENTRY(entry, end) (                                        \
> +                (!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
> +                ((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
> +
>  #ifdef CONFIG_ACPI_BOOT
>  
>  enum acpi_interrupt_id {
> -- 
> 2.1.0
> 
