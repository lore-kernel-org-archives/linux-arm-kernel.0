From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Fri,  5 Nov 2010 19:17:18 -0600
Subject: [PATCH v2 1/7] OMAP2: hwmod data: add mailbox data
In-Reply-To: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1289006244-27147-2-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmod data for omap2430 and 2420.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   67 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   66 +++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a1a3dd6..76ad991 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -557,6 +557,72 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
+/* mailbox */
+
+static struct omap_hwmod_class_sysconfig omap2420_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2420_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap2420_mailbox_sysc,
+};
+
+static struct omap_hwmod omap2420_mailbox_hwmod;
+
+static struct omap_hwmod_addr_space omap2420_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_MAILBOX_BASE,
+		.pa_end		= OMAP24XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> mailbox */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mailbox_hwmod,
+	.addr		= omap2420_mailbox_addrs,
+	.clk		= "mailboxes_ick",
+	.addr_cnt	= ARRAY_SIZE(omap2420_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mailbox_slaves[] = {
+	&omap2420_l4_core__mailbox,
+};
+
+static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = INT_24XX_MAIL_U0_MPU, },
+	{ .name = "iva", .irq = INT_24XX_MAIL_U3_MPU, },
+};
+
+static struct omap_hwmod omap2420_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2420_mailbox_hwmod_class,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.mpu_irqs	= omap2420_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mailbox_irqs),
+	.slaves		= omap2420_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -569,6 +635,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_uart3_hwmod,
 	&omap2420_i2c1_hwmod,
 	&omap2420_i2c2_hwmod,
+	&omap2420_mailbox_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 7cf0d3a..991bd5b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -569,6 +569,71 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* mailbox */
+
+static struct omap_hwmod_class_sysconfig omap2430_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap2430_mailbox_sysc,
+};
+
+static struct omap_hwmod omap2430_mailbox_hwmod;
+
+static struct omap_hwmod_addr_space omap2430_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_MAILBOX_BASE,
+		.pa_end		= OMAP24XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> mailbox */
+static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mailbox_hwmod,
+	.addr		= omap2430_mailbox_addrs,
+	.clk		= "mailboxes_ick",
+	.addr_cnt	= ARRAY_SIZE(omap2430_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2430_mailbox_slaves[] = {
+	&omap2430_l4_core__mailbox,
+};
+
+static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = INT_24XX_MAIL_U0_MPU, },
+};
+
+static struct omap_hwmod omap2430_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2430_mailbox_hwmod_class,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.mpu_irqs	= omap2430_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mailbox_irqs),
+	.slaves		= omap2430_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -581,6 +646,7 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_uart3_hwmod,
 	&omap2430_i2c1_hwmod,
 	&omap2430_i2c2_hwmod,
+	&omap2430_mailbox_hwmod,
 	NULL,
 };
 
-- 
1.7.1
