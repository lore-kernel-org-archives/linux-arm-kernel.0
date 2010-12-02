From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 2 Dec 2010 15:25:05 +0800
Subject: [PATCHv2] add clock debug information for imx51 babbage
Message-ID: <mailman.37.1291287095.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to expose a tree-like clock debug information in sysfs

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
 arch/arm/common/Kconfig                |    6 ++
 arch/arm/mach-mx5/clock-mx51-mx53.c    |   42 +++++++++++-
 arch/arm/plat-mxc/clock.c              |  121 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/clock.h |   11 +++
 4 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..d97daa4 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -41,3 +41,9 @@ config SHARP_SCOOP
 config COMMON_CLKDEV
 	bool
 	select HAVE_CLK
+
+config CLK_DEBUG
+	bool "clock debug information export to user space"
+	depends on PM_DEBUG && DEBUG_FS
+	help
+	  export clk debug information to user space
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c
b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 344ee8e..4dfb72c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -439,7 +439,14 @@ static int _clk_main_bus_set_parent(struct clk
*clk, struct clk *parent)
 	return 0;
 }

+#ifdef CONFIG_CLK_DEBUG
+#define __INIT_CLK_DEBUG(n)	.name = #n,
+#else
+#define __INIT_CLK_DEBUG(n)
+#endif
+
 static struct clk main_bus_clk = {
+	__INIT_CLK_DEBUG(main_bus_clk)
 	.parent = &pll2_sw_clk,
 	.set_parent = _clk_main_bus_set_parent,
 };
@@ -690,23 +697,28 @@ static unsigned long
clk_emi_slow_get_rate(struct clk *clk)

 /* External high frequency clock */
 static struct clk ckih_clk = {
+	__INIT_CLK_DEBUG(ckih_clk)
 	.get_rate = get_high_reference_clock_rate,
 };

 static struct clk ckih2_clk = {
+	__INIT_CLK_DEBUG(ckih2_clk)
 	.get_rate = get_ckih2_reference_clock_rate,
 };

 static struct clk osc_clk = {
+	__INIT_CLK_DEBUG(osc_clk)
 	.get_rate = get_oscillator_reference_clock_rate,
 };

 /* External low frequency (32kHz) clock */
 static struct clk ckil_clk = {
+	__INIT_CLK_DEBUG(ckil_clk)
 	.get_rate = get_low_reference_clock_rate,
 };

 static struct clk pll1_main_clk = {
+	__INIT_CLK_DEBUG(pll1_main_clk)
 	.parent = &osc_clk,
 	.get_rate = clk_pll_get_rate,
 	.enable = _clk_pll_enable,
@@ -724,6 +736,7 @@ static struct clk pll1_main_clk = {

 /* PLL1 SW supplies to ARM core */
 static struct clk pll1_sw_clk = {
+	__INIT_CLK_DEBUG(pll1_sw_clk)
 	.parent = &pll1_main_clk,
 	.set_parent = _clk_pll1_sw_set_parent,
 	.get_rate = clk_pll1_sw_get_rate,
@@ -731,6 +744,7 @@ static struct clk pll1_sw_clk = {

 /* PLL2 SW supplies to AXI/AHB/IP buses */
 static struct clk pll2_sw_clk = {
+	__INIT_CLK_DEBUG(pll2_sw_clk)
 	.parent = &osc_clk,
 	.get_rate = clk_pll_get_rate,
 	.set_rate = _clk_pll_set_rate,
@@ -741,6 +755,7 @@ static struct clk pll2_sw_clk = {

 /* PLL3 SW supplies to serial clocks like USB, SSI, etc. */
 static struct clk pll3_sw_clk = {
+	__INIT_CLK_DEBUG(pll3_sw_clk)
 	.parent = &osc_clk,
 	.set_rate = _clk_pll_set_rate,
 	.get_rate = clk_pll_get_rate,
@@ -750,6 +765,7 @@ static struct clk pll3_sw_clk = {

 /* PLL4 SW supplies to LVDS Display Bridge(LDB) */
 static struct clk mx53_pll4_sw_clk = {
+	__INIT_CLK_DEBUG(mx53_pll4_clk)
 	.parent = &osc_clk,
 	.set_rate = _clk_pll_set_rate,
 	.enable = _clk_pll_enable,
@@ -758,22 +774,26 @@ static struct clk mx53_pll4_sw_clk = {

 /* Low-power Audio Playback Mode clock */
 static struct clk lp_apm_clk = {
+	__INIT_CLK_DEBUG(lp_apm_clk)
 	.parent = &osc_clk,
 	.set_parent = _clk_lp_apm_set_parent,
 };

 static struct clk periph_apm_clk = {
+	__INIT_CLK_DEBUG(periph_apm_clk)
 	.parent = &pll1_sw_clk,
 	.set_parent = _clk_periph_apm_set_parent,
 };

 static struct clk cpu_clk = {
+	__INIT_CLK_DEBUG(cpu_clk)
 	.parent = &pll1_sw_clk,
 	.get_rate = clk_cpu_get_rate,
 	.set_rate = clk_cpu_set_rate,
 };

 static struct clk ahb_clk = {
+	__INIT_CLK_DEBUG(ahb_clk)
 	.parent = &main_bus_clk,
 	.get_rate = clk_ahb_get_rate,
 	.set_rate = _clk_ahb_set_rate,
@@ -781,6 +801,7 @@ static struct clk ahb_clk = {
 };

 static struct clk iim_clk = {
+	__INIT_CLK_DEBUG(iim_clk)
 	.parent = &ipg_clk,
 	.enable_reg = MXC_CCM_CCGR0,
 	.enable_shift = MXC_CCM_CCGRx_CG15_OFFSET,
@@ -788,17 +809,20 @@ static struct clk iim_clk = {

 /* Main IP interface clock for access to registers */
 static struct clk ipg_clk = {
+	__INIT_CLK_DEBUG(ipg_clk)
 	.parent = &ahb_clk,
 	.get_rate = clk_ipg_get_rate,
 };

 static struct clk ipg_perclk = {
+	__INIT_CLK_DEBUG(ipg_clk)
 	.parent = &lp_apm_clk,
 	.get_rate = clk_ipg_per_get_rate,
 	.set_parent = _clk_ipg_per_set_parent,
 };

 static struct clk ahb_max_clk = {
+	__INIT_CLK_DEBUG(ahb_max_clk)
 	.parent = &ahb_clk,
 	.enable_reg = MXC_CCM_CCGR0,
 	.enable_shift = MXC_CCM_CCGRx_CG14_OFFSET,
@@ -807,6 +831,7 @@ static struct clk ahb_max_clk = {
 };

 static struct clk aips_tz1_clk = {
+	__INIT_CLK_DEBUG(aips_tz1_clk)
 	.parent = &ahb_clk,
 	.secondary = &ahb_max_clk,
 	.enable_reg = MXC_CCM_CCGR0,
@@ -816,6 +841,7 @@ static struct clk aips_tz1_clk = {
 };

 static struct clk aips_tz2_clk = {
+	__INIT_CLK_DEBUG(aips_tz2_clk)
 	.parent = &ahb_clk,
 	.secondary = &ahb_max_clk,
 	.enable_reg = MXC_CCM_CCGR0,
@@ -825,15 +851,18 @@ static struct clk aips_tz2_clk = {
 };

 static struct clk gpt_32k_clk = {
+	__INIT_CLK_DEBUG(gpt_32k_clk)
 	.id = 0,
 	.parent = &ckil_clk,
 };

 static struct clk kpp_clk = {
+	__INIT_CLK_DEBUG(kpp_clk)
 	.id = 0,
 };

 static struct clk emi_slow_clk = {
+	__INIT_CLK_DEBUG(emi_slow_clk)
 	.parent = &pll2_sw_clk,
 	.enable_reg = MXC_CCM_CCGR5,
 	.enable_shift = MXC_CCM_CCGRx_CG8_OFFSET,
@@ -842,8 +871,10 @@ static struct clk emi_slow_clk = {
 	.get_rate = clk_emi_slow_get_rate,
 };

+
 #define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s)	\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.id		= i,			\
 		.enable_reg	= er,			\
 		.enable_shift	= es,			\
@@ -859,6 +890,7 @@ static struct clk emi_slow_clk = {

 #define DEFINE_CLOCK_MAX(name, i, er, es, pfx, p, s)	\
 	static struct clk name = {			\
+		__INIT_CLK_DEBUG(name)			\
 		.id		= i,			\
 		.enable_reg	= er,			\
 		.enable_shift	= es,			\
@@ -937,6 +969,7 @@ CLK_GET_RATE(uart, 1, UART)
 CLK_SET_PARENT(uart, 1, UART)

 static struct clk uart_root_clk = {
+	__INIT_CLK_DEBUG(uart_root_clk)
 	.parent = &pll2_sw_clk,
 	.get_rate = clk_uart_get_rate,
 	.set_parent = clk_uart_set_parent,
@@ -947,6 +980,7 @@ CLK_GET_RATE(usboh3, 1, USBOH3)
 CLK_SET_PARENT(usboh3, 1, USBOH3)

 static struct clk usboh3_clk = {
+	__INIT_CLK_DEBUG(usboh3_clk)
 	.parent = &pll2_sw_clk,
 	.get_rate = clk_usboh3_get_rate,
 	.set_parent = clk_usboh3_set_parent,
@@ -957,6 +991,7 @@ CLK_GET_RATE(ecspi, 2, CSPI)
 CLK_SET_PARENT(ecspi, 1, CSPI)

 static struct clk ecspi_main_clk = {
+	__INIT_CLK_DEBUG(ecspi_main_clk)
 	.parent = &pll3_sw_clk,
 	.get_rate = clk_ecspi_get_rate,
 	.set_parent = clk_ecspi_set_parent,
@@ -972,7 +1007,8 @@ CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)

 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
-	static struct clk name = {					\
+static struct clk name = {						\
+		__INIT_CLK_DEBUG(name)					\
 		.id		= i,					\
 		.enable_reg	= er,					\
 		.enable_shift	= es,					\
@@ -1147,8 +1183,10 @@ int __init mx51_clocks_init(unsigned long ckil,
unsigned long osc,
 	ckih2_reference = ckih2;
 	oscillator_reference = osc;

-	for (i = 0; i < ARRAY_SIZE(mx51_lookups); i++)
+	for (i = 0; i < ARRAY_SIZE(mx51_lookups); i++) {
 		clkdev_add(&mx51_lookups[i]);
+		clk_debug_register(mx51_lookups[i].clk);
+	}

 	clk_tree_init();

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 2ed3ab1..1289a71 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -37,6 +37,8 @@
 #include <linux/proc_fs.h>
 #include <linux/semaphore.h>
 #include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>

 #include <mach/clock.h>
 #include <mach/hardware.h>
@@ -244,3 +246,122 @@ unsigned long mxc_decode_pll(unsigned int
reg_val, u32 freq)

 	return ll;
 }
+
+#ifdef CONFIG_CLK_DEBUG
+/*
+ *	debugfs support to trace clock tree hierarchy and attributes
+ */
+static int clk_debug_rate_get(void *data, u64 *val)
+{
+	struct clk *clk = data;
+
+	*val = (u64)clk_get_rate(clk);
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(clk_debug_rate_fops, clk_debug_rate_get, NULL,
+		"%llu\n");
+
+
+static struct dentry *clk_root;
+static int clk_debug_register_one(struct clk *clk)
+{
+	int err;
+	struct dentry *d, *child, *child_tmp;
+	struct clk *pa = clk_get_parent(clk);
+
+	if (pa && !IS_ERR(pa))
+		d = debugfs_create_dir(clk->name, pa->dentry);
+	else {
+		if (!clk_root)
+			clk_root = debugfs_create_dir("clocks", NULL);
+		if (!clk_root)
+			return -ENOMEM;
+		d = debugfs_create_dir(clk->name, clk_root);
+	}
+
+	if (!d)
+		return -ENOMEM;
+
+	clk->dentry = d;
+
+	d = debugfs_create_u32("enable_count", S_IRUGO, clk->dentry,
+			(u32 *)&clk->usecount);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	d = debugfs_create_file("rate", S_IRUGO, clk->dentry, (void *)clk,
+			&clk_debug_rate_fops);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	d = clk->dentry;
+	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(clk->dentry);
+	return err;
+}
+
+struct preinit_clk {
+	struct list_head list;
+	struct clk *clk;
+};
+static LIST_HEAD(preinit_clks);
+static DEFINE_MUTEX(preinit_lock);
+static int init_done;
+
+void clk_debug_register(struct clk *clk)
+{
+	int err;
+	struct clk *pa;
+
+	if (init_done) {
+		pa = clk_get_parent(clk);
+
+		if (pa && !IS_ERR(pa) && !pa->dentry)
+			clk_debug_register(pa);
+
+		if (!clk->dentry) {
+			err = clk_debug_register_one(clk);
+			if (err)
+				return;
+		}
+	} else {
+		struct preinit_clk *p;
+		mutex_lock(&preinit_lock);
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			goto unlock;
+		p->clk = clk;
+		list_add(&p->list, &preinit_clks);
+unlock:
+		mutex_unlock(&preinit_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(clk_debug_register);
+
+static int __init clk_debugfs_init(void)
+{
+	struct preinit_clk *pclk, *tmp;
+
+	if (debugfs_initialized())
+		init_done = 1;
+
+	list_for_each_entry(pclk, &preinit_clks, list) {
+		clk_debug_register(pclk->clk);
+	}
+
+	list_for_each_entry_safe(pclk, tmp, &preinit_clks, list) {
+		list_del(&pclk->list);
+		kfree(pclk);
+	}
+	return 0;
+}
+late_initcall(clk_debugfs_init);
+#endif
diff --git a/arch/arm/plat-mxc/include/mach/clock.h
b/arch/arm/plat-mxc/include/mach/clock.h
index 753a598..b4807df 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -26,6 +26,11 @@
 struct module;

 struct clk {
+#ifdef CONFIG_CLK_DEBUG
+#define CLK_NAME_LEN 32
+	char name[CLK_NAME_LEN];
+	struct dentry           *dentry;
+#endif
 	int id;
 	/* Source clock this clk depends on */
 	struct clk *parent;
@@ -62,5 +67,11 @@ void clk_unregister(struct clk *clk);

 unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);

+#ifdef CONFIG_CLK_DEBUG
+void clk_debug_register(struct clk *clk);
+#else
+static inline void clk_debug_register(struct clk *clk) {}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.0.4

--001517511a563c754004966b3412
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-add-clock-debug-information-for-imx51-babbage.patch"
Content-Disposition: attachment; 
	filename="0001-add-clock-debug-information-for-imx51-babbage.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh7j0qvc0

RnJvbSAzNzMxYTk5NWMwOTVjZWNjNGIzZjM1YzJlMzYzNWIxMDI4NTkxZTI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nIFNoZW4gPHlvbmcuc2hlbkBsaW5hcm8ub3JnPgpEYXRl
OiBUaHUsIDIgRGVjIDIwMTAgMTU6MjU6MDUgKzA4MDAKU3ViamVjdDogW1BBVENIdjJdIGFkZCBj
bG9jayBkZWJ1ZyBpbmZvcm1hdGlvbiBmb3IgaW14NTEgYmFiYmFnZQoKQWRkIGNvZGUgdG8gZXhw
b3NlIGEgdHJlZS1saWtlIGNsb2NrIGRlYnVnIGluZm9ybWF0aW9uIGluIHN5c2ZzCgpTaWduZWQt
b2ZmLWJ5OiBZb25nIFNoZW4gPHlvbmcuc2hlbkBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtL2Nv
bW1vbi9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAgNiArKwogYXJjaC9hcm0vbWFjaC1teDUv
Y2xvY2stbXg1MS1teDUzLmMgICAgfCAgIDQyICsrKysrKysrKysrLQogYXJjaC9hcm0vcGxhdC1t
eGMvY2xvY2suYyAgICAgICAgICAgICAgfCAgMTIxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiBhcmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaCB8ICAgMTEgKysr
CiA0IGZpbGVzIGNoYW5nZWQsIDE3OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2NvbW1vbi9LY29uZmlnIGIvYXJjaC9hcm0vY29tbW9uL0tjb25m
aWcKaW5kZXggMGEzNGM4MS4uZDk3ZGFhNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vY29tbW9uL0tj
b25maWcKKysrIGIvYXJjaC9hcm0vY29tbW9uL0tjb25maWcKQEAgLTQxLDMgKzQxLDkgQEAgY29u
ZmlnIFNIQVJQX1NDT09QCiBjb25maWcgQ09NTU9OX0NMS0RFVgogCWJvb2wKIAlzZWxlY3QgSEFW
RV9DTEsKKworY29uZmlnIENMS19ERUJVRworCWJvb2wgImNsb2NrIGRlYnVnIGluZm9ybWF0aW9u
IGV4cG9ydCB0byB1c2VyIHNwYWNlIgorCWRlcGVuZHMgb24gUE1fREVCVUcgJiYgREVCVUdfRlMK
KwloZWxwCisJICBleHBvcnQgY2xrIGRlYnVnIGluZm9ybWF0aW9uIHRvIHVzZXIgc3BhY2UKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbXg1L2Nsb2NrLW14NTEtbXg1My5jIGIvYXJjaC9hcm0v
bWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKaW5kZXggMzQ0ZWU4ZS4uNGRmYjcyYyAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKKysrIGIvYXJjaC9hcm0v
bWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKQEAgLTQzOSw3ICs0MzksMTQgQEAgc3RhdGljIGlu
dCBfY2xrX21haW5fYnVzX3NldF9wYXJlbnQoc3RydWN0IGNsayAqY2xrLCBzdHJ1Y3QgY2xrICpw
YXJlbnQpCiAJcmV0dXJuIDA7CiB9CiAKKyNpZmRlZiBDT05GSUdfQ0xLX0RFQlVHCisjZGVmaW5l
IF9fSU5JVF9DTEtfREVCVUcobikJLm5hbWUgPSAjbiwKKyNlbHNlCisjZGVmaW5lIF9fSU5JVF9D
TEtfREVCVUcobikKKyNlbmRpZgorCiBzdGF0aWMgc3RydWN0IGNsayBtYWluX2J1c19jbGsgPSB7
CisJX19JTklUX0NMS19ERUJVRyhtYWluX2J1c19jbGspCiAJLnBhcmVudCA9ICZwbGwyX3N3X2Ns
aywKIAkuc2V0X3BhcmVudCA9IF9jbGtfbWFpbl9idXNfc2V0X3BhcmVudCwKIH07CkBAIC02OTAs
MjMgKzY5NywyOCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjbGtfZW1pX3Nsb3dfZ2V0X3JhdGUo
c3RydWN0IGNsayAqY2xrKQogCiAvKiBFeHRlcm5hbCBoaWdoIGZyZXF1ZW5jeSBjbG9jayAqLwog
c3RhdGljIHN0cnVjdCBjbGsgY2tpaF9jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhja2loX2Ns
aykKIAkuZ2V0X3JhdGUgPSBnZXRfaGlnaF9yZWZlcmVuY2VfY2xvY2tfcmF0ZSwKIH07CiAKIHN0
YXRpYyBzdHJ1Y3QgY2xrIGNraWgyX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGNraWgyX2Ns
aykKIAkuZ2V0X3JhdGUgPSBnZXRfY2tpaDJfcmVmZXJlbmNlX2Nsb2NrX3JhdGUsCiB9OwogCiBz
dGF0aWMgc3RydWN0IGNsayBvc2NfY2xrID0geworCV9fSU5JVF9DTEtfREVCVUcob3NjX2NsaykK
IAkuZ2V0X3JhdGUgPSBnZXRfb3NjaWxsYXRvcl9yZWZlcmVuY2VfY2xvY2tfcmF0ZSwKIH07CiAK
IC8qIEV4dGVybmFsIGxvdyBmcmVxdWVuY3kgKDMya0h6KSBjbG9jayAqLwogc3RhdGljIHN0cnVj
dCBjbGsgY2tpbF9jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhja2lsX2NsaykKIAkuZ2V0X3Jh
dGUgPSBnZXRfbG93X3JlZmVyZW5jZV9jbG9ja19yYXRlLAogfTsKIAogc3RhdGljIHN0cnVjdCBj
bGsgcGxsMV9tYWluX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHBsbDFfbWFpbl9jbGspCiAJ
LnBhcmVudCA9ICZvc2NfY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19wbGxfZ2V0X3JhdGUsCiAJLmVu
YWJsZSA9IF9jbGtfcGxsX2VuYWJsZSwKQEAgLTcyNCw2ICs3MzYsNyBAQCBzdGF0aWMgc3RydWN0
IGNsayBwbGwxX21haW5fY2xrID0gewogCiAvKiBQTEwxIFNXIHN1cHBsaWVzIHRvIEFSTSBjb3Jl
ICovCiBzdGF0aWMgc3RydWN0IGNsayBwbGwxX3N3X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVH
KHBsbDFfc3dfY2xrKQogCS5wYXJlbnQgPSAmcGxsMV9tYWluX2NsaywKIAkuc2V0X3BhcmVudCA9
IF9jbGtfcGxsMV9zd19zZXRfcGFyZW50LAogCS5nZXRfcmF0ZSA9IGNsa19wbGwxX3N3X2dldF9y
YXRlLApAQCAtNzMxLDYgKzc0NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIHBsbDFfc3dfY2xrID0g
ewogCiAvKiBQTEwyIFNXIHN1cHBsaWVzIHRvIEFYSS9BSEIvSVAgYnVzZXMgKi8KIHN0YXRpYyBz
dHJ1Y3QgY2xrIHBsbDJfc3dfY2xrID0geworCV9fSU5JVF9DTEtfREVCVUcocGxsMl9zd19jbGsp
CiAJLnBhcmVudCA9ICZvc2NfY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19wbGxfZ2V0X3JhdGUsCiAJ
LnNldF9yYXRlID0gX2Nsa19wbGxfc2V0X3JhdGUsCkBAIC03NDEsNiArNzU1LDcgQEAgc3RhdGlj
IHN0cnVjdCBjbGsgcGxsMl9zd19jbGsgPSB7CiAKIC8qIFBMTDMgU1cgc3VwcGxpZXMgdG8gc2Vy
aWFsIGNsb2NrcyBsaWtlIFVTQiwgU1NJLCBldGMuICovCiBzdGF0aWMgc3RydWN0IGNsayBwbGwz
X3N3X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHBsbDNfc3dfY2xrKQogCS5wYXJlbnQgPSAm
b3NjX2NsaywKIAkuc2V0X3JhdGUgPSBfY2xrX3BsbF9zZXRfcmF0ZSwKIAkuZ2V0X3JhdGUgPSBj
bGtfcGxsX2dldF9yYXRlLApAQCAtNzUwLDYgKzc2NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIHBs
bDNfc3dfY2xrID0gewogCiAvKiBQTEw0IFNXIHN1cHBsaWVzIHRvIExWRFMgRGlzcGxheSBCcmlk
Z2UoTERCKSAqLwogc3RhdGljIHN0cnVjdCBjbGsgbXg1M19wbGw0X3N3X2NsayA9IHsKKwlfX0lO
SVRfQ0xLX0RFQlVHKG14NTNfcGxsNF9jbGspCiAJLnBhcmVudCA9ICZvc2NfY2xrLAogCS5zZXRf
cmF0ZSA9IF9jbGtfcGxsX3NldF9yYXRlLAogCS5lbmFibGUgPSBfY2xrX3BsbF9lbmFibGUsCkBA
IC03NTgsMjIgKzc3NCwyNiBAQCBzdGF0aWMgc3RydWN0IGNsayBteDUzX3BsbDRfc3dfY2xrID0g
ewogCiAvKiBMb3ctcG93ZXIgQXVkaW8gUGxheWJhY2sgTW9kZSBjbG9jayAqLwogc3RhdGljIHN0
cnVjdCBjbGsgbHBfYXBtX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGxwX2FwbV9jbGspCiAJ
LnBhcmVudCA9ICZvc2NfY2xrLAogCS5zZXRfcGFyZW50ID0gX2Nsa19scF9hcG1fc2V0X3BhcmVu
dCwKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIHBlcmlwaF9hcG1fY2xrID0geworCV9fSU5JVF9D
TEtfREVCVUcocGVyaXBoX2FwbV9jbGspCiAJLnBhcmVudCA9ICZwbGwxX3N3X2NsaywKIAkuc2V0
X3BhcmVudCA9IF9jbGtfcGVyaXBoX2FwbV9zZXRfcGFyZW50LAogfTsKIAogc3RhdGljIHN0cnVj
dCBjbGsgY3B1X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGNwdV9jbGspCiAJLnBhcmVudCA9
ICZwbGwxX3N3X2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfY3B1X2dldF9yYXRlLAogCS5zZXRfcmF0
ZSA9IGNsa19jcHVfc2V0X3JhdGUsCiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBhaGJfY2xrID0g
eworCV9fSU5JVF9DTEtfREVCVUcoYWhiX2NsaykKIAkucGFyZW50ID0gJm1haW5fYnVzX2NsaywK
IAkuZ2V0X3JhdGUgPSBjbGtfYWhiX2dldF9yYXRlLAogCS5zZXRfcmF0ZSA9IF9jbGtfYWhiX3Nl
dF9yYXRlLApAQCAtNzgxLDYgKzgwMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIGFoYl9jbGsgPSB7
CiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBpaW1fY2xrID0geworCV9fSU5JVF9DTEtfREVCVUco
aWltX2NsaykKIAkucGFyZW50ID0gJmlwZ19jbGssCiAJLmVuYWJsZV9yZWcgPSBNWENfQ0NNX0ND
R1IwLAogCS5lbmFibGVfc2hpZnQgPSBNWENfQ0NNX0NDR1J4X0NHMTVfT0ZGU0VULApAQCAtNzg4
LDE3ICs4MDksMjAgQEAgc3RhdGljIHN0cnVjdCBjbGsgaWltX2NsayA9IHsKIAogLyogTWFpbiBJ
UCBpbnRlcmZhY2UgY2xvY2sgZm9yIGFjY2VzcyB0byByZWdpc3RlcnMgKi8KIHN0YXRpYyBzdHJ1
Y3QgY2xrIGlwZ19jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhpcGdfY2xrKQogCS5wYXJlbnQg
PSAmYWhiX2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfaXBnX2dldF9yYXRlLAogfTsKIAogc3RhdGlj
IHN0cnVjdCBjbGsgaXBnX3BlcmNsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGlwZ19jbGspCiAJ
LnBhcmVudCA9ICZscF9hcG1fY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19pcGdfcGVyX2dldF9yYXRl
LAogCS5zZXRfcGFyZW50ID0gX2Nsa19pcGdfcGVyX3NldF9wYXJlbnQsCiB9OwogCiBzdGF0aWMg
c3RydWN0IGNsayBhaGJfbWF4X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGFoYl9tYXhfY2xr
KQogCS5wYXJlbnQgPSAmYWhiX2NsaywKIAkuZW5hYmxlX3JlZyA9IE1YQ19DQ01fQ0NHUjAsCiAJ
LmVuYWJsZV9zaGlmdCA9IE1YQ19DQ01fQ0NHUnhfQ0cxNF9PRkZTRVQsCkBAIC04MDcsNiArODMx
LDcgQEAgc3RhdGljIHN0cnVjdCBjbGsgYWhiX21heF9jbGsgPSB7CiB9OwogCiBzdGF0aWMgc3Ry
dWN0IGNsayBhaXBzX3R6MV9jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhhaXBzX3R6MV9jbGsp
CiAJLnBhcmVudCA9ICZhaGJfY2xrLAogCS5zZWNvbmRhcnkgPSAmYWhiX21heF9jbGssCiAJLmVu
YWJsZV9yZWcgPSBNWENfQ0NNX0NDR1IwLApAQCAtODE2LDYgKzg0MSw3IEBAIHN0YXRpYyBzdHJ1
Y3QgY2xrIGFpcHNfdHoxX2NsayA9IHsKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIGFpcHNfdHoy
X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGFpcHNfdHoyX2NsaykKIAkucGFyZW50ID0gJmFo
Yl9jbGssCiAJLnNlY29uZGFyeSA9ICZhaGJfbWF4X2NsaywKIAkuZW5hYmxlX3JlZyA9IE1YQ19D
Q01fQ0NHUjAsCkBAIC04MjUsMTUgKzg1MSwxOCBAQCBzdGF0aWMgc3RydWN0IGNsayBhaXBzX3R6
Ml9jbGsgPSB7CiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBncHRfMzJrX2NsayA9IHsKKwlfX0lO
SVRfQ0xLX0RFQlVHKGdwdF8zMmtfY2xrKQogCS5pZCA9IDAsCiAJLnBhcmVudCA9ICZja2lsX2Ns
aywKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIGtwcF9jbGsgPSB7CisJX19JTklUX0NMS19ERUJV
RyhrcHBfY2xrKQogCS5pZCA9IDAsCiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBlbWlfc2xvd19j
bGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhlbWlfc2xvd19jbGspCiAJLnBhcmVudCA9ICZwbGwy
X3N3X2NsaywKIAkuZW5hYmxlX3JlZyA9IE1YQ19DQ01fQ0NHUjUsCiAJLmVuYWJsZV9zaGlmdCA9
IE1YQ19DQ01fQ0NHUnhfQ0c4X09GRlNFVCwKQEAgLTg0Miw4ICs4NzEsMTAgQEAgc3RhdGljIHN0
cnVjdCBjbGsgZW1pX3Nsb3dfY2xrID0gewogCS5nZXRfcmF0ZSA9IGNsa19lbWlfc2xvd19nZXRf
cmF0ZSwKIH07CiAKKwogI2RlZmluZSBERUZJTkVfQ0xPQ0tfQ0NHUihuYW1lLCBpLCBlciwgZXMs
IHBmeCwgcCwgcykJXAogCXN0YXRpYyBzdHJ1Y3QgY2xrIG5hbWUgPSB7CQkJXAorCQlfX0lOSVRf
Q0xLX0RFQlVHKG5hbWUpCQkJXAogCQkuaWQJCT0gaSwJCQlcCiAJCS5lbmFibGVfcmVnCT0gZXIs
CQkJXAogCQkuZW5hYmxlX3NoaWZ0CT0gZXMsCQkJXApAQCAtODU5LDYgKzg5MCw3IEBAIHN0YXRp
YyBzdHJ1Y3QgY2xrIGVtaV9zbG93X2NsayA9IHsKIAogI2RlZmluZSBERUZJTkVfQ0xPQ0tfTUFY
KG5hbWUsIGksIGVyLCBlcywgcGZ4LCBwLCBzKQlcCiAJc3RhdGljIHN0cnVjdCBjbGsgbmFtZSA9
IHsJCQlcCisJCV9fSU5JVF9DTEtfREVCVUcobmFtZSkJCQlcCiAJCS5pZAkJPSBpLAkJCVwKIAkJ
LmVuYWJsZV9yZWcJPSBlciwJCQlcCiAJCS5lbmFibGVfc2hpZnQJPSBlcywJCQlcCkBAIC05Mzcs
NiArOTY5LDcgQEAgQ0xLX0dFVF9SQVRFKHVhcnQsIDEsIFVBUlQpCiBDTEtfU0VUX1BBUkVOVCh1
YXJ0LCAxLCBVQVJUKQogCiBzdGF0aWMgc3RydWN0IGNsayB1YXJ0X3Jvb3RfY2xrID0geworCV9f
SU5JVF9DTEtfREVCVUcodWFydF9yb290X2NsaykKIAkucGFyZW50ID0gJnBsbDJfc3dfY2xrLAog
CS5nZXRfcmF0ZSA9IGNsa191YXJ0X2dldF9yYXRlLAogCS5zZXRfcGFyZW50ID0gY2xrX3VhcnRf
c2V0X3BhcmVudCwKQEAgLTk0Nyw2ICs5ODAsNyBAQCBDTEtfR0VUX1JBVEUodXNib2gzLCAxLCBV
U0JPSDMpCiBDTEtfU0VUX1BBUkVOVCh1c2JvaDMsIDEsIFVTQk9IMykKIAogc3RhdGljIHN0cnVj
dCBjbGsgdXNib2gzX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHVzYm9oM19jbGspCiAJLnBh
cmVudCA9ICZwbGwyX3N3X2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfdXNib2gzX2dldF9yYXRlLAog
CS5zZXRfcGFyZW50ID0gY2xrX3VzYm9oM19zZXRfcGFyZW50LApAQCAtOTU3LDYgKzk5MSw3IEBA
IENMS19HRVRfUkFURShlY3NwaSwgMiwgQ1NQSSkKIENMS19TRVRfUEFSRU5UKGVjc3BpLCAxLCBD
U1BJKQogCiBzdGF0aWMgc3RydWN0IGNsayBlY3NwaV9tYWluX2NsayA9IHsKKwlfX0lOSVRfQ0xL
X0RFQlVHKGVjc3BpX21haW5fY2xrKQogCS5wYXJlbnQgPSAmcGxsM19zd19jbGssCiAJLmdldF9y
YXRlID0gY2xrX2Vjc3BpX2dldF9yYXRlLAogCS5zZXRfcGFyZW50ID0gY2xrX2Vjc3BpX3NldF9w
YXJlbnQsCkBAIC05NzIsNyArMTAwNyw4IEBAIENMS19TRVRfUEFSRU5UKGVzZGhjMiwgMSwgRVNE
SEMyX01TSEMyKQogQ0xLX1NFVF9SQVRFKGVzZGhjMiwgMSwgRVNESEMyX01TSEMyKQogCiAjZGVm
aW5lIERFRklORV9DTE9DS19GVUxMKG5hbWUsIGksIGVyLCBlcywgZ3IsIHNyLCBlLCBkLCBwLCBz
KQkJXAotCXN0YXRpYyBzdHJ1Y3QgY2xrIG5hbWUgPSB7CQkJCQlcCitzdGF0aWMgc3RydWN0IGNs
ayBuYW1lID0gewkJCQkJCVwKKwkJX19JTklUX0NMS19ERUJVRyhuYW1lKQkJCQkJXAogCQkuaWQJ
CT0gaSwJCQkJCVwKIAkJLmVuYWJsZV9yZWcJPSBlciwJCQkJCVwKIAkJLmVuYWJsZV9zaGlmdAk9
IGVzLAkJCQkJXApAQCAtMTE0Nyw4ICsxMTgzLDEwIEBAIGludCBfX2luaXQgbXg1MV9jbG9ja3Nf
aW5pdCh1bnNpZ25lZCBsb25nIGNraWwsIHVuc2lnbmVkIGxvbmcgb3NjLAogCWNraWgyX3JlZmVy
ZW5jZSA9IGNraWgyOwogCW9zY2lsbGF0b3JfcmVmZXJlbmNlID0gb3NjOwogCi0JZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUobXg1MV9sb29rdXBzKTsgaSsrKQorCWZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKG14NTFfbG9va3Vwcyk7IGkrKykgewogCQljbGtkZXZfYWRkKCZteDUxX2xvb2t1
cHNbaV0pOworCQljbGtfZGVidWdfcmVnaXN0ZXIobXg1MV9sb29rdXBzW2ldLmNsayk7CisJfQog
CiAJY2xrX3RyZWVfaW5pdCgpOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW14Yy9jbG9j
ay5jIGIvYXJjaC9hcm0vcGxhdC1teGMvY2xvY2suYwppbmRleCAyZWQzYWIxLi4xMjg5YTcxIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW14Yy9jbG9jay5jCisrKyBiL2FyY2gvYXJtL3BsYXQt
bXhjL2Nsb2NrLmMKQEAgLTM3LDYgKzM3LDggQEAKICNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+
CiAjaW5jbHVkZSA8bGludXgvc2VtYXBob3JlLmg+CiAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+
CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4KIAog
I2luY2x1ZGUgPG1hY2gvY2xvY2suaD4KICNpbmNsdWRlIDxtYWNoL2hhcmR3YXJlLmg+CkBAIC0y
NDQsMyArMjQ2LDEyMiBAQCB1bnNpZ25lZCBsb25nIG14Y19kZWNvZGVfcGxsKHVuc2lnbmVkIGlu
dCByZWdfdmFsLCB1MzIgZnJlcSkKIAogCXJldHVybiBsbDsKIH0KKworI2lmZGVmIENPTkZJR19D
TEtfREVCVUcKKy8qCisgKglkZWJ1Z2ZzIHN1cHBvcnQgdG8gdHJhY2UgY2xvY2sgdHJlZSBoaWVy
YXJjaHkgYW5kIGF0dHJpYnV0ZXMKKyAqLworc3RhdGljIGludCBjbGtfZGVidWdfcmF0ZV9nZXQo
dm9pZCAqZGF0YSwgdTY0ICp2YWwpCit7CisJc3RydWN0IGNsayAqY2xrID0gZGF0YTsKKworCSp2
YWwgPSAodTY0KWNsa19nZXRfcmF0ZShjbGspOworCXJldHVybiAwOworfQorREVGSU5FX1NJTVBM
RV9BVFRSSUJVVEUoY2xrX2RlYnVnX3JhdGVfZm9wcywgY2xrX2RlYnVnX3JhdGVfZ2V0LCBOVUxM
LAorCQkiJWxsdVxuIik7CisKKworc3RhdGljIHN0cnVjdCBkZW50cnkgKmNsa19yb290Oworc3Rh
dGljIGludCBjbGtfZGVidWdfcmVnaXN0ZXJfb25lKHN0cnVjdCBjbGsgKmNsaykKK3sKKwlpbnQg
ZXJyOworCXN0cnVjdCBkZW50cnkgKmQsICpjaGlsZCwgKmNoaWxkX3RtcDsKKwlzdHJ1Y3QgY2xr
ICpwYSA9IGNsa19nZXRfcGFyZW50KGNsayk7CisKKwlpZiAocGEgJiYgIUlTX0VSUihwYSkpCisJ
CWQgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoY2xrLT5uYW1lLCBwYS0+ZGVudHJ5KTsKKwllbHNlIHsK
KwkJaWYgKCFjbGtfcm9vdCkKKwkJCWNsa19yb290ID0gZGVidWdmc19jcmVhdGVfZGlyKCJjbG9j
a3MiLCBOVUxMKTsKKwkJaWYgKCFjbGtfcm9vdCkKKwkJCXJldHVybiAtRU5PTUVNOworCQlkID0g
ZGVidWdmc19jcmVhdGVfZGlyKGNsay0+bmFtZSwgY2xrX3Jvb3QpOworCX0KKworCWlmICghZCkK
KwkJcmV0dXJuIC1FTk9NRU07CisKKwljbGstPmRlbnRyeSA9IGQ7CisKKwlkID0gZGVidWdmc19j
cmVhdGVfdTMyKCJlbmFibGVfY291bnQiLCBTX0lSVUdPLCBjbGstPmRlbnRyeSwKKwkJCSh1MzIg
KikmY2xrLT51c2Vjb3VudCk7CisJaWYgKCFkKSB7CisJCWVyciA9IC1FTk9NRU07CisJCWdvdG8g
ZXJyX291dDsKKwl9CisKKwlkID0gZGVidWdmc19jcmVhdGVfZmlsZSgicmF0ZSIsIFNfSVJVR08s
IGNsay0+ZGVudHJ5LCAodm9pZCAqKWNsaywKKwkJCSZjbGtfZGVidWdfcmF0ZV9mb3BzKTsKKwlp
ZiAoIWQpIHsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBlcnJfb3V0OworCX0KKworCXJldHVy
biAwOworCitlcnJfb3V0OgorCWQgPSBjbGstPmRlbnRyeTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5
X3NhZmUoY2hpbGQsIGNoaWxkX3RtcCwgJmQtPmRfc3ViZGlycywgZF91LmRfY2hpbGQpCisJCWRl
YnVnZnNfcmVtb3ZlKGNoaWxkKTsKKwlkZWJ1Z2ZzX3JlbW92ZShjbGstPmRlbnRyeSk7CisJcmV0
dXJuIGVycjsKK30KKworc3RydWN0IHByZWluaXRfY2xrIHsKKwlzdHJ1Y3QgbGlzdF9oZWFkIGxp
c3Q7CisJc3RydWN0IGNsayAqY2xrOworfTsKK3N0YXRpYyBMSVNUX0hFQUQocHJlaW5pdF9jbGtz
KTsKK3N0YXRpYyBERUZJTkVfTVVURVgocHJlaW5pdF9sb2NrKTsKK3N0YXRpYyBpbnQgaW5pdF9k
b25lOworCit2b2lkIGNsa19kZWJ1Z19yZWdpc3RlcihzdHJ1Y3QgY2xrICpjbGspCit7CisJaW50
IGVycjsKKwlzdHJ1Y3QgY2xrICpwYTsKKworCWlmIChpbml0X2RvbmUpIHsKKwkJcGEgPSBjbGtf
Z2V0X3BhcmVudChjbGspOworCisJCWlmIChwYSAmJiAhSVNfRVJSKHBhKSAmJiAhcGEtPmRlbnRy
eSkKKwkJCWNsa19kZWJ1Z19yZWdpc3RlcihwYSk7CisKKwkJaWYgKCFjbGstPmRlbnRyeSkgewor
CQkJZXJyID0gY2xrX2RlYnVnX3JlZ2lzdGVyX29uZShjbGspOworCQkJaWYgKGVycikKKwkJCQly
ZXR1cm47CisJCX0KKwl9IGVsc2UgeworCQlzdHJ1Y3QgcHJlaW5pdF9jbGsgKnA7CisJCW11dGV4
X2xvY2soJnByZWluaXRfbG9jayk7CisJCXAgPSBrbWFsbG9jKHNpemVvZigqcCksIEdGUF9LRVJO
RUwpOworCQlpZiAoIXApCisJCQlnb3RvIHVubG9jazsKKwkJcC0+Y2xrID0gY2xrOworCQlsaXN0
X2FkZCgmcC0+bGlzdCwgJnByZWluaXRfY2xrcyk7Cit1bmxvY2s6CisJCW11dGV4X3VubG9jaygm
cHJlaW5pdF9sb2NrKTsKKwl9Cit9CitFWFBPUlRfU1lNQk9MX0dQTChjbGtfZGVidWdfcmVnaXN0
ZXIpOworCitzdGF0aWMgaW50IF9faW5pdCBjbGtfZGVidWdmc19pbml0KHZvaWQpCit7CisJc3Ry
dWN0IHByZWluaXRfY2xrICpwY2xrLCAqdG1wOworCisJaWYgKGRlYnVnZnNfaW5pdGlhbGl6ZWQo
KSkKKwkJaW5pdF9kb25lID0gMTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnkocGNsaywgJnByZWlu
aXRfY2xrcywgbGlzdCkgeworCQljbGtfZGVidWdfcmVnaXN0ZXIocGNsay0+Y2xrKTsKKwl9CisK
KwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocGNsaywgdG1wLCAmcHJlaW5pdF9jbGtzLCBsaXN0
KSB7CisJCWxpc3RfZGVsKCZwY2xrLT5saXN0KTsKKwkJa2ZyZWUocGNsayk7CisJfQorCXJldHVy
biAwOworfQorbGF0ZV9pbml0Y2FsbChjbGtfZGVidWdmc19pbml0KTsKKyNlbmRpZgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vcGxhdC1teGMvaW5jbHVkZS9tYWNoL2Nsb2NrLmggYi9hcmNoL2FybS9w
bGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaAppbmRleCA3NTNhNTk4Li5iNDgwN2RmIDEwMDY0
NAotLS0gYS9hcmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaAorKysgYi9hcmNo
L2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaApAQCAtMjYsNiArMjYsMTEgQEAKIHN0
cnVjdCBtb2R1bGU7CiAKIHN0cnVjdCBjbGsgeworI2lmZGVmIENPTkZJR19DTEtfREVCVUcKKyNk
ZWZpbmUgQ0xLX05BTUVfTEVOIDMyCisJY2hhciBuYW1lW0NMS19OQU1FX0xFTl07CisJc3RydWN0
IGRlbnRyeSAgICAgICAgICAgKmRlbnRyeTsKKyNlbmRpZgogCWludCBpZDsKIAkvKiBTb3VyY2Ug
Y2xvY2sgdGhpcyBjbGsgZGVwZW5kcyBvbiAqLwogCXN0cnVjdCBjbGsgKnBhcmVudDsKQEAgLTYy
LDUgKzY3LDExIEBAIHZvaWQgY2xrX3VucmVnaXN0ZXIoc3RydWN0IGNsayAqY2xrKTsKIAogdW5z
aWduZWQgbG9uZyBteGNfZGVjb2RlX3BsbCh1bnNpZ25lZCBpbnQgcGxsLCB1MzIgZl9yZWYpOwog
CisjaWZkZWYgQ09ORklHX0NMS19ERUJVRwordm9pZCBjbGtfZGVidWdfcmVnaXN0ZXIoc3RydWN0
IGNsayAqY2xrKTsKKyNlbHNlCitzdGF0aWMgaW5saW5lIHZvaWQgY2xrX2RlYnVnX3JlZ2lzdGVy
KHN0cnVjdCBjbGsgKmNsaykge30KKyNlbmRpZgorCiAjZW5kaWYgLyogX19BU1NFTUJMWV9fICov
CiAjZW5kaWYgLyogX19BU01fQVJDSF9NWENfQ0xPQ0tfSF9fICovCi0tIAoxLjcuMC40Cgo=
--001517511a563c754004966b3412--
