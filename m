From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 31 Oct 2012 04:43:16 -0600
Subject: [PATCH 4/4] ARM: OMAP4: hwmod data: do not enable or reset the
 McPDM during kernel init
In-Reply-To: <20121031103607.6557.64591.stgit@dusk.lan>
References: <20121031103607.6557.64591.stgit@dusk.lan>
Message-ID: <20121031104314.6557.36640.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolve this kernel boot message:

omap_hwmod: mcpdm: cannot be enabled for reset (3)

The McPDM on OMAP4 can only receive its functional clock from an
off-chip source.  This source is not guaranteed to be present on the
board, and when present, it is controlled by I2C.  This would
introduce a board dependency to the early hwmod code which it was not
designed to handle.  Also, neither the driver for this off-chip clock
provider nor the I2C code is available early in boot when the hwmod
code is attempting to enable and reset IP blocks.  This effectively
makes it impossible to enable and reset this device during hwmod init.

At its core, this patch is a workaround for an OMAP hardware problem.
It should be possible to configure the OMAP to provide any IP block's
functional clock from an on-chip source.  (This is true for almost
every IP block on the chip.  As far as I know, McPDM is the only
exception.)  If the kernel cannot reset and configure IP blocks, it
cannot guarantee a sane SoC state.  Relying on an optional off-chip
clock also creates a board dependency which is beyond the scope of the
early hwmod code.

This patch works around the issue by marking the McPDM hwmod record
with the HWMOD_EXT_OPT_MAIN_CLK flag.  This prevents the hwmod
code from touching the device early during boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..7bddfa5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2125,6 +2125,14 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.name		= "mcpdm",
 	.class		= &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	/*
+	 * It's suspected that the McPDM requires an off-chip main
+	 * functional clock, controlled via I2C.  This IP block is
+	 * currently reset very early during boot, before I2C is
+	 * available, so it doesn't seem that we have any choice in
+	 * the kernel other than to avoid resetting it.
+	 */
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
