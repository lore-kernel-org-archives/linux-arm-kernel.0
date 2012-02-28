From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 28 Feb 2012 04:10:56 -0700
Subject: [PATCH 7/9] ARM: OMAP4: hwmod data: add OCP_USER_DSP;
 mark omap44xx_dsp__iva appropriately
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Message-ID: <20120228111055.808.79928.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the OMAP4 links was missing OCP_USER flags, since it was only
used by the DSP initiator, and we did not have an OCP_USER_DSP flag.
Future patches will switch the hwmod code and data to register
interfaces, rather than hwmods, and it will be mandatory for all
interfaces to have at least one user bit set.  This patch resolves the
issue by adding OCP_USER_DSP and marking the DSP-IVA interface
appropriately.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8dfed19..f3fd64d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1089,6 +1089,7 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iva = {
 	.master		= &omap44xx_dsp_hwmod,
 	.slave		= &omap44xx_iva_hwmod,
 	.clk		= "dpll_iva_m5x2_ck",
+	.user		= OCP_USER_DSP,
 };
 
 /* dsp master ports */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8814365..f0a0711 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -213,6 +213,7 @@ struct omap_hwmod_addr_space {
  */
 #define OCP_USER_MPU			(1 << 0)
 #define OCP_USER_SDMA			(1 << 1)
+#define OCP_USER_DSP			(1 << 2)
 
 /* omap_hwmod_ocp_if.flags bits */
 #define OCPIF_SWSUP_IDLE		(1 << 0)
