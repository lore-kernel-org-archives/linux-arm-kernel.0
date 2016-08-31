From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 31 Aug 2016 10:05:25 +0200
Subject: [PATCH] rtc: constify rtc_class_ops structures
Message-ID: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for rtc_class_ops structures that are only passed to
devm_rtc_device_register, rtc_device_register,
platform_device_register_data, all of which declare the corresponding
parameter as const.  Declare rtc_class_ops structures that have these
properties as const.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct rtc_class_ops i at p = { ... };

@ok@
identifier r.i;
expression e1,e2,e3,e4;
position p;
@@
(
devm_rtc_device_register(e1,e2,&i at p,e3)
|
rtc_device_register(e1,e2,&i at p,e3)
|
platform_device_register_data(e1,e2,e3,&i at p,e4)
)

@bad@
position p != {r.p,ok.p};
identifier r.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct rtc_class_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/rtc/rtc-at32ap700x.c |    2 +-
 drivers/rtc/rtc-coh901331.c  |    2 +-
 drivers/rtc/rtc-davinci.c    |    2 +-
 drivers/rtc/rtc-digicolor.c  |    2 +-
 drivers/rtc/rtc-ds1302.c     |    2 +-
 drivers/rtc/rtc-gemini.c     |    2 +-
 drivers/rtc/rtc-jz4740.c     |    2 +-
 drivers/rtc/rtc-mcp795.c     |    2 +-
 drivers/rtc/rtc-mt6397.c     |    2 +-
 drivers/rtc/rtc-nuc900.c     |    2 +-
 drivers/rtc/rtc-omap.c       |    2 +-
 drivers/rtc/rtc-palmas.c     |    2 +-
 drivers/rtc/rtc-pcf50633.c   |    2 +-
 drivers/rtc/rtc-rx6110.c     |    2 +-
 drivers/rtc/rtc-rx8025.c     |    2 +-
 drivers/rtc/rtc-spear.c      |    2 +-
 drivers/rtc/rtc-stmp3xxx.c   |    2 +-
 drivers/rtc/rtc-tegra.c      |    2 +-
 drivers/rtc/rtc-twl.c        |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index b57505e..688debc 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -110,7 +110,7 @@ static int gemini_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static struct rtc_class_ops gemini_rtc_ops = {
+static const struct rtc_class_ops gemini_rtc_ops = {
 	.read_time     = gemini_rtc_read_time,
 	.set_time      = gemini_rtc_set_time,
 };
diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
index 83ac233..de8bf56 100644
--- a/drivers/rtc/rtc-at32ap700x.c
+++ b/drivers/rtc/rtc-at32ap700x.c
@@ -187,7 +187,7 @@ static irqreturn_t at32_rtc_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
-static struct rtc_class_ops at32_rtc_ops = {
+static const struct rtc_class_ops at32_rtc_ops = {
 	.read_time	= at32_rtc_readtime,
 	.set_time	= at32_rtc_settime,
 	.read_alarm	= at32_rtc_readalarm,
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index dba60c1..caf3556 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -469,7 +469,7 @@ static int davinci_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	return 0;
 }
 
-static struct rtc_class_ops davinci_rtc_ops = {
+static const struct rtc_class_ops davinci_rtc_ops = {
 	.ioctl			= davinci_rtc_ioctl,
 	.read_time		= davinci_rtc_read_time,
 	.set_time		= davinci_rtc_set_time,
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index f5dd09f..0ec4be6 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -102,7 +102,7 @@ static int ds1302_rtc_get_time(struct device *dev, struct rtc_time *time)
 	return rtc_valid_tm(time);
 }
 
-static struct rtc_class_ops ds1302_rtc_ops = {
+static const struct rtc_class_ops ds1302_rtc_ops = {
 	.read_time	= ds1302_rtc_get_time,
 	.set_time	= ds1302_rtc_set_time,
 };
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index b2bcfc0..5e14651 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -174,7 +174,7 @@ static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ, enable);
 }
 
-static struct rtc_class_ops jz4740_rtc_ops = {
+static const struct rtc_class_ops jz4740_rtc_ops = {
 	.read_time	= jz4740_rtc_read_time,
 	.set_mmss	= jz4740_rtc_set_mmss,
 	.read_alarm	= jz4740_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 025bb33..4021fd0 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -151,7 +151,7 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	return rtc_valid_tm(tim);
 }
 
-static struct rtc_class_ops mcp795_rtc_ops = {
+static const struct rtc_class_ops mcp795_rtc_ops = {
 		.read_time = mcp795_read_time,
 		.set_time = mcp795_set_time
 };
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ec2e9c5..cadac8e 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -469,7 +469,7 @@ static void omap_rtc_power_off(void)
 	mdelay(2500);
 }
 
-static struct rtc_class_ops omap_rtc_ops = {
+static const struct rtc_class_ops omap_rtc_ops = {
 	.read_time	= omap_rtc_read_time,
 	.set_time	= omap_rtc_set_time,
 	.read_alarm	= omap_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-palmas.c b/drivers/rtc/rtc-palmas.c
index 6080e0e..4bcfb88 100644
--- a/drivers/rtc/rtc-palmas.c
+++ b/drivers/rtc/rtc-palmas.c
@@ -225,7 +225,7 @@ static irqreturn_t palmas_rtc_interrupt(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops palmas_rtc_ops = {
+static const struct rtc_class_ops palmas_rtc_ops = {
 	.read_time	= palmas_rtc_read_time,
 	.set_time	= palmas_rtc_set_time,
 	.read_alarm	= palmas_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index e6b6911..00c31c9 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -232,7 +232,7 @@ static int pcf50633_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return ret;
 }
 
-static struct rtc_class_ops pcf50633_rtc_ops = {
+static const struct rtc_class_ops pcf50633_rtc_ops = {
 	.read_time		= pcf50633_rtc_read_time,
 	.set_time		= pcf50633_rtc_set_time,
 	.read_alarm		= pcf50633_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index 591793e..7c9c08e 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -317,7 +317,7 @@ static int rx6110_init(struct rx6110_data *rx6110)
 	return ret;
 }
 
-static struct rtc_class_ops rx6110_rtc_ops = {
+static const struct rtc_class_ops rx6110_rtc_ops = {
 	.read_time = rx6110_get_time,
 	.set_time = rx6110_set_time,
 };
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 2b85cc7..91857d8 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -403,7 +403,7 @@ static int rx8025_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static struct rtc_class_ops rx8025_rtc_ops = {
+static const struct rtc_class_ops rx8025_rtc_ops = {
 	.read_time = rx8025_get_time,
 	.set_time = rx8025_set_time,
 	.read_alarm = rx8025_read_alarm,
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index f05ef85..e377f42 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -343,7 +343,7 @@ static int spear_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return ret;
 }
 
-static struct rtc_class_ops spear_rtc_ops = {
+static const struct rtc_class_ops spear_rtc_ops = {
 	.read_time = spear_rtc_read_time,
 	.set_time = spear_rtc_set_time,
 	.read_alarm = spear_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index e6aaaa5..d578e40 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -231,7 +231,7 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	return 0;
 }
 
-static struct rtc_class_ops stmp3xxx_rtc_ops = {
+static const struct rtc_class_ops stmp3xxx_rtc_ops = {
 	.alarm_irq_enable =
 			  stmp3xxx_alarm_irq_enable,
 	.read_time	= stmp3xxx_rtc_gettime,
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 2dc787d..176720b 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -462,7 +462,7 @@ out:
 	return ret;
 }
 
-static struct rtc_class_ops twl_rtc_ops = {
+static const struct rtc_class_ops twl_rtc_ops = {
 	.read_time	= twl_rtc_read_time,
 	.set_time	= twl_rtc_set_time,
 	.read_alarm	= twl_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index 09fc1c1..b1b6b30 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -214,7 +214,7 @@ static int nuc900_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static struct rtc_class_ops nuc900_rtc_ops = {
+static const struct rtc_class_ops nuc900_rtc_ops = {
 	.read_time = nuc900_rtc_read_time,
 	.set_time = nuc900_rtc_set_time,
 	.read_alarm = nuc900_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 15ac597..3853ba9 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -291,7 +291,7 @@ static irqreturn_t tegra_rtc_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops tegra_rtc_ops = {
+static const struct rtc_class_ops tegra_rtc_ops = {
 	.read_time	= tegra_rtc_read_time,
 	.set_time	= tegra_rtc_set_time,
 	.read_alarm	= tegra_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 101b7a2..cfc4141 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -140,7 +140,7 @@ static int coh901331_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static struct rtc_class_ops coh901331_ops = {
+static const struct rtc_class_ops coh901331_ops = {
 	.read_time = coh901331_read_time,
 	.set_mmss = coh901331_set_mmss,
 	.read_alarm = coh901331_read_alarm,
diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index 8d05596..b253bf1 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -159,7 +159,7 @@ static int dc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	return 0;
 }
 
-static struct rtc_class_ops dc_rtc_ops = {
+static const struct rtc_class_ops dc_rtc_ops = {
 	.read_time		= dc_rtc_read_time,
 	.set_mmss		= dc_rtc_set_mmss,
 	.read_alarm		= dc_rtc_read_alarm,
diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 44f622c..1a61fa5 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -301,7 +301,7 @@ exit:
 	return ret;
 }
 
-static struct rtc_class_ops mtk_rtc_ops = {
+static const struct rtc_class_ops mtk_rtc_ops = {
 	.read_time  = mtk_rtc_read_time,
 	.set_time   = mtk_rtc_set_time,
 	.read_alarm = mtk_rtc_read_alarm,
