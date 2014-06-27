From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Jun 2014 19:35:06 +0200
Subject: [PATCHv3 3/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1403795926-17139-4-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-4-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu_LYZMiZCaEwoQWGEY6uEnZVGumz5HJaWicXpp6jN58Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2014 17:18, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently reading /proc/cpuinfo will result in information being read
> out of the MIDR_EL1 of the current CPU, and the information is not
> associated with any particular logical CPU number.
>
> This is problematic for systems with heterogeneous CPUs (i.e.
> big.LITTLE) where fields will vary across CPUs, and the output will
> differ depending on the executing CPU.
>
> This patch reorganises the code responsible for /proc/cpuinfo to print
> information per-cpu. As hwcaps are expected to be identical across all
> CPUs, this information is printed once.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/kernel/setup.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d..b00b7a3 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -448,20 +448,30 @@ static const char *hwcap_str[] = {
>
>  static int c_show(struct seq_file *m, void *v)
>  {
> -       int i;
> +       int c, i;
>
> -       seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> -                  cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
> +       for_each_online_cpu(c) {
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
> +               seq_printf(m, "Type\t\t: %s rev %d (%s)\n",
> +                          cpu_name, MIDR_REVISION(midr), ELF_PLATFORM);
> +               seq_printf(m, "CPU implementer\t: 0x%02x\n",
> +                          MIDR_IMPLEMENTOR(midr));
> +               seq_printf(m, "CPU architecture: AArch64\n");
> +               seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
> +               seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
> +               seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
> +
> +               seq_puts(m, "\n");
>         }
>
>         /* dump out the processor features */
> @@ -470,17 +480,8 @@ static int c_show(struct seq_file *m, void *v)
>         for (i = 0; hwcap_str[i]; i++)
>                 if (elf_hwcap & (1 << i))
>                         seq_printf(m, "%s ", hwcap_str[i]);
> -
> -       seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
> -       seq_printf(m, "CPU architecture: AArch64\n");
> -       seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
> -       seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
> -       seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
> -
>         seq_puts(m, "\n");
>
> -       seq_printf(m, "Hardware\t: %s\n", machine_name);
> -
>         return 0;
>  }
>
> --
> 1.9.1
>
