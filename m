From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 22 Aug 2011 13:41:47 +0900
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <001c01cc6082$123cef20$36b6cd60$%kim@samsung.com>
References: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
	<000601cc5e30$3a38bda0$aeaa38e0$%kim@samsung.com>
	<001c01cc6082$123cef20$36b6cd60$%kim@samsung.com>
Message-ID: <001d01cc6085$cd836900$688a3b00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij Wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it is only used from the amba_bus driver
> in drivers/dma, which is already doing the same check when
> probing in drivers/amba/bus.c.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes V3->v4:
> - Fix up sparse warning due to inelegant cast to (u32) in vic.c,
>   we cast to (unsigned long) and sparse is happy.
> ---
>  arch/arm/common/pl330.c      |   40
> +++-------------------------------------
>  arch/arm/common/vic.c        |   15 ++++++++-------
>  drivers/amba/bus.c           |   19 +++----------------
>  drivers/dma/ste_dma40.c      |   14 ++++----------
>  drivers/mtd/nand/fsmc_nand.c |   10 +++-------
>  include/linux/amba/bus.h     |   26 ++++++++++++++++++++++++++
>  6 files changed, 47 insertions(+), 77 deletions(-)
>
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 97912fa..623ce74 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/amba/bus.h>
>
>  #include <asm/hardware/pl330.h>
>
> @@ -111,9 +112,6 @@
>  #define CR4		0xe10
>  #define CRD		0xe14
>
> -#define PERIPH_ID	0xfe0
> -#define PCELL_ID	0xff0
> -
>  #define CR0_PERIPH_REQ_SET	(1 << 0)
>  #define CR0_BOOT_EN_SET		(1 << 1)
>  #define CR0_BOOT_MAN_NS		(1 << 2)
> @@ -142,14 +140,6 @@
>  #define CRD_DATA_BUFF_SHIFT	20
>  #define CRD_DATA_BUFF_MASK	0x3ff
>
> -#define	PART		0x330
> -#define DESIGNER	0x41
> -#define REVISION	0x0
> -#define INTEG_CFG	0x0
> -#define PERIPH_ID_VAL	((PART << 0) | (DESIGNER << 12))
> -
> -#define PCELL_ID_VAL	0xb105f00d
> -
>  #define PL330_STATE_STOPPED		(1 << 0)
>  #define PL330_STATE_EXECUTING		(1 << 1)
>  #define PL330_STATE_WFE			(1 << 2)
> @@ -372,19 +362,6 @@ static inline bool _manager_ns(struct
> pl330_thread
> *thrd)
>  	return (pl330->pinfo->pcfg.mode & DMAC_MODE_NS) ? true : false;
>  }
>
> -static inline u32 get_id(struct pl330_info *pi, u32 off)
> -{
> -	void __iomem *regs = pi->base;
> -	u32 id = 0;
> -
> -	id |= (readb(regs + off + 0x0) << 0);
> -	id |= (readb(regs + off + 0x4) << 8);
> -	id |= (readb(regs + off + 0x8) << 16);
> -	id |= (readb(regs + off + 0xc) << 24);
> -
> -	return id;
> -}
> -
>  static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
>  		enum pl330_dst da, u16 val)
>  {
> @@ -1747,8 +1724,8 @@ static void read_dmac_config(struct pl330_info
> *pi)
>
>  	pi->pcfg.irq_ns = readl(regs + CR3);
>
> -	pi->pcfg.periph_id = get_id(pi, PERIPH_ID);
> -	pi->pcfg.pcell_id = get_id(pi, PCELL_ID);
> +	pi->pcfg.periph_id = amba_get_pid(pi->base, PCELL_SIZE);
> +	pi->pcfg.pcell_id = amba_get_cid(pi->base, PCELL_SIZE);
>  }
I think PCELL_SIZE definition is missed.
V1 had the definition of 'PCELL_SIZE' as following. But, it was gone from
V2.
+/* Used as end offset to retrieve PrimeCell ID registers */
+#define PCELL_SIZE	0x1000

Thanks
Boojin
