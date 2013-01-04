From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Fri, 4 Jan 2013 14:02:05 +0100
Subject: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the AESS
 during kernel init
In-Reply-To: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AESS on OMAP4 has additional register on top of SYS_CONFIG for
auto gatting configuration. In order to avoid running clock after
boot up we should avoid to enable and reset the module during boot up.

Audio driver will be in charge of configuring the addition register.

At its core, this patch is a workaround for an OMAP hardware problem.
It should be possible to configure the OMAP with good default reset
configuration of AESS IP for auto gatting mode.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index b340a4e..26d6cde 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -346,6 +346,14 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.name		= "aess",
 	.class		= &omap44xx_aess_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
+	/*
+	 * AESS has an internal register on top of SYS_CONFIG for
+	 * AUTO GATTING mode. Unfortunately the reset value of this
+	 * register is not set correctly. So until AESS driver is not
+	 * probe we should not try to control the module during boot up.
+	 * Audio driver will handle the additional register configuration.
+	 */
+	.flags		= HWMOD_NO_SETUP_RESET,
 	.mpu_irqs	= omap44xx_aess_irqs,
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
 	.main_clk	= "aess_fck",
-- 
1.7.10.4
