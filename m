From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 14 May 2013 11:39:29 +0900
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
References: <1368499171-22427-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368499171-22427-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7779 SoC; add a function to
register this device with board-specific platform data.

Based on a similar change for the r8a7779 by Sergei Shtylyov.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".

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
 arch/arm/mach-shmobile/setup-r8a7790.c        | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b393592..b21ff6b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -50,6 +50,7 @@
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR3 0xe615013c
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR8 0xe6150990
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
@@ -180,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP813,
 	MSTP721, MSTP720,
 	MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
@@ -187,6 +189,7 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP304] = SH_CLK_MSTP32(&cp_clk, SMSTPCR3, 4, 0), /* TPU0 */
@@ -249,6 +252,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-eth", &mstp_clks[MSTP813]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 2e919e6..89e4f70 100644
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
 void r8a7790_timer_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index eeef5f6..c56deab 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -30,6 +30,21 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+
+/* Ether */
+static __initdata struct resource ether_resources[] = {
+	DEFINE_RES_MEM(0xee700000, 0x400),
+	DEFINE_RES_IRQ(gic_spi(162)), /* IRQ0 */
+};
+
+void __init r8a7790_add_ether_device(struct sh_eth_plat_data *pdata)
+{
+	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  pdata, sizeof(*pdata));
+}
+
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
 };
-- 
1.8.2.1
