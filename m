From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 22:22:51 +0800
Subject: [PATCH V4 1/6] ARM: dts: imx6q: add common compatible name for
 reused modules
In-Reply-To: <20140113121016.GJ16215@pengutronix.de>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
 <20140113121016.GJ16215@pengutronix.de>
Message-ID: <20140113142249.GW23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:10:16PM +0100, Sascha Hauer wrote:
> > @@ -840,7 +840,7 @@
> >  			};
> >  
> >  			mmdc0: mmdc at 021b0000 { /* MMDC0 */
> > -				compatible = "fsl,imx6q-mmdc";
> > +				compatible = "fsl,imx6q-mmdc", "fsl,mmdc";
> 
> This is not nice. Here you introduce a fsl,mmdc compatible claiming all
> mmdc are compatible to each other and in the driver code you have:
> 
> static const u32 imx6q_mmdc_io_dsm_offset[]
> static const u32 imx6dl_mmdc_io_dsm_offset[]
> 
> which proves they are *not* compatible.
> 
> You do this just to share a
> 
> imx6_pm_get_base(&pm_info->mmdc_base, "fsl,mmdc");
> 
> across the different i.MX6 SoCs.
> 
> You can sanitize this by introducing a SoC struct which you populate
> differently for the SoCs
> 
> static pm_soc_data imx6q_data {
> 	.mmdc_compat = "fsl,imx6q-mmdc",
> };
> 
> And by putting cpu_type, mmdc_io_num and others in this struct you can
> also remove the if(cpu_is_x()) else if (cpu_is_y()) else...

Good point.

Anson, the change below is a demonstration of Sascha's suggestion.
Sascha, correct me if I misunderstood your comment.

Shawn

---8<-----------

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7087d1a..4dd932a 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -146,13 +146,17 @@ void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
-void imx6_suspend(void);
+void imx6_suspend(void __iomem *ocram_vbase);
 void imx6q_pm_init(void);
+void imx6dl_pm_init(void);
+void imx6sl_pm_init(void);
 void imx6q_pm_set_ccm_base(void __iomem *base);
 void imx5_pm_init(void);
 #else
-static inline void imx6_suspend(void) {}
+static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 static inline void imx6q_pm_init(void) {}
+static inline void imx6dl_pm_init(void) {}
+static inline void imx6sl_pm_init(void) {}
 static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
 static inline void imx5_pm_init(void) {}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index e51e3da..3f7b4e3 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -212,7 +212,7 @@ static void __init imx6q_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
 	imx_anatop_init();
-	imx6q_pm_init();
+	cpu_is_imx6dl() ?  imx6dl_pm_init() : imx6q_pm_init();
 	imx6q_1588_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index a26fdb2..ad32338 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -58,8 +58,7 @@ static void __init imx6sl_init_machine(void)
 
 	imx6sl_fec_init();
 	imx_anatop_init();
-	/* Reuse imx6q pm code */
-	imx6q_pm_init();
+	imx6sl_pm_init();
 }
 
 static void __init imx6sl_init_irq(void)
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 175b229..ce058db 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -66,7 +66,7 @@
 
 static void __iomem *ccm_base;
 static void __iomem *suspend_ocram_base;
-static int (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
+static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
 
 /*
  * suspend ocram space layout:
@@ -88,36 +88,66 @@ struct imx6_pm_base {
 	void __iomem *vbase;
 };
 
-static const u32 imx6q_mmdc_io_dsm_offset[] __initconst = {
-	0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
-	0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
-	0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
-	0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
-	0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
-	0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
-	0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
-	0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
-	0x74c			    /* GPR_ADDS */
+struct imx6_pm_socdata {
+	u32 cpu_type;
+	const char *mmdc_compat;
+	const char *src_compat;
+	const char *iomuxc_compat;
+	const char *gpc_compat;
+	const u32 mmdc_io_offset[MX6_MAX_MMDC_IO_NUM];
+};
+
+static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
+	.cpu_type = MXC_CPU_IMX6Q,
+	.mmdc_compat = "fsl,imx6q-mmdc",
+	.src_compat = "fsl,imx6q-src",
+	.iomuxc_compat = "fsl,imx6q-iomuxc",
+	.gpc_compat = "fsl,imx6q-gpc",
+	.mmdc_io_offset = {
+		0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
+		0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
+		0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
+		0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
+		0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
+		0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
+		0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
+		0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
+		0x74c,			    /* GPR_ADDS */
+	},
 };
 
-static const u32 imx6dl_mmdc_io_dsm_offset[] __initconst = {
-	0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
-	0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
-	0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
-	0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
-	0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
-	0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
-	0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
-	0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
-	0x74c			    /* GPR_ADDS */
+static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
+	.cpu_type = MXC_CPU_IMX6DL,
+	.mmdc_compat = "fsl,imx6dl-mmdc",
+	.src_compat = "fsl,imx6dl-src",
+	.iomuxc_compat = "fsl,imx6dl-iomuxc",
+	.gpc_compat = "fsl,imx6dl-gpc",
+	.mmdc_io_offset = {
+		0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
+		0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
+		0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
+		0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
+		0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
+		0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
+		0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
+		0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
+		0x74c,			    /* GPR_ADDS */
+	},
 };
 
-static const u32 imx6sl_mmdc_io_dsm_offset[] __initconst = {
-	0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
-	0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
-	0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
-	0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
-	0x330, 0x334, 0x320,	    /* SDCKE0, SDCKE1, RESET */
+static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
+	.cpu_type = MXC_CPU_IMX6SL,
+	.mmdc_compat = "fsl,imx6sl-mmdc",
+	.src_compat = "fsl,imx6sl-src",
+	.iomuxc_compat = "fsl,imx6sl-iomuxc",
+	.gpc_compat = "fsl,imx6sl-gpc",
+	.mmdc_io_offset = {
+		0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
+		0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
+		0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
+		0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
+		0x330, 0x334, 0x320,	    /* SDCKE0, SDCKE1, RESET */
+	},
 };
 
 /*
@@ -343,7 +373,7 @@ out:
 	return ret;
 }
 
-static int __init imx6q_ocram_suspend_init(void)
+static int __init imx6_ocram_suspend_init(const struct imx6_pm_socdata *socdata)
 {
 	phys_addr_t ocram_pbase;
 	struct device_node *node;
@@ -398,25 +428,25 @@ static int __init imx6q_ocram_suspend_init(void)
 	 */
 	pm_info->ccm_base.vbase = ccm_base;
 
-	ret = imx6_pm_get_base(&pm_info->mmdc_base, "fsl,mmdc");
+	ret = imx6_pm_get_base(&pm_info->mmdc_base, socdata->mmdc_compat);
 	if (ret) {
 		pr_warn("%s: failed to get mmdc base %d!\n", __func__, ret);
 		goto put_node;
 	}
 
-	ret = imx6_pm_get_base(&pm_info->src_base, "fsl,src");
+	ret = imx6_pm_get_base(&pm_info->src_base, socdata->src_compat);
 	if (ret) {
 		pr_warn("%s: failed to get src base %d!\n", __func__, ret);
 		goto src_map_failed;
 	}
 
-	ret = imx6_pm_get_base(&pm_info->iomuxc_base, "fsl,iomuxc");
+	ret = imx6_pm_get_base(&pm_info->iomuxc_base, socdata->iomuxc_compat);
 	if (ret) {
 		pr_warn("%s: failed to get iomuxc base %d!\n", __func__, ret);
 		goto iomuxc_map_failed;
 	}
 
-	ret = imx6_pm_get_base(&pm_info->gpc_base, "fsl,gpc");
+	ret = imx6_pm_get_base(&pm_info->gpc_base, socdata->gpc_compat);
 	if (ret) {
 		pr_warn("%s: failed to get gpc base %d!\n", __func__, ret);
 		goto gpc_map_failed;
@@ -429,34 +459,19 @@ static int __init imx6q_ocram_suspend_init(void)
 		goto pl310_cache_map_failed;
 	}
 
-	if (cpu_is_imx6q()) {
-		pm_info->cpu_type = MXC_CPU_IMX6Q;
-		pm_info->mmdc_io_num = ARRAY_SIZE(imx6q_mmdc_io_dsm_offset);
-		mmdc_offset_array = imx6q_mmdc_io_dsm_offset;
-	} else if (cpu_is_imx6dl()) {
-		pm_info->cpu_type = MXC_CPU_IMX6DL;
-		pm_info->mmdc_io_num = ARRAY_SIZE(imx6dl_mmdc_io_dsm_offset);
-		mmdc_offset_array = imx6dl_mmdc_io_dsm_offset;
-	} else if (cpu_is_imx6sl()) {
-		pm_info->cpu_type = MXC_CPU_IMX6SL;
-		pm_info->mmdc_io_num = ARRAY_SIZE(imx6sl_mmdc_io_dsm_offset);
-		mmdc_offset_array = imx6sl_mmdc_io_dsm_offset;
-	}
-
-	if (!mmdc_offset_array) {
-		pr_warn("%s: unsupported platform!\n", __func__);
-		goto pl310_cache_map_failed;
-	}
+	pm_info->cpu_type = socdata->cpu_type;
+	pm_info->mmdc_io_num = ARRAY_SIZE(socdata->mmdc_io_offset);
+	mmdc_offset_array = socdata->mmdc_io_offset;
 
 	for (i = 0; i < pm_info->mmdc_io_num; i++) {
 		pm_info->mmdc_io_val[i][0] =
 			mmdc_offset_array[i];
 		pm_info->mmdc_io_val[i][1] =
-			readl_relaxed(*(&pm_info->iomuxc_base.vbase) +
+			readl_relaxed(pm_info->iomuxc_base.vbase +
 			mmdc_offset_array[i]);
 	}
 
-	imx6_suspend_in_ocram_fn = (void *)fncpy(
+	imx6_suspend_in_ocram_fn = fncpy(
 		suspend_ocram_base + sizeof(*pm_info),
 		&imx6_suspend,
 		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
@@ -477,14 +492,14 @@ put_node:
 	return ret;
 }
 
-void __init imx6q_pm_init(void)
+static void __init imx6_pm_common_init(const struct imx6_pm_socdata *socdata)
 {
 	struct regmap *gpr;
 	int ret;
 
 	WARN_ON(!ccm_base);
 
-	ret = imx6q_ocram_suspend_init();
+	ret = imx6_ocram_suspend_init(socdata);
 	if (ret)
 		pr_warn("%s: failed to initialize ocram suspend %d!\n",
 			__func__, ret);
@@ -506,3 +521,18 @@ void __init imx6q_pm_init(void)
 
 	suspend_set_ops(&imx6q_pm_ops);
 }
+
+void __init imx6q_pm_init(void)
+{
+	imx6_pm_common_init(&imx6q_pm_data);
+}
+
+void __init imx6dl_pm_init(void)
+{
+	imx6_pm_common_init(&imx6dl_pm_data);
+}
+
+void __init imx6sl_pm_init(void)
+{
+	imx6_pm_common_init(&imx6sl_pm_data);
+}
