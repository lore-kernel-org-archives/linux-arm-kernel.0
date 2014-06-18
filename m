From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Jun 2014 20:29:01 +0200
Subject: [PATCHv2 2/4] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1403024674-25108-3-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
 <1403024674-25108-3-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu9XJnFizEtOxyyXAdUH0OQgBjxuOeCV8FB5ajXtGe5gJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 17 June 2014 19:04, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently reading /proc/cpuinfo will result in information being read
> out of the MIDR_EL1 of the current CPU, and the information is not
> associated with any particular logical CPU number.
>
> This is problematic for systems with heterogeneous CPUs (i.e.
> big.LITTLE) where fields will vary across CPUs, and the output will
> differ depending on the executing CPU. Additionally the output is
> different in format to the 32-bit ARM Linux port, where information is
> printed out for each CPU.
>
> This patch adds the necessary infrastructure to log the relevant
> registers (currently just MIDR_EL1) and print out the logged
> information.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h | 30 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/Makefile   |  3 ++-
>  arch/arm64/kernel/cpuinfo.c  | 31 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c    | 46 +++++++++++++++++++++++---------------------
>  arch/arm64/kernel/smp.c      |  6 ++++++
>  5 files changed, 93 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cpu.h
>  create mode 100644 arch/arm64/kernel/cpuinfo.c
>
[...]
> @@ -447,38 +447,40 @@ static const char *hwcap_str[] = {
>
>  static int c_show(struct seq_file *m, void *v)
>  {
> -       int i;
> +       int c;
>
> -       seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> -                  cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
> +       for_each_online_cpu(c) {
> +               int i;
> +               struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, c);
> +               u32 midr = cpuinfo->reg_midr;
>
> -       for_each_online_cpu(i) {
>                 /*
>                  * glibc reads /proc/cpuinfo to determine the number of
>                  * online processors, looking for lines beginning with
>                  * "processor".  Give glibc what it expects.
>                  */
>  #ifdef CONFIG_SMP
> -               seq_printf(m, "processor\t: %d\n", i);
> +               seq_printf(m, "processor\t: %d\n", c);
>  #endif
> -       }
> +               seq_printf(m, "Type\t\t: %s rev %d (%s)\n",
> +                          cpu_name, MIDR_REVISION(midr), ELF_PLATFORM);
>
> -       /* dump out the processor features */
> -       seq_puts(m, "Features\t: ");
> +               /* dump out the processor features */
> +               seq_puts(m, "Features\t: ");
>
> -       for (i = 0; hwcap_str[i]; i++)
> -               if (elf_hwcap & (1 << i))
> -                       seq_printf(m, "%s ", hwcap_str[i]);
> +               for (i = 0; hwcap_str[i]; i++)
> +                       if (elf_hwcap & (1 << i))
> +                               seq_printf(m, "%s ", hwcap_str[i]);
>

Same question as first time around: does it really make sense to print
the value of elf_hwcap (whose value depends only on the capabilities
of the boot cpu) for every CPU listed?

Regards,
-- 
Ard.


> -       seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
> -       seq_printf(m, "CPU architecture: AArch64\n");
> -       seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
> -       seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
> -       seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
> +               seq_printf(m, "\nCPU implementer\t: 0x%02x\n",
> +                          MIDR_IMPLEMENTOR(midr));
> +               seq_printf(m, "CPU architecture: AArch64\n");
> +               seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
> +               seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
> +               seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
>
> -       seq_puts(m, "\n");
> -
> -       seq_printf(m, "Hardware\t: %s\n", machine_name);
> +               seq_puts(m, "\n");
> +       }
>
>         return 0;
>  }
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 40f38f4..7c730a6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -39,6 +39,7 @@
>
>  #include <asm/atomic.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/mmu_context.h>
> @@ -162,6 +163,11 @@ asmlinkage void secondary_start_kernel(void)
>         smp_store_cpu_info(cpu);
>
>         /*
> +        * Log the CPU info before it is marked online and might get read.
> +        */
> +       cpuinfo_store_cpu();
> +
> +       /*
>          * OK, now it's safe to let the boot CPU continue.  Wait for
>          * the CPU migration code to notice that the CPU is online
>          * before we continue.
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
