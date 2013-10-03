From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 18:03:22 +0200
Subject: [PATCH 3/6] ARM: integrator: delete non-devicetree boot path
Message-ID: <1380816202-3128-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree boot path now supports everything the ATAG
boot can provide, and the two are equivalent. This deletes
the ATAG boot path from the Integrator/AP and
Integrator/CP platforms to move them on to the future.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                         |   1 +
 arch/arm/mach-integrator/core.c          |  57 ----------
 arch/arm/mach-integrator/integrator_ap.c | 135 ------------------------
 arch/arm/mach-integrator/integrator_cp.c | 173 -------------------------------
 arch/arm/mach-integrator/pci_v3.c        | 122 +++++-----------------
 5 files changed, 25 insertions(+), 463 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..d9ce868 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -317,6 +317,7 @@ config ARCH_INTEGRATOR
 	select NEED_MACH_MEMORY_H
 	select PLAT_VERSATILE
 	select SPARSE_IRQ
+	select USE_OF
 	select VERSATILE_FPGA_IRQ
 	help
 	  Support for ARM's Integrator platform.
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 4cdfd73..c4f984d 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -34,63 +34,6 @@
 
 #include "common.h"
 
-#ifdef CONFIG_ATAGS
-
-#define INTEGRATOR_RTC_IRQ	{ IRQ_RTCINT }
-#define INTEGRATOR_UART0_IRQ	{ IRQ_UARTINT0 }
-#define INTEGRATOR_UART1_IRQ	{ IRQ_UARTINT1 }
-#define KMI0_IRQ		{ IRQ_KMIINT0 }
-#define KMI1_IRQ		{ IRQ_KMIINT1 }
-
-static AMBA_APB_DEVICE(rtc, "rtc", 0,
-	INTEGRATOR_RTC_BASE, INTEGRATOR_RTC_IRQ, NULL);
-
-static AMBA_APB_DEVICE(uart0, "uart0", 0,
-	INTEGRATOR_UART0_BASE, INTEGRATOR_UART0_IRQ, NULL);
-
-static AMBA_APB_DEVICE(uart1, "uart1", 0,
-	INTEGRATOR_UART1_BASE, INTEGRATOR_UART1_IRQ, NULL);
-
-static AMBA_APB_DEVICE(kmi0, "kmi0", 0, KMI0_BASE, KMI0_IRQ, NULL);
-static AMBA_APB_DEVICE(kmi1, "kmi1", 0, KMI1_BASE, KMI1_IRQ, NULL);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&rtc_device,
-	&uart0_device,
-	&uart1_device,
-	&kmi0_device,
-	&kmi1_device,
-};
-
-int __init integrator_init(bool is_cp)
-{
-	int i;
-
-	/*
-	 * The Integrator/AP lacks necessary AMBA PrimeCell IDs, so we need to
-	 * hard-code them. The Integator/CP and forward have proper cell IDs.
-	 * Else we leave them undefined to the bus driver can autoprobe them.
-	 */
-	if (!is_cp && IS_ENABLED(CONFIG_ARCH_INTEGRATOR_AP)) {
-		rtc_device.periphid	= 0x00041030;
-		uart0_device.periphid	= 0x00041010;
-		uart1_device.periphid	= 0x00041010;
-		kmi0_device.periphid	= 0x00041050;
-		kmi1_device.periphid	= 0x00041050;
-		uart0_device.dev.platform_data = &ap_uart_data;
-		uart1_device.dev.platform_data = &ap_uart_data;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-
-	return 0;
-}
-
-#endif
-
 static DEFINE_RAW_SPINLOCK(cm_lock);
 
 /**
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index f5fbd8a..563f1c6 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -402,8 +402,6 @@ void __init ap_init_early(void)
 {
 }
 
-#ifdef CONFIG_OF
-
 static void __init ap_of_timer_init(void)
 {
 	struct device_node *node;
@@ -564,136 +562,3 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
 MACHINE_END
-
-#endif
-
-#ifdef CONFIG_ATAGS
-
-/*
- * For the ATAG boot some static mappings are needed. This will
- * go away with the ATAG support down the road.
- */
-
-static struct map_desc ap_io_desc_atag[] __initdata = {
-	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_SC_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_SC_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	},
-};
-
-static void __init ap_map_io_atag(void)
-{
-	iotable_init(ap_io_desc_atag, ARRAY_SIZE(ap_io_desc_atag));
-	ap_map_io();
-}
-
-/*
- * This is where non-devicetree initialization code is collected and stashed
- * for eventual deletion.
- */
-
-static struct platform_device pci_v3_device = {
-	.name		= "pci-v3",
-	.id		= 0,
-};
-
-static struct resource cfi_flash_resource = {
-	.start		= INTEGRATOR_FLASH_BASE,
-	.end		= INTEGRATOR_FLASH_BASE + INTEGRATOR_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device cfi_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &ap_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &cfi_flash_resource,
-};
-
-static void __init ap_timer_init(void)
-{
-	struct clk *clk;
-	unsigned long rate;
-
-	clk = clk_get_sys("ap_timer", NULL);
-	BUG_ON(IS_ERR(clk));
-	clk_prepare_enable(clk);
-	rate = clk_get_rate(clk);
-
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-
-	integrator_clocksource_init(rate, (void __iomem *)TIMER2_VA_BASE);
-	integrator_clockevent_init(rate, (void __iomem *)TIMER1_VA_BASE,
-				IRQ_TIMERINT1);
-}
-
-#define INTEGRATOR_SC_VALID_INT	0x003fffff
-
-static void __init ap_init_irq(void)
-{
-	/* Disable all interrupts initially. */
-	/* Do the core module ones */
-	writel(-1, VA_CMIC_BASE + IRQ_ENABLE_CLEAR);
-
-	/* do the header card stuff next */
-	writel(-1, VA_IC_BASE + IRQ_ENABLE_CLEAR);
-	writel(-1, VA_IC_BASE + FIQ_ENABLE_CLEAR);
-
-	fpga_irq_init(VA_IC_BASE, "SC", IRQ_PIC_START,
-		-1, INTEGRATOR_SC_VALID_INT, NULL);
-	integrator_clk_init(false);
-}
-
-static void __init ap_init(void)
-{
-	unsigned long sc_dec;
-	int i;
-
-	platform_device_register(&pci_v3_device);
-	platform_device_register(&cfi_flash_device);
-
-	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
-	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
-	for (i = 0; i < 4; i++) {
-		struct lm_device *lmdev;
-
-		if ((sc_dec & (16 << i)) == 0)
-			continue;
-
-		lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
-		if (!lmdev)
-			continue;
-
-		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
-		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
-		lmdev->resource.flags = IORESOURCE_MEM;
-		lmdev->irq = IRQ_AP_EXPINT0 + i;
-		lmdev->id = i;
-
-		lm_device_register(lmdev);
-	}
-
-	integrator_init(false);
-}
-
-MACHINE_START(INTEGRATOR, "ARM-Integrator")
-	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.atag_offset	= 0x100,
-	.reserve	= integrator_reserve,
-	.map_io		= ap_map_io_atag,
-	.init_early	= ap_init_early,
-	.init_irq	= ap_init_irq,
-	.handle_irq	= fpga_handle_irq,
-	.init_time	= ap_timer_init,
-	.init_machine	= ap_init,
-	.restart	= integrator_restart,
-MACHINE_END
-
-#endif
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8c60fcb..871c25d 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -249,7 +249,6 @@ static void __init intcp_init_early(void)
 #endif
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id fpga_irq_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-fpga-irq", .data = fpga_irq_of_init, },
 	{ /* Sentinel */ }
@@ -354,175 +353,3 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
 MACHINE_END
-
-#endif
-
-#ifdef CONFIG_ATAGS
-
-/*
- * For the ATAG boot some static mappings are needed. This will
- * go away with the ATAG support down the road.
- */
-
-static struct map_desc intcp_io_desc_atag[] __initdata = {
-	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_CP_CTL_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_CP_CTL_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	},
-};
-
-static void __init intcp_map_io_atag(void)
-{
-	iotable_init(intcp_io_desc_atag, ARRAY_SIZE(intcp_io_desc_atag));
-	intcp_con_base = __io_address(INTEGRATOR_CP_CTL_BASE);
-	intcp_map_io();
-}
-
-
-/*
- * This is where non-devicetree initialization code is collected and stashed
- * for eventual deletion.
- */
-
-#define INTCP_FLASH_SIZE		SZ_32M
-
-static struct resource intcp_flash_resource = {
-	.start		= INTCP_PA_FLASH_BASE,
-	.end		= INTCP_PA_FLASH_BASE + INTCP_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device intcp_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &intcp_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &intcp_flash_resource,
-};
-
-#define INTCP_ETH_SIZE			0x10
-
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.start	= INTEGRATOR_CP_ETH_BASE,
-		.end	= INTEGRATOR_CP_ETH_BASE + INTCP_ETH_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CP_ETHINT,
-		.end	= IRQ_CP_ETHINT,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
-static struct platform_device *intcp_devs[] __initdata = {
-	&intcp_flash_device,
-	&smc91x_device,
-};
-
-#define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
-#define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
-#define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
-
-static void __init intcp_init_irq(void)
-{
-	u32 pic_mask, cic_mask, sic_mask;
-
-	/* These masks are for the HW IRQ registers */
-	pic_mask = ~((~0u) << (11 - 0));
-	pic_mask |= (~((~0u) << (29 - 22))) << 22;
-	cic_mask = ~((~0u) << (1 + IRQ_CIC_END - IRQ_CIC_START));
-	sic_mask = ~((~0u) << (1 + IRQ_SIC_END - IRQ_SIC_START));
-
-	/*
-	 * Disable all interrupt sources
-	 */
-	writel(0xffffffff, INTCP_VA_PIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_PIC_BASE + FIQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(0xffffffff, INTCP_VA_CIC_BASE + FIQ_ENABLE_CLEAR);
-	writel(sic_mask, INTCP_VA_SIC_BASE + IRQ_ENABLE_CLEAR);
-	writel(sic_mask, INTCP_VA_SIC_BASE + FIQ_ENABLE_CLEAR);
-
-	fpga_irq_init(INTCP_VA_PIC_BASE, "PIC", IRQ_PIC_START,
-		      -1, pic_mask, NULL);
-
-	fpga_irq_init(INTCP_VA_CIC_BASE, "CIC", IRQ_CIC_START,
-		      -1, cic_mask, NULL);
-
-	fpga_irq_init(INTCP_VA_SIC_BASE, "SIC", IRQ_SIC_START,
-		      IRQ_CP_CPPLDINT, sic_mask, NULL);
-
-	integrator_clk_init(true);
-}
-
-#define TIMER0_VA_BASE __io_address(INTEGRATOR_TIMER0_BASE)
-#define TIMER1_VA_BASE __io_address(INTEGRATOR_TIMER1_BASE)
-#define TIMER2_VA_BASE __io_address(INTEGRATOR_TIMER2_BASE)
-
-static void __init cp_timer_init(void)
-{
-	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
-
-	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
-	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1, "timer1");
-}
-
-#define INTEGRATOR_CP_MMC_IRQS	{ IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 }
-#define INTEGRATOR_CP_AACI_IRQS	{ IRQ_CP_AACIINT }
-
-static AMBA_APB_DEVICE(mmc, "mmci", 0, INTEGRATOR_CP_MMC_BASE,
-	INTEGRATOR_CP_MMC_IRQS, &mmc_data);
-
-static AMBA_APB_DEVICE(aaci, "aaci", 0, INTEGRATOR_CP_AACI_BASE,
-	INTEGRATOR_CP_AACI_IRQS, NULL);
-
-static AMBA_AHB_DEVICE(clcd, "clcd", 0, INTCP_PA_CLCD_BASE,
-	{ IRQ_CP_CLCDCINT }, &clcd_data);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&mmc_device,
-	&aaci_device,
-	&clcd_device,
-};
-
-static void __init intcp_init(void)
-{
-	int i;
-
-	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-	integrator_init(true);
-}
-
-MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
-	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.atag_offset	= 0x100,
-	.reserve	= integrator_reserve,
-	.map_io		= intcp_map_io_atag,
-	.init_early	= intcp_init_early,
-	.init_irq	= intcp_init_irq,
-	.handle_irq	= fpga_handle_irq,
-	.init_time	= cp_timer_init,
-	.init_machine	= intcp_init,
-	.restart	= integrator_restart,
-MACHINE_END
-
-#endif
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 2d10793..67406fc 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -809,32 +809,6 @@ static u8 __init pci_v3_swizzle(struct pci_dev *dev, u8 *pinp)
 	return pci_common_swizzle(dev, pinp);
 }
 
-static int irq_tab[4] __initdata = {
-	IRQ_AP_PCIINT0,	IRQ_AP_PCIINT1,	IRQ_AP_PCIINT2,	IRQ_AP_PCIINT3
-};
-
-/*
- * map the specified device/slot/pin to an IRQ.  This works out such
- * that slot 9 pin 1 is INT0, pin 2 is INT1, and slot 10 pin 1 is INT1.
- */
-static int __init pci_v3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int intnr = ((slot - 9) + (pin - 1)) & 3;
-
-	return irq_tab[intnr];
-}
-
-static struct hw_pci pci_v3 __initdata = {
-	.swizzle		= pci_v3_swizzle,
-	.setup			= pci_v3_setup,
-	.nr_controllers		= 1,
-	.ops			= &pci_v3_ops,
-	.preinit		= pci_v3_preinit,
-	.postinit		= pci_v3_postinit,
-};
-
-#ifdef CONFIG_OF
-
 static int __init pci_v3_map_irq_dt(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct of_irq oirq;
@@ -851,14 +825,36 @@ static int __init pci_v3_map_irq_dt(const struct pci_dev *dev, u8 slot, u8 pin)
 				     oirq.size);
 }
 
-static int __init pci_v3_dtprobe(struct platform_device *pdev,
-				struct device_node *np)
+static struct hw_pci pci_v3 __initdata = {
+	.swizzle		= pci_v3_swizzle,
+	.setup			= pci_v3_setup,
+	.nr_controllers		= 1,
+	.ops			= &pci_v3_ops,
+	.preinit		= pci_v3_preinit,
+	.postinit		= pci_v3_postinit,
+};
+
+static int __init pci_v3_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
 	struct resource *res;
 	int irq, ret;
 
+	/* Remap the Integrator system controller */
+	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
+	if (!ap_syscon_base) {
+		dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
+		return -ENODEV;
+	}
+
+	/* Device tree probe path */
+	if (!np) {
+		dev_err(&pdev->dev, "no device tree node for PCIv3\n");
+		return -ENODEV;
+	}
+
 	if (of_pci_range_parser_init(&parser, np))
 		return -EINVAL;
 
@@ -925,76 +921,6 @@ static int __init pci_v3_dtprobe(struct platform_device *pdev,
 	return 0;
 }
 
-#else
-
-static inline int pci_v3_dtprobe(struct platform_device *pdev,
-				  struct device_node *np)
-{
-	return -EINVAL;
-}
-
-#endif
-
-static int __init pci_v3_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int ret;
-
-	/* Remap the Integrator system controller */
-	ap_syscon_base = ioremap(INTEGRATOR_SC_BASE, 0x100);
-	if (!ap_syscon_base) {
-		dev_err(&pdev->dev, "unable to remap the AP syscon for PCIv3\n");
-		return -ENODEV;
-	}
-
-	/* Device tree probe path */
-	if (np)
-		return pci_v3_dtprobe(pdev, np);
-
-	pci_v3_base = devm_ioremap(&pdev->dev, PHYS_PCI_V3_BASE, SZ_64K);
-	if (!pci_v3_base) {
-		dev_err(&pdev->dev, "unable to remap PCIv3 base\n");
-		return -ENODEV;
-	}
-
-	ret = devm_request_irq(&pdev->dev, IRQ_AP_V3INT, v3_irq, 0, "V3", NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to grab PCI error interrupt: %d\n",
-			ret);
-		return -ENODEV;
-	}
-
-	conf_mem.name = "PCIv3 config";
-	conf_mem.start = PHYS_PCI_CONFIG_BASE;
-	conf_mem.end = PHYS_PCI_CONFIG_BASE + SZ_16M - 1;
-	conf_mem.flags = IORESOURCE_MEM;
-
-	io_mem.name = "PCIv3 I/O";
-	io_mem.start = PHYS_PCI_IO_BASE;
-	io_mem.end = PHYS_PCI_IO_BASE + SZ_16M - 1;
-	io_mem.flags = IORESOURCE_MEM;
-
-	non_mem_pci = 0x00000000;
-	non_mem_pci_sz = SZ_256M;
-	non_mem.name = "PCIv3 non-prefetched mem";
-	non_mem.start = PHYS_PCI_MEM_BASE;
-	non_mem.end = PHYS_PCI_MEM_BASE + SZ_256M - 1;
-	non_mem.flags = IORESOURCE_MEM;
-
-	pre_mem_pci = 0x10000000;
-	pre_mem_pci_sz = SZ_256M;
-	pre_mem.name = "PCIv3 prefetched mem";
-	pre_mem.start = PHYS_PCI_PRE_BASE + SZ_256M;
-	pre_mem.end = PHYS_PCI_PRE_BASE + SZ_256M - 1;
-	pre_mem.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-
-	pci_v3.map_irq = pci_v3_map_irq;
-
-	pci_common_init_dev(&pdev->dev, &pci_v3);
-
-	return 0;
-}
-
 static const struct of_device_id pci_ids[] = {
 	{ .compatible = "v3,v360epc-pci", },
 	{},
-- 
1.8.3.1
