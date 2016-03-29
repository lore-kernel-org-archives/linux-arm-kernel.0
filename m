From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 29 Mar 2016 12:29:40 +0100
Subject: [RFC PATCH 2/3] arm64: Expose physical/virtual address bits
 through cpuinfo
In-Reply-To: <1458898209-7486-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458898209-7486-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160329112940.GE3701@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 05:30:08PM +0800, Kefeng Wang wrote:
> ARMv8 Physical Address range allows 0x0~0x6, the 0x6 is supported
> in ARMv8.2, permitted values in ID_AA64MMFR0_EL1 are:
> 0000  32 bits, 4GB.
> 0001  36 bits, 64GB.
> 0010  40 bits, 1TB.
> 0011  42 bits, 4TB.
> 0100  44 bits, 16TB.
> 0101  48 bits, 256TB.
> 0110  52 bits, 4096TB.
> All other values are reserved.
> 
> Meanwhile, ARMv8 can support 48bit or 52bit virtual addresses,
> larger virtual address(52bit) is introduced in ARMv8.2.
> 
> Exposing the physical and virtual address bits to userspace through
> procfs like x86, then it is easy to check the capacity of them that
> cpu supported from cpuinfo.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c         |  6 +++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b9b6494..5b2c206 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -170,6 +170,24 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
>  		cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
>  }
>  
> +static inline u8 get_parange_bits(u64 mmfr0)
> +{
> +	/*
> +	 * PARange[3:0] allows 0x0~0x6, the 0x6 introduced to support 52bit PA
> +	 * in ARMv8.2, other values are reserved.
> +	 */
> +	u8 pa_bits[] = {32, 36, 40, 42, 44, 48, 52};
> +	int fld = cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_PARANGE_SHIFT);
> +	return pa_bits[fld];
> +}
> +
> +static inline u8 get_varange_bits(u64 mmfr2)
> +{
> +	/* 52bit Larger virtual address supported in ARMv8.2 */
> +	int fld = cpuid_feature_extract_unsigned_field(mmfr2, ID_AA64MMFR2_LVA_SHIFT);
> +	return fld == 0x1 ? 52 : 48;
> +}
> +
>  void __init setup_cpu_features(void);
>  
>  void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 84c8684..488d49a 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -107,6 +107,8 @@ static int c_show(struct seq_file *m, void *v)
>  	for_each_online_cpu(i) {
>  		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
>  		u32 midr = cpuinfo->reg_midr;
> +		u64 mmfr0 = cpuinfo->reg_id_aa64mmfr0;
> +		u64 mmfr2 = cpuinfo->reg_id_aa64mmfr2;
>  
>  		/*
>  		 * glibc reads /proc/cpuinfo to determine the number of
> @@ -148,7 +150,9 @@ static int c_show(struct seq_file *m, void *v)
>  		seq_printf(m, "CPU architecture: 8\n");
>  		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
>  		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
> -		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
> +		seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
> +		seq_printf(m, "address sizes\t: %d bits physical, %d bits virtual\n\n",
> +			   get_parange_bits(mmfr0), get_varange_bits(mmfr2));

Can you say why this information is useful for userspace?

Once anything is added to cpuinfo it becomes ABI and must be supported
forever, so we want to avoid adding anything that is not absolutely
definitely needed...

Cheers
---Dave
