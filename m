From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 22 Aug 2011 20:57:51 +0900
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <CACRpkdat3-CRbMBsis=fTGcu61zhVvfXMqG_S_CRjBwCo2vTsQ@mail.gmail.com>
References: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
	<000601cc5e30$3a38bda0$aeaa38e0$%kim@samsung.com>
	<001c01cc6082$123cef20$36b6cd60$%kim@samsung.com>
	<001d01cc6085$cd836900$688a3b00$%kim@samsung.com>
	<CACRpkdat3-CRbMBsis=fTGcu61zhVvfXMqG_S_CRjBwCo2vTsQ@mail.gmail.com>
Message-ID: <002b01cc60c2$b83eff40$28bcfdc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> >> From: Linus Walleij <linus.walleij@linaro.org>
>
> >> Since two drivers use the PrimeCell scheme without using the
> >> amba_bus driver logic, let's break the magic lookups out as
> >> static inlines in the <linux/amba/bus.h> header so we get
> >> some consolidation anyway. Delete the primecell ID check in
> >> common/pl330.c since it is only used from the amba_bus driver
> >> in drivers/dma, which is already doing the same check when
> >> probing in drivers/amba/bus.c.
> >
> > I think PCELL_SIZE definition is missed.
> > V1 had the definition of 'PCELL_SIZE' as following. But, it was gone
> from
> > V2.
> > +/* Used as end offset to retrieve PrimeCell ID registers */
> > +#define PCELL_SIZE ? ? 0x1000
>
> I must have slipped something :-(
>
> I fixed it by simply switching PCELL_SIZE to SZ_4K in the patch
> like this:
> -       pi->pcfg.periph_id = get_id(pi, PERIPH_ID);
> -       pi->pcfg.pcell_id = get_id(pi, PCELL_ID);
> +       pi->pcfg.periph_id = amba_get_pid(pi->base, SZ_4K);
> +       pi->pcfg.pcell_id = amba_get_cid(pi->base, SZ_4K);
>
> Which defconfig shall I use to regressiontest this actually?
> I was trying to locate one but failed.
>
> I'll update the patch in the patch tracker too.
>
> Yours,
> Linus Walleij

I used 'exynos4_defconfig'. And then enables 'Device Drivers-> DMA Engine
support -> DMA API Driver for PL330' option and modify code as below.

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 2e3b3d3..763e846 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -193,6 +193,7 @@ config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
 config PL330_DMA
 	tristate "DMA API Driver for PL330"
 	select DMA_ENGINE
+	select ARM_AMBA
 	depends on PL330
 	help
 	  Select if your platform has one or more PL330 DMACs.
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 00eee59..fcad90c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
+#include <linux/scatterlist.h>

 #define NR_DEFAULT_DESC	16

Thanks
Boojin
