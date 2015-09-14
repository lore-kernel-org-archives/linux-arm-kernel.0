From: s-anna@ti.com (Suman Anna)
Date: Mon, 14 Sep 2015 18:37:13 -0500
Subject: [PATCH 2/2] ARM: OMAP3: hwmod data: Remove legacy mailbox data and
 addrs
In-Reply-To: <1442273833-25013-1-git-send-email-s-anna@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
Message-ID: <1442273833-25013-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the mailbox attribute data, irq info and hwmod addr space
data that are used for creating the legacy-style mailbox devices,
there is no need for these as the support for legacy-mode for this
IP is being dropped.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index dc55f8dedf2c..aff78d5198d2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -26,7 +26,6 @@
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/iommu-omap.h>
-#include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
 #include "soc.h"
@@ -1506,26 +1505,9 @@ static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
 	.sysc = &omap3xxx_mailbox_sysc,
 };
 
-static struct omap_mbox_dev_info omap3xxx_mailbox_info[] = {
-	{ .name = "dsp", .tx_id = 0, .rx_id = 1 },
-};
-
-static struct omap_mbox_pdata omap3xxx_mailbox_attrs = {
-	.num_users	= 2,
-	.num_fifos	= 2,
-	.info_cnt	= ARRAY_SIZE(omap3xxx_mailbox_info),
-	.info		= omap3xxx_mailbox_info,
-};
-
-static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
-	{ .irq = 26 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap3xxx_mailbox_hwmod_class,
-	.mpu_irqs	= omap3xxx_mailbox_irqs,
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
@@ -1536,7 +1518,6 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MAILBOXES_SHIFT,
 		},
 	},
-	.dev_attr	= &omap3xxx_mailbox_attrs,
 };
 
 /*
@@ -3276,20 +3257,10 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3_sidetone = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x48094000,
-		.pa_end		= 0x480941ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mailbox_hwmod,
-	.addr		= omap3xxx_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.5.0
