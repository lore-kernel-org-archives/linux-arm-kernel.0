From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 8 Jun 2012 16:30:55 +0300
Subject: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Message-ID: <1339162255.2091.56.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
core retention / dev-off patches. There are a couple of minor issues,
like the bug in patch 5, and the fact that counter_32k hwmod data is
broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
this is not done, device off does not work:

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 66da92d..6ad64c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -397,8 +397,7 @@ static struct omap_hwmod_class_sysconfig
omap44xx_counter_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 


-Tero
