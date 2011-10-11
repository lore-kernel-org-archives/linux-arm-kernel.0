From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 11 Oct 2011 17:22:00 -0600
Subject: [PATCH] arm/tegra: pinmux: ioremap registers
Message-ID: <1318375320-21138-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ioremap to obtain access to registers instead of using static
mappings. This reduces the number of users of the static mappings, which
will eventually allow them to be removed.

Note that on Tegra30, the number of register "spaces" will decrease to 2,
and the packing of specific bits into registers will change significantly.
That's why this change adds the "*_space" fields to the pingroup tables,
rather than implementing some more hard-coded scheme.

Also, completely remove the implementation of suspend/resume; Tegra doesn't
yet support suspend/resume, and the implementation is complex for the
general pinmux driver:

* Not all registers are used within each space, so we probably shouldn't
  just iterate over every register in the space, and save/restore it,
  since that would mean touching undefined registers.

* Registers are shared between pingroups, so we can't simply iterate over
  each pingroup, and save/restore the registers it uses.

It'd probably be best have probe() calculate a bitmask of actually-used
registers for each space, and have suspend/resume iterate over those
bitmaps.

Oh, and Real Soon Now, I should be looking into converting this driver to
the new pinmux/pinctrl subsystem, so I didn't want to put too much work
into the current incarnation.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/pinmux.h |    4 +
 arch/arm/mach-tegra/pinmux-t2-tables.c    |   76 +++-------------
 arch/arm/mach-tegra/pinmux.c              |  137 ++++++++++++++++++++++-------
 3 files changed, 123 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
index defd877..741147f 100644
--- a/arch/arm/mach-tegra/include/mach/pinmux.h
+++ b/arch/arm/mach-tegra/include/mach/pinmux.h
@@ -199,6 +199,7 @@ struct tegra_drive_pingroup_config {
 
 struct tegra_drive_pingroup_desc {
 	const char *name;
+	s16 reg_space;
 	s16 reg;
 };
 
@@ -207,6 +208,9 @@ struct tegra_pingroup_desc {
 	int funcs[4];
 	int func_safe;
 	int vddio;
+	s16 tri_space;	/* Register space the tri_reg exists within */
+	s16 mux_space;	/* Register space the mux_reg exists within */
+	s16 pupd_space;	/* Register space the pupd_reg exists within */
 	s16 tri_reg; 	/* offset into the TRISTATE_REG_* register bank */
 	s16 mux_reg;	/* offset into the PIN_MUX_CTL_* register bank */
 	s16 pupd_reg;	/* offset into the PULL_UPDOWN_REG_* register bank */
diff --git a/arch/arm/mach-tegra/pinmux-t2-tables.c b/arch/arm/mach-tegra/pinmux-t2-tables.c
index a475367..42795ec 100644
--- a/arch/arm/mach-tegra/pinmux-t2-tables.c
+++ b/arch/arm/mach-tegra/pinmux-t2-tables.c
@@ -31,10 +31,16 @@
 #include <mach/pinmux.h>
 #include <mach/suspend.h>
 
+#define TRISTATE_REG_A		0x14
+#define PIN_MUX_CTL_REG_A	0x80
+#define PULLUPDOWN_REG_A	0xa0
+#define PINGROUP_REG_A		0x868
+
 #define DRIVE_PINGROUP(pg_name, r)				\
 	[TEGRA_DRIVE_PINGROUP_ ## pg_name] = {			\
 		.name = #pg_name,				\
-		.reg = r					\
+		.reg_space = 3,					\
+		.reg = ((r) - PINGROUP_REG_A)			\
 	}
 
 const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[TEGRA_MAX_DRIVE_PINGROUP] = {
@@ -90,11 +96,14 @@ const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[TEGRA_MAX_DRIVE
 			TEGRA_MUX_ ## f3,			\
 		},						\
 		.func_safe = TEGRA_MUX_ ## f_safe,		\
-		.tri_reg = tri_r,				\
+		.tri_space = 0,					\
+		.tri_reg = ((tri_r) - TRISTATE_REG_A),		\
 		.tri_bit = tri_b,				\
-		.mux_reg = mux_r,				\
+		.mux_space = 1,					\
+		.mux_reg = ((mux_r) - PIN_MUX_CTL_REG_A),	\
 		.mux_bit = mux_b,				\
-		.pupd_reg = pupd_r,				\
+		.pupd_space = 2,				\
+		.pupd_reg = ((pupd_r) - PULLUPDOWN_REG_A),	\
 		.pupd_bit = pupd_b,				\
 	}
 
@@ -217,62 +226,3 @@ const struct tegra_pingroup_desc tegra_soc_pingroups[TEGRA_MAX_PINGROUP] = {
 	PINGROUP(XM2C,  DDR,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xA8, 30),
 	PINGROUP(XM2D,  DDR,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xA8, 28),
 };
-
-#ifdef CONFIG_PM
-#define TRISTATE_REG_A         0x14
-#define TRISTATE_REG_NUM       4
-#define PIN_MUX_CTL_REG_A      0x80
-#define PIN_MUX_CTL_REG_NUM    8
-#define PULLUPDOWN_REG_A       0xa0
-#define PULLUPDOWN_REG_NUM     5
-
-static u32 pinmux_reg[TRISTATE_REG_NUM + PIN_MUX_CTL_REG_NUM +
-		      PULLUPDOWN_REG_NUM +
-		      ARRAY_SIZE(tegra_soc_drive_pingroups)];
-
-static inline unsigned long pg_readl(unsigned long offset)
-{
-	return readl(IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
-}
-
-static inline void pg_writel(unsigned long value, unsigned long offset)
-{
-	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
-}
-
-void tegra_pinmux_suspend(void)
-{
-	unsigned int i;
-	u32 *ctx = pinmux_reg;
-
-	for (i = 0; i < PIN_MUX_CTL_REG_NUM; i++)
-		*ctx++ = pg_readl(PIN_MUX_CTL_REG_A + i*4);
-
-	for (i = 0; i < PULLUPDOWN_REG_NUM; i++)
-		*ctx++ = pg_readl(PULLUPDOWN_REG_A + i*4);
-
-	for (i = 0; i < TRISTATE_REG_NUM; i++)
-		*ctx++ = pg_readl(TRISTATE_REG_A + i*4);
-
-	for (i = 0; i < ARRAY_SIZE(tegra_soc_drive_pingroups); i++)
-		*ctx++ = pg_readl(tegra_soc_drive_pingroups[i].reg);
-}
-
-void tegra_pinmux_resume(void)
-{
-	unsigned int i;
-	u32 *ctx = pinmux_reg;
-
-	for (i = 0; i < PIN_MUX_CTL_REG_NUM; i++)
-		pg_writel(*ctx++, PIN_MUX_CTL_REG_A + i*4);
-
-	for (i = 0; i < PULLUPDOWN_REG_NUM; i++)
-		pg_writel(*ctx++, PULLUPDOWN_REG_A + i*4);
-
-	for (i = 0; i < TRISTATE_REG_NUM; i++)
-		pg_writel(*ctx++, TRISTATE_REG_A + i*4);
-
-	for (i = 0; i < ARRAY_SIZE(tegra_soc_drive_pingroups); i++)
-		pg_writel(*ctx++, tegra_soc_drive_pingroups[i].reg);
-}
-#endif
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index 46b9d87..99c2751 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -170,15 +170,17 @@ static const char *pupd_name(unsigned long val)
 	}
 }
 
+static int nspaces;
+static void __iomem **regs;
 
-static inline unsigned long pg_readl(unsigned long offset)
+static inline u32 pg_readl(u32 reg, u32 space)
 {
-	return readl(IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	return readl(regs[space] + reg);
 }
 
-static inline void pg_writel(unsigned long value, unsigned long offset)
+static inline void pg_writel(u32 val, u32 reg, u32 space)
 {
-	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+	writel(val, regs[space] + reg);
 }
 
 static int tegra_pinmux_set_func(const struct tegra_pingroup_config *config)
@@ -218,10 +220,10 @@ static int tegra_pinmux_set_func(const struct tegra_pingroup_config *config)
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(pingroups[pg].mux_reg);
+	reg = pg_readl(pingroups[pg].mux_reg, pingroups[pg].mux_space);
 	reg &= ~(0x3 << pingroups[pg].mux_bit);
 	reg |= mux << pingroups[pg].mux_bit;
-	pg_writel(reg, pingroups[pg].mux_reg);
+	pg_writel(reg, pingroups[pg].mux_reg, pingroups[pg].mux_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -242,11 +244,11 @@ int tegra_pinmux_set_tristate(enum tegra_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(pingroups[pg].tri_reg);
+	reg = pg_readl(pingroups[pg].tri_reg, pingroups[pg].tri_space);
 	reg &= ~(0x1 << pingroups[pg].tri_bit);
 	if (tristate)
 		reg |= 1 << pingroups[pg].tri_bit;
-	pg_writel(reg, pingroups[pg].tri_reg);
+	pg_writel(reg, pingroups[pg].tri_reg, pingroups[pg].tri_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -273,10 +275,10 @@ int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(pingroups[pg].pupd_reg);
+	reg = pg_readl(pingroups[pg].pupd_reg, pingroups[pg].pupd_space);
 	reg &= ~(0x3 << pingroups[pg].pupd_bit);
 	reg |= pupd << pingroups[pg].pupd_bit;
-	pg_writel(reg, pingroups[pg].pupd_reg);
+	pg_writel(reg, pingroups[pg].pupd_reg, pingroups[pg].pupd_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -363,12 +365,12 @@ static int tegra_drive_pinmux_set_hsm(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	if (hsm == TEGRA_HSM_ENABLE)
 		reg |= (1 << 2);
 	else
 		reg &= ~(1 << 2);
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -388,12 +390,12 @@ static int tegra_drive_pinmux_set_schmitt(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	if (schmitt == TEGRA_SCHMITT_ENABLE)
 		reg |= (1 << 3);
 	else
 		reg &= ~(1 << 3);
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -413,10 +415,10 @@ static int tegra_drive_pinmux_set_drive(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	reg &= ~(0x3 << 4);
 	reg |= drive << 4;
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -436,10 +438,10 @@ static int tegra_drive_pinmux_set_pull_down(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	reg &= ~(0x1f << 12);
 	reg |= pull_down << 12;
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -459,10 +461,10 @@ static int tegra_drive_pinmux_set_pull_up(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	reg &= ~(0x1f << 12);
 	reg |= pull_up << 12;
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -482,10 +484,10 @@ static int tegra_drive_pinmux_set_slew_rising(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	reg &= ~(0x3 << 28);
 	reg |= slew_rising << 28;
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -505,10 +507,10 @@ static int tegra_drive_pinmux_set_slew_falling(enum tegra_drive_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(drive_pingroups[pg].reg);
+	reg = pg_readl(drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 	reg &= ~(0x3 << 30);
 	reg |= slew_falling << 30;
-	pg_writel(reg, drive_pingroups[pg].reg);
+	pg_writel(reg, drive_pingroups[pg].reg, drive_pingroups[pg].reg_space);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -668,6 +670,74 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
 
 static int __init tegra_pinmux_probe(struct platform_device *pdev)
 {
+	struct resource *res;
+	int i;
+	int config_bad = 0;
+
+	for (i = 0; ; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+	}
+	nspaces = i;
+
+	for (i = 0; i < TEGRA_MAX_PINGROUP; i++) {
+		if (pingroups[i].tri_space >= nspaces) {
+			dev_err(&pdev->dev, "pingroup %d: bad tri_space\n", i);
+			config_bad = 1;
+		}
+
+		if (pingroups[i].mux_space >= nspaces) {
+			dev_err(&pdev->dev, "pingroup %d: bad mux_space\n", i);
+			config_bad = 1;
+		}
+
+		if (pingroups[i].pupd_space >= nspaces) {
+			dev_err(&pdev->dev, "pingroup %d: bad pupd_space\n", i);
+			config_bad = 1;
+		}
+	}
+
+	for (i = 0; i < TEGRA_MAX_DRIVE_PINGROUP; i++) {
+		if (drive_pingroups[i].reg_space >= nspaces) {
+			dev_err(&pdev->dev,
+				"drive pingroup %d: bad reg_space\n", i);
+			config_bad = 1;
+		}
+	}
+
+	if (config_bad)
+		return -ENODEV;
+
+	regs = devm_kzalloc(&pdev->dev, nspaces * sizeof(*regs), GFP_KERNEL);
+	if (!regs) {
+		dev_err(&pdev->dev, "Can't alloc regs pointer\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < nspaces; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			dev_err(&pdev->dev, "Missing MEM resource\n");
+			return -ENODEV;
+		}
+
+		if (!devm_request_mem_region(&pdev->dev, res->start,
+					    resource_size(res),
+					    dev_name(&pdev->dev))) {
+			dev_err(&pdev->dev,
+				"Couldn't request MEM resource %d\n", i);
+			return -ENODEV;
+		}
+
+		regs[i] = devm_ioremap(&pdev->dev, res->start,
+					resource_size(res));
+		if (!regs) {
+			dev_err(&pdev->dev, "Couldn't ioremap regs %d\n", i);
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
 
@@ -710,6 +780,7 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 	int len;
 
 	for (i = 0; i < TEGRA_MAX_PINGROUP; i++) {
+		unsigned long reg;
 		unsigned long tri;
 		unsigned long mux;
 		unsigned long pupd;
@@ -722,8 +793,9 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 			seq_printf(s, "TEGRA_MUX_NONE");
 			len = strlen("NONE");
 		} else {
-			mux = (pg_readl(pingroups[i].mux_reg) >>
-			       pingroups[i].mux_bit) & 0x3;
+			reg = pg_readl(pingroups[i].mux_reg,
+					pingroups[i].mux_space);
+			mux = (reg >> pingroups[i].mux_bit) & 0x3;
 			if (pingroups[i].funcs[mux] == TEGRA_MUX_RSVD) {
 				seq_printf(s, "TEGRA_MUX_RSVD%1lu", mux+1);
 				len = 5;
@@ -739,8 +811,9 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 			seq_printf(s, "TEGRA_PUPD_NORMAL");
 			len = strlen("NORMAL");
 		} else {
-			pupd = (pg_readl(pingroups[i].pupd_reg) >>
-				pingroups[i].pupd_bit) & 0x3;
+			reg = pg_readl(pingroups[i].pupd_reg,
+					pingroups[i].pupd_space);
+			pupd = (reg >> pingroups[i].pupd_bit) & 0x3;
 			seq_printf(s, "TEGRA_PUPD_%s", pupd_name(pupd));
 			len = strlen(pupd_name(pupd));
 		}
@@ -749,8 +822,9 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 		if (pingroups[i].tri_reg < 0) {
 			seq_printf(s, "TEGRA_TRI_NORMAL");
 		} else {
-			tri = (pg_readl(pingroups[i].tri_reg) >>
-			       pingroups[i].tri_bit) & 0x1;
+			reg = pg_readl(pingroups[i].tri_reg,
+					pingroups[i].tri_space);
+			tri = (reg >> pingroups[i].tri_bit) & 0x1;
 
 			seq_printf(s, "TEGRA_TRI_%s", tri_name(tri));
 		}
@@ -785,7 +859,8 @@ static int dbg_drive_pinmux_show(struct seq_file *s, void *unused)
 		dbg_pad_field(s, 7 - len);
 
 
-		reg = pg_readl(drive_pingroups[i].reg);
+		reg = pg_readl(drive_pingroups[i].reg,
+				drive_pingroups[i].reg_space);
 		if (HSM_EN(reg)) {
 			seq_printf(s, "TEGRA_HSM_ENABLE");
 			len = 16;
-- 
1.7.0.4
