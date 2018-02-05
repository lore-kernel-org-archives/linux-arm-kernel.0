From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Mon,  5 Feb 2018 08:07:43 -0600
Subject: [PATCH v6 2/2] staging: fsl-mc: Move irqchip code out of staging
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
Message-ID: <20180205140743.29974-3-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the fsl-mc bus core infrastructure is out of staging, the
remaining irqchip glue code used (irq-gic-v3-its-fsl-mc-msi.c) goes
to drivers/irqchip.

Create new Kconfig option for irqchip code that depends on
FSL_MC_BUS and ARM_GIC_V3_ITS. This ensures irqchip code only
gets built on ARM64 platforms. We can now remove #ifdef
GENERIC_MSI_DOMAIN_OPS as it was only needed for x86.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
[rebased, add dpaa2_eth and dpio #include updates]
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[rebased, split irqchip to separate patch]
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
[add Kconfig dependency on ARM_GIC_V3_ITS]
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
Notes:
    -v6:
      - generate patch with rename detection enabled (GregKH)
      - add Kconfig dependecy on ARM_GIC_V3_ITS (Mark Zyngier)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
    -v4 - v1:
      - no change

 drivers/irqchip/Kconfig                                             | 6 ++++++
 drivers/irqchip/Makefile                                            | 1 +
 drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c | 2 --
 drivers/staging/fsl-mc/bus/Makefile                                 | 3 +--
 4 files changed, 8 insertions(+), 4 deletions(-)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (98%)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec..f2ace51 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -51,6 +51,12 @@ config ARM_GIC_V3_ITS_PCI
 	depends on PCI_MSI
 	default ARM_GIC_V3_ITS
 
+config ARM_GIC_V3_ITS_FSL_MC
+	bool
+	depends on ARM_GIC_V3_ITS
+	depends on FSL_MC_BUS
+	default ARM_GIC_V3_ITS
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3..1ba4390 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
rename to drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index b365fbb..13a5d9a 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -43,9 +43,7 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 	 * NOTE: This device id corresponds to the IOMMU stream ID
 	 * associated with the DPRC object (ICID).
 	 */
-#ifdef GENERIC_MSI_DOMAIN_OPS
 	info->scratchpad[0].ul = mc_bus_dev->icid;
-#endif
 	msi_info = msi_get_domain_info(msi_domain->parent);
 	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
 }
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 18b1b5f..b67889e 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,8 +4,7 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += irq-gic-v3-its-fsl-mc-msi.o \
-			    dpbp.o \
+obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
 			    dpcon.o
 
 # MC DPIO driver
-- 
2.7.4
