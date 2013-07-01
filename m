From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  1 Jul 2013 13:25:53 +0900
Subject: [PATCH v3 1/3] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <1372652755-16948-1-git-send-email-horms+renesas@verge.net.au>
References: <1372652755-16948-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372652755-16948-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7779 SoC; add a function to
register this device with board-specific platform data.

Based on a similar change for the r8a7779 by Sergei Shtylyov.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".

v3
* Use newly added "r8a7790-ether" instead of "sh-eth"

v2
* Do not add MSTP812, EtherAVB. It is not used.
* As suggested by Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
  - Move Ethernet element of MSTP enum to a separate line
  - Move declaration of r8a7790_add_ether_device() to immediately
    after that of r8a7790_add_standard_devices()
  - Add __initdata annotation to ether_resource.
---
 arch/arm/mach-shmobile/clock-r8a7790.c        |  4 ++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 62d8162..2f52c0f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -52,6 +52,7 @@
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR8 0xe6150990
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
@@ -182,6 +183,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP813,
 	MSTP721, MSTP720,
 	MSTP717, MSTP716,
 	MSTP522,
@@ -192,6 +194,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
@@ -260,6 +263,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 7851cc1..b827b49 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,7 +1,10 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
+#include <linux/sh_eth.h>
+
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_ether_device(struct sh_eth_plat_data *pdata);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d89cd83..fad4251 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -31,6 +31,20 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+/* Ether */
+static struct resource ether_resources[] __initdata = {
+	DEFINE_RES_MEM(0xee700000, 0x400),
+	DEFINE_RES_IRQ(gic_spi(162)), /* IRQ0 */
+};
+
+void __init r8a7790_add_ether_device(struct sh_eth_plat_data *pdata)
+{
+	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  pdata, sizeof(*pdata));
+}
+
 static struct resource pfc_resources[] __initdata = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
 };
-- 
1.8.2.1
