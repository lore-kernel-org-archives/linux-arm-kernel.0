From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 7 Jun 2013 13:05:44 +0300
Subject: [PATCH 0/6] Drop legacy booting for omap4 for v3.11, boot with
 device tree only
In-Reply-To: <20130517191304.468.73487.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
Message-ID: <51B1B078.9000401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/05/13 22:17, Tony Lindgren wrote:
> Hi all,
> 
> Here are patches against v3.10-rc1 to drop omap4 legacy booting as
> things are now working well enough for booting omap4 with device
> tree.
> 
> We already have am33xx and omap5 booting with device tree only,
> and converting omap4 is relatively easy with just two board-*.c
> files merged as we have not accepted any new board-*.c files for
> quite some time now.
> 
> By working "well enough" I mean that I can use my omap4 panda-es
> with device tree with a Motorola LapDock with HDMI, DVI, HID, USB
> and WLAN using v3.10-rc1 and the patches in this series plus some
> extra patches that are driver related.
> 
> Of course some things will need more work, like PM. But that
> has not yet been fully working for omap4 anyways, and that
> work can now be combined with omap5 PM work to some extent.

You can also add the one below to this series.

 Tomi


>From d22837262b59ad381feb215496fafe3fe399972f Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 7 Jun 2013 13:01:05 +0300
Subject: [PATCH] ARM: OMAP2+: Remove legacy DSS initialization for omap4

This is no longer needed as omap4 is now booted using device tree.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c | 47 ----------------------------------------
 arch/arm/mach-omap2/dss-common.h |  2 --
 2 files changed, 49 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 393aeef..43ec787 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -80,24 +80,6 @@ static struct omap_dss_board_info omap4_panda_dss_data = {
 	.default_device	= &omap4_panda_dvi_device,
 };
 
-void __init omap4_panda_display_init(void)
-{
-	omap_display_init(&omap4_panda_dss_data);
-
-	/*
-	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
-	 * later have external pull up on the HDMI I2C lines
-	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
-	else
-		omap_hdmi_init(0);
-
-	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
-}
-
 void __init omap4_panda_display_init_of(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
@@ -204,35 +186,6 @@ static struct omap_dss_board_info sdp4430_dss_data = {
  * used by picodlp on the 4430sdp platform. Keep this gpio disabled as LCD2 is
  * selected by default
  */
-void __init omap_4430sdp_display_init(void)
-{
-	int r;
-
-	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
-			"display_sel");
-	if (r)
-		pr_err("%s: Could not get display_sel GPIO\n", __func__);
-
-	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
-		"DLP POWER ON");
-	if (r)
-		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
-
-	omap_display_init(&sdp4430_dss_data);
-	/*
-	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
-	 * later have external pull up on the HDMI I2C lines
-	 */
-	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
-		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
-	else
-		omap_hdmi_init(0);
-
-	omap_mux_init_gpio(HDMI_GPIO_LS_OE, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
-}
-
 void __init omap_4430sdp_display_init_of(void)
 {
 	int r;
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
index 915f6ff..c28fe3c 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -6,9 +6,7 @@
  * This file will be removed when DSS supports DT.
  */
 
-void __init omap4_panda_display_init(void);
 void __init omap4_panda_display_init_of(void);
-void __init omap_4430sdp_display_init(void);
 void __init omap_4430sdp_display_init_of(void);
 
 #endif
-- 
1.8.1.2



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130607/9210c379/attachment.sig>
