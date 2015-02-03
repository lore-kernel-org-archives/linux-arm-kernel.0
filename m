From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Feb 2015 13:53:48 +0000
Subject: [PATCH v8 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <1422881149-8177-14-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-14-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150203135348.GA31837@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:45:41PM +0000, Hanjun Guo wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map.
>
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> Parking protocol, but the Parking protocol is only specified for
> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> before some updates for the ACPI spec or the Parking protocol spec.
>
> Parking protocol patches for SMP boot will be sent to upstream when
> the new version of Parking protocol is ready.
>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h    |   2 +
>  arch/arm64/include/asm/cpu_ops.h |   1 +
>  arch/arm64/include/asm/smp.h     |   5 +-
>  arch/arm64/kernel/acpi.c         | 150 ++++++++++++++++++++++++++++++++++++++-
>  arch/arm64/kernel/cpu_ops.c      |   2 +-
>  arch/arm64/kernel/setup.c        |   7 +-
>  arch/arm64/kernel/smp.c          |   2 +-
>  7 files changed, 161 insertions(+), 8 deletions(-)

[...]

> +/**
> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> + * and map to MPIDR represented by GICC structure
> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logical cpu number which maps to MPIDR
> + */
> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
> +{
> +       int cpu;
> +
> +       if (mpidr == INVALID_HWID) {
> +               pr_info("Skip MADT cpu entry with invalid MPIDR\n");
> +               return -EINVAL;
> +       }
> +
> +       total_cpus++;
> +       if (!enabled)
> +               return -EINVAL;
> +
> +       if (enabled_cpus >=  NR_CPUS) {
> +               pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
> +                       NR_CPUS, total_cpus, mpidr);
> +               return -EINVAL;
> +       }
> +
> +       /* No need to check duplicate MPIDRs for the first CPU */
> +       if (enabled_cpus) {
> +               /*
> +                * Duplicate MPIDRs are a recipe for disaster. Scan
> +                * all initialized entries and check for
> +                * duplicates. If any is found just ignore the CPU.
> +                */
> +               for_each_possible_cpu(cpu) {
> +                       if (cpu_logical_map(cpu) == mpidr) {
> +                               pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
> +                                      mpidr);
> +                               return -EINVAL;
> +                       }
> +               }
> +
> +               /* allocate a logical cpu id for the new comer */
> +               cpu = cpumask_next_zero(-1, cpu_possible_mask);
> +       } else {
> +               /*
> +                * First GICC entry must be BSP as ACPI spec said
> +                * in section 5.2.12.15
> +                */
> +               if  (cpu_logical_map(0) != mpidr) {
> +                       pr_err("First GICC entry with MPIDR 0x%llx is not BSP\n",
> +                              mpidr);
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * boot_cpu_init() already hold bit 0 in cpu_possible_mask
> +                * for BSP, no need to allocate again.
> +                */
> +               cpu = 0;
> +       }

If/when kexec comes, on systems where CPU0 can be hotplugged the next
kernel might boot on an AP rather than the BSP. Is there a requirement
Linux-side that CPU0 is the BSP, or is this just intended as a sanity
check of the tables the FW provided?

> +
> +       if (!acpi_psci_present())
> +               return -EOPNOTSUPP;
> +
> +       cpu_ops[cpu] = cpu_get_ops("psci");
> +       /* CPU 0 was already initialized */
> +       if (cpu) {
> +               if (!cpu_ops[cpu])
> +                       return -EINVAL;
> +
> +               if (cpu_ops[cpu]->cpu_init(NULL, cpu))
> +                       return -EOPNOTSUPP;
> +
> +               /* map the logical cpu id to cpu MPIDR */
> +               cpu_logical_map(cpu) = mpidr;
> +
> +               set_cpu_possible(cpu, true);
> +       }

In the OF case we only set CPUs possible once we've scanned all the
nodes, and only when the boot CPU was actually found in a table. We
should keep the ACPI case consistent with that.

Can we not handle all of this in a later call once we've scanned all of
the GICC structures?

[...]

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 43ae914..1099ddc 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -449,13 +449,16 @@ void __init setup_arch(char **cmdline_p)
>         if (acpi_disabled) {
>                 unflatten_device_tree();
>                 psci_dt_init();
> +               cpu_read_bootcpu_ops();
> +#ifdef CONFIG_SMP
> +               of_smp_init_cpus();
> +#endif

I was going to say that it would be a little nicer if we had empty stubs
for functions in the !SMP case, rather than #ifdefs all over the place.
Unfortunately it looks like the way asm/smp.h is handled is generally a
mess, so this isn't so bad for now.

Thanks,
Mark.
