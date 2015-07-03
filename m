From: davidcdueck@googlemail.com (David Dueck)
Date: Fri,  3 Jul 2015 17:33:28 +0200
Subject: [PATCH RFC 1/2] at91: make using irqs for clock handling optional
Message-ID: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deactivating the use of interrupts here fixes a crash on early boot with
RT-Preempt.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rt4+ #197
Hardware name: Atmel SAMA5
task: c068f338 ti: c068a000 task.ti: c068a000
PC is at wake_up_process+0x8/0x4c
LR is at kthread_create_on_node+0xa0/0x148
pc : [<c0037478>]    lr : [<c00317b0>]    psr: 600001d3
sp : c068bec0  ip : 00000000  fp : 00100100
r10: 00000000  r9 : cf402380  r8 : ffffffff
r7 : c0047ae0  r6 : c068bedc  r5 : c06926b4  r4 : 00000000
r3 : c06bbf1c  r2 : c068becc  r1 : c068f338  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 20004059  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc068a210)
Stack: (0xc068bec0 to 0xc068c000)
bec0: c06bbf1c cf402700 00100100 c00317b0 00000010 c068bf00 fefffc00 00000000
bee0: c068bee0 c068bee0 00000001 cf404c00 cf4026c0 cf404c00 00000010 00000010
bf00: c00481c0 c05b05bc 00000010 c05f52fc cfdaa47c cf4026c0 00040080 cf404c00
bf20: c037286c 00000010 cf402380 c004858c cfdaa47c c050d548 fefffc00 00000010
bf40: cf402380 c06d2a1c cf402388 c0676b70 c05f52fc cf402380 00000001 cfdaa47c
bf60: cf4023c0 00000000 c06b450c cf402400 00200200 c0676888 00000000 00000001
bf80: 00000000 00000000 00000000 00000001 c06bb280 00000001 ffffffff c068c000
bfa0: c06bb280 c0682808 cfffcb40 c0660264 00000001 c065cb10 ffffffff ffffffff
bfc0: c065c66c 00000000 00000000 c0682808 00000000 c06bb454 c068c050 c0682804
bfe0: c0690550 20004059 410fc051 00000000 00000000 20008070 00000000 00000000
Code: eb1238c0 eafffff3 e92d4818 e1a04000 (e5903000)
---[ end trace 0000000000000001 ]---

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
---
 drivers/clk/Kconfig           |  1 +
 drivers/clk/at91/Kconfig      |  4 ++++
 drivers/clk/at91/clk-main.c   | 34 ++++++++++++++++++++++++++++++++++
 drivers/clk/at91/clk-master.c | 11 +++++++++++
 drivers/clk/at91/clk-pll.c    | 11 ++++++++++-
 drivers/clk/at91/clk-system.c | 11 +++++++++++
 drivers/clk/at91/clk-utmi.c   | 10 ++++++++++
 drivers/clk/at91/pmc.c        |  6 ++++++
 8 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/at91/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0b474a0..b1a56f3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -147,6 +147,7 @@ source "drivers/clk/qcom/Kconfig"
 
 endmenu
 
+source "drivers/clk/at91/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 
diff --git a/drivers/clk/at91/Kconfig b/drivers/clk/at91/Kconfig
new file mode 100644
index 0000000..343c758
--- /dev/null
+++ b/drivers/clk/at91/Kconfig
@@ -0,0 +1,4 @@
+config AT91_CLK_POLLING
+	bool "AT91 clk polling"
+	help
+		Poll clocks instead of using interrupts
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 59fa3cc..11033ae 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -69,6 +69,7 @@ struct clk_sam9x5_main {
 
 #define to_clk_sam9x5_main(hw) container_of(hw, struct clk_sam9x5_main, hw)
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
 {
 	struct clk_main_osc *osc = dev_id;
@@ -78,6 +79,7 @@ static irqreturn_t clk_main_osc_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_main_osc_prepare(struct clk_hw *hw)
 {
@@ -95,9 +97,13 @@ static int clk_main_osc_prepare(struct clk_hw *hw)
 	}
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCS)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(osc->irq);
 		wait_event(osc->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCS);
+#endif
 	}
 
 	return 0;
@@ -145,7 +151,9 @@ at91_clk_register_main_osc(struct at91_pmc *pmc,
 			   const char *parent_name,
 			   bool bypass)
 {
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	struct clk_main_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -169,11 +177,13 @@ at91_clk_register_main_osc(struct at91_pmc *pmc,
 
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(osc->irq, clk_main_osc_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, osc);
 	if (ret)
 		return ERR_PTR(ret);
 
+#endif
 	if (bypass)
 		pmc_write(pmc, AT91_CKGR_MOR,
 			  (pmc_read(pmc, AT91_CKGR_MOR) &
@@ -213,6 +223,7 @@ void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np,
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_main_rc_osc_irq_handler(int irq, void *dev_id)
 {
 	struct clk_main_rc_osc *osc = dev_id;
@@ -222,6 +233,7 @@ static irqreturn_t clk_main_rc_osc_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 {
@@ -237,9 +249,13 @@ static int clk_main_rc_osc_prepare(struct clk_hw *hw)
 	}
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCRCS)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(osc->irq);
 		wait_event(osc->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCRCS);
+#endif
 	}
 
 	return 0;
@@ -297,7 +313,9 @@ at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
 {
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	struct clk_main_rc_osc *osc;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -323,11 +341,13 @@ at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(osc->irq, clk_main_rc_osc_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, osc);
 	if (ret)
 		return ERR_PTR(ret);
 
+#endif
 	clk = clk_register(NULL, &osc->hw);
 	if (IS_ERR(clk)) {
 		free_irq(irq, osc);
@@ -476,6 +496,7 @@ void __init of_at91rm9200_clk_main_setup(struct device_node *np,
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_sam9x5_main_irq_handler(int irq, void *dev_id)
 {
 	struct clk_sam9x5_main *clkmain = dev_id;
@@ -485,6 +506,7 @@ static irqreturn_t clk_sam9x5_main_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_sam9x5_main_prepare(struct clk_hw *hw)
 {
@@ -492,9 +514,13 @@ static int clk_sam9x5_main_prepare(struct clk_hw *hw)
 	struct at91_pmc *pmc = clkmain->pmc;
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS)) {
+#ifdef CONFIG_AT91_CLK_POLLING
 		enable_irq(clkmain->irq);
 		wait_event(clkmain->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS);
+#else
+		cpu_relax();
+#endif
 	}
 
 	return clk_main_probe_frequency(pmc);
@@ -532,9 +558,13 @@ static int clk_sam9x5_main_set_parent(struct clk_hw *hw, u8 index)
 		pmc_write(pmc, AT91_CKGR_MOR, tmp & ~AT91_PMC_MOSCSEL);
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(clkmain->irq);
 		wait_event(clkmain->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MOSCSELS);
+#endif
 	}
 
 	return 0;
@@ -562,7 +592,9 @@ at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 			      const char **parent_names,
 			      int num_parents)
 {
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	struct clk_sam9x5_main *clkmain;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -590,10 +622,12 @@ at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 			     AT91_PMC_MOSCEN);
 	init_waitqueue_head(&clkmain->wait);
 	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(clkmain->irq, clk_sam9x5_main_irq_handler,
 			  IRQF_TRIGGER_HIGH, name, clkmain);
 	if (ret)
 		return ERR_PTR(ret);
+#endif
 
 	clk = clk_register(NULL, &clkmain->hw);
 	if (IS_ERR(clk)) {
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index c1af80b..8cd7c57 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -51,6 +51,7 @@ struct clk_master {
 	const struct clk_master_characteristics *characteristics;
 };
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_master_irq_handler(int irq, void *dev_id)
 {
 	struct clk_master *master = (struct clk_master *)dev_id;
@@ -60,15 +61,21 @@ static irqreturn_t clk_master_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
+
 static int clk_master_prepare(struct clk_hw *hw)
 {
 	struct clk_master *master = to_clk_master(hw);
 	struct at91_pmc *pmc = master->pmc;
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(master->irq);
 		wait_event(master->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+#endif
 	}
 
 	return 0;
@@ -138,7 +145,9 @@ at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics)
 {
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	struct clk_master *master;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -163,10 +172,12 @@ at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
 	master->irq = irq;
 	init_waitqueue_head(&master->wait);
 	irq_set_status_flags(master->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(master->irq, clk_master_irq_handler,
 			  IRQF_TRIGGER_HIGH, "clk-master", master);
 	if (ret)
 		return ERR_PTR(ret);
+#endif
 
 	clk = clk_register(NULL, &master->hw);
 	if (IS_ERR(clk))
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 6ec79db..a8b3cc5 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -69,6 +69,7 @@ struct clk_pll {
 	const struct clk_pll_characteristics *characteristics;
 };
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_pll_irq_handler(int irq, void *dev_id)
 {
 	struct clk_pll *pll = (struct clk_pll *)dev_id;
@@ -78,6 +79,7 @@ static irqreturn_t clk_pll_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_pll_prepare(struct clk_hw *hw)
 {
@@ -119,9 +121,13 @@ static int clk_pll_prepare(struct clk_hw *hw)
 	pmc_write(pmc, offset, pllr);
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & mask)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(pll->irq);
 		wait_event(pll->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & mask);
+#endif
 	}
 
 	return 0;
@@ -308,7 +314,9 @@ at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
 	struct clk_pll *pll;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	int offset = PLL_REG(id);
 	u32 tmp;
 
@@ -336,11 +344,12 @@ at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
 	pll->mul = PLL_MUL(tmp, layout);
 	init_waitqueue_head(&pll->wait);
 	irq_set_status_flags(pll->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(pll->irq, clk_pll_irq_handler, IRQF_TRIGGER_HIGH,
 			  id ? "clk-pllb" : "clk-plla", pll);
 	if (ret)
 		return ERR_PTR(ret);
-
+#endif
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk))
 		kfree(pll);
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index a76d03f..bb7c82a 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -39,6 +39,8 @@ static inline int is_pck(int id)
 {
 	return (id >= 8) && (id <= 15);
 }
+
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_system_irq_handler(int irq, void *dev_id)
 {
 	struct clk_system *sys = (struct clk_system *)dev_id;
@@ -48,6 +50,7 @@ static irqreturn_t clk_system_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_system_prepare(struct clk_hw *hw)
 {
@@ -61,12 +64,16 @@ static int clk_system_prepare(struct clk_hw *hw)
 		return 0;
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & mask)) {
+#ifdef CONFIG_AT91_CLK_POLLING
 		if (sys->irq) {
 			enable_irq(sys->irq);
 			wait_event(sys->wait,
 				   pmc_read(pmc, AT91_PMC_SR) & mask);
 		} else
 			cpu_relax();
+#else
+		cpu_relax();
+#endif
 	}
 	return 0;
 }
@@ -106,7 +113,9 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
 	struct clk_system *sys;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 
 	if (!parent_name || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
@@ -128,10 +137,12 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
 	if (irq) {
 		init_waitqueue_head(&sys->wait);
 		irq_set_status_flags(sys->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 		ret = request_irq(sys->irq, clk_system_irq_handler,
 				IRQF_TRIGGER_HIGH, name, sys);
 		if (ret)
 			return ERR_PTR(ret);
+#endif
 	}
 
 	clk = clk_register(NULL, &sys->hw);
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index ae3263b..60fdf30 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -33,6 +33,7 @@ struct clk_utmi {
 
 #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t clk_utmi_irq_handler(int irq, void *dev_id)
 {
 	struct clk_utmi *utmi = (struct clk_utmi *)dev_id;
@@ -42,6 +43,7 @@ static irqreturn_t clk_utmi_irq_handler(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static int clk_utmi_prepare(struct clk_hw *hw)
 {
@@ -53,9 +55,13 @@ static int clk_utmi_prepare(struct clk_hw *hw)
 	pmc_write(pmc, AT91_CKGR_UCKR, tmp);
 
 	while (!(pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_LOCKU)) {
+#ifdef CONFIG_AT91_CLK_POLLING
+		cpu_relax();
+#else
 		enable_irq(utmi->irq);
 		wait_event(utmi->wait,
 			   pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_LOCKU);
+#endif
 	}
 
 	return 0;
@@ -96,7 +102,9 @@ static struct clk * __init
 at91_clk_register_utmi(struct at91_pmc *pmc, unsigned int irq,
 		       const char *name, const char *parent_name)
 {
+#ifndef CONFIG_AT91_CLK_POLLING
 	int ret;
+#endif
 	struct clk_utmi *utmi;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
@@ -116,11 +124,13 @@ at91_clk_register_utmi(struct at91_pmc *pmc, unsigned int irq,
 	utmi->irq = irq;
 	init_waitqueue_head(&utmi->wait);
 	irq_set_status_flags(utmi->irq, IRQ_NOAUTOEN);
+#ifndef CONFIG_AT91_CLK_POLLING
 	ret = request_irq(utmi->irq, clk_utmi_irq_handler,
 			  IRQF_TRIGGER_HIGH, "clk-utmi", utmi);
 	if (ret)
 		return ERR_PTR(ret);
 
+#endif
 	clk = clk_register(NULL, &utmi->hw);
 	if (IS_ERR(clk))
 		kfree(utmi);
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 3f27d21..3c592bc 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -158,6 +158,7 @@ static struct irq_domain_ops pmc_irq_ops = {
 	.xlate	= pmc_irq_domain_xlate,
 };
 
+#ifndef CONFIG_AT91_CLK_POLLING
 static irqreturn_t pmc_irq_handler(int irq, void *data)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)data;
@@ -173,6 +174,7 @@ static irqreturn_t pmc_irq_handler(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+#endif
 
 static const struct at91_pmc_caps at91rm9200_caps = {
 	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_LOCKB |
@@ -241,14 +243,18 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
 		goto out_free_pmc;
 
 	pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
+#ifndef CONFIG_AT91_CLK_POLLING
 	if (request_irq(pmc->virq, pmc_irq_handler,
 			IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
 		goto out_remove_irqdomain;
+#endif
 
 	return pmc;
 
+#ifndef CONFIG_AT91_CLK_POLLING
 out_remove_irqdomain:
 	irq_domain_remove(pmc->irqdomain);
+#endif
 out_free_pmc:
 	kfree(pmc);
 
-- 
2.4.4
