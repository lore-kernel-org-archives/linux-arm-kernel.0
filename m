From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  7 Jul 2014 11:41:26 +0200
Subject: [PATCH v4 1/2] ARM: i.MX: allow disabling supervisor protect via DT
Message-ID: <1404726087-2069-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX SoCs allow to setup fine grained access rights to peripherals on the
AIPS bus.
This is done via the Peripheral Access Register (PAR) in e.g. the i.MX21
or in later SoC versions the Off-Platform Peripheral Access Control Register
(OPACR), e.g. i.MX53.
Under certain circumstances this leads to problems in which bus masters are
not granted their access rights to peripherals.
To be able to disable these restrictions on DT platforms, add a helper function
that looks for AIPS nodes in the DT and disables them for every compatible node
it finds.
The compatible has to be declared in the mach-specific entry file, where this
helper function should then be called.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v3:
	- use for_each_compatible_node

 arch/arm/mach-imx/common.h |  2 ++
 arch/arm/mach-imx/cpu.c    | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 9ab785c..8c1a305 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -19,6 +19,7 @@ struct pt_regs;
 struct clk;
 struct device_node;
 enum mxc_cpu_pwr_mode;
+struct of_device_id;
 
 void mx1_map_io(void);
 void mx21_map_io(void);
@@ -77,6 +78,7 @@ void mxc_arch_reset_init(void __iomem *);
 void mxc_arch_reset_init_dt(void);
 int mx53_revision(void);
 void imx_set_aips(void __iomem *);
+void imx_aips_allow_unprivileged_access(const char *compat);
 int mxc_device_init(void);
 void imx_set_soc_revision(unsigned int rev);
 unsigned int imx_get_soc_revision(void);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index bbe8ff1..df42c14 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -60,6 +61,18 @@ void __init imx_set_aips(void __iomem *base)
 	__raw_writel(reg, base + 0x50);
 }
 
+void __init imx_aips_allow_unprivileged_access(
+		const char *compat)
+{
+	void __iomem *aips_base_addr;
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, compat) {
+		aips_base_addr = of_iomap(np, 0);
+		imx_set_aips(aips_base_addr);
+	}
+}
+
 struct device * __init imx_soc_device_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
-- 
2.0.0
