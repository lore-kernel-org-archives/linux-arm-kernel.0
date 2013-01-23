From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 23 Jan 2013 19:21:45 +0100
Subject: [PATCH] omap2: twl-common: Add default power configuration
In-Reply-To: <CABuKBeLUXMiTXotS=JJ1P-dGUr2m-_2JmrSgjDGU=49HLA3bCA@mail.gmail.com>
References: <CABuKBeLUXMiTXotS=JJ1P-dGUr2m-_2JmrSgjDGU=49HLA3bCA@mail.gmail.com>
Message-ID: <1358965305-5989-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a generic power script configuration.
When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
With the generic power script, TWL4030 will be reset
when a warm reset occures. This way the OMAP3530 does not
hang on reboot.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/mach-omap2/twl-common.c | 41 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index d78180c..f096beb 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -121,41 +121,40 @@ static struct twl4030_audio_data omap3_audio_pdata = {
 };
 
 static struct twl4030_ins wrst_seq[] __initdata = {
-       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
-       {MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
-       {MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
-       {MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
-       {MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
-       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
 };
 
 static struct twl4030_script wrst_script __initdata = {
-       .script = wrst_seq,
-       .size   = ARRAY_SIZE(wrst_seq),
-       .flags  = TWL4030_WRST_SCRIPT,
+	.script = wrst_seq,
+	.size	= ARRAY_SIZE(wrst_seq),
+	.flags	= TWL4030_WRST_SCRIPT,
 };
 
 static struct twl4030_script *omap3_power_scripts[] __initdata = {
-       &wrst_script,
+	&wrst_script,
 };
 
 static struct twl4030_resconfig omap3_rconfig[] = {
-       { .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
-               .type2 = -1 },
-       { .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
-               .type2 = -1 },
-       { .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
-               .type2 = -1 },
-       { 0, 0},
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
+		.type2 = -1 },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+	{ 0, 0},
 };
 
 static struct twl4030_power_data omap3_power_pdata = {
-       .scripts        = omap3_power_scripts,
-       .num            = ARRAY_SIZE(omap3_power_scripts),
-       .resource_config = omap3_rconfig,
+	.scripts	= omap3_power_scripts,
+	.num		= ARRAY_SIZE(omap3_power_scripts),
+	.resource_config = omap3_rconfig,
 };
 
-
 static struct regulator_consumer_supply omap3_vdda_dac_supplies[] = {
 	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
 };
-- 
1.7.11.7
