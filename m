From: labbott@redhat.com (Laura Abbott)
Date: Tue, 29 May 2018 14:12:56 -0700
Subject: [PATCH 4/4] arm64: cpufeature: always log KPTI setting on boot
In-Reply-To: <20180524190932.32118-5-mlangsdo@redhat.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
 <20180524190932.32118-5-mlangsdo@redhat.com>
Message-ID: <c41923a7-bbcd-1c29-8d51-528d9092e8b2@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2018 12:09 PM, Mark Langsdorf wrote:
> Always log KPTI setting at boot time, whether or not KPTI was forced
> by a kernel parameter.
> 
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 697a6ef..e50bf3c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -889,16 +889,20 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   		__pti_enabled = __kpti_forced > 0;
>   		pr_info_once("kernel page table isolation forced %s by %s\n",
>   			     __pti_enabled ? "ON" : "OFF", str);
> +	} else {
> +		/* Useful for KASLR robustness */
> +		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +			__pti_enabled = true;
> +		/* Don't force KPTI for CPUs that are not vulnerable */
> +		else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> +			__pti_enabled = false;
> +		/* Defer to CPU feature registers */
> +		else
> +			__pti_enabled = !has_cpuid_feature(entry, scope);
> +
> +		pr_info_once("kernel page table isolation %s by %s\n",
> +			    __pti_enabled ? "ON" : "OFF", str);

I think this needs an update for the default logged, otherwise it
incorrectly states it was set by command line:

# dmesg | grep isolation
[    0.000000] CPU features: kernel page table isolation ON by command line option
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
# cat /proc/cmdline
nokaslr slub_debug=- console=ttyAMA0 debug_pagealloc=on earlycon=pl011,0x9000000

>   	}
> -	/* Useful for KASLR robustness */
> -	else if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -		__pti_enabled = true;
> -	/* Don't force KPTI for CPUs that are not vulnerable */
> -	else if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> -		__pti_enabled = false;
> -	/* Defer to CPU feature registers */
> -	else
> -		__pti_enabled = !has_cpuid_feature(entry, scope);
>   
>   	return __pti_enabled;
>   }
> 
