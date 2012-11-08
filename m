From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 08 Nov 2012 10:54:41 +0100
Subject: [PATCH 2/4] ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of
 Exynos4210 SOC
In-Reply-To: <0cea01cdbd6c$7ace7200$706b5600$%kim@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <201210300956.23102.b.zolnierkie@samsung.com>
 <0cea01cdbd6c$7ace7200$706b5600$%kim@samsung.com>
Message-ID: <201211081054.41649.b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012 05:49:47 Kukjin Kim wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Hmm...above change and adding definition of EXYNOS_PA_S_MDMA1 address
> > > can fix the problem you commented on EXYNOS4210 Rev0 without others?...
> > 
> > The problem is affecting only EXYNOS4210 Rev0 and the fix is applied only
> > for case when soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0,
> > or did you mean something else?
> > 
> Yeah, I know. I mean just adding secure mdma1 address is enough for
> exynos4210 rev0.
> 
> 8<-----
> @@ -275,6 +275,9 @@ static int __init exynos_dma_init(void)
>  		exynos_pdma1_pdata.nr_valid_peri =
>  			ARRAY_SIZE(exynos4210_pdma1_peri);
>  		exynos_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
> +
> +		if (samsung_rev() == EXYNOS4210_REV_0)
> +			exynos_mdma1_device.res.start = EXYNOS4_PA_S_MDMA1;
>  	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
>  		exynos_pdma0_pdata.nr_valid_peri =
>  			ARRAY_SIZE(exynos4212_pdma0_peri);
> diff --git a/arch/arm/mach-exynos/include/mach/map.h
> b/arch/arm/mach-exynos/include/mach/map.h
> index 8480849..0abfe78 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -90,6 +90,7 @@
>  
>  #define EXYNOS4_PA_MDMA0		0x10810000
>  #define EXYNOS4_PA_MDMA1		0x12850000
> +#define EXYNOS4_PA_S_MDMA1		0x12840000
>  #define EXYNOS4_PA_PDMA0		0x12680000
>  #define EXYNOS4_PA_PDMA1		0x12690000
>  #define EXYNOS5_PA_MDMA0		0x10800000
> 8<----

Ah, okay.  Here is full simplified patch.

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of Exynos4210 SOC

Commit 8214513 ("ARM: EXYNOS: fix address for EXYNOS4 MDMA1")
changed EXYNOS specific setup of PL330 DMA engine to use 'non-secure'
mdma1 address instead of 'secure' one (from 0x12840000 to 0x12850000)
to fix issue with some Exynos4212 SOCs.  Unfortunately it brakes
PL330 setup for revision 0 of Exynos4210 SOC (mdma1 device cannot
be found at 'non-secure' address):

[    0.566245] dma-pl330 dma-pl330.2: PERIPH_ID 0x0, PCELL_ID 0x0 !
[    0.566278] dma-pl330: probe of dma-pl330.2 failed with error -22

Fix it by using 'secure' mdma1 address on Exynos4210 revision 0 SOC.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/dma.c              |    3 +++
 arch/arm/mach-exynos/include/mach/map.h |    1 +
 2 files changed, 4 insertions(+)

Index: b/arch/arm/mach-exynos/dma.c
===================================================================
--- a/arch/arm/mach-exynos/dma.c	2012-11-07 18:20:36.561743865 +0100
+++ b/arch/arm/mach-exynos/dma.c	2012-11-08 10:48:23.445067606 +0100
@@ -275,6 +275,9 @@ static int __init exynos_dma_init(void)
 		exynos_pdma1_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4210_pdma1_peri);
 		exynos_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
+
+		if (samsung_rev() == EXYNOS4210_REV_0)
+			exynos_mdma1_device.res.start = EXYNOS4_PA_S_MDMA1;
 	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
 		exynos_pdma0_pdata.nr_valid_peri =
 			ARRAY_SIZE(exynos4212_pdma0_peri);
Index: b/arch/arm/mach-exynos/include/mach/map.h
===================================================================
--- a/arch/arm/mach-exynos/include/mach/map.h	2012-11-07 18:20:44.801743862 +0100
+++ b/arch/arm/mach-exynos/include/mach/map.h	2012-11-08 10:48:40.597067605 +0100
@@ -92,6 +92,7 @@
 
 #define EXYNOS4_PA_MDMA0		0x10810000
 #define EXYNOS4_PA_MDMA1		0x12850000
+#define EXYNOS4_PA_S_MDMA1		0x12840000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 #define EXYNOS5_PA_MDMA0		0x10800000
