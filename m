From: will.deacon@arm.com (Will Deacon)
Date: Sun, 17 Mar 2013 14:36:24 +0000
Subject: [PATCH 2/3] ARM: Detect support for SDIV/UDIV from ISAR0 register
In-Reply-To: <1363138321-27849-3-git-send-email-sboyd@codeaurora.org>
References: <1363138321-27849-1-git-send-email-sboyd@codeaurora.org>
 <1363138321-27849-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130317143624.GE19071@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 01:32:00AM +0000, Stephen Boyd wrote:
> The ISAR0 register indicates support for the SDIV and UDIV
> instructions in both the Thumb and ARM instruction set. Read the
> register to detect the supported instructions and update the
> elf_hwcap mask as appropriate. This is better than adding more
> and more cpuid checks in proc-v7.S for each new cpu variant that
> supports these instructions.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/setup.c | 20 ++++++++++++++++++++
>  arch/arm/mm/proc-v7.S   |  4 ++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e2c8bbf..bd27a70 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -353,6 +353,23 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +static void __init idiv_setup(void)
> +{
> +	unsigned int divide_instrs;
> +
> +	if (cpu_architecture() < CPU_ARCH_ARMv7)
> +		return;
> +
> +	divide_instrs = (read_cpuid_ext(CPUID_EXT_ISAR0) & 0x0f000000) >> 24;
> +
> +	switch (divide_instrs) {
> +	case 2:
> +		elf_hwcap |= HWCAP_IDIVA;
> +	case 1:
> +		elf_hwcap |= HWCAP_IDIVT;
> +	}
> +}
> +
>  static void __init feat_v6_fixup(void)
>  {
>  	int id = read_cpuid_id();
> @@ -483,6 +500,9 @@ static void __init setup_processor(void)
>  	snprintf(elf_platform, ELF_PLATFORM_SIZE, "%s%c",
>  		 list->elf_name, ENDIANNESS);
>  	elf_hwcap = list->elf_hwcap;
> +
> +	idiv_setup();

Perhaps give this a more generic name (cpuid_init_hwcaps) so we can add more
probing later on (we could probe swp, for example).

With that minor change:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
