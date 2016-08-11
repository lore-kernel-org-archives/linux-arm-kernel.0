From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 16:05:56 +0100
Subject: [PATCH v2 4/4] arm64: apply __ro_after_init to some objects
In-Reply-To: <1470922609-754-5-git-send-email-jszhang@marvell.com>
References: <1470922609-754-1-git-send-email-jszhang@marvell.com>
 <1470922609-754-5-git-send-email-jszhang@marvell.com>
Message-ID: <20160811150555.GD3805@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2016 at 09:36:49PM +0800, Jisheng Zhang wrote:
> These objects are set during initialization, thereafter are read only.
> 
> Previously I only want to mark vdso_pages, vdso_spec, vectors_page and
> cpu_ops as __read_mostly from performance point of view. Then inspired
> by Kees's patch[1] to apply more __ro_after_init for arm, I think it's
> better to mark them as __ro_after_init. What's more, I find some more
> objects are also read only after init. So apply __ro_after_init to all
> of them.
> 
> This patch also removes global vdso_pagelist and tries to clean up
> vdso_spec[] assignment code.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg523188.html
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/kernel/cpu_ops.c |  2 +-
>  arch/arm64/kernel/kaslr.c   |  2 +-
>  arch/arm64/kernel/vdso.c    | 27 +++++++++++++--------------
>  arch/arm64/mm/dma-mapping.c |  2 +-
>  arch/arm64/mm/init.c        |  4 ++--
>  arch/arm64/mm/mmu.c         |  2 +-
>  6 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index c7cfb8f..6d32d1a 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -28,7 +28,7 @@ extern const struct cpu_operations smp_spin_table_ops;
>  extern const struct cpu_operations acpi_parking_protocol_ops;
>  extern const struct cpu_operations cpu_psci_ops;
>  
> -const struct cpu_operations *cpu_ops[NR_CPUS];
> +const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;

It looks like we need to include <linux/cache.h> for __ro_after_init.
While we seem to get that via some transitive include, that's not
guaranteed to remain the case, and it's not something we should rely
upon.

Please explicitly include <linux/cache.h> when __ro_after_init is added.

> -	/* Populate the special mapping structures */
> -	vdso_spec[0] = (struct vm_special_mapping) {
> -		.name	= "[vvar]",
> -		.pages	= vdso_pagelist,
> -	};
> -
> -	vdso_spec[1] = (struct vm_special_mapping) {
> -		.name	= "[vdso]",
> -		.pages	= &vdso_pagelist[1],
> -	};
> +	vdso_spec[0].pages = vdso_pagelist;
> +	vdso_spec[1].pages = &vdso_pagelist[1];

While the original code was also this way, could we please make these a
little more consistent? e.g.

	vdso_spec[0].pages = &vdso_pagelist[0];
	vdso_spec[1].pages = &vdso_pagelist[1];

That way it raises few false alarms for anyone looking at the code.

Otherwise, this patch looks largely fine.

Thanks,
Mark.
