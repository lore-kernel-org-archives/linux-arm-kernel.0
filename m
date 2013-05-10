From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 May 2013 17:05:18 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ether clock and platform device for R8A7779 SoC; add a function to
register this device with board-specific platform data.

Based on a similar change for the r8a7779 by Sergei Shtylyov.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has a run-time dependency on "sh_eth: add support for r8a7790 SoC".
---
 arch/arm/mach-shmobile/clock-r8a7790.c        |  6 +++++-
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index bedd20c..2c3123e 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -49,6 +49,7 @@
 
 #define SMSTPCR2 0xe6150138
 #define SMSTPCR7 0xe615014c
+#define SMSTPCR8 0xe6150990
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
@@ -178,9 +179,11 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 /* MSTP */
-enum { MSTP721, MSTP720,
+enum { MSTP813, MSTP812, MSTP721, MSTP720,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP_NR };
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
+	[MSTP812] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 12, 0), /* EtherAVB */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
@@ -242,6 +245,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-eth", &mstp_clks[MSTP813]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 2e919e6..95b8f7e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,9 +1,12 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
+#include <linux/sh_eth.h>
+
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_timer_init(void);
+void r8a7790_add_ether_device(struct sh_eth_plat_data *pdata);
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index eeef5f6..8ed0d7b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -30,6 +30,21 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+
+/* Ether */
+static struct resource ether_resources[] = {
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
