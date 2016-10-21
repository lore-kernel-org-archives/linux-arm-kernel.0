From: octavian.purdila@nxp.com (Octavian Purdila)
Date: Fri, 21 Oct 2016 10:18:21 +0300
Subject: [PATCH 2/2] ARM: imx: init enet MAC address from ocotp
In-Reply-To: <1477034301-26579-1-git-send-email-octavian.purdila@nxp.com>
References: <1477034301-26579-1-git-send-email-octavian.purdila@nxp.com>
Message-ID: <1477034301-26579-3-git-send-email-octavian.purdila@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fugang Duan <b38611@freescale.com>

The FEC driver advertises the following order of getting it's MAC
address: module parameters or kernel command line first, then device
tree, then fuse / flash, then mac registers set by bootloader, then
random MAC address.

This patch add support for fuse MAC address for imx6/7 by updating the
device tree fec entry with a MAC address from OCOTP, if none is set.

Signed-off-by: Fugang Duan <B38611@freescale.com>
[Octavian: move to ocotp file, squash imx7d fix]
Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
---
 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/mach-imx6q.c  | 12 +++++--
 arch/arm/mach-imx/mach-imx6sl.c | 11 +++++--
 arch/arm/mach-imx/mach-imx6sx.c |  1 +
 arch/arm/mach-imx/mach-imx7d.c  |  1 +
 arch/arm/mach-imx/ocotp.c       | 73 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index fc78d4d0..7609dfe 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -108,6 +108,7 @@ u32 imx_ocotp_read(u32 offset);
 int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
+void ocotp_enet_mac_init(const char *enet_compat);
 int imx_mmdc_get_ddr_type(void);
 
 void imx_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 51f6c19..823b5ba 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -31,6 +31,7 @@
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/of_net.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
@@ -262,6 +263,13 @@ static void __init imx6q_axi_init(void)
 	}
 }
 
+static inline void imx6q_enet_init(void)
+{
+	ocotp_enet_mac_init("fsl,imx6q-fec");
+	imx6q_enet_phy_init();
+	imx6q_1588_init();
+}
+
 static void __init imx6q_init_machine(void)
 {
 	struct device *parent;
@@ -276,14 +284,12 @@ static void __init imx6q_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
-	imx6q_enet_phy_init();
-
 	of_platform_default_populate(NULL, NULL, parent);
 
 	imx_ocotp_init("fsl,imx6q-ocotp");
+	imx6q_enet_init();
 	imx_anatop_init();
 	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
-	imx6q_1588_init();
 	imx6q_axi_init();
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 01558df..1c2863f 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -19,7 +19,7 @@
 #include "common.h"
 #include "cpuidle.h"
 
-static void __init imx6sl_fec_init(void)
+static void __init imx6sl_fec_clk_init(void)
 {
 	struct regmap *gpr;
 
@@ -30,9 +30,14 @@ static void __init imx6sl_fec_init(void)
 			IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK, 0);
 		regmap_update_bits(gpr, IOMUXC_GPR1,
 			IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK, 0);
-	} else {
+	} else
 		pr_err("failed to find fsl,imx6sl-iomux-gpr regmap\n");
-	}
+}
+
+static inline void imx6sl_fec_init(void)
+{
+	imx6sl_fec_clk_init();
+	ocotp_enet_mac_init("fsl,imx6sl-fec");
 }
 
 static void __init imx6sl_init_late(void)
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index acb73c1..e502b55 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -60,6 +60,7 @@ static void __init imx6sx_enet_clk_sel(void)
 
 static inline void imx6sx_enet_init(void)
 {
+	ocotp_enet_mac_init("fsl,imx6sx-fec");
 	imx6sx_enet_phy_init();
 	imx6sx_enet_clk_sel();
 }
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index c29c771..29cde14 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -81,6 +81,7 @@ static void __init imx7d_enet_clk_sel(void)
 
 static inline void imx7d_enet_init(void)
 {
+	ocotp_enet_mac_init("fsl,imx7d-fec");
 	imx7d_enet_phy_init();
 	imx7d_enet_clk_sel();
 }
diff --git a/arch/arm/mach-imx/ocotp.c b/arch/arm/mach-imx/ocotp.c
index e73f0e8..5c5806a 100644
--- a/arch/arm/mach-imx/ocotp.c
+++ b/arch/arm/mach-imx/ocotp.c
@@ -11,6 +11,10 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_net.h>
+#include <linux/slab.h>
+
+#include "hardware.h"
 
 static void __iomem *ocotp_base;
 
@@ -38,3 +42,72 @@ u32 imx_ocotp_read(u32 offset)
 
 	return readl_relaxed(ocotp_base + offset);
 }
+
+#define OCOTP_MAC_OFF	(cpu_is_imx7d() ? 0x640 : 0x620)
+#define OCOTP_MACn(n)	(OCOTP_MAC_OFF + (n) * 0x10)
+
+void __init ocotp_enet_mac_init(const char *enet_compat)
+{
+	struct device_node *enet_np, *from = NULL;
+	struct property *newmac;
+	u32 macaddr_low;
+	u32 macaddr_high = 0;
+	u32 macaddr1_high = 0;
+	u8 *macaddr;
+	int i, id;
+
+	for (i = 0; i < 2; i++) {
+		enet_np = of_find_compatible_node(from, NULL, enet_compat);
+		if (!enet_np)
+			return;
+
+		from = enet_np;
+
+		if (of_get_mac_address(enet_np))
+			goto put_enet_node;
+
+		id = of_alias_get_id(enet_np, "ethernet");
+		if (id < 0)
+			id = i;
+
+		macaddr_low = imx_ocotp_read(OCOTP_MACn(1));
+		if (id)
+			macaddr1_high = imx_ocotp_read(OCOTP_MACn(2));
+		else
+			macaddr_high = imx_ocotp_read(OCOTP_MACn(0));
+
+		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
+		if (!newmac)
+			goto put_enet_node;
+
+		newmac->value = newmac + 1;
+		newmac->length = 6;
+		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
+		if (!newmac->name) {
+			kfree(newmac);
+			goto put_enet_node;
+		}
+
+		macaddr = newmac->value;
+		if (id) {
+			macaddr[5] = (macaddr_low >> 16) & 0xff;
+			macaddr[4] = (macaddr_low >> 24) & 0xff;
+			macaddr[3] = macaddr1_high & 0xff;
+			macaddr[2] = (macaddr1_high >> 8) & 0xff;
+			macaddr[1] = (macaddr1_high >> 16) & 0xff;
+			macaddr[0] = (macaddr1_high >> 24) & 0xff;
+		} else {
+			macaddr[5] = macaddr_high & 0xff;
+			macaddr[4] = (macaddr_high >> 8) & 0xff;
+			macaddr[3] = (macaddr_high >> 16) & 0xff;
+			macaddr[2] = (macaddr_high >> 24) & 0xff;
+			macaddr[1] = macaddr_low & 0xff;
+			macaddr[0] = (macaddr_low >> 8) & 0xff;
+		}
+
+		of_update_property(enet_np, newmac);
+
+put_enet_node:
+		of_node_put(enet_np);
+	}
+}
-- 
2.7.4
