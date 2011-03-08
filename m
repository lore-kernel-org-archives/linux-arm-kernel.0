From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  8 Mar 2011 19:27:44 +0530
Subject: [PATCH v3 5/7] da850: pruss SUART board specific additions.
In-Reply-To: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1299592667-21367-6-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pruss SUART pin mux and registers the device
with the pruss mfd driver.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   45 ++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c614c82..0cf40b2 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1053,8 +1053,51 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+const short da850_evm_pruss_suart_pins[] = {
+	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
+	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR,
+	DA850_AXR_13, DA850_AXR_9, DA850_AXR_7,
+	DA850_AXR_14, DA850_AXR_10, DA850_AXR_8,
+	-1
+};
+
+static int __init da850_evm_pruss_suart_setup(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(da850_evm_pruss_suart_pins);
+	if (ret)
+		pr_warning("%s: da850_evm_pruss_suart_pins "
+			"mux setup failed: %d\n", __func__, ret);
+	return ret;
+}
+
+static struct da850_evm_pruss_suart_data suart_data = {
+	.version	= 1,
+};
+
+static struct resource da850_evm_pruss_suart_resource[] = {
+	{
+		.name	= "da8xx_mcasp0_iomem",
+		.start	= DAVINCI_DA8XX_MCASP0_REG_BASE,
+		.end	= DAVINCI_DA8XX_MCASP0_REG_BASE +
+				(SZ_1K * 12) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static struct da8xx_pruss_devices pruss_devices[] = {
-	{.dev_name = NULL,},
+	{
+		.dev_name	= "da8xx_pruss_uart",
+		.pdata		= &suart_data,
+		.pdata_size	= sizeof(suart_data),
+		.setup		= da850_evm_pruss_suart_setup,
+		.num_resources  = ARRAY_SIZE(da850_evm_pruss_suart_resource),
+		.resources	= da850_evm_pruss_suart_resource,
+	},
+	{
+		.dev_name	= NULL,
+	},
 };
 
 static int __init da8xx_evm_setup_pruss(void)
-- 
1.7.2.3
