From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 17 Aug 2011 12:03:57 -0500
Subject: [PATCH v3] amba: consolidate PrimeCell magic
In-Reply-To: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
References: <1313569846-22902-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3884BB382@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 17, 2011 1:31 AM, Linus Walleij wrote:
>
> Since three drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it will soon only be used from the amba_bus
> driver in drivers/dma, which is already doing the same check
> when probing in drivers/amba/bus.c.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/common/pl330.c      |   40 +++-------------------------------------
>  arch/arm/common/vic.c        |   15 ++++++++-------
>  drivers/amba/bus.c           |   19 +++----------------
>  drivers/dma/ste_dma40.c      |   14 ++++----------
>  drivers/mtd/nand/fsmc_nand.c |   10 +++-------
>  include/linux/amba/bus.h     |   26 ++++++++++++++++++++++++++
>  6 files changed, 47 insertions(+), 77 deletions(-)

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Linus,
One comment on the change to vic.c.

> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 7aa4262..b163cdd 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -341,16 +341,17 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
>  void __init vic_init(void __iomem *base, unsigned int irq_start,
>  		     u32 vic_sources, u32 resume_sources)
>  {
> -	unsigned int i;
>  	u32 cellid = 0;
>  	enum amba_vendor vendor;
>  
> -	/* Identify which VIC cell this one is, by reading the ID */
> -	for (i = 0; i < 4; i++) {
> -		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
> -		cellid |= (readl(addr) & 0xff) << (8 * i);
> -	}
> -	vendor = (cellid >> 12) & 0xff;
> +	/*
> +	 * Identify which VIC cell this one is, by reading the ID - some
> +	 * implementations have two VICs in the same page but only one set
> +	 * of ID registers at the end, so we need to adjust the base to
> +	 * reference the page offset. All VIC:s are size 4K.
> +	 */
> +	cellid = amba_get_pid((void __iomem *)((u32)base & PAGE_MASK), SZ_4K);

This produces a sparse warning.  But, the same warning was present with the
old code.

arch/arm/common/vic.c:353:49: warning: cast removes address space of expression

If you want, this warning can be fixed by adding __force to the u32 cast:

+	cellid = amba_get_pid((void __iomem *)((u32 __force)base & PAGE_MASK), SZ_4K);

But, if pushes the line a bit over 80 chars...

> +	vendor = AMBA_MANF_BITS(cellid);
>  	printk(KERN_INFO "VIC @%p: id 0x%08x, vendor 0x%02x\n",
>  	       base, cellid, vendor);

Regards,
Hartley
