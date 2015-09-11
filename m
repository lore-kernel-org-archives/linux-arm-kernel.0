From: msalter@redhat.com (Mark Salter)
Date: Fri, 11 Sep 2015 09:30:55 -0400
Subject: [PATCH v2] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <1441906822-9222-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1441906822-9222-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1441978255.18796.12.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-10 at 18:40 +0100, Lorenzo Pieralisi wrote:
> The SBBR and ACPI specifications allow ACPI based systems that do not
> implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> protocol specification[1].
> 
> This patch implements the ACPI parking protocol CPU operations, and adds
> code that eases parsing the parking protocol data structures to the
> ARM64 SMP initializion carried out at the same time as cpus enumeration.
> 
> To wake-up the CPUs from the parked state, this patch implements a
> wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> ARM one, so that a specific IPI is sent for wake-up purpose in order
> to distinguish it from other IPI sources.
> 
> Given the current ACPI MADT parsing API, the patch implements a glue
> layer that helps passing MADT GICC data structure from SMP initialization
> code to the parking protocol implementation somewhat overriding the CPU
> operations interfaces. This to avoid creating a completely trasparent
> DT/ACPI CPU operations layer that would require creating opaque
> structure handling for CPUs data (DT represents CPU through DT nodes, ACPI
> through static MADT table entries), which seems overkill given that ACPI
> on ARM64 mandates only two booting protocols (PSCI and parking protocol),
> so there is no need for further protocol additions.
> 
> Based on the original work by Mark Salter <msalter@redhat.com>
> 
> [1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Al Stone <ahs3@redhat.com>
> ---
> v1->v2
> 
> - Rebased against v4.2
> - Made config option visible and disabled by default
> - Removed SMP dependency (it was removed from arm64)
> - Updated some comments
> - Clarified 64k page mailbox alignment and requested UEFI specs update
> 
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356750.html
> 
>  arch/arm64/Kconfig                        |   9 ++
>  arch/arm64/include/asm/acpi.h             |  19 +++-
>  arch/arm64/include/asm/hardirq.h          |   2 +-
>  arch/arm64/include/asm/smp.h              |   9 ++
>  arch/arm64/kernel/Makefile                |   1 +
>  arch/arm64/kernel/acpi_parking_protocol.c | 153 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpu_ops.c               |  27 +++++-
>  arch/arm64/kernel/smp.c                   |  22 +++++
>  8 files changed, 236 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/kernel/acpi_parking_protocol.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7d95663..994e12c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -414,6 +414,15 @@ config HOTPLUG_CPU
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.
>  
> +config ARM64_ACPI_PARKING_PROTOCOL
> +	bool "Enable support for the ARM64 ACPI parking protocol"
> +	depends on ACPI
> +	help
> +	  Enable support for the ARM64 ACPI parking protocol. If disabled
> +	  the kernel will not allow booting through the ARM64 ACPI parking
> +	  protocol even if the corresponding data is present in the ACPI
> +	  MADT table.
> +
>  source kernel/Kconfig.preempt
>  
>  config HZ
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 208cec0..2659291 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -88,8 +88,25 @@ void __init acpi_init_cpus(void);
>  static inline void acpi_init_cpus(void) { }
>  #endif /* CONFIG_ACPI */
>  
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +bool acpi_parking_protocol_valid(int cpu);
> +void __init
> +acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor);
> +#else
> +static inline bool acpi_parking_protocol_valid(int cpu) { return false; }
> +static inline void
> +acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
> +{}
> +#endif
> +
>  static inline const char *acpi_get_enable_method(int cpu)
>  {
> -	return acpi_psci_present() ? "psci" : NULL;
> +	if (acpi_psci_present())
> +		return "psci";
> +
> +	if (acpi_parking_protocol_valid(cpu))
> +		return "parking-protocol";
> +
> +	return NULL;
>  }
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
> index 2bb7009..0af4cdb 100644
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -20,7 +20,7 @@
>  #include <linux/threads.h>
>  #include <asm/irq.h>
>  
> -#define NR_IPI	5
> +#define NR_IPI	6
>  
>  typedef struct {
>  	unsigned int __softirq_pending;
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index d9c3d6a..2013a4d 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -64,6 +64,15 @@ extern void secondary_entry(void);
>  extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
>  
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> +#else
> +static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> +{
> +	BUILD_BUG();
> +}
> +#endif
> +
>  extern int __cpu_disable(void);
>  
>  extern void __cpu_die(unsigned int cpu);
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 22dc9bc..25edbf5 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>  arm64-obj-$(CONFIG_ACPI)		+= acpi.o
> +arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> new file mode 100644
> index 0000000..531c3ad
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -0,0 +1,153 @@
> +/*
> + * ARM64 ACPI Parking Protocol implementation
> + *
> + * Authors: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *	    Mark Salter <msalter@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/acpi.h>
> +#include <linux/types.h>
> +
> +#include <asm/cpu_ops.h>
> +
> +struct cpu_mailbox_entry {
> +	phys_addr_t mailbox_addr;
> +	u8 version;
> +	u8 gic_cpu_id;
        ^^^
Shouldn't that be u32?

> +};
> +
> +static struct cpu_mailbox_entry cpu_mailbox_entries[NR_CPUS];
> +
> +void __init acpi_set_mailbox_entry(int cpu,
> +				   struct acpi_madt_generic_interrupt *p)
> +{
> +	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +
> +	cpu_entry->mailbox_addr = p->parked_address;
> +	cpu_entry->version = p->parking_version;
> +	cpu_entry->gic_cpu_id = p->cpu_interface_number;
> +}
> +
> +bool __init acpi_parking_protocol_valid(int cpu)
> +{
> +	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +
> +	return cpu_entry->mailbox_addr && cpu_entry->version;
> +}
> +
> +static int acpi_parking_protocol_cpu_init(unsigned int cpu)
> +{
> +	pr_debug("%s: ACPI parked addr=%llx\n", __func__,
> +		  cpu_mailbox_entries[cpu].mailbox_addr);
> +
> +	return 0;
> +}
> +
> +static int acpi_parking_protocol_cpu_prepare(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +struct parking_protocol_mailbox {
> +	__le32 cpu_id;
> +	__le32 reserved;
> +	__le64 entry_point;
> +};
> +
> +static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
> +{
> +	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +	struct parking_protocol_mailbox __iomem *mailbox;
> +	__le32 cpu_id;
> +
> +	/*
> +	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
> +	 * this deviates from the parking protocol specifications since
> +	 * the mailboxes are required to be mapped nGnRnE; the attribute
> +	 * discrepancy is harmless insofar as the protocol specification
> +	 * is concerned).
> +	 * If the mailbox is mistakenly allocated in the linear mapping
> +	 * by FW ioremap will fail since the mapping will be prevented
> +	 * by the kernel (it clashes with the linear mapping attributes
> +	 * specifications).
> +	 */
> +	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> +	if (!mailbox)
> +		return -EIO;
> +
> +	cpu_id = readl_relaxed(&mailbox->cpu_id);
> +	/*
> +	 * Check if firmware has set-up the mailbox entry properly
> +	 * before kickstarting the respective cpu.
> +	 */
> +	if (cpu_id != ~0U) {
> +		iounmap(mailbox);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * We write the entry point and cpu id as LE regardless of the
> +	 * native endianness of the kernel. Therefore, any boot-loaders
> +	 * that read this address need to convert this address to the
> +	 * Boot-Loader's endianness before jumping.
> +	 */
> +	writeq_relaxed(__pa(secondary_entry), &mailbox->entry_point);
> +	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
> +
> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +	iounmap(mailbox);
> +
> +	return 0;
> +}
> +
> +static void acpi_parking_protocol_cpu_postboot(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> +	struct parking_protocol_mailbox __iomem *mailbox;
> +	__le64 entry_point;
> +
> +	/*
> +	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
> +	 * this deviates from the parking protocol specifications since
> +	 * the mailboxes are required to be mapped nGnRnE; the attribute
> +	 * discrepancy is harmless insofar as the protocol specification
> +	 * is concerned).
> +	 * If the mailbox is mistakenly allocated in the linear mapping
> +	 * by FW ioremap will fail since the mapping will be prevented
> +	 * by the kernel (it clashes with the linear mapping attributes
> +	 * specifications).
> +	 */
> +	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> +	if (!mailbox)
> +		return;
> +
> +	entry_point = readl_relaxed(&mailbox->entry_point);
> +	/*
> +	 * Check if firmware has cleared the entry_point as expected
> +	 * by the protocol specification.
> +	 */
> +	WARN_ON(entry_point);
> +
> +	iounmap(mailbox);
> +}
> +
> +const struct cpu_operations acpi_parking_protocol_ops = {
> +	.name		= "parking-protocol",
> +	.cpu_init	= acpi_parking_protocol_cpu_init,
> +	.cpu_prepare	= acpi_parking_protocol_cpu_prepare,
> +	.cpu_boot	= acpi_parking_protocol_cpu_boot,
> +	.cpu_postboot	= acpi_parking_protocol_cpu_postboot
> +};
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index b6bd7d4..c7cfb8f 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -25,19 +25,30 @@
>  #include <asm/smp_plat.h>
>  
>  extern const struct cpu_operations smp_spin_table_ops;
> +extern const struct cpu_operations acpi_parking_protocol_ops;
>  extern const struct cpu_operations cpu_psci_ops;
>  
>  const struct cpu_operations *cpu_ops[NR_CPUS];
>  
> -static const struct cpu_operations *supported_cpu_ops[] __initconst = {
> +static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
>  	&smp_spin_table_ops,
>  	&cpu_psci_ops,
>  	NULL,
>  };
>  
> +static const struct cpu_operations *acpi_supported_cpu_ops[] __initconst = {
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +	&acpi_parking_protocol_ops,
> +#endif
> +	&cpu_psci_ops,
> +	NULL,
> +};
> +
>  static const struct cpu_operations * __init cpu_get_ops(const char *name)
>  {
> -	const struct cpu_operations **ops = supported_cpu_ops;
> +	const struct cpu_operations **ops;
> +
> +	ops = acpi_disabled ? dt_supported_cpu_ops : acpi_supported_cpu_ops;
>  
>  	while (*ops) {
>  		if (!strcmp(name, (*ops)->name))
> @@ -75,8 +86,16 @@ static const char *__init cpu_read_enable_method(int cpu)
>  		}
>  	} else {
>  		enable_method = acpi_get_enable_method(cpu);
> -		if (!enable_method)
> -			pr_err("Unsupported ACPI enable-method\n");
> +		if (!enable_method) {
> +			/*
> +			 * In ACPI systems the boot CPU does not require
> +			 * checking the enable method since for some
> +			 * boot protocol (ie parking protocol) it need not
> +			 * be initialized. Don't warn spuriously.
> +			 */
> +			if (cpu != 0)
> +				pr_err("Unsupported ACPI enable-method\n");
> +		}
>  	}
>  
>  	return enable_method;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index dbdaacd..0e20a56 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -70,6 +70,7 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_TIMER,
>  	IPI_IRQ_WORK,
> +	IPI_WAKEUP
>  };
>  
>  /*
> @@ -441,6 +442,17 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>  	/* map the logical cpu id to cpu MPIDR */
>  	cpu_logical_map(cpu_count) = hwid;
>  
> +	/*
> +	 * Set-up the ACPI parking protocol cpu entries
> +	 * while initializing the cpu_logical_map to
> +	 * avoid parsing MADT entries multiple times for
> +	 * nothing (ie a valid cpu_logical_map entry should
> +	 * contain a valid parking protocol data set to
> +	 * initialize the cpu if the parking protocol is
> +	 * the only available enable method).
> +	 */
> +	acpi_set_mailbox_entry(cpu_count, processor);
> +
>  	cpu_count++;
>  }
>  
> @@ -623,6 +635,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>  	S(IPI_CPU_STOP, "CPU stop interrupts"),
>  	S(IPI_TIMER, "Timer broadcast interrupts"),
>  	S(IPI_IRQ_WORK, "IRQ work interrupts"),
> +	S(IPI_WAKEUP, "CPU wakeup interrupts"),
>  };
>  
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> @@ -666,6 +679,13 @@ void arch_send_call_function_single_ipi(int cpu)
>  	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
>  }
>  
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> +{
> +	smp_cross_call(mask, IPI_WAKEUP);
> +}
> +#endif
> +
>  #ifdef CONFIG_IRQ_WORK
>  void arch_irq_work_raise(void)
>  {
> @@ -742,6 +762,8 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		irq_exit();
>  		break;
>  #endif
> +	case IPI_WAKEUP:
> +		break;
>  
>  	default:
>  		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
