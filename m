From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Feb 2016 10:26:11 +0000
Subject: [PATCH v12 4/5] arm64, numa: Add NUMA support for arm64 platforms.
In-Reply-To: <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160223102610.GD3966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 05:58:22PM -0800, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> Attempt to get the memory and CPU NUMA node via of_numa.  If that
> fails, default the dummy NUMA node and map all memory and CPUs to node
> 0.
> 
> Tested-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/Kconfig                |  26 +++
>  arch/arm64/include/asm/mmzone.h   |  12 ++
>  arch/arm64/include/asm/numa.h     |  45 +++++
>  arch/arm64/include/asm/topology.h |  10 +
>  arch/arm64/kernel/pci.c           |  10 +
>  arch/arm64/kernel/setup.c         |   4 +
>  arch/arm64/kernel/smp.c           |   4 +
>  arch/arm64/mm/Makefile            |   1 +
>  arch/arm64/mm/init.c              |  34 +++-
>  arch/arm64/mm/mmu.c               |   1 +
>  arch/arm64/mm/numa.c              | 403 ++++++++++++++++++++++++++++++++++++++
>  11 files changed, 545 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mmzone.h
>  create mode 100644 arch/arm64/include/asm/numa.h
>  create mode 100644 arch/arm64/mm/numa.c

[...]

> diff --git a/arch/arm64/include/asm/mmzone.h b/arch/arm64/include/asm/mmzone.h
> new file mode 100644
> index 0000000..a0de9e6
> --- /dev/null
> +++ b/arch/arm64/include/asm/mmzone.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_MMZONE_H
> +#define __ASM_MMZONE_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#include <asm/numa.h>
> +
> +extern struct pglist_data *node_data[];
> +#define NODE_DATA(nid)		(node_data[(nid)])
> +
> +#endif /* CONFIG_NUMA */
> +#endif /* __ASM_MMZONE_H */

What happened to the patch cleaning this up in generic code?

Will
