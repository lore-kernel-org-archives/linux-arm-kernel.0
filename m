From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Fri, 11 Oct 2013 18:22:34 +0530
Subject: [RFC PATCH 3/4] ARM64: Big Endian fixes for kernel booting
In-Reply-To: <1381494135-15085-4-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
 <1381494135-15085-4-git-send-email-ankit.jindal@linaro.org>
Message-ID: <CAPTm99W30nDDR0bLLy7vs+CDJ9apOxTOn9Wxi_9VRW9kixEQNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2013 17:52, Ankit Jindal <ankit.jindal@linaro.org> wrote:
>
> - Enable appropriate bits for big endian kernel in SYSCTLR.EL2 and
>   SYSCTLR.EL1 registers
> - Swap entry point for secondary core for big endian kernel
> - Set machine type to "aarch64b" for big endian and "aarch64l"
>   for little endian.
>
> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
> ---
>  arch/arm64/include/asm/assembler.h |    7 +++++++
>  arch/arm64/kernel/head.S           |   34 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/setup.c          |   19 +++++++++++++++----
>  arch/arm64/kernel/smp_spin_table.c |    5 +++--
>  arch/arm64/mm/proc.S               |    2 +-
>  5 files changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 5aceb83..473faf3 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -22,6 +22,13 @@
>
>  #include <asm/ptrace.h>
>
> +/* Select code for any configuration running in BE mode */
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define ARM_BE(code...) code
> +#else
> +#define ARM_BE(code...)
> +#endif
> +
>  /*
>   * Stack pushing/popping (register pairs only). Equivalent to store decrement
>   * before, load increment after.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 7090c12..45dc50d 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -122,6 +122,7 @@
>         .word   0                               // reserved
>
>  ENTRY(stext)
> +       ARM_BE(bl      setend_be)
>         mov     x21, x0                         // x21=FDT
>         bl      __calc_phys_offset              // x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
>         bl      el2_setup                       // Drop to EL1
> @@ -148,6 +149,34 @@ ENTRY(stext)
>  ENDPROC(stext)
>
>  /*
> + * Set el0-el1-el2 to Big endian
> + */
> +
> +#if defined(CONFIG_CPU_BIG_ENDIAN)
> +ENTRY(setend_be)
> +       mrs     x21, CurrentEL
> +        cmp     x21, #PSR_MODE_EL2t
> +       b.ne    setend_be_el1_el0
> +
> +setend_be_el2:
> +       mrs     x21, sctlr_el2
> +        mov     x22, #(1<<25)
> +        orr     x21, x21, x22
> +        msr     sctlr_el2, x21
> +       isb
> +
> +setend_be_el1_el0:
> +       mrs     x21, sctlr_el1
> +        mov     x22, #(3<<24)
> +        orr     x21, x21, x22
> +        msr     sctlr_el1, x21
> +       isb
> +
> +       ret
> +ENDPROC(setend_be)
> +#endif /* defined(CONFIG_CPU_BIG_ENDIAN) */
> +
> +/*
>   * If we're fortunate enough to boot at EL2, ensure that the world is
>   * sane before dropping to EL1.
>   */
> @@ -181,7 +210,11 @@ ENTRY(el2_setup)
>
>         /* sctlr_el1 */
>         mov     x0, #0x0800                     // Set/clear RES{1,0} bits
> +#if defined(CONFIG_CPU_BIG_ENDIAN)
> +       movk    x0, #0x33d0, lsl #16
> +#else
>         movk    x0, #0x30d0, lsl #16
> +#endif
>         msr     sctlr_el1, x0
>
>         /* Coprocessor traps. */
> @@ -235,6 +268,7 @@ ENTRY(__boot_cpu_mode)
>          * cores are held until we're ready for them to initialise.
>          */
>  ENTRY(secondary_holding_pen)
> +       ARM_BE(bl       setend_be)
>         bl      __calc_phys_offset              // x24=phys offset
>         bl      el2_setup                       // Drop to EL1
>         mrs     x0, mpidr_el1
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 055cfb8..d47ae6d 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -64,6 +64,9 @@ static const char *cpu_name;
>  static const char *machine_name;
>  phys_addr_t __fdt_pointer __initdata;
>
> +static union { char c[8]; unsigned long l; } endian_test = { { 'l', '?', '?',  '?', '?', '?', '?','b' } };
> +#define ENDIANNESS ((char)endian_test.l)
> +
>  /*
>   * Standard memory resources
>   */
> @@ -117,8 +120,10 @@ static void __init setup_processor(void)
>
>         printk("CPU: %s [%08x] revision %d\n",
>                cpu_name, read_cpuid_id(), read_cpuid_id() & 15);
> -
> -       sprintf(init_utsname()->machine, "aarch64");
> +
> +       snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
> +                 "aarch64", ENDIANNESS);
> +
>         elf_hwcap = 0;
>  }
>
> @@ -310,9 +315,15 @@ static const char *hwcap_str[] = {
>  static int c_show(struct seq_file *m, void *v)
>  {
>         int i;
> +#if 0
> +       int num = 1;
> +       char c;
> +       char *cptr = (char *)&num;
> +       c = (*cptr) ? 'l' : 'b';
> +#endif

Oops, forgot to remove this #if 0. Please ignore this small change.

>
> -       seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> -                  cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
> +       seq_printf(m, "Processor\t: %s rev %d (%s%c)\n",
> +                  cpu_name, read_cpuid_id() & 15, ELF_PLATFORM, ENDIANNESS);
>
>         for_each_online_cpu(i) {
>                 /*
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index 7c35fa6..7ad68bc 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -46,9 +46,10 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
>
>         if (!cpu_release_addr[cpu])
>                 return -ENODEV;
> -
> +
>         release_addr = __va(cpu_release_addr[cpu]);
> -       release_addr[0] = (void *)__pa(secondary_holding_pen);
> +       release_addr[0] = (void *)cpu_to_le64(__pa(secondary_holding_pen));
> +
>         __flush_dcache_area(release_addr, sizeof(release_addr[0]));
>
>         /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index b1b31bb..380a707 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -166,5 +166,5 @@ ENDPROC(__cpu_setup)
>          */
>         .type   crval, #object
>  crval:
> -       .word   0x030802e2                      // clear
> +       .word   0x000802e2                      // clear
>         .word   0x0405d11d                      // set
> --
> 1.7.9.5
>
