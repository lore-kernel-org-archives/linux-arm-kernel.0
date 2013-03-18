From: Barry.Song@csr.com (Barry Song)
Date: Mon, 18 Mar 2013 15:04:38 +0800
Subject: [PATCH 1/2] arm: prima2: add new SiRFatlas6 machine in common board
In-Reply-To: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
References: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1363590279-5656-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

SiRFatlas6's machine definition is almost seem with SiRFprimaII
except that prima2 has a 256MB DMA zone.
This patch adds SiRFatlas6 machine in common board files, and
also adds atlas6 arch node in Kconfig.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/Kconfig  |   10 +++++++++-
 arch/arm/mach-prima2/common.c |   21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 4f7379f..b3be799 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,6 +1,14 @@
 if ARCH_SIRF
 
-menu "CSR SiRF primaII/Marco/Polo Specific Features"
+menu "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
+
+config ARCH_ATLAS6
+	bool "CSR SiRFSoC ATLAS6 ARM Cortex A9 Platform"
+	default y
+	select CPU_V7
+	select SIRF_IRQ
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
 
 config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 2ed5007..ce0730d 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -37,6 +37,27 @@ static __init void sirfsoc_map_io(void)
 	sirfsoc_map_scu();
 }
 
+#ifdef CONFIG_ARCH_ATLAS6
+static const char *atlas6_dt_match[] __initdata = {
+	"sirf,atlas6",
+	NULL
+};
+
+DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
+	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.map_io         = sirfsoc_map_io,
+	.init_irq	= sirfsoc_of_irq_init,
+	.init_time	= sirfsoc_prima2_timer_init,
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.handle_irq     = sirfsoc_handle_irq,
+#endif
+	.init_machine	= sirfsoc_mach_init,
+	.init_late	= sirfsoc_init_late,
+	.dt_compat      = atlas6_dt_match,
+	.restart	= sirfsoc_restart,
+MACHINE_END
+#endif
+
 #ifdef CONFIG_ARCH_PRIMA2
 static const char *prima2_dt_match[] __initdata = {
 	"sirf,prima2",
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
