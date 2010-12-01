From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 1 Dec 2010 19:18:34 +0800
Subject: [PATCH] add clock debug information for imx51 babbage
Message-ID: <mailman.31.1291203073.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to expose a tree-like clock debug information in sysfs.

Signed-off-by: Yong Shen <yong.shen@linaro.org>
---
 arch/arm/common/Kconfig                |    7 ++
 arch/arm/mach-mx5/clock-mx51-mx53.c    |   42 +++++++++++-
 arch/arm/plat-mxc/clock.c              |  121 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/clock.h |   11 +++
 4 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 0a34c81..81f8939 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -41,3 +41,10 @@ config SHARP_SCOOP
 config COMMON_CLKDEV
 	bool
 	select HAVE_CLK
+
+config CLK_DEBUG
+	bool "clock debug information export to user space"
+	depends on PM_DEBUG && DEBUG_FS
+	default n
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
index 753a598..fb0e0bd 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -23,9 +23,14 @@
 #ifndef __ASSEMBLY__
 #include <linux/list.h>

+#define CLK_NAME_LEN 32
 struct module;

 struct clk {
+#ifdef CONFIG_CLK_DEBUG
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

Cheers
Yong

--000e0cd47c686618b1049657a3b5
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-add-clock-debug-information-for-imx51-babbage.patch"
Content-Disposition: attachment; 
	filename="0001-add-clock-debug-information-for-imx51-babbage.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh64tiog0

RnJvbSBhODU2ZDY4YzUzY2Y5MWIzZmEzMGE3NzQyMDU3ZjdhZmRhZjc3NDgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nIFNoZW4gPHlvbmcuc2hlbkBsaW5hcm8ub3JnPgpEYXRl
OiBXZWQsIDEgRGVjIDIwMTAgMTk6MTg6MzQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBhZGQgY2xv
Y2sgZGVidWcgaW5mb3JtYXRpb24gZm9yIGlteDUxIGJhYmJhZ2UKCkFkZCBjb2RlIHRvIGV4cG9z
ZSBhIHRyZWUtbGlrZSBjbG9jayBkZWJ1ZyBpbmZvcm1hdGlvbiBpbiBzeXNmcy4KClNpZ25lZC1v
ZmYtYnk6IFlvbmcgU2hlbiA8eW9uZy5zaGVuQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9hcm0vY29t
bW9uL0tjb25maWcgICAgICAgICAgICAgICAgfCAgICA3ICsrCiBhcmNoL2FybS9tYWNoLW14NS9j
bG9jay1teDUxLW14NTMuYyAgICB8ICAgNDIgKysrKysrKysrKystCiBhcmNoL2FybS9wbGF0LW14
Yy9jbG9jay5jICAgICAgICAgICAgICB8ICAxMjEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGFyY2gvYXJtL3BsYXQtbXhjL2luY2x1ZGUvbWFjaC9jbG9jay5oIHwgICAxMSArKysK
IDQgZmlsZXMgY2hhbmdlZCwgMTc5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vY29tbW9uL0tjb25maWcgYi9hcmNoL2FybS9jb21tb24vS2NvbmZp
ZwppbmRleCAwYTM0YzgxLi44MWY4OTM5IDEwMDY0NAotLS0gYS9hcmNoL2FybS9jb21tb24vS2Nv
bmZpZworKysgYi9hcmNoL2FybS9jb21tb24vS2NvbmZpZwpAQCAtNDEsMyArNDEsMTAgQEAgY29u
ZmlnIFNIQVJQX1NDT09QCiBjb25maWcgQ09NTU9OX0NMS0RFVgogCWJvb2wKIAlzZWxlY3QgSEFW
RV9DTEsKKworY29uZmlnIENMS19ERUJVRworCWJvb2wgImNsb2NrIGRlYnVnIGluZm9ybWF0aW9u
IGV4cG9ydCB0byB1c2VyIHNwYWNlIgorCWRlcGVuZHMgb24gUE1fREVCVUcgJiYgREVCVUdfRlMK
KwlkZWZhdWx0IG4KKwloZWxwCisJICBleHBvcnQgY2xrIGRlYnVnIGluZm9ybWF0aW9uIHRvIHVz
ZXIgc3BhY2UKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbXg1L2Nsb2NrLW14NTEtbXg1My5j
IGIvYXJjaC9hcm0vbWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKaW5kZXggMzQ0ZWU4ZS4uNGRm
YjcyYyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKKysr
IGIvYXJjaC9hcm0vbWFjaC1teDUvY2xvY2stbXg1MS1teDUzLmMKQEAgLTQzOSw3ICs0MzksMTQg
QEAgc3RhdGljIGludCBfY2xrX21haW5fYnVzX3NldF9wYXJlbnQoc3RydWN0IGNsayAqY2xrLCBz
dHJ1Y3QgY2xrICpwYXJlbnQpCiAJcmV0dXJuIDA7CiB9CiAKKyNpZmRlZiBDT05GSUdfQ0xLX0RF
QlVHCisjZGVmaW5lIF9fSU5JVF9DTEtfREVCVUcobikJLm5hbWUgPSAjbiwKKyNlbHNlCisjZGVm
aW5lIF9fSU5JVF9DTEtfREVCVUcobikKKyNlbmRpZgorCiBzdGF0aWMgc3RydWN0IGNsayBtYWlu
X2J1c19jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhtYWluX2J1c19jbGspCiAJLnBhcmVudCA9
ICZwbGwyX3N3X2NsaywKIAkuc2V0X3BhcmVudCA9IF9jbGtfbWFpbl9idXNfc2V0X3BhcmVudCwK
IH07CkBAIC02OTAsMjMgKzY5NywyOCBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjbGtfZW1pX3Ns
b3dfZ2V0X3JhdGUoc3RydWN0IGNsayAqY2xrKQogCiAvKiBFeHRlcm5hbCBoaWdoIGZyZXF1ZW5j
eSBjbG9jayAqLwogc3RhdGljIHN0cnVjdCBjbGsgY2tpaF9jbGsgPSB7CisJX19JTklUX0NMS19E
RUJVRyhja2loX2NsaykKIAkuZ2V0X3JhdGUgPSBnZXRfaGlnaF9yZWZlcmVuY2VfY2xvY2tfcmF0
ZSwKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIGNraWgyX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RF
QlVHKGNraWgyX2NsaykKIAkuZ2V0X3JhdGUgPSBnZXRfY2tpaDJfcmVmZXJlbmNlX2Nsb2NrX3Jh
dGUsCiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBvc2NfY2xrID0geworCV9fSU5JVF9DTEtfREVC
VUcob3NjX2NsaykKIAkuZ2V0X3JhdGUgPSBnZXRfb3NjaWxsYXRvcl9yZWZlcmVuY2VfY2xvY2tf
cmF0ZSwKIH07CiAKIC8qIEV4dGVybmFsIGxvdyBmcmVxdWVuY3kgKDMya0h6KSBjbG9jayAqLwog
c3RhdGljIHN0cnVjdCBjbGsgY2tpbF9jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhja2lsX2Ns
aykKIAkuZ2V0X3JhdGUgPSBnZXRfbG93X3JlZmVyZW5jZV9jbG9ja19yYXRlLAogfTsKIAogc3Rh
dGljIHN0cnVjdCBjbGsgcGxsMV9tYWluX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHBsbDFf
bWFpbl9jbGspCiAJLnBhcmVudCA9ICZvc2NfY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19wbGxfZ2V0
X3JhdGUsCiAJLmVuYWJsZSA9IF9jbGtfcGxsX2VuYWJsZSwKQEAgLTcyNCw2ICs3MzYsNyBAQCBz
dGF0aWMgc3RydWN0IGNsayBwbGwxX21haW5fY2xrID0gewogCiAvKiBQTEwxIFNXIHN1cHBsaWVz
IHRvIEFSTSBjb3JlICovCiBzdGF0aWMgc3RydWN0IGNsayBwbGwxX3N3X2NsayA9IHsKKwlfX0lO
SVRfQ0xLX0RFQlVHKHBsbDFfc3dfY2xrKQogCS5wYXJlbnQgPSAmcGxsMV9tYWluX2NsaywKIAku
c2V0X3BhcmVudCA9IF9jbGtfcGxsMV9zd19zZXRfcGFyZW50LAogCS5nZXRfcmF0ZSA9IGNsa19w
bGwxX3N3X2dldF9yYXRlLApAQCAtNzMxLDYgKzc0NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIHBs
bDFfc3dfY2xrID0gewogCiAvKiBQTEwyIFNXIHN1cHBsaWVzIHRvIEFYSS9BSEIvSVAgYnVzZXMg
Ki8KIHN0YXRpYyBzdHJ1Y3QgY2xrIHBsbDJfc3dfY2xrID0geworCV9fSU5JVF9DTEtfREVCVUco
cGxsMl9zd19jbGspCiAJLnBhcmVudCA9ICZvc2NfY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19wbGxf
Z2V0X3JhdGUsCiAJLnNldF9yYXRlID0gX2Nsa19wbGxfc2V0X3JhdGUsCkBAIC03NDEsNiArNzU1
LDcgQEAgc3RhdGljIHN0cnVjdCBjbGsgcGxsMl9zd19jbGsgPSB7CiAKIC8qIFBMTDMgU1cgc3Vw
cGxpZXMgdG8gc2VyaWFsIGNsb2NrcyBsaWtlIFVTQiwgU1NJLCBldGMuICovCiBzdGF0aWMgc3Ry
dWN0IGNsayBwbGwzX3N3X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHBsbDNfc3dfY2xrKQog
CS5wYXJlbnQgPSAmb3NjX2NsaywKIAkuc2V0X3JhdGUgPSBfY2xrX3BsbF9zZXRfcmF0ZSwKIAku
Z2V0X3JhdGUgPSBjbGtfcGxsX2dldF9yYXRlLApAQCAtNzUwLDYgKzc2NSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgY2xrIHBsbDNfc3dfY2xrID0gewogCiAvKiBQTEw0IFNXIHN1cHBsaWVzIHRvIExWRFMg
RGlzcGxheSBCcmlkZ2UoTERCKSAqLwogc3RhdGljIHN0cnVjdCBjbGsgbXg1M19wbGw0X3N3X2Ns
ayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKG14NTNfcGxsNF9jbGspCiAJLnBhcmVudCA9ICZvc2Nf
Y2xrLAogCS5zZXRfcmF0ZSA9IF9jbGtfcGxsX3NldF9yYXRlLAogCS5lbmFibGUgPSBfY2xrX3Bs
bF9lbmFibGUsCkBAIC03NTgsMjIgKzc3NCwyNiBAQCBzdGF0aWMgc3RydWN0IGNsayBteDUzX3Bs
bDRfc3dfY2xrID0gewogCiAvKiBMb3ctcG93ZXIgQXVkaW8gUGxheWJhY2sgTW9kZSBjbG9jayAq
Lwogc3RhdGljIHN0cnVjdCBjbGsgbHBfYXBtX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGxw
X2FwbV9jbGspCiAJLnBhcmVudCA9ICZvc2NfY2xrLAogCS5zZXRfcGFyZW50ID0gX2Nsa19scF9h
cG1fc2V0X3BhcmVudCwKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIHBlcmlwaF9hcG1fY2xrID0g
eworCV9fSU5JVF9DTEtfREVCVUcocGVyaXBoX2FwbV9jbGspCiAJLnBhcmVudCA9ICZwbGwxX3N3
X2NsaywKIAkuc2V0X3BhcmVudCA9IF9jbGtfcGVyaXBoX2FwbV9zZXRfcGFyZW50LAogfTsKIAog
c3RhdGljIHN0cnVjdCBjbGsgY3B1X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGNwdV9jbGsp
CiAJLnBhcmVudCA9ICZwbGwxX3N3X2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfY3B1X2dldF9yYXRl
LAogCS5zZXRfcmF0ZSA9IGNsa19jcHVfc2V0X3JhdGUsCiB9OwogCiBzdGF0aWMgc3RydWN0IGNs
ayBhaGJfY2xrID0geworCV9fSU5JVF9DTEtfREVCVUcoYWhiX2NsaykKIAkucGFyZW50ID0gJm1h
aW5fYnVzX2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfYWhiX2dldF9yYXRlLAogCS5zZXRfcmF0ZSA9
IF9jbGtfYWhiX3NldF9yYXRlLApAQCAtNzgxLDYgKzgwMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xr
IGFoYl9jbGsgPSB7CiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBpaW1fY2xrID0geworCV9fSU5J
VF9DTEtfREVCVUcoaWltX2NsaykKIAkucGFyZW50ID0gJmlwZ19jbGssCiAJLmVuYWJsZV9yZWcg
PSBNWENfQ0NNX0NDR1IwLAogCS5lbmFibGVfc2hpZnQgPSBNWENfQ0NNX0NDR1J4X0NHMTVfT0ZG
U0VULApAQCAtNzg4LDE3ICs4MDksMjAgQEAgc3RhdGljIHN0cnVjdCBjbGsgaWltX2NsayA9IHsK
IAogLyogTWFpbiBJUCBpbnRlcmZhY2UgY2xvY2sgZm9yIGFjY2VzcyB0byByZWdpc3RlcnMgKi8K
IHN0YXRpYyBzdHJ1Y3QgY2xrIGlwZ19jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhpcGdfY2xr
KQogCS5wYXJlbnQgPSAmYWhiX2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfaXBnX2dldF9yYXRlLAog
fTsKIAogc3RhdGljIHN0cnVjdCBjbGsgaXBnX3BlcmNsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVH
KGlwZ19jbGspCiAJLnBhcmVudCA9ICZscF9hcG1fY2xrLAogCS5nZXRfcmF0ZSA9IGNsa19pcGdf
cGVyX2dldF9yYXRlLAogCS5zZXRfcGFyZW50ID0gX2Nsa19pcGdfcGVyX3NldF9wYXJlbnQsCiB9
OwogCiBzdGF0aWMgc3RydWN0IGNsayBhaGJfbWF4X2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVH
KGFoYl9tYXhfY2xrKQogCS5wYXJlbnQgPSAmYWhiX2NsaywKIAkuZW5hYmxlX3JlZyA9IE1YQ19D
Q01fQ0NHUjAsCiAJLmVuYWJsZV9zaGlmdCA9IE1YQ19DQ01fQ0NHUnhfQ0cxNF9PRkZTRVQsCkBA
IC04MDcsNiArODMxLDcgQEAgc3RhdGljIHN0cnVjdCBjbGsgYWhiX21heF9jbGsgPSB7CiB9Owog
CiBzdGF0aWMgc3RydWN0IGNsayBhaXBzX3R6MV9jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhh
aXBzX3R6MV9jbGspCiAJLnBhcmVudCA9ICZhaGJfY2xrLAogCS5zZWNvbmRhcnkgPSAmYWhiX21h
eF9jbGssCiAJLmVuYWJsZV9yZWcgPSBNWENfQ0NNX0NDR1IwLApAQCAtODE2LDYgKzg0MSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgY2xrIGFpcHNfdHoxX2NsayA9IHsKIH07CiAKIHN0YXRpYyBzdHJ1Y3Qg
Y2xrIGFpcHNfdHoyX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGFpcHNfdHoyX2NsaykKIAku
cGFyZW50ID0gJmFoYl9jbGssCiAJLnNlY29uZGFyeSA9ICZhaGJfbWF4X2NsaywKIAkuZW5hYmxl
X3JlZyA9IE1YQ19DQ01fQ0NHUjAsCkBAIC04MjUsMTUgKzg1MSwxOCBAQCBzdGF0aWMgc3RydWN0
IGNsayBhaXBzX3R6Ml9jbGsgPSB7CiB9OwogCiBzdGF0aWMgc3RydWN0IGNsayBncHRfMzJrX2Ns
ayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKGdwdF8zMmtfY2xrKQogCS5pZCA9IDAsCiAJLnBhcmVu
dCA9ICZja2lsX2NsaywKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2xrIGtwcF9jbGsgPSB7CisJX19J
TklUX0NMS19ERUJVRyhrcHBfY2xrKQogCS5pZCA9IDAsCiB9OwogCiBzdGF0aWMgc3RydWN0IGNs
ayBlbWlfc2xvd19jbGsgPSB7CisJX19JTklUX0NMS19ERUJVRyhlbWlfc2xvd19jbGspCiAJLnBh
cmVudCA9ICZwbGwyX3N3X2NsaywKIAkuZW5hYmxlX3JlZyA9IE1YQ19DQ01fQ0NHUjUsCiAJLmVu
YWJsZV9zaGlmdCA9IE1YQ19DQ01fQ0NHUnhfQ0c4X09GRlNFVCwKQEAgLTg0Miw4ICs4NzEsMTAg
QEAgc3RhdGljIHN0cnVjdCBjbGsgZW1pX3Nsb3dfY2xrID0gewogCS5nZXRfcmF0ZSA9IGNsa19l
bWlfc2xvd19nZXRfcmF0ZSwKIH07CiAKKwogI2RlZmluZSBERUZJTkVfQ0xPQ0tfQ0NHUihuYW1l
LCBpLCBlciwgZXMsIHBmeCwgcCwgcykJXAogCXN0YXRpYyBzdHJ1Y3QgY2xrIG5hbWUgPSB7CQkJ
XAorCQlfX0lOSVRfQ0xLX0RFQlVHKG5hbWUpCQkJXAogCQkuaWQJCT0gaSwJCQlcCiAJCS5lbmFi
bGVfcmVnCT0gZXIsCQkJXAogCQkuZW5hYmxlX3NoaWZ0CT0gZXMsCQkJXApAQCAtODU5LDYgKzg5
MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrIGVtaV9zbG93X2NsayA9IHsKIAogI2RlZmluZSBERUZJ
TkVfQ0xPQ0tfTUFYKG5hbWUsIGksIGVyLCBlcywgcGZ4LCBwLCBzKQlcCiAJc3RhdGljIHN0cnVj
dCBjbGsgbmFtZSA9IHsJCQlcCisJCV9fSU5JVF9DTEtfREVCVUcobmFtZSkJCQlcCiAJCS5pZAkJ
PSBpLAkJCVwKIAkJLmVuYWJsZV9yZWcJPSBlciwJCQlcCiAJCS5lbmFibGVfc2hpZnQJPSBlcywJ
CQlcCkBAIC05MzcsNiArOTY5LDcgQEAgQ0xLX0dFVF9SQVRFKHVhcnQsIDEsIFVBUlQpCiBDTEtf
U0VUX1BBUkVOVCh1YXJ0LCAxLCBVQVJUKQogCiBzdGF0aWMgc3RydWN0IGNsayB1YXJ0X3Jvb3Rf
Y2xrID0geworCV9fSU5JVF9DTEtfREVCVUcodWFydF9yb290X2NsaykKIAkucGFyZW50ID0gJnBs
bDJfc3dfY2xrLAogCS5nZXRfcmF0ZSA9IGNsa191YXJ0X2dldF9yYXRlLAogCS5zZXRfcGFyZW50
ID0gY2xrX3VhcnRfc2V0X3BhcmVudCwKQEAgLTk0Nyw2ICs5ODAsNyBAQCBDTEtfR0VUX1JBVEUo
dXNib2gzLCAxLCBVU0JPSDMpCiBDTEtfU0VUX1BBUkVOVCh1c2JvaDMsIDEsIFVTQk9IMykKIAog
c3RhdGljIHN0cnVjdCBjbGsgdXNib2gzX2NsayA9IHsKKwlfX0lOSVRfQ0xLX0RFQlVHKHVzYm9o
M19jbGspCiAJLnBhcmVudCA9ICZwbGwyX3N3X2NsaywKIAkuZ2V0X3JhdGUgPSBjbGtfdXNib2gz
X2dldF9yYXRlLAogCS5zZXRfcGFyZW50ID0gY2xrX3VzYm9oM19zZXRfcGFyZW50LApAQCAtOTU3
LDYgKzk5MSw3IEBAIENMS19HRVRfUkFURShlY3NwaSwgMiwgQ1NQSSkKIENMS19TRVRfUEFSRU5U
KGVjc3BpLCAxLCBDU1BJKQogCiBzdGF0aWMgc3RydWN0IGNsayBlY3NwaV9tYWluX2NsayA9IHsK
KwlfX0lOSVRfQ0xLX0RFQlVHKGVjc3BpX21haW5fY2xrKQogCS5wYXJlbnQgPSAmcGxsM19zd19j
bGssCiAJLmdldF9yYXRlID0gY2xrX2Vjc3BpX2dldF9yYXRlLAogCS5zZXRfcGFyZW50ID0gY2xr
X2Vjc3BpX3NldF9wYXJlbnQsCkBAIC05NzIsNyArMTAwNyw4IEBAIENMS19TRVRfUEFSRU5UKGVz
ZGhjMiwgMSwgRVNESEMyX01TSEMyKQogQ0xLX1NFVF9SQVRFKGVzZGhjMiwgMSwgRVNESEMyX01T
SEMyKQogCiAjZGVmaW5lIERFRklORV9DTE9DS19GVUxMKG5hbWUsIGksIGVyLCBlcywgZ3IsIHNy
LCBlLCBkLCBwLCBzKQkJXAotCXN0YXRpYyBzdHJ1Y3QgY2xrIG5hbWUgPSB7CQkJCQlcCitzdGF0
aWMgc3RydWN0IGNsayBuYW1lID0gewkJCQkJCVwKKwkJX19JTklUX0NMS19ERUJVRyhuYW1lKQkJ
CQkJXAogCQkuaWQJCT0gaSwJCQkJCVwKIAkJLmVuYWJsZV9yZWcJPSBlciwJCQkJCVwKIAkJLmVu
YWJsZV9zaGlmdAk9IGVzLAkJCQkJXApAQCAtMTE0Nyw4ICsxMTgzLDEwIEBAIGludCBfX2luaXQg
bXg1MV9jbG9ja3NfaW5pdCh1bnNpZ25lZCBsb25nIGNraWwsIHVuc2lnbmVkIGxvbmcgb3NjLAog
CWNraWgyX3JlZmVyZW5jZSA9IGNraWgyOwogCW9zY2lsbGF0b3JfcmVmZXJlbmNlID0gb3NjOwog
Ci0JZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUobXg1MV9sb29rdXBzKTsgaSsrKQorCWZvciAo
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKG14NTFfbG9va3Vwcyk7IGkrKykgewogCQljbGtkZXZfYWRk
KCZteDUxX2xvb2t1cHNbaV0pOworCQljbGtfZGVidWdfcmVnaXN0ZXIobXg1MV9sb29rdXBzW2ld
LmNsayk7CisJfQogCiAJY2xrX3RyZWVfaW5pdCgpOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybS9w
bGF0LW14Yy9jbG9jay5jIGIvYXJjaC9hcm0vcGxhdC1teGMvY2xvY2suYwppbmRleCAyZWQzYWIx
Li4xMjg5YTcxIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW14Yy9jbG9jay5jCisrKyBiL2Fy
Y2gvYXJtL3BsYXQtbXhjL2Nsb2NrLmMKQEAgLTM3LDYgKzM3LDggQEAKICNpbmNsdWRlIDxsaW51
eC9wcm9jX2ZzLmg+CiAjaW5jbHVkZSA8bGludXgvc2VtYXBob3JlLmg+CiAjaW5jbHVkZSA8bGlu
dXgvc3RyaW5nLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2Rl
YnVnZnMuaD4KIAogI2luY2x1ZGUgPG1hY2gvY2xvY2suaD4KICNpbmNsdWRlIDxtYWNoL2hhcmR3
YXJlLmg+CkBAIC0yNDQsMyArMjQ2LDEyMiBAQCB1bnNpZ25lZCBsb25nIG14Y19kZWNvZGVfcGxs
KHVuc2lnbmVkIGludCByZWdfdmFsLCB1MzIgZnJlcSkKIAogCXJldHVybiBsbDsKIH0KKworI2lm
ZGVmIENPTkZJR19DTEtfREVCVUcKKy8qCisgKglkZWJ1Z2ZzIHN1cHBvcnQgdG8gdHJhY2UgY2xv
Y2sgdHJlZSBoaWVyYXJjaHkgYW5kIGF0dHJpYnV0ZXMKKyAqLworc3RhdGljIGludCBjbGtfZGVi
dWdfcmF0ZV9nZXQodm9pZCAqZGF0YSwgdTY0ICp2YWwpCit7CisJc3RydWN0IGNsayAqY2xrID0g
ZGF0YTsKKworCSp2YWwgPSAodTY0KWNsa19nZXRfcmF0ZShjbGspOworCXJldHVybiAwOworfQor
REVGSU5FX1NJTVBMRV9BVFRSSUJVVEUoY2xrX2RlYnVnX3JhdGVfZm9wcywgY2xrX2RlYnVnX3Jh
dGVfZ2V0LCBOVUxMLAorCQkiJWxsdVxuIik7CisKKworc3RhdGljIHN0cnVjdCBkZW50cnkgKmNs
a19yb290Oworc3RhdGljIGludCBjbGtfZGVidWdfcmVnaXN0ZXJfb25lKHN0cnVjdCBjbGsgKmNs
aykKK3sKKwlpbnQgZXJyOworCXN0cnVjdCBkZW50cnkgKmQsICpjaGlsZCwgKmNoaWxkX3RtcDsK
KwlzdHJ1Y3QgY2xrICpwYSA9IGNsa19nZXRfcGFyZW50KGNsayk7CisKKwlpZiAocGEgJiYgIUlT
X0VSUihwYSkpCisJCWQgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoY2xrLT5uYW1lLCBwYS0+ZGVudHJ5
KTsKKwllbHNlIHsKKwkJaWYgKCFjbGtfcm9vdCkKKwkJCWNsa19yb290ID0gZGVidWdmc19jcmVh
dGVfZGlyKCJjbG9ja3MiLCBOVUxMKTsKKwkJaWYgKCFjbGtfcm9vdCkKKwkJCXJldHVybiAtRU5P
TUVNOworCQlkID0gZGVidWdmc19jcmVhdGVfZGlyKGNsay0+bmFtZSwgY2xrX3Jvb3QpOworCX0K
KworCWlmICghZCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwljbGstPmRlbnRyeSA9IGQ7CisKKwlk
ID0gZGVidWdmc19jcmVhdGVfdTMyKCJlbmFibGVfY291bnQiLCBTX0lSVUdPLCBjbGstPmRlbnRy
eSwKKwkJCSh1MzIgKikmY2xrLT51c2Vjb3VudCk7CisJaWYgKCFkKSB7CisJCWVyciA9IC1FTk9N
RU07CisJCWdvdG8gZXJyX291dDsKKwl9CisKKwlkID0gZGVidWdmc19jcmVhdGVfZmlsZSgicmF0
ZSIsIFNfSVJVR08sIGNsay0+ZGVudHJ5LCAodm9pZCAqKWNsaywKKwkJCSZjbGtfZGVidWdfcmF0
ZV9mb3BzKTsKKwlpZiAoIWQpIHsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBlcnJfb3V0Owor
CX0KKworCXJldHVybiAwOworCitlcnJfb3V0OgorCWQgPSBjbGstPmRlbnRyeTsKKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUoY2hpbGQsIGNoaWxkX3RtcCwgJmQtPmRfc3ViZGlycywgZF91LmRf
Y2hpbGQpCisJCWRlYnVnZnNfcmVtb3ZlKGNoaWxkKTsKKwlkZWJ1Z2ZzX3JlbW92ZShjbGstPmRl
bnRyeSk7CisJcmV0dXJuIGVycjsKK30KKworc3RydWN0IHByZWluaXRfY2xrIHsKKwlzdHJ1Y3Qg
bGlzdF9oZWFkIGxpc3Q7CisJc3RydWN0IGNsayAqY2xrOworfTsKK3N0YXRpYyBMSVNUX0hFQUQo
cHJlaW5pdF9jbGtzKTsKK3N0YXRpYyBERUZJTkVfTVVURVgocHJlaW5pdF9sb2NrKTsKK3N0YXRp
YyBpbnQgaW5pdF9kb25lOworCit2b2lkIGNsa19kZWJ1Z19yZWdpc3RlcihzdHJ1Y3QgY2xrICpj
bGspCit7CisJaW50IGVycjsKKwlzdHJ1Y3QgY2xrICpwYTsKKworCWlmIChpbml0X2RvbmUpIHsK
KwkJcGEgPSBjbGtfZ2V0X3BhcmVudChjbGspOworCisJCWlmIChwYSAmJiAhSVNfRVJSKHBhKSAm
JiAhcGEtPmRlbnRyeSkKKwkJCWNsa19kZWJ1Z19yZWdpc3RlcihwYSk7CisKKwkJaWYgKCFjbGst
PmRlbnRyeSkgeworCQkJZXJyID0gY2xrX2RlYnVnX3JlZ2lzdGVyX29uZShjbGspOworCQkJaWYg
KGVycikKKwkJCQlyZXR1cm47CisJCX0KKwl9IGVsc2UgeworCQlzdHJ1Y3QgcHJlaW5pdF9jbGsg
KnA7CisJCW11dGV4X2xvY2soJnByZWluaXRfbG9jayk7CisJCXAgPSBrbWFsbG9jKHNpemVvZigq
cCksIEdGUF9LRVJORUwpOworCQlpZiAoIXApCisJCQlnb3RvIHVubG9jazsKKwkJcC0+Y2xrID0g
Y2xrOworCQlsaXN0X2FkZCgmcC0+bGlzdCwgJnByZWluaXRfY2xrcyk7Cit1bmxvY2s6CisJCW11
dGV4X3VubG9jaygmcHJlaW5pdF9sb2NrKTsKKwl9Cit9CitFWFBPUlRfU1lNQk9MX0dQTChjbGtf
ZGVidWdfcmVnaXN0ZXIpOworCitzdGF0aWMgaW50IF9faW5pdCBjbGtfZGVidWdmc19pbml0KHZv
aWQpCit7CisJc3RydWN0IHByZWluaXRfY2xrICpwY2xrLCAqdG1wOworCisJaWYgKGRlYnVnZnNf
aW5pdGlhbGl6ZWQoKSkKKwkJaW5pdF9kb25lID0gMTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnko
cGNsaywgJnByZWluaXRfY2xrcywgbGlzdCkgeworCQljbGtfZGVidWdfcmVnaXN0ZXIocGNsay0+
Y2xrKTsKKwl9CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocGNsaywgdG1wLCAmcHJlaW5p
dF9jbGtzLCBsaXN0KSB7CisJCWxpc3RfZGVsKCZwY2xrLT5saXN0KTsKKwkJa2ZyZWUocGNsayk7
CisJfQorCXJldHVybiAwOworfQorbGF0ZV9pbml0Y2FsbChjbGtfZGVidWdmc19pbml0KTsKKyNl
bmRpZgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1teGMvaW5jbHVkZS9tYWNoL2Nsb2NrLmgg
Yi9hcmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaAppbmRleCA3NTNhNTk4Li5m
YjBlMGJkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2su
aAorKysgYi9hcmNoL2FybS9wbGF0LW14Yy9pbmNsdWRlL21hY2gvY2xvY2suaApAQCAtMjMsOSAr
MjMsMTQgQEAKICNpZm5kZWYgX19BU1NFTUJMWV9fCiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPgog
CisjZGVmaW5lIENMS19OQU1FX0xFTiAzMgogc3RydWN0IG1vZHVsZTsKIAogc3RydWN0IGNsayB7
CisjaWZkZWYgQ09ORklHX0NMS19ERUJVRworCWNoYXIgbmFtZVtDTEtfTkFNRV9MRU5dOworCXN0
cnVjdCBkZW50cnkgICAgICAgICAgICpkZW50cnk7CisjZW5kaWYKIAlpbnQgaWQ7CiAJLyogU291
cmNlIGNsb2NrIHRoaXMgY2xrIGRlcGVuZHMgb24gKi8KIAlzdHJ1Y3QgY2xrICpwYXJlbnQ7CkBA
IC02Miw1ICs2NywxMSBAQCB2b2lkIGNsa191bnJlZ2lzdGVyKHN0cnVjdCBjbGsgKmNsayk7CiAK
IHVuc2lnbmVkIGxvbmcgbXhjX2RlY29kZV9wbGwodW5zaWduZWQgaW50IHBsbCwgdTMyIGZfcmVm
KTsKIAorI2lmZGVmIENPTkZJR19DTEtfREVCVUcKK3ZvaWQgY2xrX2RlYnVnX3JlZ2lzdGVyKHN0
cnVjdCBjbGsgKmNsayk7CisjZWxzZQorc3RhdGljIGlubGluZSB2b2lkIGNsa19kZWJ1Z19yZWdp
c3RlcihzdHJ1Y3QgY2xrICpjbGspIHt9CisjZW5kaWYKKwogI2VuZGlmIC8qIF9fQVNTRU1CTFlf
XyAqLwogI2VuZGlmIC8qIF9fQVNNX0FSQ0hfTVhDX0NMT0NLX0hfXyAqLwotLSAKMS43LjAuNAoK
--000e0cd47c686618b1049657a3b5--
