From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 May 2012 15:50:06 -0700
Subject: [PATCH-V2 4/4] ARM: OMAP2+: CLEANUP: Add new config option for
 different DPLL features
In-Reply-To: <1336506724-5494-5-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Wed, 9 May 2012 01:22:04 +0530")
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-5-git-send-email-hvaibhav@ti.com>
Message-ID: <87ehqui8yp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch cleans up dpll_data structure, making structure
> fields definition based on feature availability for given SoC,
> managed using Kconfig rules.
>
> SOC_HAS_OMAP3_DPLL_IDLE: idle state
> SOC_HAS_OMAP3_DPLL_RECAL: recalibration capability
> SOC_HAS_OMAP3_DPLL_DCO_SEL: dco selection
> SOC_HAS_OMAP3_DPLL_SDDIV: sigma-delta div factor
> SOC_HAS_OMAP3_DPLL_FREQSEL: frequency selection
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Paul is the one to make the call here, but personally I'd much prefer to
just see the existing ifdefs go away[1] instead of adding a bunch of new
ones.  

Yes, doing so would add a few fields to a struct that may be unused, but
IMO, the improvement in readabilitly and maintainability is improved.

Note that the users of these fields are not changed and are still based
on Kconfig/Makefile values as before (e.g. CONFIG_ARCH_OMAP3), so to me
this creates another layer of obfuscation.

Kevin


[1]
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..656b986 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -156,7 +156,6 @@ struct dpll_data {
 	u8			min_divider;
 	u16			max_divider;
 	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
@@ -167,7 +166,6 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-#  endif
 	u8			flags;
 };
 
