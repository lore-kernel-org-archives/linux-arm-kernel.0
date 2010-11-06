From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Fri,  5 Nov 2010 19:17:20 -0600
Subject: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
In-Reply-To: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

hwmod data for omap4 mailbox.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   63 ++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0d5c6eb..f7525e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1043,6 +1043,66 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/* mailbox */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap44xx_mailbox_sysc,
+};
+
+static struct omap_hwmod omap44xx_mailbox_hwmod;
+
+static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP44XX_MAILBOX_BASE,
+		.pa_end		= OMAP44XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_cfg -> mailbox */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_mailbox_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mailbox_slaves[] = {
+	&omap44xx_l4_cfg__mailbox,
+};
+
+static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
+	{ .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
+};
+
+static struct omap_hwmod omap44xx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap44xx_mailbox_hwmod_class,
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
+		},
+	},
+	.mpu_irqs	= omap44xx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
+	.slaves		= omap44xx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -1077,6 +1137,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_uart2_hwmod,
 	&omap44xx_uart3_hwmod,
 	&omap44xx_uart4_hwmod,
+
+	/* mailbox */
+	&omap44xx_mailbox_hwmod,
 	NULL,
 };
 
-- 
1.7.1
