From: pekon@ti.com (Gupta, Pekon)
Date: Mon, 14 Jul 2014 05:41:24 +0000
Subject: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable()
In-Reply-To: <1405301778.29716.72.camel@mars>
References: <1405301778.29716.72.camel@mars>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EB02569@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Christoph Fritz [mailto:chf.fritz at googlemail.com]
>
>This patch adds bch8 ecc software fallback which is mostly used by
>omap3s because they lack hardware elm support.
>
>Fixes: 0611c41934ab35ce84dea34ab291897ad3cbc7be (ARM: OMAP2+: gpmc:
>update gpmc_hwecc_bch_capable() for new platforms and ECC schemes)
>Cc: <stable@vger.kernel.org> # 3.15.x+
>Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
>---
> arch/arm/mach-omap2/gpmc-nand.c |   18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>index 17cd393..93914d2 100644
>--- a/arch/arm/mach-omap2/gpmc-nand.c
>+++ b/arch/arm/mach-omap2/gpmc-nand.c
>@@ -50,6 +50,16 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
> 		 soc_is_omap54xx() || soc_is_dra7xx())
> 		return 1;
>
>+	if (ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW ||
>+		 ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW) {
>+		if (cpu_is_omap24xx())
>+			return 0;
>+		else if (cpu_is_omap3630() && (GET_OMAP_REVISION() == 0))
>+			return 0;
>+		else
>+			return 1;
>+	}
>+
> 	/* OMAP3xxx do not have ELM engine, so cannot support ECC schemes
> 	 * which require H/W based ECC error detection */
> 	if ((cpu_is_omap34xx() || cpu_is_omap3630()) &&
>@@ -57,14 +67,6 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
> 		 (ecc_opt == OMAP_ECC_BCH8_CODE_HW)))
> 		return 0;
>
>-	/*
>-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
>-	 * and AM33xx derivates. Other chips may be added if confirmed to work.
>-	 */
>-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) &&
>-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)))
>-		return 0;
>-
> 	/* legacy platforms support only HAM1 (1-bit Hamming) ECC scheme */
> 	if (ecc_opt == OMAP_ECC_HAM1_CODE_HW)
> 		return 1;
>--
>1.7.10.4
>
Thanks much for this fix.
Reviewed-by: Pekon Gupta <pekon@ti.com>


with regards, pekon
