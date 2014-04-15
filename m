From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 11:00:50 -0600
Subject: [PATCH V2 1/4] pinctrl: tegra: remove redundant data table fields
Message-ID: <1397581250-1506-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Any SoC which supports the einput, odrain, lock, ioreset, or rcv_sel
options has the relevant HW register fields in the same register as the
mux function selection. Similarly, the drvtype option is always in the
drive register, if it is supported at all. Hence, we don't need to have
struct *_reg fields in the pin group table to define which register and
bank to use for those options. Delete this to save space in the driver's
data tables.

However, many of those options are not supported on all SoCs, or not
supported on some pingroups. We need a way to detect when they are
supported. Previously, this was indicated by setting the struct *_reg
field to -1. With the struct *_reg fields removed, we use the struct
*_bit fields for this purpose instead. The struct *_bit fields need to
be expanded from 5 to 6 bits in order to store a value outside the valid
HW bit range of 0..31.

Even without removing the struct *_reg fields, we still need to add code
to validate the struct *_bit fields, since some struct *_bit fields were
already being set to -1, without an option-specific struct *_reg field to
"guard" them. In other words, before this change, the pinmux driver might
allow some unsupported options to be written to HW.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
(Note: For V2, I'm only reposting patch 1/4, since patch 2/4 is large, and
I don't want to spam the list again with the whole series)

v2:
* Modify width of struct tegra_pingroup's drvtype_bit in the same way as
  other *_bit fields.
* Fix struct tegra_pingroup's documentation to match the changes made
  to the struct.
* Fix pinctrl-tegra20.c's DRV_PG_EXT() macro to initialize the drvtype_bit
  field.
---
 drivers/pinctrl/pinctrl-tegra.c    |  26 ++++----
 drivers/pinctrl/pinctrl-tegra.h    | 124 ++++++++++++++++---------------------
 drivers/pinctrl/pinctrl-tegra114.c |  53 ++++++----------
 drivers/pinctrl/pinctrl-tegra124.c |  53 ++++++----------
 drivers/pinctrl/pinctrl-tegra20.c  |  25 ++------
 drivers/pinctrl/pinctrl-tegra30.c  |  48 ++++++--------
 6 files changed, 132 insertions(+), 197 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index 65458096f41e..22faf5b10bda 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -336,32 +336,32 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 		*width = 1;
 		break;
 	case TEGRA_PINCONF_PARAM_ENABLE_INPUT:
-		*bank = g->einput_bank;
-		*reg = g->einput_reg;
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
 		*bit = g->einput_bit;
 		*width = 1;
 		break;
 	case TEGRA_PINCONF_PARAM_OPEN_DRAIN:
-		*bank = g->odrain_bank;
-		*reg = g->odrain_reg;
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
 		*bit = g->odrain_bit;
 		*width = 1;
 		break;
 	case TEGRA_PINCONF_PARAM_LOCK:
-		*bank = g->lock_bank;
-		*reg = g->lock_reg;
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
 		*bit = g->lock_bit;
 		*width = 1;
 		break;
 	case TEGRA_PINCONF_PARAM_IORESET:
-		*bank = g->ioreset_bank;
-		*reg = g->ioreset_reg;
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
 		*bit = g->ioreset_bit;
 		*width = 1;
 		break;
 	case TEGRA_PINCONF_PARAM_RCV_SEL:
-		*bank = g->rcv_sel_bank;
-		*reg = g->rcv_sel_reg;
+		*bank = g->mux_bank;
+		*reg = g->mux_reg;
 		*bit = g->rcv_sel_bit;
 		*width = 1;
 		break;
@@ -408,8 +408,8 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 		*width = g->slwr_width;
 		break;
 	case TEGRA_PINCONF_PARAM_DRIVE_TYPE:
-		*bank = g->drvtype_bank;
-		*reg = g->drvtype_reg;
+		*bank = g->drv_bank;
+		*reg = g->drv_reg;
 		*bit = g->drvtype_bit;
 		*width = 2;
 		break;
@@ -418,7 +418,7 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
 		return -ENOTSUPP;
 	}
 
-	if (*reg < 0) {
+	if (*reg < 0 || *bit > 31) {
 		if (report_err)
 			dev_err(pmx->dev,
 				"Config param %04x not supported on group %s\n",
diff --git a/drivers/pinctrl/pinctrl-tegra.h b/drivers/pinctrl/pinctrl-tegra.h
index 6053832d433e..7262ba8ebade 100644
--- a/drivers/pinctrl/pinctrl-tegra.h
+++ b/drivers/pinctrl/pinctrl-tegra.h
@@ -78,55 +78,49 @@ struct tegra_function {
 
 /**
  * struct tegra_pingroup - Tegra pin group
- * @mux_reg:		Mux register offset. -1 if unsupported.
- * @mux_bank:		Mux register bank. 0 if unsupported.
- * @mux_bit:		Mux register bit. 0 if unsupported.
- * @pupd_reg:		Pull-up/down register offset. -1 if unsupported.
- * @pupd_bank:		Pull-up/down register bank. 0 if unsupported.
- * @pupd_bit:		Pull-up/down register bit. 0 if unsupported.
- * @tri_reg:		Tri-state register offset. -1 if unsupported.
- * @tri_bank:		Tri-state register bank. 0 if unsupported.
- * @tri_bit:		Tri-state register bit. 0 if unsupported.
- * @einput_reg:		Enable-input register offset. -1 if unsupported.
- * @einput_bank:	Enable-input register bank. 0 if unsupported.
- * @einput_bit:		Enable-input register bit. 0 if unsupported.
- * @odrain_reg:		Open-drain register offset. -1 if unsupported.
- * @odrain_bank:	Open-drain register bank. 0 if unsupported.
- * @odrain_bit:		Open-drain register bit. 0 if unsupported.
- * @lock_reg:		Lock register offset. -1 if unsupported.
- * @lock_bank:		Lock register bank. 0 if unsupported.
- * @lock_bit:		Lock register bit. 0 if unsupported.
- * @ioreset_reg:	IO reset register offset. -1 if unsupported.
- * @ioreset_bank:	IO reset register bank. 0 if unsupported.
- * @ioreset_bit:	IO reset register bit. 0 if unsupported.
- * @rcv_sel_reg:	Receiver select offset. -1 if unsupported.
- * @rcv_sel_bank:	Receiver select bank. 0 if unsupported.
- * @rcv_sel_bit:	Receiver select bit. 0 if unsupported.
- * @drv_reg:		Drive fields register offset. -1 if unsupported.
- *			This register contains the hsm, schmitt, lpmd, drvdn,
- *			drvup, slwr, and slwf parameters.
- * @drv_bank:		Drive fields register bank. 0 if unsupported.
- * @hsm_bit:		High Speed Mode register bit. 0 if unsupported.
- * @schmitt_bit:	Scmitt register bit. 0 if unsupported.
- * @lpmd_bit:		Low Power Mode register bit. 0 if unsupported.
- * @drvdn_bit:		Drive Down register bit. 0 if unsupported.
- * @drvdn_width:	Drive Down field width. 0 if unsupported.
- * @drvup_bit:		Drive Up register bit. 0 if unsupported.
- * @drvup_width:	Drive Up field width. 0 if unsupported.
- * @slwr_bit:		Slew Rising register bit. 0 if unsupported.
- * @slwr_width:		Slew Rising field width. 0 if unsupported.
- * @slwf_bit:		Slew Falling register bit. 0 if unsupported.
- * @slwf_width:		Slew Falling field width. 0 if unsupported.
- * @drvtype_reg:	Drive type fields register offset. -1 if unsupported.
- * @drvtype_bank:	Drive type fields register bank. 0 if unsupported.
- * @drvtype_bit:	Drive type register bit. 0 if unsupported.
+ * @mux_reg:		Mux register offset.
+ *			This register contains the mux, einput, odrain, lock,
+ *			ioreset, rcv_sel parameters.
+ * @mux_bank:		Mux register bank.
+ * @mux_bit:		Mux register bit.
+ * @pupd_reg:		Pull-up/down register offset.
+ * @pupd_bank:		Pull-up/down register bank.
+ * @pupd_bit:		Pull-up/down register bit.
+ * @tri_reg:		Tri-state register offset.
+ * @tri_bank:		Tri-state register bank.
+ * @tri_bit:		Tri-state register bit.
+ * @einput_bit:		Enable-input register bit.
+ * @odrain_bit:		Open-drain register bit.
+ * @lock_bit:		Lock register bit.
+ * @ioreset_bit:	IO reset register bit.
+ * @rcv_sel_bit:	Receiver select bit.
+ * @drv_reg:		Drive fields register offset.
+ *			This register contains hsm, schmitt, lpmd, drvdn,
+ *			drvup, slwr, slwf, and drvtype parameters.
+ * @drv_bank:		Drive fields register bank.
+ * @hsm_bit:		High Speed Mode register bit.
+ * @schmitt_bit:	Scmitt register bit.
+ * @lpmd_bit:		Low Power Mode register bit.
+ * @drvdn_bit:		Drive Down register bit.
+ * @drvdn_width:	Drive Down field width.
+ * @drvup_bit:		Drive Up register bit.
+ * @drvup_width:	Drive Up field width.
+ * @slwr_bit:		Slew Rising register bit.
+ * @slwr_width:		Slew Rising field width.
+ * @slwf_bit:		Slew Falling register bit.
+ * @slwf_width:		Slew Falling field width.
+ * @drvtype_bit:	Drive type register bit.
+ *
+ * -1 in a *_reg field means that feature is unsupported for this group.
+ * *_bank and *_reg values are irrelevant when *_reg is -1.
+ * When *_reg is valid, *_bit may be -1 to indicate an unsupported feature.
  *
  * A representation of a group of pins (possibly just one pin) in the Tegra
  * pin controller. Each group allows some parameter or parameters to be
  * configured. The most common is mux function selection. Many others exist
  * such as pull-up/down, tri-state, etc. Tegra's pin controller is complex;
  * certain groups may only support configuring certain parameters, hence
- * each parameter is optional, represented by a -1 "reg" value.
+ * each parameter is optional.
  */
 struct tegra_pingroup {
 	const char *name;
@@ -137,39 +131,27 @@ struct tegra_pingroup {
 	s16 mux_reg;
 	s16 pupd_reg;
 	s16 tri_reg;
-	s16 einput_reg;
-	s16 odrain_reg;
-	s16 lock_reg;
-	s16 ioreset_reg;
-	s16 rcv_sel_reg;
 	s16 drv_reg;
-	s16 drvtype_reg;
 	u32 mux_bank:2;
 	u32 pupd_bank:2;
 	u32 tri_bank:2;
-	u32 einput_bank:2;
-	u32 odrain_bank:2;
-	u32 ioreset_bank:2;
-	u32 rcv_sel_bank:2;
-	u32 lock_bank:2;
 	u32 drv_bank:2;
-	u32 drvtype_bank:2;
-	u32 mux_bit:5;
-	u32 pupd_bit:5;
-	u32 tri_bit:5;
-	u32 einput_bit:5;
-	u32 odrain_bit:5;
-	u32 lock_bit:5;
-	u32 ioreset_bit:5;
-	u32 rcv_sel_bit:5;
-	u32 hsm_bit:5;
-	u32 schmitt_bit:5;
-	u32 lpmd_bit:5;
-	u32 drvdn_bit:5;
-	u32 drvup_bit:5;
-	u32 slwr_bit:5;
-	u32 slwf_bit:5;
-	u32 drvtype_bit:5;
+	u32 mux_bit:6;
+	u32 pupd_bit:6;
+	u32 tri_bit:6;
+	u32 einput_bit:6;
+	u32 odrain_bit:6;
+	u32 lock_bit:6;
+	u32 ioreset_bit:6;
+	u32 rcv_sel_bit:6;
+	u32 hsm_bit:6;
+	u32 schmitt_bit:6;
+	u32 lpmd_bit:6;
+	u32 drvdn_bit:6;
+	u32 drvup_bit:6;
+	u32 slwr_bit:6;
+	u32 slwf_bit:6;
+	u32 drvtype_bit:6;
 	u32 drvdn_width:6;
 	u32 drvup_width:6;
 	u32 slwr_width:6;
diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 63fe7619d3ff..6766873669e8 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -1547,8 +1547,10 @@ static struct tegra_function tegra114_functions[] = {
 #define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
 #define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
-#define PINGROUP_REG_N(r)		-1
+#define PINGROUP_REG(r)			((r) - PINGROUP_REG_A)
+
+#define PINGROUP_BIT_Y(b)		(b)
+#define PINGROUP_BIT_N(b)		(-1)
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior, rcv_sel)	\
 	{								\
@@ -1562,37 +1564,24 @@ static struct tegra_function tegra114_functions[] = {
 			TEGRA_MUX_##f3,					\
 		},							\
 		.func_safe = TEGRA_MUX_##f_safe,			\
-		.mux_reg = PINGROUP_REG_Y(r),				\
+		.mux_reg = PINGROUP_REG(r),				\
 		.mux_bank = 1,						\
 		.mux_bit = 0,						\
-		.pupd_reg = PINGROUP_REG_Y(r),				\
+		.pupd_reg = PINGROUP_REG(r),				\
 		.pupd_bank = 1,						\
 		.pupd_bit = 2,						\
-		.tri_reg = PINGROUP_REG_Y(r),				\
+		.tri_reg = PINGROUP_REG(r),				\
 		.tri_bank = 1,						\
 		.tri_bit = 4,						\
-		.einput_reg = PINGROUP_REG_Y(r),			\
-		.einput_bank = 1,					\
-		.einput_bit = 5,					\
-		.odrain_reg = PINGROUP_REG_##od(r),			\
-		.odrain_bank = 1,					\
-		.odrain_bit = 6,					\
-		.lock_reg = PINGROUP_REG_Y(r),				\
-		.lock_bank = 1,						\
-		.lock_bit = 7,						\
-		.ioreset_reg = PINGROUP_REG_##ior(r),			\
-		.ioreset_bank = 1,					\
-		.ioreset_bit = 8,					\
-		.rcv_sel_reg = PINGROUP_REG_##rcv_sel(r),		\
-		.rcv_sel_bank = 1,					\
-		.rcv_sel_bit = 9,					\
+		.einput_bit = PINGROUP_BIT_Y(5),			\
+		.odrain_bit = PINGROUP_BIT_##od(6),			\
+		.lock_bit = PINGROUP_BIT_Y(7),				\
+		.ioreset_bit = PINGROUP_BIT_##ior(8),			\
+		.rcv_sel_bit = PINGROUP_BIT_##rcv_sel(9),		\
 		.drv_reg = -1,						\
-		.drvtype_reg = -1,					\
 	}
 
-#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
-#define DRV_PINGROUP_REG_N(r)		-1
-
+#define DRV_PINGROUP_REG(r)		((r) - DRV_PINGROUP_REG_A)
 
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,		\
 		     drvdn_b, drvdn_w, drvup_b, drvup_w,		\
@@ -1605,12 +1594,12 @@ static struct tegra_function tegra114_functions[] = {
 		.mux_reg = -1,						\
 		.pupd_reg = -1,						\
 		.tri_reg = -1,						\
-		.einput_reg = -1,					\
-		.odrain_reg = -1,					\
-		.lock_reg = -1,						\
-		.ioreset_reg = -1,					\
-		.rcv_sel_reg = -1,					\
-		.drv_reg = DRV_PINGROUP_REG_Y(r),			\
+		.einput_bit = -1,					\
+		.odrain_bit = -1,					\
+		.lock_bit = -1,						\
+		.ioreset_bit = -1,					\
+		.rcv_sel_bit = -1,					\
+		.drv_reg = DRV_PINGROUP_REG(r),				\
 		.drv_bank = 0,						\
 		.hsm_bit = hsm_b,					\
 		.schmitt_bit = schmitt_b,				\
@@ -1623,9 +1612,7 @@ static struct tegra_function tegra114_functions[] = {
 		.slwr_width = slwr_w,					\
 		.slwf_bit = slwf_b,					\
 		.slwf_width = slwf_w,					\
-		.drvtype_reg = DRV_PINGROUP_REG_##drvtype(r),		\
-		.drvtype_bank = 0,					\
-		.drvtype_bit = 6,					\
+		.drvtype_bit = PINGROUP_BIT_##drvtype(6),		\
 	}
 
 static const struct tegra_pingroup tegra114_groups[] = {
diff --git a/drivers/pinctrl/pinctrl-tegra124.c b/drivers/pinctrl/pinctrl-tegra124.c
index 73773706755b..03e4918b5ade 100644
--- a/drivers/pinctrl/pinctrl-tegra124.c
+++ b/drivers/pinctrl/pinctrl-tegra124.c
@@ -1677,8 +1677,10 @@ static struct tegra_function tegra124_functions[] = {
 #define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
 #define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
-#define PINGROUP_REG_N(r)		-1
+#define PINGROUP_REG(r)			((r) - PINGROUP_REG_A)
+
+#define PINGROUP_BIT_Y(b)		(b)
+#define PINGROUP_BIT_N(b)		(-1)
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior, rcv_sel)	\
 	{								\
@@ -1692,37 +1694,24 @@ static struct tegra_function tegra124_functions[] = {
 			TEGRA_MUX_##f3,					\
 		},							\
 		.func_safe = TEGRA_MUX_##f_safe,			\
-		.mux_reg = PINGROUP_REG_Y(r),				\
+		.mux_reg = PINGROUP_REG(r),				\
 		.mux_bank = 1,						\
 		.mux_bit = 0,						\
-		.pupd_reg = PINGROUP_REG_Y(r),				\
+		.pupd_reg = PINGROUP_REG(r),				\
 		.pupd_bank = 1,						\
 		.pupd_bit = 2,						\
-		.tri_reg = PINGROUP_REG_Y(r),				\
+		.tri_reg = PINGROUP_REG(r),				\
 		.tri_bank = 1,						\
 		.tri_bit = 4,						\
-		.einput_reg = PINGROUP_REG_Y(r),			\
-		.einput_bank = 1,					\
-		.einput_bit = 5,					\
-		.odrain_reg = PINGROUP_REG_##od(r),			\
-		.odrain_bank = 1,					\
-		.odrain_bit = 6,					\
-		.lock_reg = PINGROUP_REG_Y(r),				\
-		.lock_bank = 1,						\
-		.lock_bit = 7,						\
-		.ioreset_reg = PINGROUP_REG_##ior(r),			\
-		.ioreset_bank = 1,					\
-		.ioreset_bit = 8,					\
-		.rcv_sel_reg = PINGROUP_REG_##rcv_sel(r),		\
-		.rcv_sel_bank = 1,					\
-		.rcv_sel_bit = 9,					\
+		.einput_bit = PINGROUP_BIT_Y(5),			\
+		.odrain_bit = PINGROUP_BIT_##od(6),			\
+		.lock_bit = PINGROUP_BIT_Y(7),				\
+		.ioreset_bit = PINGROUP_BIT_##ior(8),			\
+		.rcv_sel_bit = PINGROUP_BIT_##rcv_sel(9),		\
 		.drv_reg = -1,						\
-		.drvtype_reg = -1,					\
 	}
 
-#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
-#define DRV_PINGROUP_REG_N(r)		-1
-
+#define DRV_PINGROUP_REG(r)		((r) - DRV_PINGROUP_REG_A)
 
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,		\
 		     drvdn_b, drvdn_w, drvup_b, drvup_w,		\
@@ -1735,12 +1724,12 @@ static struct tegra_function tegra124_functions[] = {
 		.mux_reg = -1,						\
 		.pupd_reg = -1,						\
 		.tri_reg = -1,						\
-		.einput_reg = -1,					\
-		.odrain_reg = -1,					\
-		.lock_reg = -1,						\
-		.ioreset_reg = -1,					\
-		.rcv_sel_reg = -1,					\
-		.drv_reg = DRV_PINGROUP_REG_Y(r),			\
+		.einput_bit = -1,					\
+		.odrain_bit = -1,					\
+		.lock_bit = -1,						\
+		.ioreset_bit = -1,					\
+		.rcv_sel_bit = -1,					\
+		.drv_reg = DRV_PINGROUP_REG(r),				\
 		.drv_bank = 0,						\
 		.hsm_bit = hsm_b,					\
 		.schmitt_bit = schmitt_b,				\
@@ -1753,9 +1742,7 @@ static struct tegra_function tegra124_functions[] = {
 		.slwr_width = slwr_w,					\
 		.slwf_bit = slwf_b,					\
 		.slwf_width = slwf_w,					\
-		.drvtype_reg = DRV_PINGROUP_REG_##drvtype(r),		\
-		.drvtype_bank = 0,					\
-		.drvtype_bit = 6,					\
+		.drvtype_bit = PINGROUP_BIT_##drvtype(6),		\
 	}
 
 static const struct tegra_pingroup tegra124_groups[] = {
diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index e0b504088387..8d3b34a97ef5 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -1995,13 +1995,12 @@ static struct tegra_function tegra20_functions[] = {
 		.tri_reg = ((tri_r) - TRISTATE_REG_A),		\
 		.tri_bank = 0,					\
 		.tri_bit = tri_b,				\
-		.einput_reg = -1,				\
-		.odrain_reg = -1,				\
-		.lock_reg = -1,					\
-		.ioreset_reg = -1,				\
-		.rcv_sel_reg = -1,				\
+		.einput_bit = -1,				\
+		.odrain_bit = -1,				\
+		.lock_bit = -1,					\
+		.ioreset_bit = -1,				\
+		.rcv_sel_bit = -1,				\
 		.drv_reg = -1,					\
-		.drvtype_reg = -1,				\
 	}
 
 /* Pin groups with only pull up and pull down control */
@@ -2014,14 +2013,7 @@ static struct tegra_function tegra20_functions[] = {
 		.pupd_reg = ((pupd_r) - PULLUPDOWN_REG_A),	\
 		.pupd_bank = 2,					\
 		.pupd_bit = pupd_b,				\
-		.tri_reg = -1,					\
-		.einput_reg = -1,				\
-		.odrain_reg = -1,				\
-		.lock_reg = -1,					\
-		.ioreset_reg = -1,				\
-		.rcv_sel_reg = -1,				\
 		.drv_reg = -1,					\
-		.drvtype_reg = -1,				\
 	}
 
 /* Pin groups for drive strength registers (configurable version) */
@@ -2035,11 +2027,6 @@ static struct tegra_function tegra20_functions[] = {
 		.mux_reg = -1,					\
 		.pupd_reg = -1,					\
 		.tri_reg = -1,					\
-		.einput_reg = -1,				\
-		.odrain_reg = -1,				\
-		.lock_reg = -1,					\
-		.ioreset_reg = -1,				\
-		.rcv_sel_reg = -1,				\
 		.drv_reg = ((r) - PINGROUP_REG_A),		\
 		.drv_bank = 3,					\
 		.hsm_bit = hsm_b,				\
@@ -2053,7 +2040,7 @@ static struct tegra_function tegra20_functions[] = {
 		.slwr_width = slwr_w,				\
 		.slwf_bit = slwf_b,				\
 		.slwf_width = slwf_w,				\
-		.drvtype_reg = -1,				\
+		.drvtype_bit = -1,				\
 	}
 
 /* Pin groups for drive strength registers (simple version) */
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index 41d24f5c2854..6492adaa0575 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -2108,8 +2108,10 @@ static struct tegra_function tegra30_functions[] = {
 #define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
 #define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
-#define PINGROUP_REG_N(r)		-1
+#define PINGROUP_REG(r)			((r) - PINGROUP_REG_A)
+
+#define PINGROUP_BIT_Y(b)		(b)
+#define PINGROUP_BIT_N(b)		(-1)
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior)	\
 	{							\
@@ -2123,34 +2125,24 @@ static struct tegra_function tegra30_functions[] = {
 			TEGRA_MUX_##f3,				\
 		},						\
 		.func_safe = TEGRA_MUX_##f_safe,		\
-		.mux_reg = PINGROUP_REG_Y(r),			\
+		.mux_reg = PINGROUP_REG(r),			\
 		.mux_bank = 1,					\
 		.mux_bit = 0,					\
-		.pupd_reg = PINGROUP_REG_Y(r),			\
+		.pupd_reg = PINGROUP_REG(r),			\
 		.pupd_bank = 1,					\
 		.pupd_bit = 2,					\
-		.tri_reg = PINGROUP_REG_Y(r),			\
+		.tri_reg = PINGROUP_REG(r),			\
 		.tri_bank = 1,					\
 		.tri_bit = 4,					\
-		.einput_reg = PINGROUP_REG_Y(r),		\
-		.einput_bank = 1,				\
-		.einput_bit = 5,				\
-		.odrain_reg = PINGROUP_REG_##od(r),		\
-		.odrain_bank = 1,				\
-		.odrain_bit = 6,				\
-		.lock_reg = PINGROUP_REG_Y(r),			\
-		.lock_bank = 1,					\
-		.lock_bit = 7,					\
-		.ioreset_reg = PINGROUP_REG_##ior(r),		\
-		.ioreset_bank = 1,				\
-		.ioreset_bit = 8,				\
-		.rcv_sel_reg = -1,				\
+		.einput_bit = PINGROUP_BIT_Y(5),		\
+		.odrain_bit = PINGROUP_BIT_##od(6),		\
+		.lock_bit = PINGROUP_BIT_Y(7),			\
+		.ioreset_bit = PINGROUP_BIT_##ior(8),		\
+		.rcv_sel_bit = -1,				\
 		.drv_reg = -1,					\
-		.drvtype_reg = -1,				\
 	}
 
-#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
-#define DRV_PINGROUP_REG_N(r)		-1
+#define DRV_PINGROUP_REG(r)		((r) - DRV_PINGROUP_REG_A)
 
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,	\
 		     drvdn_b, drvdn_w, drvup_b, drvup_w,	\
@@ -2162,12 +2154,12 @@ static struct tegra_function tegra30_functions[] = {
 		.mux_reg = -1,					\
 		.pupd_reg = -1,					\
 		.tri_reg = -1,					\
-		.einput_reg = -1,				\
-		.odrain_reg = -1,				\
-		.lock_reg = -1,					\
-		.ioreset_reg = -1,				\
-		.rcv_sel_reg = -1,				\
-		.drv_reg = DRV_PINGROUP_REG_Y(r),		\
+		.einput_bit = -1,				\
+		.odrain_bit = -1,				\
+		.lock_bit = -1,					\
+		.ioreset_bit = -1,				\
+		.rcv_sel_bit = -1,				\
+		.drv_reg = DRV_PINGROUP_REG(r),			\
 		.drv_bank = 0,					\
 		.hsm_bit = hsm_b,				\
 		.schmitt_bit = schmitt_b,			\
@@ -2180,7 +2172,7 @@ static struct tegra_function tegra30_functions[] = {
 		.slwr_width = slwr_w,				\
 		.slwf_bit = slwf_b,				\
 		.slwf_width = slwf_w,				\
-		.drvtype_reg = -1,				\
+		.drvtype_bit = -1,				\
 	}
 
 static const struct tegra_pingroup tegra30_groups[] = {
-- 
1.8.1.5
