From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Jul 2012 16:26:31 +0300
Subject: [PATCHv7 11/12] ARM: OMAP4: hwmod_data: add context lose information
 for l4_abe hwmod
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Message-ID: <1342704392-23657-12-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'l4_abe' hwmod uses the LOSTMEM_AESSMEM bit of RM_ABE_AESS_CONTEXT register,
as l4_abe doesn't have its own dedicated register for this purpose. This
register is shared with 'aess' hwmod, thus both hwmods must also specify
which bits of the register are used for them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8b60377..48431cb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -204,7 +204,8 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
-			.context_offs = USHRT_MAX,
+			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
+			.lostcontext_mask = OMAP4430_LOSTMEM_AESSMEM_MASK,
 		},
 	},
 };
@@ -350,6 +351,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
+			.lostcontext_mask = OMAP4430_LOSTCONTEXT_DFF_MASK,
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.7.4.1
