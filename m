From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 19 Dec 2011 14:48:38 -0700 (MST)
Subject: [RFC PATCH v2 1/8] omap4: introduce fdif(face detect module) hwmod
In-Reply-To: <4EEB5BBC.7050807@ti.com>
References: <1323871214-25435-1-git-send-email-ming.lei@canonical.com>
 <1323871214-25435-2-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1112152252260.12660@utopia.booyaka.com>
 <4EEB5BBC.7050807@ti.com>
Message-ID: <alpine.DEB.2.00.1112191447270.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Fri, 16 Dec 2011, Cousson, Benoit wrote:

> On 12/16/2011 6:53 AM, Paul Walmsley wrote:
> > Hi Beno?t
> > 
> > On Wed, 14 Dec 2011, Ming Lei wrote:
> > 
> > > Signed-off-by: Ming Lei<ming.lei@canonical.com>
> 
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> 
> > > ---
> > >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   81
> > > ++++++++++++++++++++++++++++
> > >   1 files changed, 81 insertions(+), 0 deletions(-)
> > 
> > any comments on this patch?  I'd like to queue it if it looks good to you.
> 
> It looks good to me. The only minor comment is about fdif location in the list
> that should be sorted and thus cannot be after wd_timer2.

Thanks, patch updated to match the script output and queued.  Modified 
patch follows.


- Paul

From: Ming Lei <ming.lei@canonical.com>
Date: Mon, 19 Dec 2011 14:34:06 -0700
Subject: [PATCH] ARM: OMAP4: hwmod data: introduce fdif(face detect module)
 hwmod

Add hwmod data for the OMAP4 FDIF IP block.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Acked-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: rearranged to match script output; fixed FDIF end address to
 match script data; wrote trivial changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   85 ++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..3ac4bf6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -53,6 +53,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod;
 static struct omap_hwmod omap44xx_dsp_hwmod;
 static struct omap_hwmod omap44xx_dss_hwmod;
 static struct omap_hwmod omap44xx_emif_fw_hwmod;
+static struct omap_hwmod omap44xx_fdif_hwmod;
 static struct omap_hwmod omap44xx_hsi_hwmod;
 static struct omap_hwmod omap44xx_ipu_hwmod;
 static struct omap_hwmod omap44xx_iss_hwmod;
@@ -346,6 +347,14 @@ static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* fdif -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 = {
+	.master		= &omap44xx_fdif_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* hsi -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 = {
 	.master		= &omap44xx_hsi_hwmod,
@@ -1797,6 +1806,79 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 };
 
 /*
+ * 'fdif' class
+ * face detection hw accelerator module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_fdif_hwmod_class = {
+	.name	= "fdif",
+	.sysc	= &omap44xx_fdif_sysc,
+};
+
+/* fdif */
+static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] = {
+	{ .irq = 69 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+/* fdif master ports */
+static struct omap_hwmod_ocp_if *omap44xx_fdif_masters[] = {
+	&omap44xx_fdif__l3_main_2,
+};
+
+static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
+	{
+		.pa_start	= 0x4a10a000,
+		.pa_end		= 0x4a10a1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> fdif */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_fdif_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_fdif_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* fdif slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_fdif_slaves[] = {
+	&omap44xx_l4_cfg__fdif,
+};
+
+static struct omap_hwmod omap44xx_fdif_hwmod = {
+	.name		= "fdif",
+	.class		= &omap44xx_fdif_hwmod_class,
+	.clkdm_name	= "iss_clkdm",
+	.mpu_irqs	= omap44xx_fdif_irqs,
+	.main_clk	= "fdif_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_CAM_FDIF_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.slaves		= omap44xx_fdif_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_fdif_slaves),
+	.masters	= omap44xx_fdif_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_fdif_masters),
+};
+
+/*
  * 'gpio' class
  * general purpose io module
  */
@@ -5327,6 +5409,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_dss_rfbi_hwmod,
 	&omap44xx_dss_venc_hwmod,
 
+	/* fdif class */
+	&omap44xx_fdif_hwmod,
+
 	/* gpio class */
 	&omap44xx_gpio1_hwmod,
 	&omap44xx_gpio2_hwmod,
-- 
1.7.7.3
