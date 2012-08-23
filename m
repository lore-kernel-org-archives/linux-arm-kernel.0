From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 13:41:59 +0800
Subject: [PATCH v2 3/3] ARM: SIRF: make sirf irqchip driver optional since new
 SoCs will have GIC
In-Reply-To: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
References: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345700519-667-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

New MARCO and POLO SoC use GIC, so make irq.c optional and enable it
only if we enable ARCH_PRIMA2 in Kconfig

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: if dt node is not found, return but not panic since we might enable
 ARCH_PRIMA2 even we work on ARCH_MARCO

 arch/arm/mach-prima2/Kconfig  |    4 ++++
 arch/arm/mach-prima2/Makefile |    2 +-
 arch/arm/mach-prima2/irq.c    |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 65438e1..41fc853 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -7,9 +7,13 @@ config ARCH_PRIMA2
 	default y
 	select CPU_V7
 	select ZONE_DMA
+	select SIRF_IRQ
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
 endmenu
 
+config SIRF_IRQ
+	bool
+
 endif
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index f2cde60..fc9ce22 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -1,8 +1,8 @@
 obj-y := timer.o
-obj-y += irq.o
 obj-y += rstc.o
 obj-y += common.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
+obj-$(CONFIG_SIRF_IRQ) += irq.o
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index a7b9415..7dee917 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -63,7 +63,7 @@ void __init sirfsoc_of_irq_init(void)
 
 	np = of_find_matching_node(NULL, intc_ids);
 	if (!np)
-		panic("unable to find compatible intc node in dtb\n");
+		return;
 
 	sirfsoc_intc_base = of_iomap(np, 0);
 	if (!sirfsoc_intc_base)
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
