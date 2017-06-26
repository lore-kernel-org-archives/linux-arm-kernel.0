From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 26 Jun 2017 15:32:48 -0700
Subject: [PATCH v2 4/4] soc bcm: brcmstb: Add support for S2/S3/S5 suspend
 states (MIPS)
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Message-ID: <20170626223248.14199-9-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Chen <justinpopo6@gmail.com>

This commit adds support for the Broadcom STB S2/S3/S5 suspend
states on MIPS based SoCs.

This requires quite a lot of code in order to deal with the
different HW blocks that need to be quiesced during suspend:

- DDR PHY
- DDR memory controller and arbiter
- control processor

The final steps of the suspend execute in cache and there is is a little
bit of assembly code in order to shut down the DDR PHY PLL and then go
into a wait loop until a wake-up even occurs. Conversely the resume part
involves waiting for the DDR PHY PLL to come back up and resume
executions where we left.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/Kconfig      |   2 +-
 drivers/soc/bcm/brcmstb/pm/Makefile  |   1 +
 drivers/soc/bcm/brcmstb/pm/pm-mips.c | 461 +++++++++++++++++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h      |  13 +-
 drivers/soc/bcm/brcmstb/pm/s2-mips.S | 200 +++++++++++++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S | 146 +++++++++++
 6 files changed, 821 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S

diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
index 9b1cc7f86ea2..d05bfce82e71 100644
--- a/drivers/soc/bcm/brcmstb/Kconfig
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -4,6 +4,6 @@ config BRCMSTB_PM
 	bool "Support suspend/resume for STB platforms"
 	default y
 	depends on PM
-	depends on ARM
+	depends on ARM || BMIPS_GENERIC
 
 endif # SOC_BRCMSTB
diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
index 7c3d20135b7c..08bbd244ef11 100644
--- a/drivers/soc/bcm/brcmstb/pm/Makefile
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
 AFLAGS_s2-arm.o			:= -march=armv7-a
+obj-$(CONFIG_BMIPS_GENERIC)	+= s2-mips.o s3-mips.o pm-mips.o
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-mips.c b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
new file mode 100644
index 000000000000..9300b5f62e56
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
@@ -0,0 +1,461 @@
+/*
+ * MIPS-specific support for Broadcom STB S2/S3/S5 power management
+ *
+ * Copyright (C) 2016-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/suspend.h>
+#include <asm/bmips.h>
+#include <asm/tlbflush.h>
+
+#include "pm.h"
+
+#define S2_NUM_PARAMS		6
+#define MAX_NUM_MEMC		3
+
+/* S3 constants */
+#define MAX_GP_REGS		16
+#define MAX_CP0_REGS		32
+#define NUM_MEMC_CLIENTS	128
+#define AON_CTRL_RAM_SIZE	128
+#define BRCMSTB_S3_MAGIC	0x5AFEB007
+
+#define CLEAR_RESET_MASK	0x01
+
+/* Index each CP0 register that needs to be saved */
+#define CONTEXT		0
+#define USER_LOCAL	1
+#define PGMK		2
+#define HWRENA		3
+#define COMPARE		4
+#define STATUS		5
+#define CONFIG		6
+#define MODE		7
+#define EDSP		8
+#define BOOT_VEC	9
+#define EBASE		10
+
+struct brcmstb_memc {
+	void __iomem *ddr_phy_base;
+	void __iomem *arb_base;
+};
+
+struct brcmstb_pm_control {
+	void __iomem *aon_ctrl_base;
+	void __iomem *aon_sram_base;
+	void __iomem *timers_base;
+	struct brcmstb_memc memcs[MAX_NUM_MEMC];
+	int num_memc;
+};
+
+struct brcm_pm_s3_context {
+	u32			cp0_regs[MAX_CP0_REGS];
+	u32			memc0_rts[NUM_MEMC_CLIENTS];
+	u32			sc_boot_vec;
+};
+
+struct brcmstb_mem_transfer;
+
+struct brcmstb_mem_transfer {
+	struct brcmstb_mem_transfer	*next;
+	void				*src;
+	void				*dst;
+	dma_addr_t			pa_src;
+	dma_addr_t			pa_dst;
+	u32				len;
+	u8				key;
+	u8				mode;
+	u8				src_remapped;
+	u8				dst_remapped;
+	u8				src_dst_remapped;
+};
+
+#define AON_SAVE_SRAM(base, idx, val) \
+	__raw_writel(val, base + (idx << 2))
+
+/* Used for saving registers in asm */
+u32 gp_regs[MAX_GP_REGS];
+
+#define	BSP_CLOCK_STOP		0x00
+#define PM_INITIATE		0x01
+
+static struct brcmstb_pm_control ctrl;
+
+static void brcm_pm_save_cp0_context(struct brcm_pm_s3_context *ctx)
+{
+	/* Generic MIPS */
+	ctx->cp0_regs[CONTEXT] = read_c0_context();
+	ctx->cp0_regs[USER_LOCAL] = read_c0_userlocal();
+	ctx->cp0_regs[PGMK] = read_c0_pagemask();
+	ctx->cp0_regs[HWRENA] = read_c0_cache();
+	ctx->cp0_regs[COMPARE] = read_c0_compare();
+	ctx->cp0_regs[STATUS] = read_c0_status();
+
+	/* Broadcom specific */
+	ctx->cp0_regs[CONFIG] = read_c0_brcm_config();
+	ctx->cp0_regs[MODE] = read_c0_brcm_mode();
+	ctx->cp0_regs[EDSP] = read_c0_brcm_edsp();
+	ctx->cp0_regs[BOOT_VEC] = read_c0_brcm_bootvec();
+	ctx->cp0_regs[EBASE] = read_c0_ebase();
+
+	ctx->sc_boot_vec = bmips_read_zscm_reg(0xa0);
+}
+
+static void brcm_pm_restore_cp0_context(struct brcm_pm_s3_context *ctx)
+{
+	/* Restore cp0 state */
+	bmips_write_zscm_reg(0xa0, ctx->sc_boot_vec);
+
+	/* Generic MIPS */
+	write_c0_context(ctx->cp0_regs[CONTEXT]);
+	write_c0_userlocal(ctx->cp0_regs[USER_LOCAL]);
+	write_c0_pagemask(ctx->cp0_regs[PGMK]);
+	write_c0_cache(ctx->cp0_regs[HWRENA]);
+	write_c0_compare(ctx->cp0_regs[COMPARE]);
+	write_c0_status(ctx->cp0_regs[STATUS]);
+
+	/* Broadcom specific */
+	write_c0_brcm_config(ctx->cp0_regs[CONFIG]);
+	write_c0_brcm_mode(ctx->cp0_regs[MODE]);
+	write_c0_brcm_edsp(ctx->cp0_regs[EDSP]);
+	write_c0_brcm_bootvec(ctx->cp0_regs[BOOT_VEC]);
+	write_c0_ebase(ctx->cp0_regs[EBASE]);
+}
+
+static void  brcmstb_pm_handshake(void)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+	u32 tmp;
+
+	/* BSP power handshake, v1 */
+	tmp = __raw_readl(base + AON_CTRL_HOST_MISC_CMDS);
+	tmp &= ~1UL;
+	__raw_writel(tmp, base + AON_CTRL_HOST_MISC_CMDS);
+	(void)__raw_readl(base + AON_CTRL_HOST_MISC_CMDS);
+
+	__raw_writel(0, base + AON_CTRL_PM_INITIATE);
+	(void)__raw_readl(base + AON_CTRL_PM_INITIATE);
+	__raw_writel(BSP_CLOCK_STOP | PM_INITIATE,
+		     base + AON_CTRL_PM_INITIATE);
+	/*
+	 * HACK: BSP may have internal race on the CLOCK_STOP command.
+	 * Avoid touching the BSP for a few milliseconds.
+	 */
+	mdelay(3);
+}
+
+static void brcmstb_pm_s5(void)
+{
+	void __iomem *base = ctrl.aon_ctrl_base;
+
+	brcmstb_pm_handshake();
+
+	/* Clear magic s3 warm-boot value */
+	AON_SAVE_SRAM(ctrl.aon_sram_base, 0, 0);
+
+	/* Set the countdown */
+	__raw_writel(0x10, base + AON_CTRL_PM_CPU_WAIT_COUNT);
+	(void)__raw_readl(base + AON_CTRL_PM_CPU_WAIT_COUNT);
+
+	/* Prepare to S5 cold boot */
+	__raw_writel(PM_COLD_CONFIG, base + AON_CTRL_PM_CTRL);
+	(void)__raw_readl(base + AON_CTRL_PM_CTRL);
+
+	__raw_writel((PM_COLD_CONFIG | PM_PWR_DOWN), base +
+		      AON_CTRL_PM_CTRL);
+	(void)__raw_readl(base + AON_CTRL_PM_CTRL);
+
+	__asm__ __volatile__(
+	"	wait\n"
+	: : : "memory");
+}
+
+static int brcmstb_pm_s3(void)
+{
+	struct brcm_pm_s3_context s3_context;
+	void __iomem *memc_arb_base;
+	unsigned long flags;
+	u32 tmp;
+	int i;
+
+	/* Prepare for s3 */
+	AON_SAVE_SRAM(ctrl.aon_sram_base, 0, BRCMSTB_S3_MAGIC);
+	AON_SAVE_SRAM(ctrl.aon_sram_base, 1, (u32)&s3_reentry);
+	AON_SAVE_SRAM(ctrl.aon_sram_base, 2, 0);
+
+	/* Clear RESET_HISTORY */
+	tmp = __raw_readl(ctrl.aon_ctrl_base + AON_CTRL_RESET_CTRL);
+	tmp &= ~CLEAR_RESET_MASK;
+	__raw_writel(tmp, ctrl.aon_ctrl_base + AON_CTRL_RESET_CTRL);
+
+	local_irq_save(flags);
+
+	/* Inhibit DDR_RSTb pulse for both MMCs*/
+	for (i = 0; i < ctrl.num_memc; i++) {
+		tmp = __raw_readl(ctrl.memcs[i].ddr_phy_base +
+			DDR40_PHY_CONTROL_REGS_0_STANDBY_CTRL);
+
+		tmp &= ~0x0f;
+		__raw_writel(tmp, ctrl.memcs[i].ddr_phy_base +
+			DDR40_PHY_CONTROL_REGS_0_STANDBY_CTRL);
+		tmp |= (0x05 | BIT(5));
+		__raw_writel(tmp, ctrl.memcs[i].ddr_phy_base +
+			DDR40_PHY_CONTROL_REGS_0_STANDBY_CTRL);
+	}
+
+	/* Save CP0 context */
+	brcm_pm_save_cp0_context(&s3_context);
+
+	/* Save RTS(skip debug register) */
+	memc_arb_base = ctrl.memcs[0].arb_base + 4;
+	for (i = 0; i < NUM_MEMC_CLIENTS; i++) {
+		s3_context.memc0_rts[i] = __raw_readl(memc_arb_base);
+		memc_arb_base += 4;
+	}
+
+	/* Save I/O context */
+	local_flush_tlb_all();
+	_dma_cache_wback_inv(0, ~0);
+
+	brcm_pm_do_s3(ctrl.aon_ctrl_base, current_cpu_data.dcache.linesz);
+
+	/* CPU reconfiguration */
+	local_flush_tlb_all();
+	bmips_cpu_setup();
+	cpumask_clear(&bmips_booted_mask);
+
+	/* Restore RTS (skip debug register) */
+	memc_arb_base = ctrl.memcs[0].arb_base + 4;
+	for (i = 0; i < NUM_MEMC_CLIENTS; i++) {
+		__raw_writel(s3_context.memc0_rts[i], memc_arb_base);
+		memc_arb_base += 4;
+	}
+
+	/* restore CP0 context */
+	brcm_pm_restore_cp0_context(&s3_context);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int brcmstb_pm_s2(void)
+{
+	/*
+	 * We need to pass 6 arguments to an assembly function. Lets avoid the
+	 * stack and pass arguments in a explicit 4 byte array. The assembly
+	 * code assumes all arguments are 4 bytes and arguments are ordered
+	 * like so:
+	 *
+	 * 0: AON_CTRl base register
+	 * 1: DDR_PHY base register
+	 * 2: TIMERS base resgister
+	 * 3: I-Cache line size
+	 * 4: Restart vector address
+	 * 5: Restart vector size
+	 */
+	u32 s2_params[6];
+
+	/* Prepare s2 parameters */
+	s2_params[0] = (u32)ctrl.aon_ctrl_base;
+	s2_params[1] = (u32)ctrl.memcs[0].ddr_phy_base;
+	s2_params[2] = (u32)ctrl.timers_base;
+	s2_params[3] = (u32)current_cpu_data.icache.linesz;
+	s2_params[4] = (u32)BMIPS_WARM_RESTART_VEC;
+	s2_params[5] = (u32)(bmips_smp_int_vec_end -
+		bmips_smp_int_vec);
+
+	/* Drop to standby */
+	brcm_pm_do_s2(s2_params);
+
+	return 0;
+}
+
+static int brcmstb_pm_standby(bool deep_standby)
+{
+	brcmstb_pm_handshake();
+
+	/* Send IRQs to BMIPS_WARM_RESTART_VEC */
+	clear_c0_cause(CAUSEF_IV);
+	irq_disable_hazard();
+	set_c0_status(ST0_BEV);
+	irq_disable_hazard();
+
+	if (deep_standby)
+		brcmstb_pm_s3();
+	else
+		brcmstb_pm_s2();
+
+	/* Send IRQs to normal runtime vectors */
+	clear_c0_status(ST0_BEV);
+	irq_disable_hazard();
+	set_c0_cause(CAUSEF_IV);
+	irq_disable_hazard();
+
+	return 0;
+}
+
+static int brcmstb_pm_enter(suspend_state_t state)
+{
+	int ret = -EINVAL;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		ret = brcmstb_pm_standby(false);
+		break;
+	case PM_SUSPEND_MEM:
+		ret = brcmstb_pm_standby(true);
+		break;
+	}
+
+	return ret;
+}
+
+static int brcmstb_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return true;
+	case PM_SUSPEND_MEM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct platform_suspend_ops brcmstb_pm_ops = {
+	.enter		= brcmstb_pm_enter,
+	.valid		= brcmstb_pm_valid,
+};
+
+static const struct of_device_id aon_ctrl_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-aon-ctrl" },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id ddr_phy_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-ddr-phy" },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id arb_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-memc-arb" },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id timers_ids[] = {
+	{ .compatible = "brcm,brcmstb-timers" },
+	{ /* sentinel */ }
+};
+
+static inline void __iomem *brcmstb_ioremap_node(struct device_node *dn,
+						 int index)
+{
+	return of_io_request_and_map(dn, index, dn->full_name);
+}
+
+static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
+					   int index, const void **ofdata)
+{
+	struct device_node *dn;
+	const struct of_device_id *match;
+
+	dn = of_find_matching_node_and_match(NULL, matches, &match);
+	if (!dn)
+		return ERR_PTR(-EINVAL);
+
+	if (ofdata)
+		*ofdata = match->data;
+
+	return brcmstb_ioremap_node(dn, index);
+}
+
+static int brcmstb_pm_init(void)
+{
+	struct device_node *dn;
+	void __iomem *base;
+	int i;
+
+	/* AON ctrl registers */
+	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("error mapping AON_CTRL\n");
+		goto aon_err;
+	}
+	ctrl.aon_ctrl_base = base;
+
+	/* AON SRAM registers */
+	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 1, NULL);
+	if (IS_ERR(base)) {
+		pr_err("error mapping AON_SRAM\n");
+		goto sram_err;
+	}
+	ctrl.aon_sram_base = base;
+
+	ctrl.num_memc = 0;
+	/* Map MEMC DDR PHY registers */
+	for_each_matching_node(dn, ddr_phy_dt_ids) {
+		i = ctrl.num_memc;
+		if (i >= MAX_NUM_MEMC) {
+			pr_warn("Too many MEMCs (max %d)\n", MAX_NUM_MEMC);
+			break;
+		}
+		base = brcmstb_ioremap_node(dn, 0);
+		if (IS_ERR(base))
+			goto ddr_err;
+
+		ctrl.memcs[i].ddr_phy_base = base;
+		ctrl.num_memc++;
+	}
+
+	/* MEMC ARB registers */
+	base = brcmstb_ioremap_match(arb_dt_ids, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("error mapping MEMC ARB\n");
+		goto ddr_err;
+	}
+	ctrl.memcs[0].arb_base = base;
+
+	/* Timer registers */
+	base = brcmstb_ioremap_match(timers_ids, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("error mapping timers\n");
+		goto tmr_err;
+	}
+	ctrl.timers_base = base;
+
+	/* s3 cold boot aka s5 */
+	pm_power_off = brcmstb_pm_s5;
+
+	suspend_set_ops(&brcmstb_pm_ops);
+
+	return 0;
+
+tmr_err:
+	iounmap(ctrl.memcs[0].arb_base);
+ddr_err:
+	for (i = 0; i < ctrl.num_memc; i++)
+		iounmap(ctrl.memcs[i].ddr_phy_base);
+
+	iounmap(ctrl.aon_sram_base);
+sram_err:
+	iounmap(ctrl.aon_ctrl_base);
+aon_err:
+	return PTR_ERR(base);
+}
+arch_initcall(brcmstb_pm_init);
diff --git a/drivers/soc/bcm/brcmstb/pm/pm.h b/drivers/soc/bcm/brcmstb/pm/pm.h
index 142519fdb8f8..b7d35ac70e60 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm.h
+++ b/drivers/soc/bcm/brcmstb/pm/pm.h
@@ -70,9 +70,20 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef CONFIG_MIPS
 extern const unsigned long brcmstb_pm_do_s2_sz;
 extern asmlinkage int brcmstb_pm_do_s2(void __iomem *aon_ctrl_base,
 		void __iomem *ddr_phy_pll_status);
-#endif
+#else
+/* s2 asm */
+extern asmlinkage int brcm_pm_do_s2(u32 *s2_params);
+
+/* s3 asm */
+extern asmlinkage int brcm_pm_do_s3(void __iomem *aon_ctrl_base,
+		int dcache_linesz);
+extern int s3_reentry;
+#endif /* CONFIG_MIPS */
+
+#endif 
 
 #endif /* __BRCMSTB_PM_H__ */
diff --git a/drivers/soc/bcm/brcmstb/pm/s2-mips.S b/drivers/soc/bcm/brcmstb/pm/s2-mips.S
new file mode 100644
index 000000000000..27a14bc46043
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/s2-mips.S
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) 2016 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+
+#include "pm.h"
+
+	.text
+	.set	noreorder
+	.align	5
+
+/*
+ * a0: u32 params array
+ */
+LEAF(brcm_pm_do_s2)
+
+	subu	sp, 64
+	sw	ra, 0(sp)
+	sw	s0, 4(sp)
+	sw	s1, 8(sp)
+	sw	s2, 12(sp)
+	sw	s3, 16(sp)
+	sw	s4, 20(sp)
+	sw	s5, 24(sp)
+	sw	s6, 28(sp)
+	sw	s7, 32(sp)
+
+	/*
+	 * Dereference the params array
+	 * s0: AON_CTRL base register
+	 * s1: DDR_PHY base register
+	 * s2: TIMERS base register
+	 * s3: I-Cache line size
+	 * s4: Restart vector address
+	 * s5: Restart vector size
+	 */
+	move	t0, a0
+
+	lw	s0, 0(t0)
+	lw	s1, 4(t0)
+	lw	s2, 8(t0)
+	lw	s3, 12(t0)
+	lw	s4, 16(t0)
+	lw	s5, 20(t0)
+
+	/* Lock this asm section into the I-cache */
+	addiu	t1, s3, -1
+	not	t1
+
+	la	t0, brcm_pm_do_s2
+	and	t0, t1
+
+	la	t2, asm_end
+	and	t2, t1
+
+1:	cache	0x1c, 0(t0)
+	bne	t0, t2, 1b
+	addu	t0, s3
+
+	/* Lock the interrupt vector into the I-cache */
+	move	t0, zero
+
+2:	move	t1, s4
+	cache 	0x1c, 0(t1)
+	addu	t1, s3
+	addu	t0, s3
+	ble	t0, s5, 2b
+	nop
+
+	sync
+
+	/* Power down request */
+	li	t0, PM_S2_COMMAND
+	sw	zero, AON_CTRL_PM_CTRL(s0)
+	lw	zero, AON_CTRL_PM_CTRL(s0)
+	sw	t0, AON_CTRL_PM_CTRL(s0)
+	lw	t0, AON_CTRL_PM_CTRL(s0)
+
+	/* Enable CP0 interrupt 2 and wait for interrupt */
+	mfc0	t0, CP0_STATUS
+	/* Save cp0 sr for restoring later */
+	move	s6, t0
+
+	li	t1, ~(ST0_IM | ST0_IE)
+	and	t0, t1
+	ori	t0, STATUSF_IP2
+	mtc0	t0, CP0_STATUS
+	nop
+	nop
+	nop
+	ori	t0, ST0_IE
+	mtc0	t0, CP0_STATUS
+
+	/* Wait for interrupt */
+	wait
+	nop
+
+	/* Wait for memc0 */
+1:	lw	t0, DDR40_PHY_CONTROL_REGS_0_PLL_STATUS(s1)
+	andi	t0, 1
+	beqz	t0, 1b
+	nop
+
+	/* 1ms delay needed for stable recovery */
+	/* Use TIMER1 to count 1 ms */
+	li	t0, RESET_TIMER
+	sw	t0, TIMER_TIMER1_CTRL(s2)
+	lw	t0, TIMER_TIMER1_CTRL(s2)
+
+	li	t0, START_TIMER
+	sw	t0, TIMER_TIMER1_CTRL(s2)
+	lw	t0, TIMER_TIMER1_CTRL(s2)
+
+	/* Prepare delay */
+	li	t0, TIMER_MASK
+	lw	t1, TIMER_TIMER1_STAT(s2)
+	and	t1, t0
+	/* 1ms delay */
+	addi	t1, 27000
+
+	/* Wait for the timer value to exceed t1 */
+1:	lw	t0, TIMER_TIMER1_STAT(s2)
+	sgtu	t2, t1, t0
+	bnez	t2, 1b
+	nop
+
+	/* Power back up */
+	li	t1, 1
+	sw	t1, AON_CTRL_HOST_MISC_CMDS(s0)
+	lw	t1, AON_CTRL_HOST_MISC_CMDS(s0)
+
+	sw	zero, AON_CTRL_PM_CTRL(s0)
+	lw	zero, AON_CTRL_PM_CTRL(s0)
+
+	/* Unlock I-cache */
+	addiu	t1, s3, -1
+	not	t1
+
+	la	t0, brcm_pm_do_s2
+	and 	t0, t1
+
+	la	t2, asm_end
+	and	t2, t1
+
+1:	cache	0x00, 0(t0)
+	bne	t0, t2, 1b
+	addu	t0, s3
+
+	/* Unlock interrupt vector */
+	move	t0, zero
+
+2:	move	t1, s4
+	cache 	0x00, 0(t1)
+	addu	t1, s3
+	addu	t0, s3
+	ble	t0, s5, 2b
+	nop
+
+	/* Restore cp0 sr */
+	sync
+	nop
+	mtc0	s6, CP0_STATUS
+	nop
+
+	/* Set return value to success */
+	li	v0, 0
+
+	/* Return to caller */
+	lw	s7, 32(sp)
+	lw	s6, 28(sp)
+	lw	s5, 24(sp)
+	lw	s4, 20(sp)
+	lw	s3, 16(sp)
+	lw	s2, 12(sp)
+	lw	s1, 8(sp)
+	lw	s0, 4(sp)
+	lw	ra, 0(sp)
+	addiu	sp, 64
+
+	jr ra
+	nop
+END(brcm_pm_do_s2)
+
+	.globl asm_end
+asm_end:
+	nop
+
diff --git a/drivers/soc/bcm/brcmstb/pm/s3-mips.S b/drivers/soc/bcm/brcmstb/pm/s3-mips.S
new file mode 100644
index 000000000000..1242308a8868
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/pm/s3-mips.S
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2016 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/bmips.h>
+
+#include "pm.h"
+
+	.text
+	.set		noreorder
+	.align		5
+	.global		s3_reentry
+
+/*
+ * a0: AON_CTRL base register
+ * a1: D-Cache line size
+ */
+LEAF(brcm_pm_do_s3)
+
+	/* Get the address of s3_context */
+	la	t0, gp_regs
+	sw	ra, 0(t0)
+	sw	s0, 4(t0)
+	sw	s1, 8(t0)
+	sw	s2, 12(t0)
+	sw	s3, 16(t0)
+	sw	s4, 20(t0)
+	sw	s5, 24(t0)
+	sw	s6, 28(t0)
+	sw	s7, 32(t0)
+	sw	gp, 36(t0)
+	sw	sp, 40(t0)
+	sw	fp, 44(t0)
+
+	/* Save CP0 Status */
+	mfc0	t1, CP0_STATUS
+	sw	t1, 48(t0)
+
+	/* Write-back gp registers - cache will be gone */
+	addiu	t1, a1, -1
+	not	t1
+	and	t0, t1
+
+	/* Flush at least 64 bytes */
+	addiu	t2, t0, 64
+	and	t2, t1
+
+1:	cache	0x17, 0(t0)
+	bne	t0, t2, 1b
+	addu	t0, a1
+
+	/* Drop to deep standby */
+	li	t1, PM_WARM_CONFIG
+	sw	zero, AON_CTRL_PM_CTRL(a0)
+	lw	zero, AON_CTRL_PM_CTRL(a0)
+	sw	t1, AON_CTRL_PM_CTRL(a0)
+	lw	t1, AON_CTRL_PM_CTRL(a0)
+
+	li	t1, (PM_WARM_CONFIG | PM_PWR_DOWN)
+	sw	t1, AON_CTRL_PM_CTRL(a0)
+	lw	t1, AON_CTRL_PM_CTRL(a0)
+
+	/* Enable CP0 interrupt 2 and wait for interrupt */
+	mfc0	t0, CP0_STATUS
+
+	li	t1, ~(ST0_IM | ST0_IE)
+	and	t0, t1
+	ori	t0, STATUSF_IP2
+	mtc0	t0, CP0_STATUS
+	nop
+	nop
+	nop
+	ori	t0, ST0_IE
+	mtc0	t0, CP0_STATUS
+
+        /* Wait for interrupt */
+        wait
+        nop
+
+s3_reentry:
+
+	/* Clear call/return stack */
+	li	t0, (0x06 << 16)
+	mtc0	t0, $22, 2
+	ssnop
+	ssnop
+	ssnop
+
+	/* Clear jump target buffer */
+	li	t0, (0x04 << 16)
+	mtc0	t0, $22, 2
+	ssnop
+	ssnop
+	ssnop
+
+	sync
+	nop
+
+	/* Setup mmu defaults */
+	mtc0	zero, CP0_WIRED
+	mtc0	zero, CP0_ENTRYHI
+	li	k0, PM_DEFAULT_MASK
+	mtc0	k0, CP0_PAGEMASK
+
+	li	sp, BMIPS_WARM_RESTART_VEC
+	la	k0, plat_wired_tlb_setup
+	jalr	k0
+	nop
+
+	/* Restore general purpose registers */
+	la	t0, gp_regs
+	lw	fp, 44(t0)
+	lw	sp, 40(t0)
+	lw	gp, 36(t0)
+	lw	s7, 32(t0)
+	lw	s6, 28(t0)
+	lw	s5, 24(t0)
+	lw	s4, 20(t0)
+	lw	s3, 16(t0)
+	lw	s2, 12(t0)
+	lw	s1, 8(t0)
+	lw	s0, 4(t0)
+	lw	ra, 0(t0)
+
+	/* Restore CP0 status */
+	lw	t1, 48(t0)
+	mtc0	t1, CP0_STATUS
+
+	/* Return to caller */
+	li	v0, 0
+	jr      ra
+	nop
+
+END(brcm_pm_do_s3)
-- 
2.9.3
