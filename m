From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 17:30:34 +0900
Subject: [PATCH 2/4] ARM: S5PV210: Powerdomain/Clock-gating Support
In-Reply-To: <1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210 Machine specific code for powerdomain/clock-gating support

Powerdomains and Blocks are defined for each corresponding clk.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig |   17 ++
 arch/arm/mach-s5pv210/clock.c |  461 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 478 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 631019a..92f6b74 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -101,4 +101,21 @@ config MACH_SMDKC110
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
 
+config S5PV210_POWERDOMAIN
+	bool "Use Powerdomain control for S5PV210"
+	depends on SAMSUNG_POWERDOMAIN && CPU_S5PV210
+	help
+	  Compile support for powerdomain controls in S5PV210.
+	  This code allows enabling and diabling powerdomain
+	  according to its clocks, which often saves significant
+	  amount of power. Note that BLOCKGATING code depends on
+	  POWERDOMAIN in S5PV210 code.
+
+config S5PV210_BLOCKGATING
+	bool "Use Block Gating for S5PV210"
+	depends on SAMSUNG_POWERDOMAIN && S5PV210_POWERDOMAIN &&\
+		SAMSUNG_BLOCKGATING
+	help
+	  Compile support for block gating controls in S5PV210.
+
 endif
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 04a0ef9..af2af5e 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/sysdev.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 
 #include <mach/map.h>
 
@@ -31,6 +32,392 @@
 #include <plat/clock-clksrc.h>
 #include <plat/s5pv210.h>
 
+#ifdef CONFIG_S5PV210_POWERDOMAIN
+#include <linux/delay.h>
+#define PD_SET(x)		.pd = &pd_##x,
+
+#ifdef CONFIG_S5PV210_BLOCKGATING
+#define BD_SET(x)		.bd = &bd_##x,
+#else
+#define BD_SET(x)
+#endif
+
+#else
+#define PD_SET(x)
+#define BD_SET(x)
+#endif
+
+#ifdef CONFIG_S5PV210_POWERDOMAIN
+static void normal_ff_save(struct register_save *regs, unsigned int num_regs)
+{
+	int i;
+	for (i = 0; i < num_regs; i++)
+		regs[i].data = __raw_readl(regs[i].addr);
+}
+
+static void normal_ff_restore(struct register_save *regs, unsigned int num_regs)
+{
+	int i;
+	for (i = 0; i < num_regs; i++) {
+		__raw_writel(regs[i].data, regs[i].addr);
+#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
+		__raw_readl(regs[i].addr);
+#endif
+	}
+}
+
+DEFINE_SPINLOCK(powerdomain_lock);
+
+static int powerdomain_set(struct powerdomain *pd, int enable)
+{
+	unsigned long ctrlbit;
+	void __iomem *reg;
+	void __iomem *stable_reg;
+	unsigned long reg_dat;
+
+	if (pd == NULL)
+		return -EINVAL;
+
+	ctrlbit = pd->pd_ctrlbit;
+	reg = (void __iomem *)pd->pd_reg;
+	stable_reg = (void __iomem *)pd->pd_stable_reg;
+
+	spin_lock(&powerdomain_lock);
+	reg_dat = __raw_readl(reg);
+
+	if (enable) {
+		__raw_writel(reg_dat|ctrlbit, reg);
+		spin_unlock(&powerdomain_lock);
+
+		if (pd->pd_stable_ctrlbit && stable_reg) {
+			do { } while (!(__raw_readl(stable_reg) &
+						pd->pd_stable_ctrlbit));
+		}
+
+		if (pd->normal_ff_saved && pd->normal_ff) {
+			normal_ff_restore(pd->normal_ff, pd->num_normal_ff);
+			pd->normal_ff_saved = 0;
+		}
+	} else {
+		if (pd->normal_ff) {
+			normal_ff_save(pd->normal_ff, pd->num_normal_ff);
+			pd->normal_ff_saved = 1;
+		}
+		__raw_writel(reg_dat & ~(ctrlbit), reg);
+		spin_unlock(&powerdomain_lock);
+	}
+
+	return 0;
+}
+
+static struct powerdomain pd_lcd = {
+	/* L-block: G2D, FIMD, MIE, DSIM */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 3),
+	.pd_stable_ctrlbit	= (0x1 << 3),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_lcd.clocks),
+};
+
+static struct powerdomain pd_tv = {
+	/* T-block: VP, MIXER, TVENC, HDMI */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 4),
+	.pd_stable_ctrlbit	= (0x1 << 4),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_tv.clocks),
+};
+
+static struct powerdomain pd_mfc = {
+	/* F-block: MFC */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 1),
+	.pd_stable_ctrlbit	= (0x1 << 1),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_mfc.clocks),
+};
+
+static struct powerdomain pd_cam = {
+	/* X-block: FIMC0, FIMC1, FIMC2, CSIS, JPEG, Rotator,
+	 * MIE(Deprecated) */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 5),
+	.pd_stable_ctrlbit	= (0x1 << 5),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_cam.clocks),
+};
+
+static struct powerdomain pd_audio = {
+	/* Audio sub-block: I2S0, Audio buffer RAM */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 7),
+	.pd_stable_ctrlbit	= (0x1 << 7),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_audio.clocks),
+};
+
+static struct powerdomain pd_irom = {
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= (0x1 << 20),
+	.pd_stable_ctrlbit	= (0x0), /* not avaiable */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_irom.clocks),
+};
+
+static struct powerdomain pd_g3d = {
+	/* G3D Block */
+	.pd_reg			= S5P_NORMAL_CFG,
+	.pd_stable_reg		= S5P_BLK_PWR_STAT,
+	.pd_ctrlbit		= (0x1 << 2),
+	.pd_stable_ctrlbit	= (0x1 << 2),
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(pd_g3d.clocks),
+};
+
+static struct powerdomain *pd_list[] = {
+	&pd_lcd,
+	&pd_tv,
+	&pd_mfc,
+	&pd_cam,
+	&pd_audio,
+	&pd_irom,
+	&pd_g3d,
+};
+
+/* Support for Deep-Idle:
+ * AUDIO block is not turned off with top-off (deep-idle) */
+static struct powerdomain *pd_backup_topoff[] = {
+	&pd_lcd,
+	&pd_tv,
+	&pd_mfc,
+	&pd_cam,
+	&pd_irom,
+	&pd_g3d,
+};
+
+unsigned int powerdomain_backup_topoff(void)
+{
+	int pdset = 0;
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pd_backup_topoff); i++) {
+		if (__raw_readl(pd_backup_topoff[i]->pd_reg) &
+				pd_backup_topoff[i]->pd_ctrlbit) {
+			/* powerdomain alive. back it up */
+			normal_ff_save(pd_backup_topoff[i]->normal_ff,
+					pd_backup_topoff[i]->num_normal_ff);
+			pdset |= pd_backup_topoff[i]->pd_ctrlbit;
+		}
+	}
+	return pdset;
+}
+
+void powerdomain_restore_topoff(unsigned int pdset)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pd_backup_topoff); i++) {
+		if (pdset & pd_backup_topoff[i]->pd_ctrlbit) {
+			/* powerdomain backuped. restore it */
+			normal_ff_restore(pd_backup_topoff[i]->normal_ff,
+					pd_backup_topoff[i]->num_normal_ff);
+		}
+	}
+}
+#endif
+
+#ifdef CONFIG_S5PV210_BLOCKGATING
+static struct powerdomain bd_intc = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 10,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_intc.clocks),
+};
+
+static struct powerdomain bd_hsmmc = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 9,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_hsmmc.clocks),
+};
+
+static struct powerdomain bd_debug = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 8,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_debug.clocks),
+};
+
+static struct powerdomain bd_security = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 7,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_security.clocks),
+};
+
+static struct powerdomain bd_memory = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 6,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_memory.clocks),
+};
+
+static struct powerdomain bd_usb = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 5,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_usb.clocks),
+};
+
+static struct powerdomain bd_tv = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 4,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_tv.clocks),
+};
+
+static struct powerdomain bd_lcd = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 3,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_lcd.clocks),
+};
+
+static struct powerdomain bd_img = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 2,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_img.clocks),
+};
+
+static struct powerdomain bd_mfc = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 1,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_mfc.clocks),
+};
+
+static struct powerdomain bd_g3d = {
+	.pd_reg			= S5P_CLKGATE_BLOCK,
+	.pd_stable_reg		= NULL,
+	.pd_ctrlbit		= 1 << 0,
+	.pd_stable_ctrlbit	= (0x0), /* not available */
+	.ref_count		= 0,
+	.pd_set			= powerdomain_set,
+	.normal_ff_saved	= 0,
+	.normal_ff		= NULL,
+	.num_normal_ff		= 0,
+	.clocks			= LIST_HEAD_INIT(bd_g3d.clocks),
+};
+
+static struct powerdomain *bd_list[] = {
+	&bd_intc,
+	&bd_hsmmc,
+	&bd_debug,
+	&bd_security,
+	&bd_memory,
+	&bd_usb,
+	&bd_tv,
+	&bd_lcd,
+	&bd_img,
+	&bd_mfc,
+	&bd_g3d,
+};
+#endif
+
 static struct clksrc_clk clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
@@ -280,138 +667,173 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_pclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 31),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "rot",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1<<29),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "jpeg",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 28),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "fimc",
 		.id		= 0,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 24),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "fimc",
 		.id		= 1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 25),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "fimc",
 		.id		= 2,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1 << 26),
+		PD_SET(cam)
+		BD_SET(img)
 	}, {
 		.name		= "nfcon",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 28),
+		BD_SET(memory)
 	}, {
 		.name		= "tvenc",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 10),
+		PD_SET(tv)
+		BD_SET(tv)
 	}, {
 		.name		= "hdmi",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 11),
+		PD_SET(tv)
+		BD_SET(tv)
 	}, {
 		.name		= "mixer",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 9),
+		PD_SET(tv)
+		BD_SET(tv)
 	}, {
 		.name		= "otg",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<16),
+		BD_SET(usb)
 	}, {
 		.name		= "usb-host",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<17),
+		BD_SET(usb)
 	}, {
 		.name		= "lcd",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<0),
+		PD_SET(lcd)
+		BD_SET(lcd)
 	}, {
 		.name		= "cfcon",
 		.id		= 0,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<25),
+		BD_SET(memory)
 	}, {
 		.name		= "vp",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 8),
+		PD_SET(tv)
+		BD_SET(tv)
 	}, {
 		.name		= "dsim",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 2),
+		PD_SET(lcd)
+		BD_SET(lcd)
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<16),
+		BD_SET(hsmmc)
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<17),
+		BD_SET(hsmmc)
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<18),
+		BD_SET(hsmmc)
 	}, {
 		.name		= "hsmmc",
 		.id		= 3,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<19),
+		BD_SET(hsmmc)
 	}, {
 		.name		= "tsi",
 		.id		= -1,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 20),
+		BD_SET(hsmmc)
 	}, {
 		.name		= "hostif",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 10),
+		BD_SET(debug)
 	}, {
 		.name		= "modem",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 9),
+		BD_SET(debug)
 	}, {
 		.name		= "pcm",
 		.id		= 0,
@@ -520,6 +942,8 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<4),
+		/* Note that only i2s-0 is connected to pd_audio */
+		PD_SET(audio)
 	}, {
 		.name		= "i2s_v32",
 		.id		= 0,
@@ -614,72 +1038,84 @@ static struct clk init_clocks[] = {
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 24),
+		BD_SET(memory)
 	}, {
 		.name		= "sromc",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 26),
+		BD_SET(memory)
 	}, {
 		.name		= "tzic",
 		.id		= 0,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 28),
+		BD_SET(intc)
 	}, {
 		.name		= "tzic",
 		.id		= 1,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 29),
+		BD_SET(intc)
 	}, {
 		.name		= "tzic",
 		.id		= 2,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 30),
+		BD_SET(intc)
 	}, {
 		.name		= "tzic",
 		.id		= 3,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 31),
+		BD_SET(intc)
 	}, {
 		.name		= "vic",
 		.id		= 0,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 24),
+		BD_SET(intc)
 	}, {
 		.name		= "vic",
 		.id		= 1,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 25),
+		BD_SET(intc)
 	}, {
 		.name		= "vic",
 		.id		= 2,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 26),
+		BD_SET(intc)
 	}, {
 		.name		= "vic",
 		.id		= 3,
 		.parent		= &clk_hclk_msys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 27),
+		BD_SET(intc)
 	}, {
 		.name		= "secjtag",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 11),
+		BD_SET(debug)
 	}, {
 		.name		= "coresight",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 8),
+		BD_SET(debug)
 	}, {
 		.name		= "sdm",
 		.id		= -1,
@@ -691,6 +1127,7 @@ static struct clk init_clocks[] = {
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 0),
+		BD_SET(security)
 	}, {
 		.name		= "syscon",
 		.id		= -1,
@@ -1344,5 +1781,29 @@ void __init s5pv210_register_clocks(void)
 		(clkp->enable)(clkp, 0);
 	}
 
+#ifdef CONFIG_S5PV210_POWERDOMAIN
+	/* According to the state of the members, turn on/off power domains
+	 * and blocks. */
+	for (ptr = 0; ptr < ARRAY_SIZE(pd_list); ptr++) {
+		if (pd_list[ptr]->pd_set) {
+			if (pd_list[ptr]->num_clks_boot_on > 0)
+				pd_list[ptr]->pd_set(pd_list[ptr], 1);
+			else
+				pd_list[ptr]->pd_set(pd_list[ptr], 0);
+		}
+	}
+#endif /* CONFIG_S5PV210_POWERDOMAIN */
+
+#ifdef CONFIG_S5PV210_BLOCKGATING
+	for (ptr = 0; ptr < ARRAY_SIZE(bd_list); ptr++) {
+		if (bd_list[ptr]->pd_set) {
+			if (bd_list[ptr]->num_clks_boot_on > 0)
+				bd_list[ptr]->pd_set(bd_list[ptr], 1);
+			else
+				bd_list[ptr]->pd_set(bd_list[ptr], 0);
+		}
+	}
+#endif /* CONFIG_S5PV210_BLOCKGATING */
+
 	s3c_pwmclk_init();
 }
-- 
1.6.3.3
