From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 15 Jan 2014 16:32:03 -0800
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <1389325833-16535-5-git-send-email-msalter@redhat.com>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
Message-ID: <52D72883.3020500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/2014 7:50 PM, Mark Salter wrote:
....
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 987a7f5..038fb75 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -36,6 +36,7 @@
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
>   #include <asm/elf.h>
> +#include <asm/io.h>
>   #include <asm/procinfo.h>
>   #include <asm/psci.h>
>   #include <asm/sections.h>
> @@ -887,6 +888,8 @@ void __init setup_arch(char **cmdline_p)
>
>   	parse_early_param();
>
> +	early_ioremap_init();
> +
>   	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
>
>   	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));

Any chance we could do this even earlier, say right after 
setup_processor? It would be nice to be able to do this while FDT 
scanning (I have a use case in mind, potential patches are in the works)

<snip>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 580ef2d..bef59b9 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -34,6 +34,7 @@
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>
>   #include <asm/mach/pci.h>
> +#include <asm/early_ioremap.h>
>
>   #include "mm.h"
>   #include "tcm.h"
> @@ -1405,6 +1406,7 @@ void __init paging_init(const struct machine_desc *mdesc)
>   {
>   	void *zero_page;
>
> +	early_ioremap_reset();
>   	build_mem_type_table();
>   	prepare_page_table();
>   	map_lowmem();
>

Neither x86 nor arm64 get rid of existing mapping in paging_init. Is 
there a reason this needs to be here for arm? Are there concerns about 
alias mappings?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
