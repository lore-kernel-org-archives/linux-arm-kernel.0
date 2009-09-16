From: dgriego@mvista.com (David A. Griego)
Date: Tue, 15 Sep 2009 18:10:20 -0700
Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
Message-ID: <mailman.84.1256051222.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux settings, etc. to enable the MMC/SC hardware.

Signed-off-by: David A. Griego <dgriego@mvista.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   54 +++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 39711c1..fe86afa 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -23,6 +23,7 @@
 #include <mach/irqs.h>
 #include <mach/cp_intc.h>
 #include <mach/mux.h>
+#include <mach/gpio.h>
 #include <mach/da8xx.h>
 #include <mach/asp.h>
 
@@ -83,6 +84,57 @@ static struct snd_platform_data da830_evm_snd_data = {
 	.rxnumevt	= 1,
 };
 
+/*
+ * GPIO2[1] is used as MMC_SD_WP and GPIO2[2] as MMC_SD_INS.
+ */
+static const short da830_evm_mmc_sd_pins[] = {
+	DA830_MMCSD_DAT_0, DA830_MMCSD_DAT_1, DA830_MMCSD_DAT_2,
+	DA830_MMCSD_DAT_3, DA830_MMCSD_DAT_4, DA830_MMCSD_DAT_5,
+	DA830_MMCSD_DAT_6, DA830_MMCSD_DAT_7, DA830_MMCSD_CLK,
+	DA830_MMCSD_CMD,   DA830_GPIO2_1,     DA830_GPIO2_2,
+	-1
+};
+
+#define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
+
+static int da830_evm_mmc_get_ro(int index)
+{
+	return gpio_get_value(DA830_MMCSD_WP_PIN);
+}
+
+static struct davinci_mmc_config da830_evm_mmc_config = {
+	.get_ro			= da830_evm_mmc_get_ro,
+	.wires			= 4,
+	.version		= MMC_CTLR_VERSION_2,
+};
+
+static inline void da830_evm_init_mmc(void)
+{
+	int ret;
+
+	ret = da8xx_pinmux_setup(da830_evm_mmc_sd_pins);
+	if (ret) {
+		pr_warning("da830_evm_init: mmc/sd mux setup failed: %d\n",
+				ret);
+		return;
+	}
+
+	ret = gpio_request(DA830_MMCSD_WP_PIN, "MMC WP");
+	if (ret) {
+		pr_warning("da830_evm_init: can not open GPIO %d\n",
+			   DA830_MMCSD_WP_PIN);
+		return;
+	}
+	gpio_direction_input(DA830_MMCSD_WP_PIN);
+
+	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
+	if (ret) {
+		pr_warning("da830_evm_init: mmc/sd registration failed: %d\n",
+				ret);
+		gpio_free(DA830_MMCSD_WP_PIN);
+	}
+}
+
 static __init void da830_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -132,6 +184,8 @@ static __init void da830_evm_init(void)
 				ret);
 
 	da8xx_register_mcasp(1, &da830_evm_snd_data);
+
+	da830_evm_init_mmc();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.6.4.3
