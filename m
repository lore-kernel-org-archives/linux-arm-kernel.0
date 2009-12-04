From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Dec 2009 00:41:48 -0500
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <1259084033-7283-2-git-send-email-saeed@marvell.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
Message-ID: <771cded00912032141x368ae423n6603edbd7acd3f10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index 70f75d2..ebfe6c1 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -130,9 +130,16 @@ ENTRY(cpu_v6_set_pte_ext)
>
>
>
> -
> + ? ? ? .type ? cpu_v6_name, #object
> ?cpu_v6_name:
> ? ? ? ?.asciz ?"ARMv6-compatible processor"
> + ? ? ? .size ? cpu_v6_name, . - cpu_v6_name
> +
> + ? ? ? .type ? cpu_pj4_name, #object
> +cpu_pj4_name:
> + ? ? ? .asciz ?"Marvell PJ4 processor"
> + ? ? ? .size ? cpu_pj4_name, . - cpu_pj4_name
> +
> ? ? ? ?.align
>
> ? ? ? ?__INIT
> @@ -241,3 +248,27 @@ __v6_proc_info:
> ? ? ? ?.long ? v6_user_fns
> ? ? ? ?.long ? v6_cache_fns
> ? ? ? ?.size ? __v6_proc_info, . - __v6_proc_info
> +
> + ? ? ? .type ? __pj4_v6_proc_info, #object
> +__pj4_v6_proc_info:
> + ? ? ? .long ? 0x560f5810
> + ? ? ? .long ? 0xff0ffff0
> + ? ? ? .long ? PMD_TYPE_SECT | \
> + ? ? ? ? ? ? ? PMD_SECT_BUFFERABLE | \
> + ? ? ? ? ? ? ? PMD_SECT_CACHEABLE | \
These two flags are different from flags used in v6 proc_info. Is PJ4
full compatible to armv6? Is there any reason to select
PMD_SECT_BUFFERABLE & PMD_SECT_CACHEABLE at here?
> + ? ? ? ? ? ? ? PMD_SECT_AP_WRITE | \
> + ? ? ? ? ? ? ? PMD_SECT_AP_READ
> + ? ? ? .long ? PMD_TYPE_SECT | \
> + ? ? ? ? ? ? ? PMD_SECT_XN | \
> + ? ? ? ? ? ? ? PMD_SECT_AP_WRITE | \
> + ? ? ? ? ? ? ? PMD_SECT_AP_READ
> + ? ? ? b ? ? ? __v6_setup
> + ? ? ? .long ? cpu_arch_name
> + ? ? ? .long ? cpu_elf_name
> + ? ? ? .long ? HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> + ? ? ? .long ? cpu_pj4_name
> + ? ? ? .long ? v6_processor_functions
> + ? ? ? .long ? v6wbi_tlb_fns
> + ? ? ? .long ? v6_user_fns
> + ? ? ? .long ? v6_cache_fns
> + ? ? ? .size ? __v6_proc_info, . - __v6_proc_info
You created __pj4_v6_proc_info. But you still used __v6_proc_info at here. Why?
