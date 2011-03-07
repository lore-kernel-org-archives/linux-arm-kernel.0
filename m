From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  7 Mar 2011 10:19:27 +0900
Subject: [PATCH 1/2] ARM: EXYNOS4: Enhancement of System MMU driver
In-Reply-To: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
References: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1299460768-4077-2-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes the following enhancements for System MMU:
- Enhanced readability
- Removal of unused data structures or their members
- Simplified function definitions
- Corrections of some logical errors
- Full compliance with Linux coding style
- Simpler way of registering callback functions of System MMU faults

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/dev-sysmmu.c               |   23 ++-
 arch/arm/mach-exynos4/include/mach/regs-sysmmu.h |    4 +
 arch/arm/mach-exynos4/include/mach/sysmmu.h      |   88 +-----
 arch/arm/plat-s5p/include/plat/sysmmu.h          |   95 ++++++
 arch/arm/plat-s5p/sysmmu.c                       |  368 ++++++++++------------
 5 files changed, 299 insertions(+), 279 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/sysmmu.h

diff --git a/arch/arm/mach-exynos4/dev-sysmmu.c b/arch/arm/mach-exynos4/dev-sysmmu.c
index a10790a..6889c9a 100644
--- a/arch/arm/mach-exynos4/dev-sysmmu.c
+++ b/arch/arm/mach-exynos4/dev-sysmmu.c
@@ -15,6 +15,28 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
+#include <mach/sysmmu.h>
+#include <plat/s5p-clock.h>
+
+/* These names must be equal to the clock names in mach-exynos4/clock.c */
+const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM] = {
+	"SYSMMU_MDMA"	,
+	"SYSMMU_SSS"	,
+	"SYSMMU_FIMC0"	,
+	"SYSMMU_FIMC1"	,
+	"SYSMMU_FIMC2"	,
+	"SYSMMU_FIMC3"	,
+	"SYSMMU_JPEG"	,
+	"SYSMMU_FIMD0"	,
+	"SYSMMU_FIMD1"	,
+	"SYSMMU_PCIe"	,
+	"SYSMMU_G2D"	,
+	"SYSMMU_ROTATOR",
+	"SYSMMU_MDMA2"	,
+	"SYSMMU_TV"	,
+	"SYSMMU_MFC_L"	,
+	"SYSMMU_MFC_R"	,
+};
 
 static struct resource exynos4_sysmmu_resource[] = {
 	[0] = {
@@ -185,5 +207,4 @@ struct platform_device exynos4_device_sysmmu = {
 	.num_resources	= ARRAY_SIZE(exynos4_sysmmu_resource),
 	.resource	= exynos4_sysmmu_resource,
 };
-
 EXPORT_SYMBOL(exynos4_device_sysmmu);
diff --git a/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h b/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
index b6aef86..68ff6ad 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-sysmmu.h
@@ -19,6 +19,10 @@
 #define S5P_MMU_FLUSH			0x00C
 #define S5P_PT_BASE_ADDR		0x014
 #define S5P_INT_STATUS			0x018
+#define S5P_INT_CLEAR			0x01C
 #define S5P_PAGE_FAULT_ADDR		0x024
+#define S5P_AW_FAULT_ADDR		0x028
+#define S5P_AR_FAULT_ADDR		0x02C
+#define S5P_DEFAULT_SLAVE_ADDR		0x030
 
 #endif /* __ASM_ARCH_REGS_SYSMMU_H */
diff --git a/arch/arm/mach-exynos4/include/mach/sysmmu.h b/arch/arm/mach-exynos4/include/mach/sysmmu.h
index 1428ada..eff3dc3 100644
--- a/arch/arm/mach-exynos4/include/mach/sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/sysmmu.h
@@ -13,9 +13,6 @@
 #ifndef __ASM_ARM_ARCH_SYSMMU_H
 #define __ASM_ARM_ARCH_SYSMMU_H __FILE__
 
-#define EXYNOS4_SYSMMU_TOTAL_IPNUM	16
-#define S5P_SYSMMU_TOTAL_IPNUM		EXYNOS4_SYSMMU_TOTAL_IPNUM
-
 enum exynos4_sysmmu_ips {
 	SYSMMU_MDMA,
 	SYSMMU_SSS,
@@ -33,90 +30,13 @@ enum exynos4_sysmmu_ips {
 	SYSMMU_TV,
 	SYSMMU_MFC_L,
 	SYSMMU_MFC_R,
+	EXYNOS4_SYSMMU_TOTAL_IPNUM,
 };
 
-static char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM] = {
-	"SYSMMU_MDMA"	,
-	"SYSMMU_SSS"	,
-	"SYSMMU_FIMC0"	,
-	"SYSMMU_FIMC1"	,
-	"SYSMMU_FIMC2"	,
-	"SYSMMU_FIMC3"	,
-	"SYSMMU_JPEG"	,
-	"SYSMMU_FIMD0"	,
-	"SYSMMU_FIMD1"	,
-	"SYSMMU_PCIe"	,
-	"SYSMMU_G2D"	,
-	"SYSMMU_ROTATOR",
-	"SYSMMU_MDMA2"	,
-	"SYSMMU_TV"	,
-	"SYSMMU_MFC_L"	,
-	"SYSMMU_MFC_R"	,
-};
-
-typedef enum exynos4_sysmmu_ips sysmmu_ips;
-
-struct sysmmu_tt_info {
-	unsigned long *pgd;
-	unsigned long pgd_paddr;
-	unsigned long *pte;
-};
-
-struct sysmmu_controller {
-	const char		*name;
-
-	/* channels registers */
-	void __iomem		*regs;
-
-	/* channel irq */
-	unsigned int		irq;
-
-	sysmmu_ips		ips;
-
-	/* Translation Table Info. */
-	struct sysmmu_tt_info	*tt_info;
-
-	struct resource		*mem;
-	struct device		*dev;
-
-	/* SysMMU controller enable - true : enable */
-	bool			enable;
-};
-
-/**
- * s5p_sysmmu_enable() - enable system mmu of ip
- * @ips: The ip connected system mmu.
- *
- * This function enable system mmu to transfer address
- * from virtual address to physical address
- */
-int s5p_sysmmu_enable(sysmmu_ips ips);
+#define S5P_SYSMMU_TOTAL_IPNUM		EXYNOS4_SYSMMU_TOTAL_IPNUM
 
-/**
- * s5p_sysmmu_disable() - disable sysmmu mmu of ip
- * @ips: The ip connected system mmu.
- *
- * This function disable system mmu to transfer address
- * from virtual address to physical address
- */
-int s5p_sysmmu_disable(sysmmu_ips ips);
+extern const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM];
 
-/**
- * s5p_sysmmu_set_tablebase_pgd() - set page table base address to refer page table
- * @ips: The ip connected system mmu.
- * @pgd: The page table base address.
- *
- * This function set page table base address
- * When system mmu transfer address from virtaul address to physical address,
- * system mmu refer address information from page table
- */
-int s5p_sysmmu_set_tablebase_pgd(sysmmu_ips ips, unsigned long pgd);
+typedef enum exynos4_sysmmu_ips sysmmu_ips;
 
-/**
- * s5p_sysmmu_tlb_invalidate() - flush all TLB entry in system mmu
- * @ips: The ip connected system mmu.
- *
- * This function flush all TLB entry in system mmu
- */
-int s5p_sysmmu_tlb_invalidate(sysmmu_ips ips);
 #endif /* __ASM_ARM_ARCH_SYSMMU_H */
diff --git a/arch/arm/plat-s5p/include/plat/sysmmu.h b/arch/arm/plat-s5p/include/plat/sysmmu.h
new file mode 100644
index 0000000..bf5283c
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/sysmmu.h
@@ -0,0 +1,95 @@
+/* linux/arch/arm/plat-s5p/include/plat/sysmmu.h
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung System MMU driver for S5P platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM__PLAT_SYSMMU_H
+#define __ASM__PLAT_SYSMMU_H __FILE__
+
+enum S5P_SYSMMU_INTERRUPT_TYPE {
+	SYSMMU_PAGEFAULT,
+	SYSMMU_AR_MULTIHIT,
+	SYSMMU_AW_MULTIHIT,
+	SYSMMU_BUSERROR,
+	SYSMMU_AR_SECURITY,
+	SYSMMU_AR_ACCESS,
+	SYSMMU_AW_SECURITY,
+	SYSMMU_AW_PROTECTION, /* 7 */
+	SYSMMU_FAULTS_NUM
+};
+
+#ifdef CONFIG_S5P_SYSTEM_MMU
+
+#include <mach/sysmmu.h>
+
+/**
+ * s5p_sysmmu_enable() - enable system mmu of ip
+ * @ips: The ip connected system mmu.
+ * #pgd: Base physical address of the 1st level page table
+ *
+ * This function enable system mmu to transfer address
+ * from virtual address to physical address
+ */
+void s5p_sysmmu_enable(sysmmu_ips ips, unsigned long pgd);
+
+/**
+ * s5p_sysmmu_disable() - disable sysmmu mmu of ip
+ * @ips: The ip connected system mmu.
+ *
+ * This function disable system mmu to transfer address
+ * from virtual address to physical address
+ */
+void s5p_sysmmu_disable(sysmmu_ips ips);
+
+/**
+ * s5p_sysmmu_set_tablebase_pgd() - set page table base address to refer page table
+ * @ips: The ip connected system mmu.
+ * @pgd: The page table base address.
+ *
+ * This function set page table base address
+ * When system mmu transfer address from virtaul address to physical address,
+ * system mmu refer address information from page table
+ */
+void s5p_sysmmu_set_tablebase_pgd(sysmmu_ips ips, unsigned long pgd);
+
+/**
+ * s5p_sysmmu_tlb_invalidate() - flush all TLB entry in system mmu
+ * @ips: The ip connected system mmu.
+ *
+ * This function flush all TLB entry in system mmu
+ */
+void s5p_sysmmu_tlb_invalidate(sysmmu_ips ips);
+
+/** s5p_sysmmu_set_fault_handler() - Fault handler for System MMUs
+ * @itype: type of fault.
+ * @pgtable_base: the physical address of page table base. This is 0 if @ips is
+ *               SYSMMU_BUSERROR.
+ * @fault_addr: the device (virtual) address that the System MMU tried to
+ *             translated. This is 0 if @ips is SYSMMU_BUSERROR.
+ * Called when interrupt occurred by the System MMUs
+ * The device drivers of peripheral devices that has a System MMU can implement
+ * a fault handler to resolve address translation fault by System MMU.
+ * The meanings of return value and parameters are described below.
+
+ * return value: non-zero if the fault is correctly resolved.
+ *         zero if the fault is not handled.
+ */
+void s5p_sysmmu_set_fault_handler(sysmmu_ips ips,
+			int (*handler)(enum S5P_SYSMMU_INTERRUPT_TYPE itype,
+					unsigned long pgtable_base,
+					unsigned long fault_addr));
+#else
+#define s5p_sysmmu_enable(ips, pgd) do { } while (0)
+#define s5p_sysmmu_disable(ips) do { } while (0)
+#define s5p_sysmmu_set_tablebase_pgd(ips, pgd) do { } while (0)
+#define s5p_sysmmu_tlb_invalidate(ips) do { } while (0)
+#define s5p_sysmmu_set_fault_handler(ips, handler) do { } while (0)
+#endif
+#endif /* __ASM_PLAT_SYSMMU_H */
diff --git a/arch/arm/plat-s5p/sysmmu.c b/arch/arm/plat-s5p/sysmmu.c
index ffe8a48..89e024f 100644
--- a/arch/arm/plat-s5p/sysmmu.c
+++ b/arch/arm/plat-s5p/sysmmu.c
@@ -12,280 +12,260 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
+#include <asm/pgtable.h>
+
 #include <mach/map.h>
 #include <mach/regs-sysmmu.h>
-#include <mach/sysmmu.h>
+#include <plat/sysmmu.h>
+
+#define CTRL_ENABLE	0x5
+#define CTRL_BLOCK	0x7
+#define CTRL_DISABLE	0x0
+
+static struct device *dev;
+
+static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
+	S5P_PAGE_FAULT_ADDR,
+	S5P_AR_FAULT_ADDR,
+	S5P_AW_FAULT_ADDR,
+	S5P_DEFAULT_SLAVE_ADDR,
+	S5P_AR_FAULT_ADDR,
+	S5P_AR_FAULT_ADDR,
+	S5P_AW_FAULT_ADDR,
+	S5P_AW_FAULT_ADDR
+};
 
-struct sysmmu_controller s5p_sysmmu_cntlrs[S5P_SYSMMU_TOTAL_IPNUM];
+static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
+	"PAGE FAULT",
+	"AR MULTI-HIT FAULT",
+	"AW MULTI-HIT FAULT",
+	"BUS ERROR",
+	"AR SECURITY PROTECTION FAULT",
+	"AR ACCESS PROTECTION FAULT",
+	"AW SECURITY PROTECTION FAULT",
+	"AW ACCESS PROTECTION FAULT"
+};
 
-void s5p_sysmmu_register(struct sysmmu_controller *sysmmuconp)
+static int (*fault_handlers[S5P_SYSMMU_TOTAL_IPNUM])(
+		enum S5P_SYSMMU_INTERRUPT_TYPE itype,
+		unsigned long pgtable_base,
+		unsigned long fault_addr);
+
+/*
+ * If adjacent 2 bits are true, the system MMU is enabled.
+ * The system MMU is disabled, otherwise.
+ */
+static unsigned long sysmmu_states;
+
+static inline void set_sysmmu_active(sysmmu_ips ips)
 {
-	unsigned int reg_mmu_ctrl;
-	unsigned int reg_mmu_status;
-	unsigned int reg_pt_base_addr;
-	unsigned int reg_int_status;
-	unsigned int reg_page_ft_addr;
-
-	reg_int_status = __raw_readl(sysmmuconp->regs + S5P_INT_STATUS);
-	reg_mmu_ctrl = __raw_readl(sysmmuconp->regs + S5P_MMU_CTRL);
-	reg_mmu_status = __raw_readl(sysmmuconp->regs + S5P_MMU_STATUS);
-	reg_pt_base_addr = __raw_readl(sysmmuconp->regs + S5P_PT_BASE_ADDR);
-	reg_page_ft_addr = __raw_readl(sysmmuconp->regs + S5P_PAGE_FAULT_ADDR);
-
-	printk(KERN_INFO "%s: ips:%s\n", __func__, sysmmuconp->name);
-	printk(KERN_INFO "%s: MMU_CTRL:0x%X, ", __func__, reg_mmu_ctrl);
-	printk(KERN_INFO "MMU_STATUS:0x%X, PT_BASE_ADDR:0x%X\n", reg_mmu_status, reg_pt_base_addr);
-	printk(KERN_INFO "%s: INT_STATUS:0x%X, PAGE_FAULT_ADDR:0x%X\n", __func__, reg_int_status, reg_page_ft_addr);
-
-	switch (reg_int_status & 0xFF) {
-	case 0x1:
-		printk(KERN_INFO "%s: Page fault\n", __func__);
-		printk(KERN_INFO "%s: Virtual address causing last page fault or bus error : 0x%x\n", __func__ , reg_page_ft_addr);
-		break;
-	case 0x2:
-		printk(KERN_INFO "%s: AR multi-hit fault\n", __func__);
-		break;
-	case 0x4:
-		printk(KERN_INFO "%s: AW multi-hit fault\n", __func__);
-		break;
-	case 0x8:
-		printk(KERN_INFO "%s: Bus error\n", __func__);
-		break;
-	case 0x10:
-		printk(KERN_INFO "%s: AR Security protection fault\n", __func__);
-		break;
-	case 0x20:
-		printk(KERN_INFO "%s: AR Access protection fault\n", __func__);
-		break;
-	case 0x40:
-		printk(KERN_INFO "%s: AW Security protection fault\n", __func__);
-		break;
-	case 0x80:
-		printk(KERN_INFO "%s: AW Access protection fault\n", __func__);
-		break;
-	}
+	sysmmu_states |= 3 << (ips * 2);
 }
 
-static irqreturn_t s5p_sysmmu_irq(int irq, void *dev_id)
+static inline void set_sysmmu_inactive(sysmmu_ips ips)
 {
-	unsigned int i;
-	unsigned int reg_int_status;
-	struct sysmmu_controller *sysmmuconp;
-
-	for (i = 0; i < S5P_SYSMMU_TOTAL_IPNUM; i++) {
-		sysmmuconp = &s5p_sysmmu_cntlrs[i];
-
-		if (sysmmuconp->enable == true) {
-			reg_int_status = __raw_readl(sysmmuconp->regs + S5P_INT_STATUS);
-
-			if (reg_int_status & 0xFF)
-				s5p_sysmmu_register(sysmmuconp);
-		}
-	}
-	return IRQ_HANDLED;
+	sysmmu_states &= ~(3 << (ips * 2));
 }
 
-int s5p_sysmmu_set_tablebase_pgd(sysmmu_ips ips, unsigned long pgd)
+static inline int is_sysmmu_active(sysmmu_ips ips)
 {
-	struct sysmmu_controller *sysmmuconp = NULL;
-
-	sysmmuconp = &s5p_sysmmu_cntlrs[ips];
-
-	if (sysmmuconp == NULL) {
-		printk(KERN_ERR "failed to get ip's sysmmu info\n");
-		return 1;
-	}
-
-	/* Set sysmmu page table base address */
-	__raw_writel(pgd, sysmmuconp->regs + S5P_PT_BASE_ADDR);
+	return sysmmu_states & (3 << (ips * 2));
+}
 
-	if (s5p_sysmmu_tlb_invalidate(ips) != 0)
-		printk(KERN_ERR "failed s5p_sysmmu_tlb_invalidate\n");
+static void __iomem *sysmmusfrs[S5P_SYSMMU_TOTAL_IPNUM];
 
-	return 0;
+static inline void sysmmu_block(sysmmu_ips ips)
+{
+	__raw_writel(CTRL_BLOCK, sysmmusfrs[ips] + S5P_MMU_CTRL);
+	dev_dbg(dev, "%s is blocked.\n", sysmmu_ips_name[ips]);
 }
 
-static int s5p_sysmmu_set_tablebase(sysmmu_ips ips)
+static inline void sysmmu_unblock(sysmmu_ips ips)
 {
-	unsigned int pg;
-	struct sysmmu_controller *sysmmuconp;
+	__raw_writel(CTRL_ENABLE, sysmmusfrs[ips] + S5P_MMU_CTRL);
+	dev_dbg(dev, "%s is unblocked.\n", sysmmu_ips_name[ips]);
+}
 
-	sysmmuconp = &s5p_sysmmu_cntlrs[ips];
+static inline void __sysmmu_tlb_invalidate(sysmmu_ips ips)
+{
+	__raw_writel(0x1, sysmmusfrs[ips] + S5P_MMU_FLUSH);
+	dev_dbg(dev, "TLB of %s is invalidated.\n", sysmmu_ips_name[ips]);
+}
 
-	if (sysmmuconp == NULL) {
-		printk(KERN_ERR "failed to get ip's sysmmu info\n");
-		return 1;
+static inline void __sysmmu_set_ptbase(sysmmu_ips ips, unsigned long pgd)
+{
+	if (unlikely(pgd == 0)) {
+		pgd = (unsigned long)ZERO_PAGE(0);
+		__raw_writel(0x20, sysmmusfrs[ips] + S5P_MMU_CFG); /* 4KB LV1 */
+	} else {
+		__raw_writel(0x0, sysmmusfrs[ips] + S5P_MMU_CFG); /* 16KB LV1 */
 	}
 
-	__asm__("mrc	p15, 0, %0, c2, c0, 0"	\
-		: "=r" (pg) : : "cc");		\
-		pg &= ~0x3fff;
-
-	printk(KERN_INFO "%s: CP15 TTBR0 : 0x%x\n", __func__, pg);
+	__raw_writel(pgd, sysmmusfrs[ips] + S5P_PT_BASE_ADDR);
 
-	/* Set sysmmu page table base address */
-	__raw_writel(pg, sysmmuconp->regs + S5P_PT_BASE_ADDR);
+	dev_dbg(dev, "Page table base of %s is initialized with 0x%08lX.\n",
+						sysmmu_ips_name[ips], pgd);
+	__sysmmu_tlb_invalidate(ips);
+}
 
-	return 0;
+void sysmmu_set_fault_handler(sysmmu_ips ips,
+			int (*handler)(enum S5P_SYSMMU_INTERRUPT_TYPE itype,
+					unsigned long pgtable_base,
+					unsigned long fault_addr))
+{
+	BUG_ON(!((ips >= SYSMMU_MDMA) && (ips < S5P_SYSMMU_TOTAL_IPNUM)));
+	fault_handlers[ips] = handler;
 }
 
-int s5p_sysmmu_enable(sysmmu_ips ips)
+static irqreturn_t s5p_sysmmu_irq(int irq, void *dev_id)
 {
-	unsigned int reg;
+	/* SYSMMU is in blocked when interrupt occurred. */
+	unsigned long base = 0;
+	sysmmu_ips ips = (sysmmu_ips)dev_id;
+	enum S5P_SYSMMU_INTERRUPT_TYPE itype;
 
-	struct sysmmu_controller *sysmmuconp;
+	itype = (enum S5P_SYSMMU_INTERRUPT_TYPE)
+		__ffs(__raw_readl(sysmmusfrs[ips] + S5P_INT_STATUS));
 
-	sysmmuconp = &s5p_sysmmu_cntlrs[ips];
+	BUG_ON(!((itype >= 0) && (itype < 8)));
 
-	if (sysmmuconp == NULL) {
-		printk(KERN_ERR "failed to get ip's sysmmu info\n");
-		return 1;
-	}
+	dev_alert(dev, "%s occurred by %s.\n", sysmmu_fault_name[itype],
+							sysmmu_ips_name[ips]);
 
-	s5p_sysmmu_set_tablebase(ips);
+	if (fault_handlers[ips]) {
+		unsigned long addr;
 
-	/* replacement policy : LRU */
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CFG);
-	reg |= 0x1;
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CFG);
+		base = __raw_readl(sysmmusfrs[ips] + S5P_PT_BASE_ADDR);
+		addr = __raw_readl(sysmmusfrs[ips] + fault_reg_offset[itype]);
 
-	/* Enable interrupt, Enable MMU */
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CTRL);
-	reg |= (0x1 << 2) | (0x1 << 0);
+		if (fault_handlers[ips](itype, base, addr)) {
+			__raw_writel(1 << itype,
+					sysmmusfrs[ips] + S5P_INT_CLEAR);
+			dev_notice(dev, "%s from %s is resolved."
+					" Retrying translation.\n",
+				sysmmu_fault_name[itype], sysmmu_ips_name[ips]);
+		} else {
+			base = 0;
+		}
+	}
 
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CTRL);
+	sysmmu_unblock(ips);
 
-	sysmmuconp->enable = true;
+	if (!base)
+		dev_notice(dev, "%s from %s is not handled.\n",
+			sysmmu_fault_name[itype], sysmmu_ips_name[ips]);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
-int s5p_sysmmu_disable(sysmmu_ips ips)
+void s5p_sysmmu_set_tablebase_pgd(sysmmu_ips ips, unsigned long pgd)
 {
-	unsigned int reg;
-
-	struct sysmmu_controller *sysmmuconp = NULL;
-
-	if (ips > S5P_SYSMMU_TOTAL_IPNUM)
-		printk(KERN_ERR "failed to get ips parameter\n");
-
-	sysmmuconp = &s5p_sysmmu_cntlrs[ips];
-
-	if (sysmmuconp == NULL) {
-		printk(KERN_ERR "failed to get ip's sysmmu info\n");
-		return 1;
+	if (is_sysmmu_active(ips)) {
+		sysmmu_block(ips);
+		__sysmmu_set_ptbase(ips, pgd);
+		sysmmu_unblock(ips);
+	} else {
+		dev_dbg(dev, "%s is disabled. "
+			"Skipping initializing page table base.\n",
+						sysmmu_ips_name[ips]);
 	}
-
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CFG);
-
-	/* replacement policy : LRU */
-	reg |= 0x1;
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CFG);
-
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CTRL);
-
-	/* Disable MMU */
-	reg &= ~0x1;
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CTRL);
-
-	sysmmuconp->enable = false;
-
-	return 0;
 }
 
-int s5p_sysmmu_tlb_invalidate(sysmmu_ips ips)
+void s5p_sysmmu_enable(sysmmu_ips ips, unsigned long pgd)
 {
-	unsigned int reg;
-	struct sysmmu_controller *sysmmuconp = NULL;
+	if (!is_sysmmu_active(ips)) {
+		__sysmmu_set_ptbase(ips, pgd);
 
-	sysmmuconp = &s5p_sysmmu_cntlrs[ips];
+		__raw_writel(CTRL_ENABLE, sysmmusfrs[ips] + S5P_MMU_CTRL);
 
-	if (sysmmuconp == NULL) {
-		printk(KERN_ERR "failed to get ip's sysmmu info\n");
-		return 1;
+		set_sysmmu_active(ips);
+		dev_dbg(dev, "%s is enabled.\n", sysmmu_ips_name[ips]);
+	} else {
+		dev_dbg(dev, "%s is already enabled.\n", sysmmu_ips_name[ips]);
 	}
+}
 
-	/* set Block MMU for flush TLB */
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CTRL);
-	reg |= 0x1 << 1;
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CTRL);
-
-	/* flush all TLB entry */
-	__raw_writel(0x1, sysmmuconp->regs + S5P_MMU_FLUSH);
-
-	/* set Un-block MMU after flush TLB */
-	reg = __raw_readl(sysmmuconp->regs + S5P_MMU_CTRL);
-	reg &= ~(0x1 << 1);
-	__raw_writel(reg, sysmmuconp->regs + S5P_MMU_CTRL);
+void s5p_sysmmu_disable(sysmmu_ips ips)
+{
+	if (is_sysmmu_active(ips)) {
+		__raw_writel(CTRL_DISABLE, sysmmusfrs[ips] + S5P_MMU_CTRL);
+		set_sysmmu_inactive(ips);
+		dev_dbg(dev, "%s is disabled.\n", sysmmu_ips_name[ips]);
+	} else {
+		dev_dbg(dev, "%s is already disabled.\n", sysmmu_ips_name[ips]);
+	}
+}
 
-	return 0;
+void s5p_sysmmu_tlb_invalidate(sysmmu_ips ips)
+{
+	if (is_sysmmu_active(ips)) {
+		sysmmu_block(ips);
+		__sysmmu_tlb_invalidate(ips);
+		sysmmu_unblock(ips);
+	} else {
+		dev_dbg(dev, "%s is disabled. "
+			"Skipping invalidating TLB.\n", sysmmu_ips_name[ips]);
+	}
 }
 
 static int s5p_sysmmu_probe(struct platform_device *pdev)
 {
-	int i;
-	int ret;
-	struct resource *res;
-	struct sysmmu_controller *sysmmuconp;
-	sysmmu_ips ips;
+	int i, ret;
+	struct resource *res, *mem;
 
-	for (i = 0; i < S5P_SYSMMU_TOTAL_IPNUM; i++) {
-		sysmmuconp = &s5p_sysmmu_cntlrs[i];
-		if (sysmmuconp == NULL) {
-			printk(KERN_ERR "failed to get ip's sysmmu info\n");
-			ret = -ENOENT;
-			goto err_res;
-		}
+	dev = &pdev->dev;
 
-		sysmmuconp->name = sysmmu_ips_name[i];
+	for (i = 0; i < S5P_SYSMMU_TOTAL_IPNUM; i++) {
+		int irq;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res) {
-			printk(KERN_ERR "failed to get sysmmu resource\n");
+			dev_err(dev, "Failed to get the resource of %s.\n",
+							sysmmu_ips_name[i]);
 			ret = -ENODEV;
 			goto err_res;
 		}
 
-		sysmmuconp->mem = request_mem_region(res->start,
+		mem = request_mem_region(res->start,
 				((res->end) - (res->start)) + 1, pdev->name);
-		if (!sysmmuconp->mem) {
-			pr_err("failed to request sysmmu memory region\n");
+		if (!mem) {
+			dev_err(dev, "Failed to request the memory region of %s.\n",
+							sysmmu_ips_name[i]);
 			ret = -EBUSY;
 			goto err_res;
 		}
 
-		sysmmuconp->regs = ioremap(res->start, res->end - res->start + 1);
-		if (!sysmmuconp->regs) {
-			pr_err("failed to sysmmu ioremap\n");
+		sysmmusfrs[i] = ioremap(res->start, res->end - res->start + 1);
+		if (!sysmmusfrs[i]) {
+			dev_err(dev, "Failed to ioremap() for %s.\n",
+							sysmmu_ips_name[i]);
 			ret = -ENXIO;
 			goto err_reg;
 		}
 
-		sysmmuconp->irq = platform_get_irq(pdev, i);
-		if (sysmmuconp->irq <= 0) {
-			pr_err("failed to get sysmmu irq resource\n");
+		irq = platform_get_irq(pdev, i);
+		if (irq <= 0) {
+			dev_err(dev, "Failed to get the IRQ resource of %s.\n",
+							sysmmu_ips_name[i]);
 			ret = -ENOENT;
 			goto err_map;
 		}
 
-		ret = request_irq(sysmmuconp->irq, s5p_sysmmu_irq, IRQF_DISABLED, pdev->name, sysmmuconp);
-		if (ret) {
-			pr_err("failed to request irq\n");
+		if (request_irq(irq, s5p_sysmmu_irq, IRQF_DISABLED,
+						pdev->name, (void *)i)) {
+			dev_err(dev, "Failed to request IRQ for %s.\n",
+							sysmmu_ips_name[i]);
 			ret = -ENOENT;
 			goto err_map;
 		}
-
-		ips = (sysmmu_ips)i;
-
-		sysmmuconp->ips = ips;
 	}
 
 	return 0;
 
-err_reg:
-	release_mem_region((resource_size_t)sysmmuconp->mem, (resource_size_t)((res->end) - (res->start) + 1));
 err_map:
-	iounmap(sysmmuconp->regs);
+	iounmap(sysmmusfrs[i]);
+err_reg:
+	release_mem_region(mem->start, resource_size(mem));
 err_res:
 	return ret;
 }
-- 
1.7.1
