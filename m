From: panand@redhat.com (Pratyush Anand)
Date: Tue, 7 Jun 2016 11:11:59 +0530
Subject: [PATCH kexec-tools v2 18/32] arm: report if crash kernel is out
 of bounds
In-Reply-To: <E1b9xsu-0003tA-3i@e0050434b2927.dyn.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xsu-0003tA-3i@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160607054159.GC13643@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016:06:00:16 PM, Russell King wrote:
> Report an error if the crash kernel memory region is outside of the
> boot-view memory range - this can happen with systems such as
> Keystone 2.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Reviewed-by: Pratyush Anand <panand@redhat.com> 
> ---
>  kexec/arch/arm/crashdump-arm.c | 11 +++++++++++
>  kexec/arch/arm/crashdump-arm.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index fcc4d42..739c906 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -365,6 +365,17 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>  	if (get_kernel_page_offset(info, &elf_info))
>  		return -1;
>  
> +	/*
> +	 * Ensure that the crash kernel memory range is sane. The crash kernel
> +	 * must be located within memory which is visible during booting.
> +	 */
> +	if (crash_reserved_mem.end > ARM_MAX_VIRTUAL) {
> +		fprintf(stderr,
> +			"Crash kernel memory [0x%llx-0x%llx] is inaccessible at boot - unable to load crash kernel\n",
> +			crash_reserved_mem.start, crash_reserved_mem.end);
> +		return -1;
> +	}
> +
>  	last_ranges = usablemem_rgns.size - 1;
>  	if (last_ranges < 0)
>  		last_ranges = 0;
> diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
> index 2dbde04..7314960 100644
> --- a/kexec/arch/arm/crashdump-arm.h
> +++ b/kexec/arch/arm/crashdump-arm.h
> @@ -9,6 +9,7 @@ extern "C" {
>  #define DEFAULT_PAGE_OFFSET		(0xc0000000)
>  #define KVBASE_MASK	(0x1ffffff)
>  #define CRASH_MAX_MEMORY_RANGES	32
> +#define ARM_MAX_VIRTUAL		UINT32_MAX
>  
>  
>  extern struct memory_ranges usablemem_rgns;
> -- 
> 1.9.1
