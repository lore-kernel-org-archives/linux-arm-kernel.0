From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Dec 2015 17:09:51 +0000
Subject: [PATCH v5] arm64: run-time detection for aarch32 support
In-Reply-To: <1450673050-12101-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450673050-12101-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151221170951.GA24894@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 07:44:10AM +0300, Yury Norov wrote:
> Kernel option COMPAT defines the ability of executing aarch32 binaries.
> Some platforms does not support aarch32 mode, and so cannot execute that
> binaries. But we cannot just disable COMPAT for them because the same
> kernel binary may be used by multiple platforms.
> 
> In this patch, system_supports_aarch32_el0() is introduced to detect
> aarch32 support at run-time.
> 
> v4: use new CPU Feature API.
> v5: use cpuid_feature_extract_field.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 7 +++++++
>  arch/arm64/include/asm/elf.h        | 6 ++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8f271b8..bcb0dbe 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -184,6 +184,13 @@ static inline bool system_supports_mixed_endian_el0(void)
>  	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
>  }
>  
> +static inline bool system_supports_aarch32_el0(void)
> +{
> +	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
> +	return cpuid_feature_extract_field(pfr0, ID_AA64PFR0_EL0_SHIFT)
> +						!= ID_AA64PFR0_EL0_64BIT_ONLY;
> +}

Suzuki already suggested to hook this into the existing arm64_features[]
array:

http://lkml.kernel.org/g/56748437.2040905 at arm.com

> +#define compat_elf_check_arch(x)	(system_supports_aarch32_el0()	\
> +					 && ((x)->e_machine == EM_ARM)	\
> +					 && ((x)->e_flags & EF_ARM_EABI_MASK))

And here use something like cpus_have_cap(ARM64_HAS_32BIT_EL0).

And a nitpick: please use the same convention for placing the "&&"
operator like in the rest of the file, i.e. on the previous line
(similarly for "!=" etc.)

-- 
Catalin
