From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 Jul 2015 18:12:21 +0100
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <1437063431.3583.2.camel@redhat.com>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com>
Message-ID: <20150716171221.GB18582@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:17:11PM +0100, Mark Salter wrote:
> On Wed, 2015-07-15 at 12:33 +0100, Lorenzo Pieralisi wrote:
> 
> > The SBBR and ACPI specifications allow ACPI based systems that do not
> > implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> > protocol specification[1].
> >
> > This patch implements the ACPI parking protocol CPU operations, and adds
> > code that eases parsing the parking protocol data structures to the
> > ARM64 SMP initializion carried out at the same time as cpus enumeration.
> >
> > To wake-up the CPUs from the parked state, this patch implements a
> > wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> > ARM one, so that a specific IPI is sent for wake-up purpose in order
> > to distinguish it from other IPI sources.
> >
> > Given the current ACPI MADT parsing API, the patch implements a glue
> > layer that helps passing MADT GICC data structure from SMP initialization
> 
> Somewhat off topic, but this reminds once again, that it might be
> better to generalize the ACPI_MADT_TYPE_GENERIC_INTERRUPT so that it
> could be done in one pass. Currently, the SMP code and the GIC code
> need boot-time info from ACPI_MADT_TYPE_GENERIC_INTERRUPT tables. This
> patch adds parking protocol, and this patch:
> 
>  https://lkml.org/lkml/2015/5/1/203
> 
> need to get the PMU irq from the same table. I've been thinking of
> something like a single loop through the table in setup.c with
> callouts to registered users of the various bits of data.

It is not off topic at all, it is bang on topic. I hate the code
as it stands forcing parsing the MADT in multiple places at different
times, that's why I added hooks to set the parking protocol entries
from smp.c and I know that's ugly, I posted it like this on purpose
to get feedback.

> Those users could register a handler function with something like an
> ACPI_MADT_GIC_DECLARE() macro which would add a handler to a
> special linker section.
> 
> I could work up a separate patch if others think it a worthwhile
> thing to do.

Something simpler ? Like stashing the GICC entries (I know we need
permanent table mappings for that to work unless we create data
structures out of the MADT entries with the fields we are interested in)
for possible CPUS ?

> > code to the parking protocol implementation somewhat overriding the CPU
> > operations interfaces. This to avoid creating a completely trasparent
>                                                              ^^^ transparent

Ok.

[...]

> > +static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
> > +{
> > +     struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> > +     struct parking_protocol_mailbox __iomem *mailbox;
> > +     __le32 cpu_id;
> > +
> > +     /*
> > +      * Map mailbox memory with attribute device nGnRE (ie ioremap -
> > +      * this deviates from the parking protocol specifications since
> > +      * the mailboxes are required to be mapped nGnRnE; the attribute
> > +      * discrepancy is harmless insofar as the protocol specification
> > +      * is concerned).
> > +      * If the mailbox is mistakenly allocated in the linear mapping
> > +      * by FW ioremap will fail since the mapping will be prevented
> > +      * by the kernel (it clashes with the linear mapping attributes
> > +      * specifications).
> > +      */
> > +     mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> > +     if (!mailbox)
> > +             return -EIO;
> > +
> > +     cpu_id = readl_relaxed(&mailbox->cpu_id);
> > +     /*
> > +      * Check if firmware has set-up the mailbox entry properly
> > +      * before kickstarting the respective cpu.
> > +      */
> > +     if (cpu_id != ~0U) {
> > +             iounmap(mailbox);
> > +             return -ENXIO;
> > +     }
> > +
> > +     /*
> > +      * We write the entry point and cpu id as LE regardless of the
> > +      * native endianness of the kernel. Therefore, any boot-loaders
> > +      * that read this address need to convert this address to the
> > +      * Boot-Loader's endianness before jumping.
> > +      */
> > +     writeq_relaxed(__pa(secondary_entry), &mailbox->entry_point);
> > +     writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
> > +
> > +     arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> > +
> > +     iounmap(mailbox);
> > +
> > +     return 0;
> > +}
> > +
> > +static void acpi_parking_protocol_cpu_postboot(void)
> > +{
> > +     int cpu = smp_processor_id();
> > +     struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> > +     struct parking_protocol_mailbox __iomem *mailbox;
> > +     __le64 entry_point;
> > +
> > +     /*
> > +      * Map mailbox memory with attribute device nGnRE (ie ioremap -
> > +      * this deviates from the parking protocol specifications since
> > +      * the mailboxes are required to be mapped nGnRnE; the attribute
> 
> Where is the nGnRnE requirement? I couldn't find it in the protocol doc.
> Just curious.

Page 11 (3.5 Mailbox Access Rules), in the Note
"...On ARM v8 Systems, the OS must map the memory as Device-nGnRnE".

> > +      * discrepancy is harmless insofar as the protocol specification
> > +      * is concerned).
> > +      * If the mailbox is mistakenly allocated in the linear mapping
> > +      * by FW ioremap will fail since the mapping will be prevented
> > +      * by the kernel (it clashes with the linear mapping attributes
> > +      * specifications).
> 
> The kernel will only add cached memory regions to linear mapping and
> presumably, the FW will mark the mailboxes as uncached. Otherwise, it
> is a FW bug. But I suppose we could run into problems with kernels
> using 64K pagesize since firmware assumes 4k.

Nope, ioremap takes care of that, everything should be fine.

Did you give this patch a go ?

Thanks,
Lorenzo

> > +      */
> > +     mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> > +     if (!mailbox)
> > +             return;
> > +
> > +     entry_point = readl_relaxed(&mailbox->entry_point);
> > +     /*
> > +      * Check if firmware has cleared the entry_point as expected
> > +      * by the protocol specification.
> > +      */
> > +     WARN_ON(entry_point);
> > +
> > +     iounmap(mailbox);
> > +}
> > +
> > +const struct cpu_operations acpi_parking_protocol_ops = {
> > +     .name           = "parking-protocol",
> > +     .cpu_init       = acpi_parking_protocol_cpu_init,
> > +     .cpu_prepare    = acpi_parking_protocol_cpu_prepare,
> > +     .cpu_boot       = acpi_parking_protocol_cpu_boot,
> > +     .cpu_postboot   = acpi_parking_protocol_cpu_postboot
> > +};
> > diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> > index 5ea337d..db31991 100644
> > --- a/arch/arm64/kernel/cpu_ops.c
> > +++ b/arch/arm64/kernel/cpu_ops.c
> > @@ -25,11 +25,12 @@
> >  #include <asm/smp_plat.h>
> >
> >  extern const struct cpu_operations smp_spin_table_ops;
> > +extern const struct cpu_operations acpi_parking_protocol_ops;
> >  extern const struct cpu_operations cpu_psci_ops;
> >
> >  const struct cpu_operations *cpu_ops[NR_CPUS];
> >
> > -static const struct cpu_operations *supported_cpu_ops[] __initconst = {
> > +static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
> >  #ifdef CONFIG_SMP
> >       &smp_spin_table_ops,
> >  #endif
> > @@ -37,9 +38,19 @@ static const struct cpu_operations *supported_cpu_ops[] __initconst = {
> >       NULL,
> >  };
> >
> > +static const struct cpu_operations *acpi_supported_cpu_ops[] __initconst = {
> > +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> > +     &acpi_parking_protocol_ops,
> > +#endif
> > +     &cpu_psci_ops,
> > +     NULL,
> > +};
> > +
> >  static const struct cpu_operations * __init cpu_get_ops(const char *name)
> >  {
> > -     const struct cpu_operations **ops = supported_cpu_ops;
> > +     const struct cpu_operations **ops;
> > +
> > +     ops = acpi_disabled ? dt_supported_cpu_ops : acpi_supported_cpu_ops;
> >
> >       while (*ops) {
> >               if (!strcmp(name, (*ops)->name))
> > @@ -77,8 +88,16 @@ static const char *__init cpu_read_enable_method(int cpu)
> >               }
> >       } else {
> >               enable_method = acpi_get_enable_method(cpu);
> > -             if (!enable_method)
> > -                     pr_err("Unsupported ACPI enable-method\n");
> > +             if (!enable_method) {
> > +                     /*
> > +                      * In ACPI systems the boot CPU does not require
> > +                      * checking the enable method since for some
> > +                      * boot protocol (ie parking protocol) it need not
> > +                      * be initialized. Don't warn spuriously.
> > +                      */
> > +                     if (cpu != 0)
> > +                             pr_err("Unsupported ACPI enable-method\n");
> > +             }
> >       }
> >
> >       return enable_method;
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 50fb469..1d98f2d 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -69,6 +69,7 @@ enum ipi_msg_type {
> >       IPI_CPU_STOP,
> >       IPI_TIMER,
> >       IPI_IRQ_WORK,
> > +     IPI_WAKEUP
> >  };
> >
> >  /*
> > @@ -428,6 +429,8 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
> >       /* map the logical cpu id to cpu MPIDR */
> >       cpu_logical_map(cpu_count) = hwid;
> >
> > +     acpi_set_mailbox_entry(cpu_count, processor);
> > +
> >       cpu_count++;
> >  }
> >
> > @@ -610,6 +613,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
> >       S(IPI_CPU_STOP, "CPU stop interrupts"),
> >       S(IPI_TIMER, "Timer broadcast interrupts"),
> >       S(IPI_IRQ_WORK, "IRQ work interrupts"),
> > +     S(IPI_WAKEUP, "CPU wakeup interrupts"),
> >  };
> >
> >  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> > @@ -653,6 +657,13 @@ void arch_send_call_function_single_ipi(int cpu)
> >       smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
> >  }
> >
> > +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> > +void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> > +{
> > +     smp_cross_call(mask, IPI_WAKEUP);
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_IRQ_WORK
> >  void arch_irq_work_raise(void)
> >  {
> > @@ -729,6 +740,8 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
> >               irq_exit();
> >               break;
> >  #endif
> > +     case IPI_WAKEUP:
> > +             break;
> >
> >       default:
> >               pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
> 
