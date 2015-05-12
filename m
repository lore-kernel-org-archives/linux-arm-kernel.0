From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 12 May 2015 15:31:03 +0200
Subject: [PATCH V2] ARM: imx53: Set DDR pins to high impedance when in suspend
 to RAM.
Message-ID: <20150512124032.7328.18562.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to save power the DDR pins should be put into high
impedance when in suspend to RAM.

This requires manually requesting self refresh (rather than using the
automatic mode implemented by the CCM / ESDCTL), followed by
reconfiguring the IOMUXC.

Of course the code to do this cannot itself run from DDR so the
code is copied to and executed from internal memory.

In my tests using a custom i.MX53 board with LPDDR2 RAM
this reduced the suspend power consumption from 200mW to 60mW.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---

Changes since V1:
 * Drop struct imx5_suspend_io_config and just use struct imx5_suspend_io_state
 * Populate IRAM state structures with memcpy()


 arch/arm/mach-imx/Makefile        |    1 
 arch/arm/mach-imx/common.h        |    4 +
 arch/arm/mach-imx/pm-imx5.c       |  190 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/suspend-imx53.S |  139 +++++++++++++++++++++++++++
 4 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/suspend-imx53.S

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3244cf1..6ba3894 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o mach-imx6sx.o
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
+obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
 endif
 obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0f04e30..9ade280c 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -121,9 +121,13 @@ int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_SUSPEND
 void v7_cpu_resume(void);
+void imx53_suspend(void __iomem *ocram_vbase);
+extern const u32 imx53_suspend_sz;
 void imx6_suspend(void __iomem *ocram_vbase);
 #else
 static inline void v7_cpu_resume(void) {}
+static inline void imx53_suspend(void __iomem *ocram_vbase) {}
+static const u32 imx53_suspend_sz;
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 #endif
 
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index f1f80ab..5dba62e 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -13,7 +13,14 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
+
+#include <linux/genalloc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
 #include <asm/system_misc.h>
 #include <asm/tlbflush.h>
 
@@ -49,9 +56,49 @@
  */
 #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
 
+struct imx5_suspend_io_state {
+	u32	offset;
+	u32	clear;
+	u32	set;
+	u32	saved_value;
+};
+
 struct imx5_pm_data {
 	phys_addr_t cortex_addr;
 	phys_addr_t gpc_addr;
+	phys_addr_t m4if_addr;
+	phys_addr_t iomuxc_addr;
+	void (*suspend_asm)(void __iomem *ocram_vbase);
+	const u32 *suspend_asm_sz;
+	const struct imx5_suspend_io_state *suspend_io_config;
+	int suspend_io_count;
+};
+
+static const struct imx5_suspend_io_state imx53_suspend_io_config[] = {
+#define MX53_DSE_HIGHZ_MASK (0x7 << 19)
+	{.offset = 0x584, .clear = MX53_DSE_HIGHZ_MASK}, /* DQM0 */
+	{.offset = 0x594, .clear = MX53_DSE_HIGHZ_MASK}, /* DQM1 */
+	{.offset = 0x560, .clear = MX53_DSE_HIGHZ_MASK}, /* DQM2 */
+	{.offset = 0x554, .clear = MX53_DSE_HIGHZ_MASK}, /* DQM3 */
+	{.offset = 0x574, .clear = MX53_DSE_HIGHZ_MASK}, /* CAS */
+	{.offset = 0x588, .clear = MX53_DSE_HIGHZ_MASK}, /* RAS */
+	{.offset = 0x578, .clear = MX53_DSE_HIGHZ_MASK}, /* SDCLK_0 */
+	{.offset = 0x570, .clear = MX53_DSE_HIGHZ_MASK}, /* SDCLK_1 */
+
+	{.offset = 0x580, .clear = MX53_DSE_HIGHZ_MASK}, /* SDODT0 */
+	{.offset = 0x564, .clear = MX53_DSE_HIGHZ_MASK}, /* SDODT1 */
+	{.offset = 0x57c, .clear = MX53_DSE_HIGHZ_MASK}, /* SDQS0 */
+	{.offset = 0x590, .clear = MX53_DSE_HIGHZ_MASK}, /* SDQS1 */
+	{.offset = 0x568, .clear = MX53_DSE_HIGHZ_MASK}, /* SDQS2 */
+	{.offset = 0x558, .clear = MX53_DSE_HIGHZ_MASK}, /* SDSQ3 */
+	{.offset = 0x6f0, .clear = MX53_DSE_HIGHZ_MASK}, /* GRP_ADDS */
+	{.offset = 0x718, .clear = MX53_DSE_HIGHZ_MASK}, /* GRP_BODS */
+	{.offset = 0x71c, .clear = MX53_DSE_HIGHZ_MASK}, /* GRP_B1DS */
+	{.offset = 0x728, .clear = MX53_DSE_HIGHZ_MASK}, /* GRP_B2DS */
+	{.offset = 0x72c, .clear = MX53_DSE_HIGHZ_MASK}, /* GRP_B3DS */
+
+	/* Controls the CKE signal which is required to leave self refresh */
+	{.offset = 0x720, .clear = MX53_DSE_HIGHZ_MASK, .set = 1 << 19}, /* CTLDS */
 };
 
 static const struct imx5_pm_data imx51_pm_data __initconst = {
@@ -62,11 +109,35 @@ static const struct imx5_pm_data imx51_pm_data __initconst = {
 static const struct imx5_pm_data imx53_pm_data __initconst = {
 	.cortex_addr = 0x63fa0000,
 	.gpc_addr = 0x53fd8000,
+	.m4if_addr = 0x63fd8000,
+	.iomuxc_addr = 0x53fa8000,
+	.suspend_asm = &imx53_suspend,
+	.suspend_asm_sz = &imx53_suspend_sz,
+	.suspend_io_config = imx53_suspend_io_config,
+	.suspend_io_count = ARRAY_SIZE(imx53_suspend_io_config),
 };
 
+#define MX5_MAX_SUSPEND_IOSTATE ARRAY_SIZE(imx53_suspend_io_config)
+
+/*
+ * This structure is for passing necessary data for low level ocram
+ * suspend code(arch/arm/mach-imx/suspend-imx53.S), if this struct
+ * definition is changed, the offset definition in that file
+ * must be also changed accordingly otherwise, the suspend to ocram
+ * function will be broken!
+ */
+struct imx5_cpu_suspend_info {
+	void __iomem	*m4if_base;
+	void __iomem	*iomuxc_base;
+	u32		io_count;
+	struct imx5_suspend_io_state io_state[MX5_MAX_SUSPEND_IOSTATE];
+} __aligned(8);
+
 static void __iomem *ccm_base;
 static void __iomem *cortex_base;
 static void __iomem *gpc_base;
+static void __iomem *suspend_ocram_base;
+static void (*imx5_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
 
 void __init imx5_pm_set_ccm_base(void __iomem *base)
 {
@@ -161,8 +232,15 @@ static int mx5_suspend_enter(suspend_state_t state)
 		/*clear the EMPGC0/1 bits */
 		__raw_writel(0, gpc_base + MXC_SRPG_EMPGC0_SRPGCR);
 		__raw_writel(0, gpc_base + MXC_SRPG_EMPGC1_SRPGCR);
+
+		if (imx5_suspend_in_ocram_fn)
+			imx5_suspend_in_ocram_fn(suspend_ocram_base);
+		else
+			cpu_do_idle();
+
+	} else {
+		cpu_do_idle();
 	}
-	cpu_do_idle();
 
 	/* return registers to default idle state */
 	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
@@ -194,6 +272,111 @@ static void imx5_pm_idle(void)
 	imx5_cpu_do_idle();
 }
 
+static int __init imx_suspend_alloc_ocram(
+				size_t size,
+				void __iomem **virt_out,
+				phys_addr_t *phys_out)
+{
+	struct device_node *node;
+	struct platform_device *pdev;
+	struct gen_pool *ocram_pool;
+	unsigned long ocram_base;
+	void __iomem *virt;
+	phys_addr_t phys;
+	int ret = 0;
+
+	/* Copied from imx6: TODO factorize */
+	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
+	if (!node) {
+		pr_warn("%s: failed to find ocram node!\n", __func__);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		pr_warn("%s: failed to find ocram device!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_pool = dev_get_gen_pool(&pdev->dev);
+	if (!ocram_pool) {
+		pr_warn("%s: ocram pool unavailable!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_base = gen_pool_alloc(ocram_pool, size);
+	if (!ocram_base) {
+		pr_warn("%s: unable to alloc ocram!\n", __func__);
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	phys = gen_pool_virt_to_phys(ocram_pool, ocram_base);
+	virt = __arm_ioremap_exec(phys, size, false);
+	if (phys_out)
+		*phys_out = phys;
+	if (virt_out)
+		*virt_out = virt;
+
+put_node:
+	of_node_put(node);
+
+	return ret;
+}
+
+static int __init imx5_suspend_init(const struct imx5_pm_data *soc_data)
+{
+	struct imx5_cpu_suspend_info *suspend_info;
+	int ret;
+	/* Need this to avoid compile error due to const typeof in fncpy.h */
+	void (*suspend_asm)(void __iomem *) = soc_data->suspend_asm;
+
+	if (!suspend_asm)
+		return 0;
+
+	if (!soc_data->suspend_asm_sz || !*soc_data->suspend_asm_sz)
+		return -EINVAL;
+
+	ret = imx_suspend_alloc_ocram(
+		*soc_data->suspend_asm_sz + sizeof(*suspend_info),
+		&suspend_ocram_base, NULL);
+	if (ret)
+		return ret;
+
+	suspend_info = suspend_ocram_base;
+
+	suspend_info->io_count = soc_data->suspend_io_count;
+	memcpy(suspend_info->io_state, soc_data->suspend_io_config,
+	       sizeof(*suspend_info->io_state) * soc_data->suspend_io_count);
+
+	suspend_info->m4if_base = ioremap(soc_data->m4if_addr, SZ_16K);
+	if (!suspend_info->m4if_base) {
+		ret = -ENOMEM;
+		goto failed_map_m4if;
+	}
+
+	suspend_info->iomuxc_base = ioremap(soc_data->iomuxc_addr, SZ_16K);
+	if (!suspend_info->iomuxc_base) {
+		ret = -ENOMEM;
+		goto failed_map_iomuxc;
+	}
+
+	imx5_suspend_in_ocram_fn = fncpy(
+		suspend_ocram_base + sizeof(*suspend_info),
+		suspend_asm,
+		*soc_data->suspend_asm_sz);
+
+	return 0;
+
+failed_map_iomuxc:
+	iounmap(suspend_info->m4if_base);
+
+failed_map_m4if:
+	return ret;
+}
+
 static int __init imx5_pm_common_init(const struct imx5_pm_data *data)
 {
 	int ret;
@@ -219,6 +402,11 @@ static int __init imx5_pm_common_init(const struct imx5_pm_data *data)
 	if (ret)
 		pr_warn("%s: cpuidle init failed %d\n", __func__, ret);
 
+	ret = imx5_suspend_init(data);
+	if (ret)
+		pr_warn("%s: No DDR LPM support with suspend %d!\n",
+			__func__, ret);
+
 	suspend_set_ops(&mx5_suspend_ops);
 
 	return 0;
diff --git a/arch/arm/mach-imx/suspend-imx53.S b/arch/arm/mach-imx/suspend-imx53.S
new file mode 100644
index 0000000..5ed078a
--- /dev/null
+++ b/arch/arm/mach-imx/suspend-imx53.S
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) 2008-2011 Freescale Semiconductor, Inc.
+ */
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/linkage.h>
+
+#define M4IF_MCR0_OFFSET			(0x008C)
+#define M4IF_MCR0_FDVFS				(0x1 << 11)
+#define M4IF_MCR0_FDVACK			(0x1 << 27)
+
+	.align 3
+
+/*
+ * ==================== low level suspend ====================
+ *
+ * On entry
+ * r0: pm_info structure address;
+ *
+ * suspend ocram space layout:
+ * ======================== high address ======================
+ *                              .
+ *                              .
+ *                              .
+ *                              ^
+ *                              ^
+ *                              ^
+ *                      imx53_suspend code
+ *              PM_INFO structure(imx53_suspend_info)
+ * ======================== low address =======================
+ */
+
+/* Offsets of members of struct imx53_suspend_info */
+#define SUSPEND_INFO_MX53_M4IF_V_OFFSET		0x0
+#define SUSPEND_INFO_MX53_IOMUXC_V_OFFSET	0x4
+#define SUSPEND_INFO_MX53_IO_COUNT_OFFSET	0x8
+#define SUSPEND_INFO_MX53_IO_STATE_OFFSET	0xc
+
+ENTRY(imx53_suspend)
+	stmfd	sp!, {r4,r5,r6,r7}
+
+	/* Save pad config */
+	ldr	r1, [r0, #SUSPEND_INFO_MX53_IO_COUNT_OFFSET]
+	cmp	r1, #0
+	beq	skip_pad_conf_1
+
+	add	r2, r0, #SUSPEND_INFO_MX53_IO_STATE_OFFSET
+	ldr	r3, [r0, #SUSPEND_INFO_MX53_IOMUXC_V_OFFSET]
+
+1:
+	ldr	r5, [r2], #12	/* IOMUXC register offset */
+	ldr	r6, [r3, r5]	/* current value */
+	str	r6, [r2], #4	/* save area */
+	subs	r1, r1, #1
+	bne	1b
+
+skip_pad_conf_1:
+	/* Set FDVFS bit of M4IF_MCR0 to request DDR to enter self-refresh */
+	ldr	r1, [r0, #SUSPEND_INFO_MX53_M4IF_V_OFFSET]
+	ldr	r2,[r1, #M4IF_MCR0_OFFSET]
+	orr	r2, r2, #M4IF_MCR0_FDVFS
+	str	r2,[r1, #M4IF_MCR0_OFFSET]
+
+	/* Poll FDVACK bit of M4IF_MCR to wait for DDR to enter self-refresh */
+wait_sr_ack:
+	ldr	r2,[r1, #M4IF_MCR0_OFFSET]
+	ands	r2, r2, #M4IF_MCR0_FDVACK
+	beq	wait_sr_ack
+
+	/* Set pad config */
+	ldr	r1, [r0, #SUSPEND_INFO_MX53_IO_COUNT_OFFSET]
+	cmp	r1, #0
+	beq	skip_pad_conf_2
+
+	add	r2, r0, #SUSPEND_INFO_MX53_IO_STATE_OFFSET
+	ldr	r3, [r0, #SUSPEND_INFO_MX53_IOMUXC_V_OFFSET]
+
+2:
+	ldr	r5, [r2], #4	/* IOMUXC register offset */
+	ldr	r6, [r2], #4	/* clear */
+	ldr	r7, [r3, r5]
+	bic	r7, r7, r6
+	ldr	r6, [r2], #8	/* set */
+	orr	r7, r7, r6
+	str	r7, [r3, r5]
+	subs	r1, r1, #1
+	bne	2b
+
+skip_pad_conf_2:
+	/* Zzz, enter stop mode */
+	wfi
+	nop
+	nop
+	nop
+	nop
+
+	/* Restore pad config */
+	ldr	r1, [r0, #SUSPEND_INFO_MX53_IO_COUNT_OFFSET]
+	cmp	r1, #0
+	beq	skip_pad_conf_3
+
+	add	r2, r0, #SUSPEND_INFO_MX53_IO_STATE_OFFSET
+	ldr	r3, [r0, #SUSPEND_INFO_MX53_IOMUXC_V_OFFSET]
+
+3:
+	ldr	r5, [r2], #12	/* IOMUXC register offset */
+	ldr	r6, [r2], #4	/* saved value */
+	str	r6, [r3, r5]
+	subs	r1, r1, #1
+	bne	3b
+
+skip_pad_conf_3:
+	/* Clear FDVFS bit of M4IF_MCR0 to request DDR to exit self-refresh */
+	ldr	r1, [r0, #SUSPEND_INFO_MX53_M4IF_V_OFFSET]
+	ldr	r2,[r1, #M4IF_MCR0_OFFSET]
+	bic	r2, r2, #M4IF_MCR0_FDVFS
+	str	r2,[r1, #M4IF_MCR0_OFFSET]
+
+	/* Poll FDVACK bit of M4IF_MCR to wait for DDR to exit self-refresh */
+wait_ar_ack:
+	ldr	r2,[r1, #M4IF_MCR0_OFFSET]
+	ands	r2, r2, #M4IF_MCR0_FDVACK
+	bne	wait_ar_ack
+
+	/* Restore registers */
+	ldmfd	sp!, {r4,r5,r6,r7}
+	mov	pc, lr
+
+ENDPROC(imx53_suspend)
+
+ENTRY(imx53_suspend_sz)
+        .word   . - imx53_suspend
