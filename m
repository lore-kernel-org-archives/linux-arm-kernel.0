From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Nov 2012 13:49:47 +0900
Subject: [PATCH 2/4] ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of
 Exynos4210 SOC
In-Reply-To: <201210300956.23102.b.zolnierkie@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <1351504796-24788-3-git-send-email-b.zolnierkie@samsung.com>
 <508EBBB6.2090006@samsung.com> <201210300956.23102.b.zolnierkie@samsung.com>
Message-ID: <0cea01cdbd6c$7ace7200$706b5600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz wrote:
> 
> > Hmm...above change and adding definition of EXYNOS_PA_S_MDMA1 address
> > can fix the problem you commented on EXYNOS4210 Rev0 without others?...
> 
> The problem is affecting only EXYNOS4210 Rev0 and the fix is applied only
> for case when soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0,
> or did you mean something else?
> 
Yeah, I know. I mean just adding secure mdma1 address is enough for
exynos4210 rev0.

8<-----
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
diff --git a/arch/arm/mach-exynos/include/mach/map.h
b/arch/arm/mach-exynos/include/mach/map.h
index 8480849..0abfe78 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -90,6 +90,7 @@
 
 #define EXYNOS4_PA_MDMA0		0x10810000
 #define EXYNOS4_PA_MDMA1		0x12850000
+#define EXYNOS4_PA_S_MDMA1		0x12840000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 #define EXYNOS5_PA_MDMA0		0x10800000
8<----

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
