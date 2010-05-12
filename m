From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:51 -0700
Subject: [PATCH 22/25] msm: io: add io support for 7x30
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-23-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/io.h |    2 ++
 arch/arm/mach-msm/io.c              |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index dbfb013..c35b29f 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -27,6 +27,8 @@ void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int m
 #define __mem_pci(a)    (a)
 
 void msm_map_qsd8x50_io(void);
+void msm_map_msm7x30_io(void);
+
 extern unsigned int msm_shared_ram_phys;
 
 #endif
diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index c94ba33..1c05060 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -100,6 +100,39 @@ void __init msm_map_qsd8x50_io(void)
 }
 #endif /* CONFIG_ARCH_QSD8X50 */
 
+#ifdef CONFIG_ARCH_MSM7X30
+static struct map_desc msm7x30_io_desc[] __initdata = {
+	MSM_DEVICE(VIC),
+	MSM_DEVICE(CSR),
+	MSM_DEVICE(TMR),
+	MSM_DEVICE(DMOV),
+	MSM_DEVICE(GPIO1),
+	MSM_DEVICE(GPIO2),
+	MSM_DEVICE(CLK_CTL),
+	MSM_DEVICE(CLK_CTL_SH2),
+	MSM_DEVICE(AD5),
+	MSM_DEVICE(MDC),
+	MSM_DEVICE(ACC),
+	MSM_DEVICE(SAW),
+	MSM_DEVICE(GCC),
+	MSM_DEVICE(TCSR),
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
+void __init msm_map_msm7x30_io(void)
+{
+	iotable_init(msm7x30_io_desc, ARRAY_SIZE(msm7x30_io_desc));
+}
+#endif /* CONFIG_ARCH_MSM7X30 */
+
 void __iomem *
 __msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 {
-- 
1.6.2.3
