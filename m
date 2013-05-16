From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 May 2013 01:28:02 +0400
Subject: [PATCH v4 1/3] ARM: shmobile: r8a7778: add VIN support
In-Reply-To: <201305170122.33996.sergei.shtylyov@cogentembedded.com>
References: <201305170122.33996.sergei.shtylyov@cogentembedded.com>
Message-ID: <201305170128.03074.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add VIN clocks and platform devices on R8A7778 SoC; add function to register
the VIN platform devices.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
[Sergei: added 'id' parameter check to r8a7779_add_vin_device(), used '*pdata'
in *sizeof* operator there, renamed some variables, annotated 'vin[01]_info' and
vin[01]_resources[] as '__initdata'.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since version 3:
- changed the VIN platform device names to be R8A7778 specific; 
- resolved reject in <mach/r8a7778.h>  due to USB patch rework.

Changes from version 2:
- annotated 'vin[01]_info' and vin[01]_resources[] as '__initdata' since they're
  kmemdup()'ed while registering the platform devices anyway;
- refreshed the patch.

 arch/arm/mach-shmobile/clock-r8a7778.c        |    5 +++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   33 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -106,6 +106,7 @@ static struct clk *main_clks[] = {
 enum {
 	MSTP323, MSTP322, MSTP321,
 	MSTP114,
+	MSTP110, MSTP109,
 	MSTP100,
 	MSTP030, MSTP029,
 	MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
@@ -117,6 +118,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
+	[MSTP110] = SH_CLK_MSTP32(&s_clk, MSTPCR1, 10, 0), /* VIN0 */
+	[MSTP109] = SH_CLK_MSTP32(&s_clk, MSTPCR1,  9, 0), /* VIN1 */
 	[MSTP100] = SH_CLK_MSTP32(&p_clk, MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 30, 0), /* I2C0 */
 	[MSTP029] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 29, 0), /* I2C1 */
@@ -140,6 +143,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
+	CLKDEV_DEV_ID("r8a7778-vin.0", &mstp_clks[MSTP110]), /* VIN0 */
+	CLKDEV_DEV_ID("r8a7778-vin.1", &mstp_clks[MSTP109]), /* VIN1 */
 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
Index: renesas/arch/arm/mach-shmobile/include/mach/r8a7778.h
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ renesas/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -21,11 +21,14 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 #include <linux/platform_data/usb-rcar-phy.h>
+#include <linux/platform_data/camera-rcar.h>
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
+extern void r8a7778_add_vin_device(int id,
+				   struct rcar_vin_platform_data *pdata);
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -299,6 +299,39 @@ void __init r8a7778_sdhi_init(int id,
 		info, sizeof(*info));
 }
 
+/* VIN */
+#define R8A7778_VIN(idx)						\
+static struct resource vin##idx##_resources[] __initdata = {		\
+	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),		\
+	DEFINE_RES_IRQ(gic_iid(0x5a)),					\
+};									\
+									\
+static struct platform_device_info vin##idx##_info __initdata = {	\
+	.parent		= &platform_bus,				\
+	.name		= "r8a7778-vin",				\
+	.id		= idx,						\
+	.res		= vin##idx##_resources,				\
+	.num_res	= ARRAY_SIZE(vin##idx##_resources),		\
+	.dma_mask	= DMA_BIT_MASK(32),				\
+}
+
+R8A7778_VIN(0);
+R8A7778_VIN(1);
+
+static struct platform_device_info *vin_info_table[] __initdata = {
+	&vin0_info,
+	&vin1_info,
+};
+
+void __init r8a7778_add_vin_device(int id, struct rcar_vin_platform_data *pdata)
+{
+	BUG_ON(id < 0 || id > 1);
+
+	vin_info_table[id]->data = pdata;
+	vin_info_table[id]->size_data = sizeof(*pdata);
+	platform_device_register_full(vin_info_table[id]);
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
