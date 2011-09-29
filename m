From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Sep 2011 11:05:58 +0530
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <4E8403BE.9050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry,

On Monday 26 September 2011 08:56 AM, Barry Song wrote:
> we save the l2x0 registers at the first initialization, and platform codes
> can get them to restore l2x0 status after wakeup.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2:
>  define the structure l2x0_regs to hold all saved registers;
>  make saved copy of registers non-static so that platform codes can access them;
>  add asm_offset for l2x0 saved regs(l2x0_regs struct) so that asm codes can use
> 
>  arch/arm/include/asm/hardware/cache-l2x0.h |   13 +++++
>  arch/arm/include/asm/outercache.h          |    7 +++
>  arch/arm/kernel/asm-offsets.c              |    9 +++
>  arch/arm/mm/cache-l2x0.c                   |   81 ++++++++++++++++++++++++---
>  4 files changed, 101 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index c48cb1e..4f9e81d 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -96,6 +96,19 @@
>  #ifndef __ASSEMBLY__
>  extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
>  extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
> +
> +struct l2x0_regs {
> +	unsigned long aux_ctrl;
> +	/*
> +	 * Whether the following registers need to be saved/restored
> +	 * depends on platform
> +	 */
> +	unsigned long tag_latency;
> +	unsigned long data_latency;
> +	unsigned long filter_start;
> +	unsigned long filter_end;
> +};
> +
You are missing POR register here which is available on
PL310 versions. You should add that.

[...]
>  static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 16baba2..b8d72a8 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -20,6 +20,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/procinfo.h>
> +#include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
>  
>  /*
> @@ -92,6 +93,14 @@ int main(void)
>    DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
> +#ifdef CONFIG_CACHE_L2X0
> +  DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
> +  DEFINE(L2X0_R_TAG_LATENCY,	offsetof(struct l2x0_regs, tag_latency));
> +  DEFINE(L2X0_R_DATA_LATENCY,	offsetof(struct l2x0_regs, data_latency));
> +  DEFINE(L2X0_R_FILTER_START,	offsetof(struct l2x0_regs, filter_start));
> +  DEFINE(L2X0_R_FILTER_END,	offsetof(struct l2x0_regs, filter_end));
Add POR as commented earlier.

Rest of the patch looks good to me. I have ignored DT related
changes since I don't understand them.

Shawn,
Have you tried this patch on IMX and see if you are
able to use it from the asm code?

Regards
Santosh
