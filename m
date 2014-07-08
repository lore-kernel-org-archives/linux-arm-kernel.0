From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Jul 2014 22:42:17 +0100
Subject: [PATCH] arm64: Get the number of bits in ASID from the CPU
In-Reply-To: <1404846860-15055-1-git-send-email-amartin@nvidia.com>
References: <1404846860-15055-1-git-send-email-amartin@nvidia.com>
Message-ID: <FDB72495-5071-4A82-A7D0-17BA1DF10D84@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 Jul 2014, at 20:14, Allen Martin <amartin@nvidia.com> wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Instead of hard coding the number of ASID bits to 16, read the value
> from the CPU through the register ID_AA64MMFR0_EL1 at boot time.  This
> is required on Tegra132 Denver CPU which implements 8 bits.

Did you actually find a bug in the existing code?

> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
[?]
> @@ -219,6 +220,16 @@ static void __init setup_processor(void)
> 	sprintf(init_utsname()->machine, ELF_PLATFORM);
> 	elf_hwcap = 0;
> 
> +	/* Read the number of ASID bits */
> +	reg_value = read_cpuid(ID_AA64MMFR0_EL1) & 0xf0;
> +	if (reg_value == 0x00)
> +		max_asid_bits = 8;
> +	else if (reg_value == 0x20)
> +		max_asid_bits = 16;
> +	else
> +		BUG_ON(1);
> +	cpu_last_asid = 1 << max_asid_bits;

There is even a macro called asid_bits() in arch/arm64/mm/context.c.

> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
[?]
> 
> @@ -142,9 +141,9 @@ void __new_context(struct mm_struct *mm)
> 	 */
> 	if (unlikely((asid & ((1 << bits) - 1)) == 0)) {

That?s the part where it uses the actual number of bits supported by
the hardware (bits is computed higher up in this function based on
ID_AA64MMFR0_EL1).

> 		/* increment the ASID version */
> -		cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);

And here it bumps the generation@bit 16 onwards.

So unless you find some bug in the existing logic, I don?t think your
patch is needed.

Catalin
