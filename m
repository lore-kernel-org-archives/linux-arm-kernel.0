From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:42 -0700
Subject: [PATCH 13/25] msm: io: add io support for 8x50
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-14-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/io.h |    3 ++
 arch/arm/mach-msm/io.c              |   39 ++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index aab9645..dbfb013 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -26,4 +26,7 @@ void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int m
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)    (a)
 
+void msm_map_qsd8x50_io(void);
+extern unsigned int msm_shared_ram_phys;
+
 #endif
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index fde5e58..c94ba33 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -1,8 +1,9 @@
 /* arch/arm/mach-msm/io.c
  *
- * MSM7K io support
+ * MSM7K, QSD io support
  *
  * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2010, Code Aurora Forum. All rights reserved.
  * Author: Brian Swetland <swetland@google.com>
  *
  * This software is licensed under the terms of the GNU General Public
@@ -34,6 +35,8 @@
 		.type = MT_DEVICE_NONSHARED, \
 	 }
 
+#if defined(CONFIG_ARCH_MSM7X00A) || defined(CONFIG_ARCH_MSM7X27) \
+	|| defined(CONFIG_ARCH_MSM7X25)
 static struct map_desc msm_io_desc[] __initdata = {
 	MSM_DEVICE(VIC),
 	MSM_DEVICE(CSR),
@@ -50,7 +53,7 @@ static struct map_desc msm_io_desc[] __initdata = {
 #endif
 	{
 		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
-		.pfn =      __phys_to_pfn(MSM_SHARED_RAM_PHYS),
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
 		.length =   MSM_SHARED_RAM_SIZE,
 		.type =     MT_DEVICE,
 	},
@@ -63,9 +66,39 @@ void __init msm_map_common_io(void)
 	 * pages are peripheral interface or not.
 	 */
 	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
-
 	iotable_init(msm_io_desc, ARRAY_SIZE(msm_io_desc));
 }
+#endif
+
+#ifdef CONFIG_ARCH_QSD8X50
+static struct map_desc qsd8x50_io_desc[] __initdata = {
+	MSM_DEVICE(VIC),
+	MSM_DEVICE(CSR),
+	MSM_DEVICE(TMR),
+	MSM_DEVICE(DMOV),
+	MSM_DEVICE(GPIO1),
+	MSM_DEVICE(GPIO2),
+	MSM_DEVICE(CLK_CTL),
+	MSM_DEVICE(SIRC),
+	MSM_DEVICE(SCPLL),
+	MSM_DEVICE(AD5),
+	MSM_DEVICE(MDC),
+#ifdef CONFIG_MSM_DEBUG_UART
+	MSM_DEVICE(DEBUG_UART),
+#endif
+	{
+		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
+		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
+		.length =   MSM_SHARED_RAM_SIZE,
+		.type =     MT_DEVICE,
+	},
+};
+
+void __init msm_map_qsd8x50_io(void)
+{
+	iotable_init(qsd8x50_io_desc, ARRAY_SIZE(qsd8x50_io_desc));
+}
+#endif /* CONFIG_ARCH_QSD8X50 */
 
 void __iomem *
 __msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
-- 
1.6.2.3
