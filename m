From: mporter@ti.com (Matt Porter)
Date: Fri,  5 Oct 2012 13:04:46 -0400
Subject: [PATCH v4 7/7] ARM: davinci: register pruss_uio device on DA850 EVM
In-Reply-To: <1349456686-22736-1-git-send-email-mporter@ti.com>
References: <1349456686-22736-1-git-send-email-mporter@ti.com>
Message-ID: <1349456686-22736-8-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configures the required pdata and registers the pruss_uio
platform device on the DA850 EVM.

Tested on AM180x-EVM using the PRU_memAccessPRUDataRam and
PRU_memAccessL3andDDR examples from the PRU userspace tools
available from http://www.ti.com/tool/sprc940

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 7359375..6f9478b 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
+#include <linux/platform_data/uio_pruss.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
 #include <linux/spi/spi.h>
@@ -40,6 +41,7 @@
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
+#include <mach/sram.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -1253,6 +1255,10 @@ static __init int da850_wl12xx_init(void)
 
 #endif /* CONFIG_DA850_WL12XX */
 
+struct uio_pruss_pdata da8xx_pruss_uio_pdata = {
+	.pintc_base	= 0x4000,
+};
+
 #define DA850EVM_SATA_REFCLKPN_RATE	(100 * 1000 * 1000)
 
 static __init void da850_evm_init(void)
@@ -1339,6 +1345,12 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",
 				ret);
 
+	da8xx_pruss_uio_pdata.sram_pool = sram_get_gen_pool();
+	ret = da8xx_register_pruss_uio(&da8xx_pruss_uio_pdata);
+	if (ret)
+		pr_warning("pruss_uio initialization failed: %d\n",
+				ret);
+
 	/* Handle board specific muxing for LCD here */
 	ret = davinci_cfg_reg_list(da850_evm_lcdc_pins);
 	if (ret)
-- 
1.7.9.5
