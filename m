From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 23 Mar 2015 17:11:02 +0000
Subject: [PATCH v5 1/8] arm64: Get rid of struct cpu_table
In-Reply-To: <1426690527-14258-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <55104926.1060901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/15 14:55, Ard Biesheuvel wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
>
> struct cpu_table is an artifact left from the (very) early days of
> the arm64 port, and its only real use is to allow the most beautiful
> "AArch64 Processor" string to be displayed at boot time.
>
> Really? Yes, really.
>
> Let's get rid of it. In order to avoid another BogoMips-gate, the
> aforementioned string is preserved.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>   arch/arm64/include/asm/cputable.h | 30 ----------------
>   arch/arm64/kernel/Makefile        |  2 +-
>   arch/arm64/kernel/asm-offsets.c   |  4 ---
>   arch/arm64/kernel/cputable.c      | 33 -----------------
>   arch/arm64/kernel/head.S          | 76 +++------------------------------------
>   arch/arm64/kernel/setup.c         | 16 ++-------
>   6 files changed, 8 insertions(+), 153 deletions(-)
>   delete mode 100644 arch/arm64/include/asm/cputable.h
>   delete mode 100644 arch/arm64/kernel/cputable.c
...
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -50,7 +50,6 @@
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
>   #include <asm/elf.h>
> -#include <asm/cputable.h>
>   #include <asm/cpufeature.h>
>   #include <asm/cpu_ops.h>
>   #include <asm/sections.h>
> @@ -83,7 +82,6 @@ unsigned int compat_elf_hwcap2 __read_mostly;
>
>   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>
> -static const char *cpu_name;
>   phys_addr_t __fdt_pointer __initdata;
>
>   /*
> @@ -209,22 +207,12 @@ static void __init smp_build_mpidr_hash(void)
>
>   static void __init setup_processor(void)
>   {
> -       struct cpu_info *cpu_info;
>          u64 features, block;
>          u32 cwg;
>          int cls;
>
> -       cpu_info = lookup_processor_type(read_cpuid_id());
> -       if (!cpu_info) {
> -               printk("CPU configuration botched (ID %08x), unable to continue.\n",
> -                      read_cpuid_id());
> -               while (1);
> -       }
> -
> -       cpu_name = cpu_info->cpu_name;
> -
> -       printk("CPU: %s [%08x] revision %d\n",
> -              cpu_name, read_cpuid_id(), read_cpuid_id() & 15);
> +       printk("CPU: AArch64 Processor [%08x] revision %d\n",
> +              read_cpuid_id(), read_cpuid_id() & 15);
>

While we are at it, does it make sense to change

  s/CPU/Boot CPU/

to make it clear on a big.Little system ?

Suzuki
