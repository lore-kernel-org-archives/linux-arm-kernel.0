From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 11:03:20 +0000
Subject: [PATCH RFC 2/5] pinctrl: mvebu: provide per-control private data
In-Reply-To: <20170113110240.GA29164@n2100.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
Message-ID: <E1cRzdg-0002YX-D7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide per-control private data into each mvebu pinctrl method, which
will allow us to provide some completely generic helpers without the
global variable and per-instance function definitions that would be
required when we have multiple pin controllers on a SoC.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-375.c |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 50 ++++++++++++++++++++----------
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   |  6 ++--
 drivers/pinctrl/mvebu/pinctrl-mvebu.c      | 14 ++++++---
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      | 21 ++++++++++---
 drivers/pinctrl/mvebu/pinctrl-orion.c      |  6 ++--
 10 files changed, 88 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 3cb6b4ea0118..4dc083ffd561 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -25,12 +25,14 @@
 
 static void __iomem *mpp_base;
 
-static int armada_370_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int armada_370_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int armada_370_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int armada_370_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index c9dba08780c5..c6168102bd17 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -25,12 +25,14 @@
 
 static void __iomem *mpp_base;
 
-static int armada_375_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int armada_375_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int armada_375_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int armada_375_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 52f2ab82901a..98aee37effef 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -24,12 +24,14 @@
 
 static void __iomem *mpp_base;
 
-static int armada_38x_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int armada_38x_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int armada_38x_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int armada_38x_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 8ebc28ac289e..4b1ba4424e0a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -24,12 +24,14 @@
 
 static void __iomem *mpp_base;
 
-static int armada_39x_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int armada_39x_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int armada_39x_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int armada_39x_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				   unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index cec3fef6f77f..a777925e0f34 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -33,12 +33,14 @@
 static void __iomem *mpp_base;
 static u32 *mpp_saved_regs;
 
-static int armada_xp_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int armada_xp_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				  unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int armada_xp_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int armada_xp_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				  unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index 745421496f6b..fb0b42c24405 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -66,17 +66,20 @@ static void __iomem *mpp4_base;
 static void __iomem *pmu_base;
 static struct regmap *gconfmap;
 
-static int dove_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			     unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int dove_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int dove_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			     unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
 
-static int dove_pmu_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_pmu_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				 unsigned pid, unsigned long *config)
 {
 	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
@@ -93,7 +96,8 @@ static int dove_pmu_mpp_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_pmu_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int dove_pmu_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				 unsigned pid, unsigned long config)
 {
 	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
@@ -114,7 +118,8 @@ static int dove_pmu_mpp_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-static int dove_mpp4_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_mpp4_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long *config)
 {
 	unsigned long mpp4 = readl(mpp4_base);
 	unsigned long mask;
@@ -144,7 +149,8 @@ static int dove_mpp4_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_mpp4_ctrl_set(unsigned pid, unsigned long config)
+static int dove_mpp4_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long config)
 {
 	unsigned long mpp4 = readl(mpp4_base);
 	unsigned long mask;
@@ -178,7 +184,8 @@ static int dove_mpp4_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-static int dove_nand_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_nand_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long *config)
 {
 	unsigned int gmpp;
 
@@ -188,7 +195,8 @@ static int dove_nand_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_nand_ctrl_set(unsigned pid, unsigned long config)
+static int dove_nand_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long config)
 {
 	regmap_update_bits(gconfmap, MPP_GENERAL_CONFIG,
 			   NAND_GPIO_EN,
@@ -196,7 +204,8 @@ static int dove_nand_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-static int dove_audio0_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_audio0_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+				unsigned long *config)
 {
 	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
 
@@ -205,7 +214,8 @@ static int dove_audio0_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_audio0_ctrl_set(unsigned pid, unsigned long config)
+static int dove_audio0_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+				unsigned long config)
 {
 	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
 
@@ -217,7 +227,8 @@ static int dove_audio0_ctrl_set(unsigned pid, unsigned long config)
 	return 0;
 }
 
-static int dove_audio1_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_audio1_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+				unsigned long *config)
 {
 	unsigned int mpp4 = readl(mpp4_base);
 	unsigned int sspc1;
@@ -247,7 +258,8 @@ static int dove_audio1_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_audio1_ctrl_set(unsigned pid, unsigned long config)
+static int dove_audio1_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+				unsigned long config)
 {
 	unsigned int mpp4 = readl(mpp4_base);
 
@@ -274,11 +286,12 @@ static int dove_audio1_ctrl_set(unsigned pid, unsigned long config)
  * break other functions. If you require all mpps as gpio
  * enforce gpio setting by pinctrl mapping.
  */
-static int dove_audio1_ctrl_gpio_req(unsigned pid)
+static int dove_audio1_ctrl_gpio_req(struct mvebu_mpp_ctrl_data *data,
+				     unsigned pid)
 {
 	unsigned long config;
 
-	dove_audio1_ctrl_get(pid, &config);
+	dove_audio1_ctrl_get(data, pid, &config);
 
 	switch (config) {
 	case 0x02: /* i2s1 : gpio[56:57] */
@@ -301,14 +314,16 @@ static int dove_audio1_ctrl_gpio_req(unsigned pid)
 }
 
 /* mpp[52:57] has gpio pins capable of in and out */
-static int dove_audio1_ctrl_gpio_dir(unsigned pid, bool input)
+static int dove_audio1_ctrl_gpio_dir(struct mvebu_mpp_ctrl_data *data,
+				     unsigned pid, bool input)
 {
 	if (pid < 52 || pid > 57)
 		return -ENOTSUPP;
 	return 0;
 }
 
-static int dove_twsi_ctrl_get(unsigned pid, unsigned long *config)
+static int dove_twsi_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long *config)
 {
 	unsigned int gcfg1;
 	unsigned int gcfg2;
@@ -327,7 +342,8 @@ static int dove_twsi_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int dove_twsi_ctrl_set(unsigned pid, unsigned long config)
+static int dove_twsi_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			      unsigned long config)
 {
 	unsigned int gcfg1 = 0;
 	unsigned int gcfg2 = 0;
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index a331bb13a984..89101f36f5d0 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -23,12 +23,14 @@
 
 static void __iomem *mpp_base;
 
-static int kirkwood_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int kirkwood_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+				 unsigned pid, unsigned long *config)
 {
 	return default_mpp_ctrl_get(mpp_base, pid, config);
 }
 
-static int kirkwood_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int kirkwood_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+				 unsigned pid, unsigned long config)
 {
 	return default_mpp_ctrl_set(mpp_base, pid, config);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index a073d67f03e3..c2e35da9bbd7 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -39,6 +39,7 @@ struct mvebu_pinctrl_function {
 struct mvebu_pinctrl_group {
 	const char *name;
 	const struct mvebu_mpp_ctrl *ctrl;
+	struct mvebu_mpp_ctrl_data *data;
 	struct mvebu_mpp_ctrl_setting *settings;
 	unsigned num_settings;
 	unsigned gid;
@@ -146,7 +147,7 @@ static int mvebu_pinconf_group_get(struct pinctrl_dev *pctldev,
 	if (!grp->ctrl)
 		return -EINVAL;
 
-	return grp->ctrl->mpp_get(grp->pins[0], config);
+	return grp->ctrl->mpp_get(grp->data, grp->pins[0], config);
 }
 
 static int mvebu_pinconf_group_set(struct pinctrl_dev *pctldev,
@@ -161,7 +162,7 @@ static int mvebu_pinconf_group_set(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	for (i = 0; i < num_configs; i++) {
-		ret = grp->ctrl->mpp_set(grp->pins[0], configs[i]);
+		ret = grp->ctrl->mpp_set(grp->data, grp->pins[0], configs[i]);
 		if (ret)
 			return ret;
 	} /* for each config */
@@ -302,7 +303,7 @@ static int mvebu_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	if (grp->ctrl->mpp_gpio_req)
-		return grp->ctrl->mpp_gpio_req(offset);
+		return grp->ctrl->mpp_gpio_req(grp->data, offset);
 
 	setting = mvebu_pinctrl_find_gpio_setting(pctl, grp);
 	if (!setting)
@@ -325,7 +326,7 @@ static int mvebu_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	if (grp->ctrl->mpp_gpio_dir)
-		return grp->ctrl->mpp_gpio_dir(offset, input);
+		return grp->ctrl->mpp_gpio_dir(grp->data, offset, input);
 
 	setting = mvebu_pinctrl_find_gpio_setting(pctl, grp);
 	if (!setting)
@@ -629,8 +630,12 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 	gid = 0;
 	for (n = 0; n < soc->ncontrols; n++) {
 		const struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
+		struct mvebu_mpp_ctrl_data *data = soc->control_data ?
+						   &soc->control_data[n] : NULL;
+
 		pctl->groups[gid].gid = gid;
 		pctl->groups[gid].ctrl = ctrl;
+		pctl->groups[gid].data = data;
 		pctl->groups[gid].name = ctrl->name;
 		pctl->groups[gid].pins = ctrl->pins;
 		pctl->groups[gid].npins = ctrl->npins;
@@ -650,6 +655,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 				gid++;
 				pctl->groups[gid].gid = gid;
 				pctl->groups[gid].ctrl = ctrl;
+				pctl->groups[gid].data = data;
 				pctl->groups[gid].name = noname_buf;
 				pctl->groups[gid].pins = &ctrl->pins[k];
 				pctl->groups[gid].npins = 1;
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index 7f7c24ac49e3..37bfa3bb56f0 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -14,6 +14,14 @@
 #define __PINCTRL_MVEBU_H__
 
 /**
+ * struct mvebu_mpp_ctrl_data - private data for the mpp ctrl operations
+ * @base: base address of pinctrl hardware
+ */
+struct mvebu_mpp_ctrl_data {
+	void __iomem *base;
+};
+
+/**
  * struct mvebu_mpp_ctrl - describe a mpp control
  * @name: name of the control group
  * @pid: first pin id handled by this control
@@ -37,10 +45,13 @@ struct mvebu_mpp_ctrl {
 	u8 pid;
 	u8 npins;
 	unsigned *pins;
-	int (*mpp_get)(unsigned pid, unsigned long *config);
-	int (*mpp_set)(unsigned pid, unsigned long config);
-	int (*mpp_gpio_req)(unsigned pid);
-	int (*mpp_gpio_dir)(unsigned pid, bool input);
+	int (*mpp_get)(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+		       unsigned long *config);
+	int (*mpp_set)(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+		       unsigned long config);
+	int (*mpp_gpio_req)(struct mvebu_mpp_ctrl_data *data, unsigned pid);
+	int (*mpp_gpio_dir)(struct mvebu_mpp_ctrl_data *data, unsigned pid,
+			    bool input);
 };
 
 /**
@@ -93,6 +104,7 @@ struct mvebu_mpp_mode {
  * struct mvebu_pinctrl_soc_info - SoC specific info passed to pinctrl-mvebu
  * @variant: variant mask of soc_info
  * @controls: list of available mvebu_mpp_ctrls
+ * @control_data: optional array, one entry for each control
  * @ncontrols: number of available mvebu_mpp_ctrls
  * @modes: list of available mvebu_mpp_modes
  * @nmodes: number of available mvebu_mpp_modes
@@ -106,6 +118,7 @@ struct mvebu_mpp_mode {
 struct mvebu_pinctrl_soc_info {
 	u8 variant;
 	const struct mvebu_mpp_ctrl *controls;
+	struct mvebu_mpp_ctrl_data *control_data;
 	int ncontrols;
 	struct mvebu_mpp_mode *modes;
 	int nmodes;
diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
index 18c83b0a5a7c..c2e0c16cf9b3 100644
--- a/drivers/pinctrl/mvebu/pinctrl-orion.c
+++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
@@ -32,7 +32,8 @@
 static void __iomem *mpp_base;
 static void __iomem *high_mpp_base;
 
-static int orion_mpp_ctrl_get(unsigned pid, unsigned long *config)
+static int orion_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
+			      unsigned pid, unsigned long *config)
 {
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 
@@ -47,7 +48,8 @@ static int orion_mpp_ctrl_get(unsigned pid, unsigned long *config)
 	return 0;
 }
 
-static int orion_mpp_ctrl_set(unsigned pid, unsigned long config)
+static int orion_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
+			      unsigned pid, unsigned long config)
 {
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 
-- 
2.7.4
